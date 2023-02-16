#include "ss_search.h"

#include "../globals.h"
#include "../heuristic.h"
#include "../option_parser.h"
#include "../successor_generator.h"
#include "../g_evaluator.h"
#include "../sum_evaluator.h"
#include "../plugin.h"
#include "../rng.h"

#include <iostream>
#include <fstream>

//ss+culprits
#include "../ext/boost/dynamic_bitset.hpp"
#include <boost/lexical_cast.hpp>
#include <stdlib.h>

SSSearch::SSSearch(const Options &opts) : SearchEngine(opts), current_state(g_initial_state()) {	
	ScalarEvaluator * evaluator = opts.get<ScalarEvaluator *>("eval");
	std::set<Heuristic *> hset;
	evaluator->get_involved_heuristics(hset);
	for (set<Heuristic *>::iterator it = hset.begin(); it != hset.end(); it++) {
		heuristics.push_back(*it);
	}
	assert(heuristics.size() == 1);
	heuristic = heuristics[0];

	sampler = new TypeSystem(heuristic);
	this->RanGen2 = new CRandomMersenne((unsigned)time(NULL));        
}

SSSearch::~SSSearch() {
}


SearchStatus SSSearch::step() {
        predict(ss_probes);
        return SOLVED;
}

void SSSearch::predict(int probes) {
        totalPrediction = 0;

        for (int i = 0; i < probes; i++) {
            vweight.clear();
            probe();
            double p = getProbingResult();
            totalPrediction = totalPrediction + (p - totalPrediction)/(i + 1);
            //cout<<"**********"<<endl;
            //cout<<"p = "<<p<<endl;
            //cout<<"prePre_"<<(i+1)<<" = "<<totalPrediction<<endl;
            //cout<<"**********"<<endl;
        }
        ss_timer_value = ss_timer();	
        cout<<"\ntotalPrediction : "<<totalPrediction<<"\n";
        cout<<"ss_timer: "<<ss_timer_value<<"\n";
	cout<<"probes: "<<probes<<"\n"; 
	cout<<"threshold : "<<threshold<<"\n";
	generateSSCCReport();
	generateGeneratedReport();
        generateExpandedReport();
	
}

void SSSearch::probe()
{
	/*
	 * Probing is done based on the types of the children of the root state
	 */

        queue.clear();
	boost::dynamic_bitset<> b_initial_v(heuristics.size());
	vector<int> h_initial_v;
	// evaluating the vector of initial state
	
	int hmin_initial = INT_MAX/2;
	for (size_t i = 0; i < heuristics.size(); i++) {
		heuristics[i]->evaluate(g_initial_state());
		if (!heuristics[i]->is_dead_end())
		{
			hmin_initial = min(hmin_initial, heuristics[i]->get_heuristic());
			h_initial_v.push_back(heuristics[i]->get_heuristic());
		} else {
			hmin_initial = INT_MAX/2;
			h_initial_v.push_back(hmin_initial);
			break;
		}
	}
	initial_value = hmin_initial;
        //for the open domains the heuristic is set to six
	//cout<<"f_boundary = "<<f_boundary<<endl;
	//cout<<"initial_value = "<<initial_value<<"\n";
        if (f_boundary) {
	   threshold = f_boundary;
	} else {
           threshold = 2*initial_value;
	   if (threshold == 0) {
		threshold = 2;
	   }
	}
	//cout<<"threshold = "<<threshold<<endl;
	//filling the bitset b_initial_v
        for (size_t i = 0; i < h_initial_v.size(); i++) {
            int h_value = h_initial_v.at(i); 
            if (h_value <= threshold) {
               b_initial_v.set(i);
            }
        }

	//Initializing the operators to determinate how many childs the root node will have
	std::vector<const GlobalOperator*> applicable_ops0;
        GlobalState global_state0 = g_state_registry->lookup_state(g_initial_state().get_id());
        g_successor_generator->generate_applicable_ops(global_state0, applicable_ops0);
	//count nodes generated
	double amount_initial = (double)applicable_ops0.size();

	bitcollector.insert(std::pair<boost::dynamic_bitset<>, double>(b_initial_v, 1 + amount_initial));

	//end counting nodes generated by the root node
	
        SSNode node;
        const GlobalState &initial_state = g_initial_state();
        StateID initial_state_id = initial_state.get_id();
        node.set_id(initial_state_id);
        node.setWeight(1.0);
        node.setGreal(0);  // g_real value of the node
	/*
	 * Seeding the prediction with the children of the start state
	 *
	 */
	Type type = sampler->getType(node.get_id(), initial_value, 1);
          
 
	type.setLevel( 0 ); // level where the node is located

	queue.insert( pair<Type, SSNode>( type, node ) );

        int nraiz = 1;
  
	while( !queue.empty() )
	{
		Type out = queue.begin()->first;
		SSNode s = queue.begin()->second;
               	double g_real = s.getGreal();
                double level =  out.getLevel();

                //printQueue();

                std::map<Type, SSNode>::iterator rt;
                rt = queue.find(out);


		queue.erase( rt );
                //cout<<nraiz<<": Raiz: h = "<<out.getH()<<", g = "<<g_real<<", f = "<<out.getH() + g_real<<", level = "<<level<<", w  = "<<s.getWeight()<<endl;   
                nraiz++;                
                
		vweight.push_back(s);
		
	        
                //Insert each node.
                Node2 node2(out.getH() + g_real, level);
                double new_f_value = out.getH() + g_real;
                //count nodes expanded
                if (new_f_value <= threshold) {
			std::pair<std::map<Node2, double>::iterator, bool> ret0;

                	std::map<Node2, double>::iterator it0;

                	ret0 = expanded.insert(pair<Node2, double>(node2, s.getWeight()));
                	it0 = ret0.first;

                	if (ret0.second) {
                    	   //cout<<"new node expanded is added."<<endl;
                	} else {
                    	   //cout<<"node expanded is being updated."<<endl;
                    	   it0->second += s.getWeight();
                    	   //cout<<"it0->second = "<<it0->second<<endl;
                	}
                	//end count node
                }

		double w = s.getWeight();
 
                std::vector<const GlobalOperator*> applicable_ops;
                GlobalState global_state = g_state_registry->lookup_state(s.get_id()); 
		g_successor_generator->generate_applicable_ops(global_state, applicable_ops);

                //count nodes generated
                double amount = (double)applicable_ops.size();

                std::pair<std::map<Node2, double>::iterator, bool> ret;
                std::map<Node2, double>::iterator it;

                ret = generated.insert(std::pair<Node2, double>(node2, amount*w));
                it = ret.first;


                if (ret.second) {
                   //cout<<"new node is added."<<endl;
                } else {
                   //cout<<"old is being updated."<<endl;
                   it->second += amount*w;
                   //cout<<"new = "<<it->second<<endl;
                }
                 //end count nodes generated
                //cout<<"\t__________________begin Childs_________________\n";
		L.clear();
		check.clear();
		for (size_t i = 0; i < applicable_ops.size(); ++i)
		{
                        const GlobalOperator *op = applicable_ops[i];
                        GlobalState child = g_state_registry->get_successor_state(global_state, *op);

			//creating the child bitset
			boost::dynamic_bitset<> b_child_v(heuristics.size());
			b_child_v.set();

			int min_heur = INT_MAX/2;
			for (size_t i = 0; i < heuristics.size(); i++) {
				heuristics[i]->evaluate(child);
				if (!heuristics[i]->is_dead_end()) {
					min_heur = min(min_heur, heuristics[i]->get_heuristic());
					if ( heuristics[i]->get_heuristic() + g_real + get_adjusted_cost(*op)  > threshold) {
                                        	b_child_v.reset(i);
                                  	}
				} else {
					b_child_v.reset(i);
					min_heur = INT_MAX/2;
					break;
				}
			}
			int h = min_heur;
			
                        //cout<<"\tthe cost get_adjusted_cost(*op) = "<<get_adjusted_cost(*op)<<"\n";
			//cout<<"\tChild_"<<(i+1)<<" : h = "<< h <<", g = "<< g_real + get_adjusted_cost(*op) <<", f = "<< h + g_real + get_adjusted_cost(*op) <<", level = "<<level+1<< ", w = "<<w<<endl;
                       
			//count the childs generated by a child node
			std::vector<const GlobalOperator *> applicable_ops_2;
                        GlobalState global_state_2 = g_state_registry->lookup_state(child.get_id());
                        //cout<<"S:"<<endl;global_state_2.dump_inline();
                        g_successor_generator->generate_applicable_ops(global_state_2, applicable_ops_2);
                        int amount = applicable_ops_2.size();
                        std::pair<std::map<boost::dynamic_bitset<>, double>::iterator, bool> ret2;
                        std::map<boost::dynamic_bitset<>, double>::iterator it2;

			if (b_child_v.count() > 0) {
                                ret2 = bitcollector.insert(std::pair<boost::dynamic_bitset<>, double>(b_child_v, amount*w));
                                it2 = ret2.first;

                                if (ret2.second) {
                                        //cout<<"raiz bc new is added"<<endl;
                                } else {
                                        //cout<<"raiz bc old is being updated"<<endl; 
                                        it2->second += amount*w;
                                        //cout<<", newcc : "<<it2->second<<"\n"; 
                                }
			}
			//end count the child generated by a childe node
 
                        if (h + g_real + get_adjusted_cost(*op) <= threshold) {
			   Type object = sampler->getType(child.get_id(), h,  1);
			    
                           object.setLevel( level + 1 );

                           SSNode child_node;
                           StateID child_state_id = child.get_id();
                           child_node.set_id(child_state_id);
                           child_node.setWeight(w);
                           child_node.setGreal(g_real + get_adjusted_cost(*op));
                           //cout<<"\t\tChild f<=threshold: h = "<<object.getH()<<" g = "<<child_node.getGreal()<<" f = "<<object.getH() + child_node.getGreal()<<", level = "<<level+1<<", get_adjusted_cost(*op) = "<<get_adjusted_cost(*op)<<   ", w = "<<w<<endl; 
 
			   
			   if (get_adjusted_cost(*op) == 0) {
				//cout<<"\t\tget_adjusted_cost(*op) == 0\n";
				//fflush(NULL);
			   	BFS(child_node, object);
				//cout<<"after BFS in the ss."<<endl;
				std::set<SSQueue>::iterator it;
				for (it = L.begin(); it != L.end(); it++) {	
					SSQueue sst = *it;
					SSNode node = sst.getNode();
					Type t = sst.getT();
					//double new_g_real = node.getGreal();
					StateID new_state_id = node.get_id();
					double w2 = node.getWeight();

					//cout<<"\n\t\tNode restored: h = "<<t.getH()<<", g_real = "<<node.getGreal()<<", f = "<<t.getH() + node.getGreal()<<", level = "<<t.getLevel()<<", w = "<<w2<<"\n";
                        		GlobalState global_state2 = g_state_registry->lookup_state(new_state_id);
                           			
					map<Type, SSNode>::iterator queueIt = queue.find( t );
			   		if( queueIt != queue.end() )
			   		{
                                	SSNode snode = queueIt->second;

                                		//cout<<"\t\t\tzc: The duplicate node is: h = "<<queueIt->first.getH()<<", g = "<<snode.getGreal()<<", f = "<< queueIt->first.getH() + snode.getGreal()<<", w = "<<snode.getWeight()<<", level = "<<queueIt->first.getLevel()<<"\n";
                                
						double wa = (double)snode.getWeight();
						//snode.setWeight( wa + w);
                                		queueIt->second.setWeight(wa + w2); // set w the node that already exists
                                		//cout<<"\t\t\tzc: before ss process starts, the w of the duplicate node is updated to: "<<queueIt->second.getWeight()<<endl; 
                                		//std::pair<std::map<Type, SSNode>::iterator, bool> ret0;
                                		//ret0 = queue.insert(pair<Type, SSNode>(object, snode));
                                		//cout<<"\tsnode.getWeight() = "<<snode.getWeight()<<endl;
                                		//queueIt->second.setWeight(snode.getWeight());
						double prob = ( double )w2 / (double)( wa + w2);
						int rand_100 =  RanGen2->IRandom(0, 99);  //(int)g_rng.next(100);
                          	 
                                		double a = (( double )rand_100) / 100;
                                		//cout<<"a = "<<a<<" prob = "<<prob<<endl;
                                
						if (a < prob) 
						{
                                        		//cout<<"\t\t\tzc: Added even though is duplicate.\n";                               
				        		node.setWeight( wa + w2);
                                        		//cout<<"\t\t\tzc: the w is updated to = "<<node.getWeight()<<endl;
                                        		std::pair<std::map<Type, SSNode>::iterator, bool> ret3;
                                     			queue.erase(t); 
                                        
                                        		ret3 = queue.insert( pair<Type, SSNode>( t, node ));      
                                        		queueIt = ret3.first;
                                        		queueIt->second.setWeight(node.getWeight());
						} else {
                                        		//cout<<"\t\t\tzc: Not added.\n";
                                        		//cout<<"\t\t\tbut the w is updated for the node that already exists to: "<<queueIt->second.getWeight()<<endl;
                                		}
			   		} 
			   		else
			   		{
                                		//cout<<"\t\t\tzc: New node added.\n";
						queue.insert( pair<Type, SSNode>( t, node ) );
                                		//cout<<"\t\tsucc_node2.getWeight() = "<<succ_node2.getWeight()<<"\n";
                                
                                		//cout<<"\t\t\tzc: Child: h = "<< t.getH() <<", g_real = "<< new_g_real <<", f = "<< t.getH() + new_g_real << " threshold: " << threshold <<" w = "<<node.getWeight()<<endl;
                           		}// End queueIt != queue.end()
				}   //End for set lopp
			   } else {
				map<Type, SSNode>::iterator queueIt = queue.find( object );
			   	if( queueIt != queue.end() )
			   	{
                                	SSNode snode = queueIt->second;

                                	//cout<<"\t\tThe duplicate node is: h = "<<queueIt->first.getH()<<", g = "<<snode.getGreal()<<", f = "<< queueIt->first.getH() + snode.getGreal()<<", w = "<<snode.getWeight()<<", level = "<<queueIt->first.getLevel()<<"\n";
                                
					double wa = (double)snode.getWeight();
					//snode.setWeight( wa + w);
                                	queueIt->second.setWeight(wa + w); // set w the node that already exists
                                	//cout<<"\t\tbefore ss process starts, the w of the duplicate node is updated to: "<<queueIt->second.getWeight()<<endl; 
                                	//std::pair<std::map<Type, SSNode>::iterator, bool> ret0;
                                	//ret0 = queue.insert(pair<Type, SSNode>(object, snode));
                                	//cout<<"\tsnode.getWeight() = "<<snode.getWeight()<<endl;
                                	//queueIt->second.setWeight(snode.getWeight());
					double prob = ( double )w / (double)( wa + w );
					int rand_100 =  RanGen2->IRandom(0, 99);  //(int)g_rng.next(100);
                          	 
                                	double a = (( double )rand_100) / 100;
                                	//cout<<"a = "<<a<<" prob = "<<prob<<endl;
                                
					if (a < prob) 
					{
                                        	//cout<<"\t\tAdded even though is duplicate.\n";                               
				        	child_node.setWeight( wa + w);
                                        	//cout<<"\t\tthe w is updated to = "<<child_node.getWeight()<<endl;
                                        	std::pair<std::map<Type, SSNode>::iterator, bool> ret2;
                                     		queue.erase(object); 
                                        
                                        	ret2 = queue.insert( pair<Type, SSNode>( object, child_node ));      
                                        	queueIt = ret2.first;
                                        	queueIt->second.setWeight(child_node.getWeight());
					} else {
                                        	//cout<<"\t\tNot added.\n";
                                        	//cout<<"\t\tbut the w is updated for the node that already exists to: "<<queueIt->second.getWeight()<<endl;
                                	}
			   	} 
			   	else
			   	{
                                	//cout<<"\t\tNew node added\n";
					queue.insert( pair<Type, SSNode>( object, child_node ) );
                                	//cout<<"\t\tchild_node.getWeight() = "<<child_node.getWeight()<<"\n";
                                
                                	//cout<<"\t\tChild: h = "<< h <<", g = "<< g_real + get_adjusted_cost(*op) <<", f = "<< h + g_real + get_adjusted_cost(*op) << " threshold: " << threshold <<" w = "<<child_node.getWeight()<<endl;
                           	}// End queueIt != queue.end()

			   }// End get_adjusted_cost(*op)

                        } //End else f <= threshold
			else 
			{
				//cout << "\t\tNode was pruned!" << endl;
				//cout<<"\t\tChild: h = "<< h <<" g = "<< g_real + get_adjusted_cost(*op) <<", f = "<< h + g_real + get_adjusted_cost(*op) << ", threshold: " << threshold <<"\n";
			} //End f <= threshold
                        //cout<<"\tend Child_"<<(i+1)<<"\n";
		} //End  applicable_ops
                //cout<<"\t__________________end Childs_________________\n";
	}
        
}

void SSSearch::BFS(SSNode root, Type type) {
	//std::queue<SSNode> D;
	std::deque<SSQueue> D;
	SSQueue s1;
	s1.setNode(root);
	s1.setT(type);
        D.push_back(s1);
	
	check.insert(root);
	
	//double weight = root.getWeight();
	//int counter = 0;
        //cout<<"\t\t\tD.size() = "<<D.size()<<endl;
        while (!D.empty()) {
		SSQueue sq = D.front();
                SSNode nodecp = sq.getNode();
		Type t = sq.getT();

                double g_real = nodecp.getGreal();
                StateID state_id = nodecp.get_id();
		double w = nodecp.getWeight();
                double level = t.getLevel();
                //cout<<"\n\t\t\tBFS: Node expanded: h = "<<t.getH()<<", g_real = "<<nodecp.getGreal()<<", f = "<<t.getH() + nodecp.getGreal()<<", level = "<<level<<", w = "<<w<<", stateID,:"<<state_id<<"\n";
                //counter++;
		D.pop_front();

                std::vector<const GlobalOperator *> applicable_ops;
                //Recover the global_state
                GlobalState global_state = g_state_registry->lookup_state(state_id);
                g_successor_generator->generate_applicable_ops(global_state, applicable_ops);
                //cout<<"\t\t\tBFS: applicable_ops.size() = "<<applicable_ops.size()<<endl;
                //cout<<"\t\t\t--------------childs-------------\n";
		for (size_t i = 0; i < applicable_ops.size(); i++) {

                        const GlobalOperator *op = applicable_ops[i];
                        GlobalState child =  g_state_registry->get_successor_state(global_state, *op);

                        int hmin_value = INT_MAX/2;
			int cost_op = get_adjusted_cost(*op);
			SSNode succ_node(child.get_id(), w, g_real + cost_op);

			std::pair<std::set<SSNode, classcomp2>::iterator, bool> r1;
			r1 = check.insert(succ_node);

			if (r1.second) {
				for (size_t i = 0; i < heuristics.size(); i++) {
                                	heuristics[i]->evaluate(child);
					if (!heuristics[i]->is_dead_end()) {
						hmin_value = min(hmin_value, heuristics[i]->get_heuristic());
					} else {
						hmin_value = INT_MAX/2;
						break;
					}
                        	}

                        	double succ_h = hmin_value;
				Type object = sampler->getType(child.get_id(), succ_h,  1);
                      		object.setLevel( level + 1 );
				
				SSQueue s3;
				s3.setNode(succ_node);
				s3.setT(object);

				//cout<<"\t\t\tChild_"<<(i+1)<<" : h = "<<succ_h<<", g_real = "<<succ_node.getGreal()<<", f = "<<succ_h + succ_node.getGreal()<<", level = "<<object.getLevel()<<", w = "<<w<<", stateID,:"<<child.get_id()<<"\n";
				if (succ_h + succ_node.getGreal() <= threshold) {
					if (cost_op == 0) {
						//cout<<"\t\t\tcost = 0, then is inserted to the D.\n";
						D.push_back(s3);			
					} else {
						//cout<<"\t\t\tcost != 0, then is inserted to the L.\n";
						L.insert(s3);
					}
				}
			} else {
				//cout<<"\t\t\tSSQueue with id = "<<child.get_id()<<" already exists.\n";
			}
                }//end for
                //cout<<"\t\t\t-------------End childs------------\n";
	//fflush(NULL);
        }
	/*double result = counter*weight;
	root.setWeight(result);
	vweight.push_back(root);

	//Insert each node.
	double new_f_value = type.getH() + root.getGreal();
        Node2 node2(new_f_value, type.getLevel());
        
        //count nodes expanded
        if (new_f_value <= threshold) {
		std::pair<std::map<Node2, double>::iterator, bool> ret0;
                std::map<Node2, double>::iterator it0;

                ret0 = expanded.insert(pair<Node2, double>(node2, weight));
                it0 = ret0.first;

                if (ret0.second) {
                    //cout<<"new node expanded is added."<<endl;
                } else {
                    //cout<<"node expanded is being updated."<<endl;
                    it0->second += weight;
                    //cout<<"it0->second = "<<it0->second<<endl;
                }
                //end count node
        }*/
	//cout<<"\t\t\tbefore memory error."<<endl;
        //cout<<"\t\t\tis std::queue empty? D.empty() == "<<D.empty()<<endl;
	//cout<<"\t\t\t return L.size() = "<<L.size()<<endl;
}



void SSSearch::generateGeneratedReport() {
       double count_nodes = 0;
       for (map<Node2, double>::iterator iter = generated.begin(); iter != generated.end(); iter++) {
           double n = iter->second;
           count_nodes += n;
       }
       cout<<"count nodes generates : "<<count_nodes/(double)ss_probes<<endl;
       generated.clear();
}

void SSSearch::generateExpandedReport() {
        
        string dominio = domain_name;
        string tarefa = problem_name2;
        string heuristica = heuristic_name2;
        double total_nodes = 0.0;
        for (map<Node2, double>::iterator iter = expanded.begin(); iter != expanded.end(); iter++) {
            double n = iter->second;
            total_nodes += n;
        }
	double predictionExpanded = (double)total_nodes/(double)ss_probes;
        cout<<"count nodes expanded : "<<predictionExpanded <<endl;

        cout<<"dominio = "<<dominio<<endl;
        cout<<"tarefa = "<<tarefa<<endl;
        cout<<"heuristica = "<<heuristica<<endl;

	string dirDomain, dirfDist, outputFile;

	if (is_mov_bound) {
		dirDomain = "mkdir /home/marvin/marvin/testss/"+heuristica+"/reportss_bounds/"+dominio;
        	dirfDist = "mkdir /home/marvin/marvin/testss/"+heuristica+"/reportss_bounds/"+dominio+"/fdist";
        	outputFile = "/home/marvin/marvin/testss/"+heuristica+"/reportss_bounds/"+dominio+"/fdist/"+tarefa;
	} else {
        	dirDomain = "mkdir /home/marvin/marvin/testss/"+heuristica+"/reportss/"+dominio;
        	dirfDist = "mkdir /home/marvin/marvin/testss/"+heuristica+"/reportss/"+dominio+"/fdist";
        	outputFile = "/home/marvin/marvin/testss/"+heuristica+"/reportss/"+dominio+"/fdist/"+tarefa;
	}

        ofstream output;

        output.open(outputFile.c_str());
        output<<"\t"<<outputFile.c_str()<<"\n";
        //output<<"predictionSS: "<<totalPrediction<<"\n";
        output<<"predictionSS: "<<predictionExpanded<<"\n";
        output<<"ss_timer: "<<ss_timer_value<<"\n";
        

        if (system(dirDomain.c_str())) {
           cout<<"Directory: "<<heuristica<<" created."<<endl;
        }

        if (system(dirfDist.c_str())) {
           cout<<"Directory: fdist created."<<endl;
        }
        cout<<"print."<<endl;
        for (size_t i = 0; i <= threshold; i++) {
            int k = 0;
            vector<long> f;
            vector<double> q;
            for (map<Node2, double>::iterator iter = expanded.begin(); iter != expanded.end(); iter++) {
                 Node2 n = iter->first;
                
                 if (i == (size_t)n.getL()) {
                    k++;
                    f.push_back(n.getF());
                    q.push_back(((double)iter->second)/(double)ss_probes);

                    //cout<<"l = "<<n.getL()<<" f = "<<n.getF()<<" q = "<<(iter->second)/ss_probes<<endl;
                    //output<<"l = "<<n.getL()<<" f = "<<n.getF()<<" q = "<<(iter->second)/ss_probes<<"\n";
                 }
            }
            
            cout<<"g:"<<i<<"\n";
            output<<"g:"<<i<<"\n";

            cout<<"size: "<<k<<"\n";            
            output<<"size: "<<k<<"\n"; 
            for (size_t j = 0; j < f.size(); j++) {
                 cout<<"\tf: "<<f.at(j)<<"\tq: "<<q.at(j)<<"\n";
                 output<<"\tf: "<<f.at(j)<<"\tq: "<<q.at(j)<<"\n";
            }
            cout<<"\n";
            output<<"\n";
            
        }
        output.close();
        expanded.clear();
}


double SSSearch::getProbingResult() {
        double expansions = 0;
        
        for (size_t i = 0; i < vweight.size(); i++) {
             SSNode n = vweight.at(i);
             expansions += n.getWeight();
        }
	//cout << endl;
        //cout<<"expansions = "<<expansions<<endl;
        return expansions;
}

void SSSearch::generateSSCCReport() {
        string dominio = domain_name;
        string tarefa = problem_name2;
        string heuristica = heuristic_name2;

        cout<<"dominio = "<<dominio<<endl;
        cout<<"tarefa = "<<tarefa<<endl;
        cout<<"heuristica = "<<heuristica<<endl;
        int length = tarefa.size();
        cout<<"length = "<<length<<endl;
        size_t found = tarefa.find(".");
        cout<<"found = "<<found<<endl;
        string name = tarefa.substr(0, found);
        name+="_F_";
        name+=boost::lexical_cast<std::string>(threshold);
        name += ".csv";
        cout<<"name = "<<name<<endl;
	
	string dirDomain, dirSSCC, outputFile;
	if (is_mov_bound) {
        	dirDomain = "mkdir /home/marvin/marvin/testss/"+heuristica+"/reportss_bounds/"+dominio;
        	dirSSCC = "mkdir /home/marvin/marvin/testss/"+heuristica+"/reportss_bounds/"+dominio+"/bc";
        	outputFile = "/home/marvin/marvin/testss/"+heuristica+"/reportss_bounds/"+dominio+"/bc/"+name;

	} else {
		dirDomain = "mkdir /home/marvin/marvin/testss/"+heuristica+"/reportss/"+dominio;
        	dirSSCC = "mkdir /home/marvin/marvin/testss/"+heuristica+"/reportss/"+dominio+"/bc";
        	outputFile = "/home/marvin/marvin/testss/"+heuristica+"/reportss/"+dominio+"/bc/"+name;
	}

        if (system(dirDomain.c_str())) {
           cout<<"Directory: "<<heuristica<<" created."<<endl;
        }

        if (system(dirSSCC.c_str())) {
           cout<<"Directory: SSCC created."<<endl;
        }

        ofstream output;
        output.open(outputFile.c_str());


        for (size_t i = 0; i < heuristics.size(); i++) {
            string heur_name = heuristics[i]->get_heur_name();
            output<<"h(,"<<i<<"):,"<<heur_name<<"\n";
        }

       for (map<boost::dynamic_bitset<>, double>::iterator iter = bitcollector.begin(); iter != bitcollector.end(); iter++) {
                boost::dynamic_bitset<> b_node_v = iter->first;
                double cc = iter->second;
                //cout<<"bc(";
                output<<"bc(";
                for (size_t i = 0; i < b_node_v.size(); i++) {
                        //cout<<b_node_v.test(i);
                        output<<b_node_v.test(i);
                        if (i != b_node_v.size() - 1) {
                                //cout<<"/";
                                output<<"/";
                        }
                }
                //cout<<")cc="<<(double)cc/(double)ss_probes<<"\n";
                output<<")cc="<<(double)cc/(double)ss_probes<<"\n";
        }
        output.close(); 
}

void SSSearch::printQueue() {
        cout<<"\nPrintQueue\n";
	for (map<Type, SSNode>::iterator iter = queue.begin(); iter !=  queue.end(); iter++) {
            Type t = iter->first;
            SSNode t2  = iter->second;
            cout<<"\t\t h = "<<t.getH()<<" g = "<<t.getLevel()<<" f = "<<t.getH() + t2.getGreal()<<" w = "<<t2.getWeight()<<"\n"; 
        }
        cout<<"\n";
        cout<<"\nEnd PrintQueue\n";
}

void SSSearch::initialize() {
	cout << "SSSearch ..." << endl;
        ss_timer.reset();

	//ss+cc santiago code
        if (use_saved_pdbs) {
                stored_GA_patterns.clear();
                cout<<"cleared store_GA_patterns."<<endl;
        }	
}

static SearchEngine *_parse(OptionParser &parser) {
        
	parser.add_option<ScalarEvaluator *>("eval");
	
	SearchEngine::add_options_to_parser(parser);
	Options opts = parser.parse();
	SSSearch *engine = 0;
	if (!parser.dry_run()) {
		engine = new SSSearch(opts);
	}
	return engine;
}


static Plugin<SearchEngine> _plugin("ss", _parse);
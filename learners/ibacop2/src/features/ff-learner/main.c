

/*
 * THIS SOURCE CODE IS SUPPLIED  ``AS IS'' WITHOUT WARRANTY OF ANY KIND, 
 * AND ITS AUTHOR AND THE JOURNAL OF ARTIFICIAL INTELLIGENCE RESEARCH 
 * (JAIR) AND JAIR'S PUBLISHERS AND DISTRIBUTORS, DISCLAIM ANY AND ALL 
 * WARRANTIES, INCLUDING BUT NOT LIMITED TO ANY IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, AND
 * ANY WARRANTIES OR NON INFRINGEMENT.  THE USER ASSUMES ALL LIABILITY AND
 * RESPONSIBILITY FOR USE OF THIS SOURCE CODE, AND NEITHER THE AUTHOR NOR
 * JAIR, NOR JAIR'S PUBLISHERS AND DISTRIBUTORS, WILL BE LIABLE FOR 
 * DAMAGES OF ANY KIND RESULTING FROM ITS USE.  Without limiting the 
 * generality of the foregoing, neither the author, nor JAIR, nor JAIR's
 * publishers and distributors, warrant that the Source Code will be 
 * error-free, will operate without interruption, or will meet the needs 
 * of the user.
 */






/*********************************************************************
 * File: main.c
 * Description: The main routine for the Metric-FastForward Planner.
 *
 * Author: Joerg Hoffmann 2001 / 2002
 * 
 *********************************************************************/ 








#include "ff.h"

#include "memory.h"
#include "output.h"

#include "parse.h"

#include "expressions.h"

#include "inst_pre.h"
#include "inst_easy.h"
#include "inst_hard.h"
#include "inst_final.h"

#include "relax.h"
#include "search.h"
#include "matcher.h"
#include "learner.h"
#include "learn-ltl.h"
#include "learn-helpful.h"
#include "hornclause-reader.h"
#include "derived-preds.h"
#include "gtask-classifier.h"



/*
 *  ----------------------------- GLOBAL VARIABLES ----------------------------
 */












/*******************
 * GENERAL HELPERS *
 *******************/


/* raquel */
float final_total_cost=INFINITY;
float total_time_relax=0;
int total_levels_relax=0;

int Search_upper_bound=MAX_PLAN_LENGTH;



/* used to time the different stages of the planner
 */
float gtempl_time = 0, greach_time = 0, grelev_time = 0, gconn_time = 0;
float gLNF_time = 0, gsearch_time = 0;
float time_search = 0;
float matching_time = 0;

/* the command line inputs
 */
struct _command_line gcmd_line;

/* number of states that got heuristically evaluated
 */
int gevaluated_states = 0;

int gevaluated_states_lookahead_FF_heuristic = 0;

int gexpanded_states = 0;

long int ggenerated_nodes = 0;
long int ggenerated_atfirst = 0;

/* globals for learning info */
int learn_total_examples = 0;
long int learn_positive_transition = 0;
long int learn_positive_insolution = 0;
long int learn_positive_repeated = 0;

long int learn_recog_dead_end = 0; 
/* maximal depth of breadth first search
 */
int gmax_search_depth = 0;





/***********
 * PARSING *
 ***********/







/* used for pddl parsing, flex only allows global variables
 */
int gbracket_count;
char *gproblem_name;

/* The current input line number
 */
int lineno = 1;

/* The current input filename
 */
char *gact_filename;

/* The pddl domain name
 */
char *gdomain_name = NULL;

/* loaded, uninstantiated operators
 */
PlOperator *gloaded_ops = NULL;

/* stores initials as fact_list 
 */
PlNode *gorig_initial_facts = NULL;

/* not yet preprocessed goal facts
 */
PlNode *gorig_goal_facts = NULL;

/* axioms as in UCPOP before being changed to ops
 */
PlOperator *gloaded_axioms = NULL;

/* the types, as defined in the domain file
 */
TypedList *gparse_types = NULL;

/* the constants, as defined in domain file
 */
TypedList *gparse_constants = NULL;

/* the predicates and their arg types, as defined in the domain file
 */
TypedListList *gparse_predicates = NULL;

/* the functions and their arg types, as defined in the domain file
 */
TypedListList *gparse_functions = NULL;

/* the objects, declared in the problem file
 */
TypedList *gparse_objects = NULL;

/* the metric
 */
Token gparse_optimization;
ParseExpNode *gparse_metric = NULL;


/* connection to instantiation ( except ops, goal, initial )
 */

/* all typed objects 
 */
FactList *gorig_constant_list = NULL;

/* the predicates and their types
 */
FactList *gpredicates_and_types = NULL;

/* the functions and their types
 */
FactList *gfunctions_and_types = NULL;












/*****************
 * INSTANTIATING *
 *****************/









/* global arrays of constant names,
 *               type names (with their constants),
 *               predicate names,
 *               predicate aritys,
 *               defined types of predicate args
 */
Token gconstants[MAX_CONSTANTS];
int gnum_constants = 0;
Token gtype_names[MAX_TYPES];
int gtype_consts[MAX_TYPES][MAX_TYPE];
Bool gis_member[MAX_CONSTANTS][MAX_TYPES];
int gtype_size[MAX_TYPES];
int gnum_types = 0;
Token gpredicates[MAX_PREDICATES];
int garity[MAX_PREDICATES];
int gpredicates_args_type[MAX_PREDICATES][MAX_ARITY];
int gnum_predicates = 0;
int gnum_orig_predicates = 0;
Token gfunctions[MAX_FUNCTIONS];
int gf_arity[MAX_FUNCTIONS];
int gfunctions_args_type[MAX_FUNCTIONS][MAX_ARITY];
int gnum_functions = 0;





/* the domain in integer (Fact) representation
 */
Operator_pointer goperators[MAX_OPERATORS];
int gnum_operators = 0;
Fact *gfull_initial;
int gnum_full_initial = 0;
FluentValue *gfull_fluents_initial;
int gnum_full_fluents_initial = 0;
WffNode *ggoal = NULL;

ExpNode *gmetric = NULL;



/* stores inertia - information: is any occurence of the predicate
 * added / deleted in the uninstantiated ops ?
 */
Bool gis_added[MAX_PREDICATES];
Bool gis_deleted[MAX_PREDICATES];


/* for functions we *might* want to say, symmetrically, whether it is
 * increased resp. decreased at all.
 *
 * that is, however, somewhat involved because the right hand
 * sides can be arbirtray expressions, so we have no guarantee
 * that increasing really does adds to a functions value...
 *
 * thus (for the time being), we settle for "is the function changed at all?"
 */
Bool gis_changed[MAX_FUNCTIONS];



/* splitted initial state:
 * initial non static facts,
 * initial static facts, divided into predicates
 * (will be two dimensional array, allocated directly before need)
 */
Facts *ginitial = NULL;
int gnum_initial = 0;
Fact **ginitial_predicate;
int *gnum_initial_predicate;

/* same thing for functions
 */
FluentValues *gf_initial;
int gnum_f_initial = 0;
FluentValue **ginitial_function;
int *gnum_initial_function;



/* the type numbers corresponding to any unary inertia
 */
int gtype_to_predicate[MAX_PREDICATES];
int gpredicate_to_type[MAX_TYPES];

/* (ordered) numbers of types that new type is intersection of
 */
TypeArray gintersected_types[MAX_TYPES];
int gnum_intersected_types[MAX_TYPES];



/* splitted domain: hard n easy ops
 */
Operator_pointer *ghard_operators;
int gnum_hard_operators;
NormOperator_pointer *geasy_operators;
int gnum_easy_operators;



/* so called Templates for easy ops: possible inertia constrained
 * instantiation constants
 */
EasyTemplate *geasy_templates;
int gnum_easy_templates;



/* first step for hard ops: create mixed operators, with conjunctive
 * precondition and arbitrary effects
 */
MixedOperator *ghard_mixed_operators;
int gnum_hard_mixed_operators;



/* hard ''templates'' : pseudo actions
 */
PseudoAction_pointer *ghard_templates;
int gnum_hard_templates;



/* store the final "relevant facts"
 */
Fact grelevant_facts[MAX_RELEVANT_FACTS];
int gnum_relevant_facts = 0;
int gnum_pp_facts = 0;
/* store the "relevant fluents"
 */
Fluent grelevant_fluents[MAX_RELEVANT_FLUENTS];
int gnum_relevant_fluents = 0;
Token grelevant_fluents_name[MAX_RELEVANT_FLUENTS];
/* this is NULL for normal, and the LNF for
 * artificial fluents.
 */
LnfExpNode_pointer grelevant_fluents_lnf[MAX_RELEVANT_FLUENTS];



/* the final actions and problem representation
 */
Action *gactions = NULL;
int gnum_actions;
State ginitial_state;
int *glogic_goal = NULL;
int gnum_logic_goal = 0;
Comparator *gnumeric_goal_comp = NULL;
ExpNode_pointer *gnumeric_goal_lh = NULL, *gnumeric_goal_rh = NULL;
int gnum_numeric_goal = 0;

/* TD. For fast computing of ROLLER target goals*/
int *gtarget_goal = NULL;
int gnum_target_goal = 0;



/* direct numeric goal access
 */
Comparator *gnumeric_goal_direct_comp;
float *gnumeric_goal_direct_c;



/* to avoid memory leaks; too complicated to identify
 * the exact state of the action to throw away (during construction),
 * memory gain not worth the implementation effort.
 */
Action *gtrash_actions = NULL;



/* additional lnf step between finalized inst and
 * conn graph
 */
Comparator *glnf_goal_comp = NULL;
LnfExpNode_pointer *glnf_goal_lh = NULL;
float *glnf_goal_rh = NULL;
int gnum_lnf_goal = 0;

LnfExpNode glnf_metric;
Bool goptimization_established = FALSE;







/**********************
 * CONNECTIVITY GRAPH *
 **********************/







/* one ops (actions) array ...
 */
OpConn *gop_conn;
int gnum_op_conn;



/* one effects array ...
 */
EfConn *gef_conn;
int gnum_ef_conn;



/* one facts array.
 */
FtConn *gft_conn;
int gnum_ft_conn;



/* and: one fluents array.
 */
FlConn *gfl_conn;
int gnum_fl_conn;
int gnum_real_fl_conn;/* number of non-artificial ones */



/* final goal is also transformed one more step.
 */
int *gflogic_goal = NULL;
int gnum_flogic_goal = 0;
Comparator *gfnumeric_goal_comp = NULL;
int *gfnumeric_goal_fl = NULL;
float *gfnumeric_goal_c = NULL;
int gnum_fnumeric_goal = 0;

/* direct access (by relevant fluents)
 */
Comparator *gfnumeric_goal_direct_comp = NULL;
float *gfnumeric_goal_direct_c = NULL;











/*******************
 * SEARCHING NEEDS *
 *******************/











/* applicable actions
 */
int *gA;
int gnum_A;



/* communication from extract 1.P. to search engine:
 * 1P action choice
 */
int *gH;
int gnum_H;
/* cost of relaxed plan
 */
float gcost;
float float_admissible_h;
int int_admissible_h;


/* raquel: actions in the relaxed plan */
int g_RP[MAX_PLAN_LENGTH];
int gnum_RP;

int numero_rp_igual=0;
int numero_rp_distinto =0;
int distinto_misma_h=0;
int distinto_mayor_add=0;
float diff = 0;

/* to store plan
 */
int gplan_ops[MAX_PLAN_LENGTH];
int gnum_plan_ops = 0;



/* stores the states that the current plan goes through
 * ( for knowing where new agenda entry starts from )
 */
State gplan_states[MAX_PLAN_LENGTH + 1];







/* dirty: multiplic. of total-time in final metric LNF
 */
float gtt;







/* the mneed structures
 */
Bool **gassign_influence;
Bool **gTassign_influence;



/* the real var input to the mneed computation.
 */
Bool *gmneed_start_D;
float *gmneed_start_V;


BfsNode *gSearch_tree;

Solution *Sols_for_learning=NULL;
int numSolutions=0;
int numSols_for_learning=0;

Bool domain_with_static_facts;
Facts *gStatic_literals=NULL;


int feature_hmax = 0;
int feature_hff = 0;
float feature_hff_ratio = 0.0;
int feature_hmax_momentum = 0;

int feature_rp_balance_min = 0;
int feature_goal_balance_min = 0;
float feature_rp_balance_avg = 0.0;
float feature_rp_balance_var = 0.0;
float feature_goal_balance_avg = 0.0; 
float feature_goal_balance_var = 0.0;
float feature_balance_ratio = 0.0;
float feature_unbalance_ratio = 0.0;
unsigned long feature_balance_distorsion = 0;


/*
 *  ----------------------------- HEADERS FOR PARSING ----------------------------
 * ( fns defined in the scan-* files )
 */







void get_fct_file_name( char *filename );
void load_ops_file( char *filename );
void load_fct_file( char *filename );






/*
 *  ----------------------------- HELPING FUNCTIONS ----------------------------
 */












void output_planner_info( void )

{

  printf( "\n\ntime spent: %7.2f seconds instantiating %d easy, %d hard action templates", 
	  gtempl_time, gnum_easy_templates, gnum_hard_mixed_operators );
  printf( "\n            %7.2f seconds reachability analysis, yielding %d facts and %d actions", 
	  greach_time, gnum_pp_facts, gnum_actions );
  printf( "\n            %7.2f seconds creating final representation with %d relevant facts, %d relevant fluents", 
	  grelev_time, gnum_relevant_facts, gnum_relevant_fluents );
  printf( "\n            %7.2f seconds computing LNF",
	  gLNF_time );
  printf( "\n            %7.2f seconds building connectivity graph",
	  gconn_time );
  printf( "\n            %7.2f seconds searching, evaluating %d states, to a max depth of %d", 
	  gsearch_time, gevaluated_states, gmax_search_depth );
  printf( "\n            %7.2f seconds total time", 
	  gtempl_time + greach_time + grelev_time + gLNF_time + gconn_time + gsearch_time );

  if (gcmd_line.search_algorithm == 10 || gcmd_line.search_algorithm == 12 || gcmd_line.search_algorithm == 13 || gcmd_line.search_algorithm == 16 || gcmd_line.search_algorithm == 17  || gcmd_line.search_algorithm == 18 || gcmd_line.search_algorithm == 22 || gcmd_line.search_algorithm == 23 ){
    printf( "\n            %7.2f seconds matching time",  matching_time );
    printf( "\n               expanding %d states", gexpanded_states );
    if (gcmd_line.search_algorithm == 17  || gcmd_line.search_algorithm == 18)
      {
	printf( "\n               evaluating %d states for lookahead generation", gevaluated_states_lookahead_FF_heuristic);
	printf( "\n               evaluating %d states for searching", gevaluated_states - gevaluated_states_lookahead_FF_heuristic);
      }
  }

  if (gcmd_line.optimize && goptimization_established)
    {
      printf( "\n\ntotal cost: %7.2f", final_total_cost);
      printf("\n\n");
    }
  
  fflush(stdout);
  /*exit( 0 );*/

}

void output_planner_info_to_file (void)
{
  FILE *output_file; 
  int success_closing;
  char output_file_name[MAX_LENGTH];
  int  first_time=0;
 
  sprintf(output_file_name, "%s%s", gcmd_line.path, gcmd_line.ofile_name);
  //sprintf(output_file_name, "%s", gcmd_line.ofile_name);
  output_file=fopen(output_file_name, "r");
  if (output_file==NULL)
    {
      first_time++;
    }
  else
    fclose(output_file);

  output_file=fopen(output_file_name, "a+");

  if (output_file == NULL){
     printf("\ncan't open file %s to write final results\n", output_file_name);
  }
  else {
    /* output info:
    fct_file_name total-cost ops-number  number-of-evaluated-states max-depth seconds-searching seconds-building-relaxed-plan
    seconds-total-time total-levels-relaxed-plan 
    */
       if (first_time > 0 )
      {
	fprintf(output_file, "# fct_file_name total-cost ops-number number-of-evaluated-states max-depth-ehc seconds-searching second-building-relaxed-graphplan seconds-total-time total-relaxed-graphplan-levels max-open-list-elements");
	fprintf(output_file, "\n # %s", gcmd_line.ops_file_name);
      }
       
       
    if (final_total_cost==INFINITY)
      fprintf(output_file, "\n#");
    else
      fprintf(output_file, "\n");

    fprintf(output_file, "%-8s %10.2f %8d %8d %8d %10.2f %10.2f %10.2f %8d %6d", 
	    gcmd_line.fct_file_name, final_total_cost, gnum_plan_ops,  gevaluated_states,
	    gmax_search_depth, gsearch_time, total_time_relax, 
	    gtempl_time + greach_time + grelev_time + gLNF_time + gconn_time + gsearch_time, 
	    total_levels_relax,-1);

    
    success_closing=fclose(output_file); 
    if (success_closing != 0){
     printf("\ncan't close file %s\n", output_file_name);
    }
  }
}


void output_learner_info_to_file (void)
{
  FILE *output_file; 
  int success_closing;
  char output_file_name[MAX_LENGTH];
  int  first_time=0;
  int line_counter=0;
  float total_time = gtempl_time + greach_time + grelev_time + gLNF_time + gconn_time + gsearch_time;
  char line[MAX_LENGTH] = "";

  sprintf(output_file_name, "%s%s", gcmd_line.knowledge_path, "learner-info.txt");

  output_file=fopen(output_file_name, "r");
  if (output_file==NULL){
      first_time++;
      line_counter++;
  }
  else{
    while(fgets(line,sizeof(line), output_file)) 
      line_counter++;    
    fclose(output_file);
    
  }

  output_file=fopen(output_file_name, "a+");

  if (output_file == NULL){
     printf("\ncan't open file %s to write learning results\n", output_file_name);
  }
  else {
    /* output info:*/
       if (first_time > 0 )
      {
	fprintf(output_file, "#no. fichero cost time generated gen_1sol numSolutions learnSolution num_examples ");
	fprintf(output_file, "positive_transitions positive_insol positive_repeated num_dead_ends num_objects \n");
	/*fprintf(output_file, "\n # %s", gcmd_line.ops_file_name);*/
      }
       
       fprintf(output_file, "%3d %s %8d %10.2f %8ld %8ld %6d %6d %6d %6ld %6ld %6ld %4d \n", 
	       line_counter, gcmd_line.fct_file_name, Search_upper_bound, total_time, ggenerated_nodes, ggenerated_atfirst,
	       numSolutions, numSols_for_learning, learn_total_examples, learn_positive_transition, learn_positive_insolution,
	       learn_positive_repeated, learn_recog_dead_end, gnum_constants);

    
    success_closing=fclose(output_file); 
    if (success_closing != 0){
     printf("\ncan't close file %s\n", output_file_name);
    }
  }
}

void output_initfeature_info_to_file (char* name)
{
  FILE *output_file; 
  int success_closing;
  char output_file_name[MAX_LENGTH];
  int  first_time=0;
  int line_counter=0;
  float total_time = gtempl_time + greach_time + grelev_time + gLNF_time + gconn_time + gsearch_time;
  char line[MAX_LENGTH] = "";

  //sprintf(output_file_name, "%s%s", gcmd_line.knowledge_path, "initfeature-info.txt");
  char nameFile[150];
  memset(nameFile, '\0', sizeof(nameFile));
  strcpy(nameFile, name);
  strcat(nameFile, "/initfeature-info.txt");
  printf(nameFile);
  printf("\n\n*******\n\n");
  //sprintf(output_file_name, "***NAme file:: %s\n", nameFile);
  output_file=fopen("initfeature-info.txt", "r");
  
  if (output_file==NULL){
      first_time++;
      line_counter++;
  }
  else{
    while(fgets(line,sizeof(line), output_file)) 
      line_counter++;    
    fclose(output_file);
    
  }
  printf("initfeature-info.txt",  "\n");
  output_file=fopen("initfeature-info.txt" , "w");

  if (output_file == NULL){
     printf("\ncan't open file %s to write learning results\n", output_file_name);
  }
  else {
    /* output info:*/
      /* if (first_time > 0 )
      {
	fprintf(output_file, "#no., fichero, num_relevant_facts, num_actions, h_max, h_ff, h_ff_ratio, ");
	fprintf(output_file, "rp_fact_balance_min, rp_fact_balance_avg, rp_fact_balance_var, ");
	fprintf(output_file, "rp_goal_balance_min, rp_goal_balance_avg, rp_goal_balance_var\n");
      }*/
       
       fprintf(output_file, "%3d, %s, %d, %d, %d, %d, %.6f, ", line_counter, gcmd_line.fct_file_name, 
	       gnum_relevant_facts, gnum_actions, feature_hmax, feature_hff,  feature_hff_ratio);
       fprintf(output_file, "%d, %.6f, %.6f, ", feature_rp_balance_min, feature_rp_balance_avg, feature_rp_balance_var);
       fprintf(output_file, "%d, %.6f, %.6f, ", feature_goal_balance_min, feature_goal_balance_avg, feature_goal_balance_var);
       fprintf(output_file, "%.6f, %.6f, %lu\n", feature_balance_ratio, feature_unbalance_ratio, feature_balance_distorsion);
       

    success_closing=fclose(output_file); 
    if (success_closing != 0){
     printf("\ncan't close file %s\n", output_file_name);
    }
  }
}





void output_learner_end(void){
//   int i;
  printf("\n >>> SEARCHING FOR LEARNING DONE! \n");
  printf("\n %7.2f exploring total time ", gtempl_time + greach_time + grelev_time + gLNF_time + gconn_time + gsearch_time );
  printf("\n %ld total generated nodes", ggenerated_nodes);
  printf("\n %ld generated at first solution", ggenerated_atfirst);
  printf("\n %d number of best-cost solutions", numSolutions);
  printf("\n %d number of used solutions for learning", numSols_for_learning);
  printf("\n\n %d number of training examples ", learn_total_examples);
  printf("\n %ld number of positive transitions ", learn_positive_transition);
  printf("\n %ld number of positive transitions in found solutions ", learn_positive_insolution);
  printf("\n %ld number of positive transitions in repeated nodes ", learn_positive_repeated);
  printf("\n\n %ld number of recognized dead-ends ", learn_recog_dead_end);
  printf("\n\n %d number of objects \n", gnum_constants);
}

void ff_usage( void )

{

  printf("\nusage of ff-cbp:\n");

  printf("\nOPTIONS   DESCRIPTIONS\n\n");
  printf("-p <str>    path for operator and fact file\n");
  printf("-o <str>    operator file name\n");
  printf("-f <str>    fact file name\n\n"); 

  printf("-F <file-name> results file name\n\n"); 

  //  printf("-E          don't do enforced hill-climbing try before bestfirst\n\n");

  printf("-g <num>    set weight w_g in w_g*g(s) + w_h*h(s) \n");
  printf("-h <num>    set weight w_h in w_g*g(s) + w_h*h(s) \n\n");

  printf("-O          switch on optimization expression (default is plan length)\n\n");

  printf("-U          use plan length heuristic in cost-EHC (default is cost heuristic)\n\n");

  printf("-H <num>    heuristic (default 0: Metric-FF) \n");
  printf("                0: Metric-FF\n");
  printf("                1: hlevel max propagation\n");
  printf("                2: hlevel add propagation\n");
  printf("                3: hmax \n");
  printf("                4: hadd \n");
  printf("                5: hadd con helpful actions \n\n");

  printf("-S <num>    search algorithm (default 0: Metric-FF EHC) \n");
  printf("                0: EHC Metric-FF original\n");
  printf("                1: best first Metric-FF original\n");
  printf("                2: CEHC (EHC with and without costs)\n");
  printf("                3: anytime BFS (bounded by g value and repeated states prune)\n");
  printf("                4: anytime BFS + helpful and secondary lists \n");
  printf("                5: NOT USE. Trials\n");
  printf("                6: anytime BFS + rescue nodes\n");
  printf("                7: anytime BFS + lookahead + rescue nodes\n");
  printf("                8: NOT USE. Trials\n");
  printf("                9: anytime BFS prune + lookahead + helpful and secondary lists\n");
  printf("                10: depth first with chronological backtracking and Roller\n");
  printf("                11: modified Hill-Climbing\n");
  printf("                12: anytime BFS + Roller policy lookahead with horizon\n");
  printf("                13: anytime BFS + Roller policy lookahead with horizon + rescue nodes\n");
  printf("                14: BFS+BnB (exhaustive) for learning \n");
  printf("                15: BFS+BnB (exhaustive) for learning using previous solution as upper bound\n");
  printf("                16: depth first with chronological backtracking sorting actions using ff heuristic (for Roller paper). Set h weigth (-h) to 0 for not sorting actions\n");
  printf("                17: anytime BFS + FF heuristic policy lookahead with horizon (for Roller paper). Set horizon equal to 0 for eliminating lookahead generation\n");
  printf("                18: anytime BFS + FF heuristic policy lookahead with horizon + rescue nodes (for Roller paper). Set horizon equal 0 for eliminating lookahead generation\n");
  printf("                21: Random Depth-First for DIP-Generator\n");
  printf("                22: anytime BFS with secondary list for non HA + Roller policy lookahead with horizon\n");
  printf("                23: anytime BFS with secondary list for non HA +  FF heuristic policy lookahead with horizon\n\n");
  printf("                24: Depth-First for Derived-predicate trees\n");
  printf("                25: Depth-First for Derived-predicate trees and Helpful Actions\n");
  printf("                26: Anytime BFS for Derived-predicate trees\n");
  printf("                27: Hill-climbing with horizon -Z. For cutting off the search in psuedo-rrt for goal generation.\n");
  printf("                28: Compute the init-state features. This does not perform search.\n");
  printf("                30: Goal-Task classifier for  ROLLER \n");
  printf("-n          not stopping at first solution for anytime algorithms\n\n");

  printf("-L <num>    Writing Examples for learning \n");
  printf("                1: LTL for TLPlan \n");
  printf("                2: Helpful Context for ROLLER\n");

  printf("-D <num>    use HDIFF (default 0: not use it ) \n");
  printf("                1: HDIFF\n");
  printf("                2: opposite HDIFF\n");

  printf("-c <num> horizon for the BFS Roller policy algorithm (-S 12,13,17,18,22,23) (default 100 ) \n");
  printf("-s <num> seed \n\n");
  printf("-R          Using the repeated state check in the exhaustive BFS-BnB (-S 14) \n");
  printf("-N          Upper-bound in the number of generated nodes (for -S [14 |15] \n");
  printf("-Y          Save Repeated lists of nodes \n");
  printf("-Z <num>    Allow empty goals for -S 21. Stop at depth <num>.\n");
  printf("-X <num>    Continue even when goals are achieved until depth = <num> if possible. For -S 21.\n");

  if ( 0 ) {
    printf("-i <num>    run-time information level( preset: 1 )\n");
    printf("      0     only times\n");
    printf("      1     problem name, planning process infos\n");
    printf("    101     parsed problem data\n");
    printf("    102     cleaned up ADL problem\n");
    printf("    103     collected string tables\n");
    printf("    104     encoded domain\n");
    printf("    105     predicates inertia info\n");
    printf("    106     splitted initial state\n");
    printf("    107     domain with Wff s normalized\n");
    printf("    108     domain with NOT conds translated\n");
    printf("    109     splitted domain\n");
    printf("    110     cleaned up easy domain\n");
    printf("    111     unaries encoded easy domain\n");
    printf("    112     effects multiplied easy domain\n");
    printf("    113     inertia removed easy domain\n");
    printf("    114     easy action templates\n");
    printf("    115     cleaned up hard domain representation\n");
    printf("    116     mixed hard domain representation\n");
    printf("    117     final hard domain representation\n");
    printf("    118     reachability analysis results\n");
    printf("    119     facts selected as relevant\n");
    printf("    120     final domain and problem representations\n");
    printf("    121     normalized expressions representation\n");
    printf("    122     LNF: translated subtractions representation\n");
    printf("    123     summarized effects LNF  representation\n");
    printf("    124     encoded LNF representation\n");
    printf("    125     connectivity graph\n");
    printf("    126     fixpoint result on each evaluated state\n");
    printf("    127     1P extracted on each evaluated state\n");
    printf("    128     H set collected for each evaluated state\n");
    
    
    /*    printf("    125     False sets of goals <GAM>\n"); */
    /*    printf("    126     detected ordering constraints leq_h <GAM>\n"); */
    /*    printf("    127     the Goal Agenda <GAM>\n"); */
    
    
    
    /*   printf("    109     reachability analysis results\n"); */
    /*   printf("    110     final domain representation\n"); */
    /*   printf("    111     connectivity graph\n"); */
    /*   printf("    112     False sets of goals <GAM>\n"); */
    /*   printf("    113     detected ordering constraints leq_h <GAM>\n"); */
    /*   printf("    114     the Goal Agenda <GAM>\n"); */
    /*   printf("    115     fixpoint result on each evaluated state <1Ph>\n"); */
    /*   printf("    116     1P extracted on each evaluated state <1Ph>\n"); */
    /*   printf("    117     H set collected for each evaluated state <1Ph>\n"); */
    
    printf("\n-d <num>    switch on debugging\n\n");
  }

}



Bool process_command_line( int argc, char *argv[] )

{

  char option;

  gcmd_line.display_info = 1;
  gcmd_line.debug = 0;
  gcmd_line.stop_at_first_sol = TRUE;
  gcmd_line.check_repeated = FALSE;
  gcmd_line.save_repeated_lists = FALSE;
  gcmd_line.timeout = INFINITY;

  gcmd_line.learner = -1;
  gcmd_line.node_bound = INFINITY;
  gcmd_line.adm_pruning = FALSE;
  
  gcmd_line.info_record = 0;
  //  gcmd_line.ehc = TRUE;
  gcmd_line.optimize = FALSE;

  /* default: greedy best first search.
   */
  gcmd_line.g_weight = -1;
  gcmd_line.h_weight = -1;

  gcmd_line.seed = 0;
  /* raquel
   */
  gcmd_line.heuristic = 0;
  gcmd_line.use_cost_heuristic = TRUE;
  gcmd_line.search_algorithm = 0;
  gcmd_line.o_file = FALSE;
  gcmd_line.hdiff = 0;
  gcmd_line.roller_bfs_horizon = 100;

  gcmd_line.steps_empty_goal = 0;
  gcmd_line.steps_with_goals = 0;

  gcmd_line.apply_harmless = FALSE;

  memset(gcmd_line.ops_file_name, 0, MAX_LENGTH);
  memset(gcmd_line.fct_file_name, 0, MAX_LENGTH);
  memset(gcmd_line.path, 0, MAX_LENGTH);
  memset(gcmd_line.knowledge_path, 0, MAX_LENGTH);   

  strcpy(gcmd_line.knowledge_path, "");

  while ( --argc && ++argv ) {
    if ( *argv[0] != '-' || strlen(*argv) != 2 ) {
      return FALSE;
    }
    option = *++argv[0];
    switch ( option ) {
      /*    case 'E':
      gcmd_line.ehc = FALSE;
      break;
      */
    case 'O':
      gcmd_line.optimize = TRUE;
      //      gcmd_line.ehc = FALSE;
      break;   
    case 'U':
      gcmd_line.use_cost_heuristic = FALSE;
      break;   
    case 'n':
      gcmd_line.stop_at_first_sol = FALSE;
      break;
    case 'R':
      gcmd_line.check_repeated = TRUE;
      break;
    case 'Y':
      gcmd_line.save_repeated_lists = TRUE;
      break;
    case 'M':
      gcmd_line.apply_harmless = TRUE;
      break;
    case 'A':
      gcmd_line.adm_pruning = TRUE;
      break;

    default:
      if ( --argc && ++argv ) {
	switch ( option ) {
	case 'p':
	  strncpy( gcmd_line.path, *argv, MAX_LENGTH );
	  break;
	case 'o':
	  strncpy( gcmd_line.ops_file_name, *argv, MAX_LENGTH );
	  break;
	case 'f':
	  strncpy( gcmd_line.fct_file_name, *argv, MAX_LENGTH );
	  break;
	case 'i':
	  sscanf( *argv, "%d", &gcmd_line.display_info );
	  break;
	case 'I':
	  sscanf( *argv, "%d", &gcmd_line.info_record);
	  break;
	case 'd':
	  sscanf( *argv, "%d", &gcmd_line.debug );
	  break;
	case 'g':
	  sscanf( *argv, "%f", &gcmd_line.g_weight );
	  break;
	case 'h':
	  sscanf( *argv, "%f", &gcmd_line.h_weight );
	  break;
	case 't':
	  sscanf( *argv, "%d", &gcmd_line.timeout );
	  break;
	case 'N':
	  sscanf( *argv, "%ld", &gcmd_line.node_bound);
	  break;
	case 'Z':
	  sscanf( *argv, "%d", &gcmd_line.steps_empty_goal);
	  break;
	case 'X':
	  sscanf( *argv, "%d", &gcmd_line.steps_with_goals);
	  break;
	case 'H':
	  sscanf( *argv, "%d", &gcmd_line.heuristic);
          if (gcmd_line.heuristic < 0 || gcmd_line.heuristic > 5)
	    {
	     printf( "\nff: %d is not an allowed option for heuristic computation",
		     gcmd_line.heuristic );
	     return FALSE;
	    }
	  break;
	case 'S':
	  sscanf( *argv, "%d", &gcmd_line.search_algorithm);
          if (gcmd_line.search_algorithm < 0 || gcmd_line.search_algorithm > 30)
	    {
	     printf( "\nff: %d is not an allowed search algorithm",
		     gcmd_line.search_algorithm );
	     return FALSE;
	    }   
	  switch(gcmd_line.search_algorithm) {
	  case 0:
	  case 2:
          case 10:
          case 11:
	  case 16:  
	    if (gcmd_line.g_weight < 0) // not assigned
	      {
	      gcmd_line.g_weight = 0.0;
	      gcmd_line.h_weight = 1.0;
	      }
	    break;
	  case 14:
	  case 15:
	    gcmd_line.g_weight = 1.0;
	    gcmd_line.h_weight = 1.0;
	    break;
	  default:  
    	    if (gcmd_line.g_weight < 0) // not assigned
	      {
		gcmd_line.g_weight = 1.0;
		gcmd_line.h_weight = 3.0;
	      }
	    break;
	  }
	  break;

	case 'D':
	  sscanf( *argv, "%d", &gcmd_line.hdiff);
          if (gcmd_line.heuristic < 0 || gcmd_line.heuristic > 2)
	    {
	     printf( "\nff: %d is not an allowed option for hdiff",
		     gcmd_line.hdiff );
	     return FALSE;
	    }
	  break;

	case 'k':
	  strncpy( gcmd_line.knowledge_path, *argv, MAX_LENGTH );
	  break;
	case 'F':
	  gcmd_line.o_file = TRUE;
	  strncpy( gcmd_line.ofile_name, *argv, MAX_LENGTH );
	  break;
	case 'c':
	  sscanf( *argv, "%d", &gcmd_line.roller_bfs_horizon);
	  break;
	case 's':
	  sscanf( *argv, "%d", &gcmd_line.seed);
	  break;
	case 'L':
	  sscanf( *argv, "%d", &gcmd_line.learner);
	  break;


	default:
	  printf( "\nff: unknown option: %c entered\n\n", option );
	  return FALSE;
	}
      } else {
	return FALSE;
      }
    }
  }

  /*
  if ( gcmd_line.ehc &&
       gcmd_line.optimize ) {
    printf("\n\nff: no enforced hill-climbing when optimizing expressions.\n\n");
    return FALSE;
  }
  */
  /* default value for knowledge path */
  if (strlen(gcmd_line.knowledge_path) == 0)
    {
      sprintf(gcmd_line.knowledge_path, "%s%s", gcmd_line.path,"roller/");
    }

  return TRUE;

}




void execute_learner(){

  printf("\n\n Starting Learner...");
  printf("\n Total generated nodes %ld", ggenerated_nodes);
  switch (gcmd_line.learner) {
  case 1: // LTL
    printf("\n FF-LEARNER for LTL");
    execute_learner_ltl(gcmd_line.path);
    break;
  case 2: // ROLLER
  case 3:
    printf("\n FF-LEARNER for ROLLER");
    execute_learner_roller();
    break;
  case 4:
    printf("\n FF-LEARNER for DPTREES");
    execute_learner_dptrees(NULL);
    break;

  default:
    printf("\n FF-LEARNET: No Learning system selected");
  }

  if (gcmd_line.display_info >= 300){
    printf ("\n Writing dot file for search tree graph!");
    data_draw_search_tree();
  }  

  switch (gcmd_line.info_record){
  case 1: 
    printf (" Learner Info Record: H-labeled nodes");
    record_h_labeled_nodes();
    break;
  }

}




/*
 *  ----------------------------- MAIN ROUTINE ----------------------------
 */





struct tms lstart, lend;



Bool lfound_plan;


int main( int argc, char *argv[] )

{

  /* resulting name for ops file
   */
  char ops_file[MAX_LENGTH] = "";  
  /* same for fct file 
   */
  char fct_file[MAX_LENGTH] = "";
  
  struct tms start, end;

  Bool found_plan;

  times ( &lstart );

  /* command line treatment
   */
  if ( argc == 1 || ( argc == 2 && *++argv[0] == '?' ) ) {
    ff_usage();
    exit( 1 );
  }
  if ( !process_command_line( argc, argv ) ) {
    ff_usage();
    exit( 1 );
  }



  /* make file names
   */

  /* one input name missing
   */
  if ( !gcmd_line.ops_file_name || 
       !gcmd_line.fct_file_name ) {
    fprintf(stdout, "\nff: two input files needed\n\n");
    ff_usage();      
    exit( 1 );
  }
  /* add path info, complete file names will be stored in
   * ops_file and fct_file 
   */
  sprintf(ops_file, "%s%s", gcmd_line.path, gcmd_line.ops_file_name);
  sprintf(fct_file, "%s%s", gcmd_line.path, gcmd_line.fct_file_name);


  /* parse the input files
   */

  /* start parse & instantiation timing
   */
  times( &start );
  /* domain file (ops)
   */
  if ( gcmd_line.display_info >= 1 ) {
    printf("\nff: parsing domain file");
  } 
  /* it is important for the pddl language to define the domain before 
   * reading the problem 
   */
  load_ops_file( ops_file );
  /* problem file (facts)
   */  
  if ( gcmd_line.display_info >= 1 ) {
    printf(" ... done.\nff: parsing problem file"); 
  }
  load_fct_file( fct_file );
  if ( gcmd_line.display_info >= 1 ) {
    printf(" ... done.\n\n");
  }

  /* This is needed to get all types.
   */
  build_orig_constant_list();

  /* last step of parsing: see if it's an ADL domain!
   */
  if ( !make_adl_domain() ) {
    printf("\nff: this is not an ADL problem!");
    printf("\n    can't be handled by this version.\n\n");
    exit( 1 );
  }


  /* now instantiate operators;
   */


  /**************************
   * first do PREPROCESSING * 
   **************************/

  /* start by collecting all strings and thereby encoding 
   * the domain in integers.
   */
  encode_domain_in_integers();

  /* inertia preprocessing, first step:
   *   - collect inertia information
   *   - split initial state into
   *        - arrays for individual predicates
   *        - arrays for all static relations
   *        - array containing non - static relations
   */
  do_inertia_preprocessing_step_1();

  /* normalize all PL1 formulae in domain description:
   * (goal, preconds and effect conditions)
   *   - simplify formula
   *   - expand quantifiers
   *   - NOTs down
   */
  normalize_all_wffs();

  /* translate negative preconds: introduce symmetric new predicate
   * NOT-p(..) (e.g., not-in(?ob) in briefcaseworld)
   */
  translate_negative_preconds();

  /* split domain in easy (disjunction of conjunctive preconds)
   * and hard (non DNF preconds) part, to apply 
   * different instantiation algorithms
   */
  split_domain();

  /***********************************************
   * PREPROCESSING FINISHED                      *
   *                                             *
   * NOW MULTIPLY PARAMETERS IN EFFECTIVE MANNER *
   ***********************************************/

  build_easy_action_templates();
  build_hard_action_templates();

  times( &end );
  TIME( gtempl_time );

  times( &start );

  /* perform reachability analysis in terms of relaxed 
   * fixpoint
   */
  perform_reachability_analysis();

  times( &end );
  TIME( greach_time );

  times( &start );

  /* collect the relevant facts and build final domain
   * and problem representations.
   */
  collect_relevant_facts_and_fluents();

  times( &end );
  TIME( grelev_time );


  /* now transform problem to additive normal form,
   * if possible
   */
  times( &start );
  if ( !transform_to_LNF() ) {
    printf("\n\nThis is not a linear task!\n\n");
    exit( 1 );
  }
  times( &end );
  TIME( gLNF_time );
  
  times( &start );

  /* now build globally accessable connectivity graph
   */
  build_connectivity_graph();

  /* now check for acyclic := effects (in expressions.c)
   */
  check_assigncycles();
  /* set the relevanc info (in expressions.c)
   */
  determine_fl_relevance();

  times( &end );
  TIME( gconn_time );
  
  /* raquel: roller */
  //pruebaLT();
  
  

  /***********************************************************
   * we are finally through with preprocessing and can worry *
   * bout finding a plan instead.                            *
   ***********************************************************/
  /*
  if ( gcmd_line.display_info ) {
    printf("\n\nff: search configuration is ");
    if ( gcmd_line.ehc ) {
      printf("EHC, if that fails then ");
    }
    printf(" best-first on %f*g(s) + %f*h(s) where\n    metric is ",
	   gcmd_line.g_weight, gcmd_line.h_weight);
    if ( gcmd_line.optimize && goptimization_established ) {
      print_LnfExpNode( &glnf_metric );
    } else {
      printf(" plan length");
    }
  }

  */
  if ( gcmd_line.display_info ) {
    printf("\n\nEvaluation function %f*g(s) + %f*h(s) where\n metric is",
	   gcmd_line.g_weight, gcmd_line.h_weight);
    if ( gcmd_line.optimize && goptimization_established ) {
      print_LnfExpNode( &glnf_metric );
    } else {
      printf(" plan length");
    }

  }

  if (gcmd_line.hdiff)
    gtt = 1;

  times( &start );

  switch (gcmd_line.search_algorithm) {
    case 0 :
      {
          found_plan = do_enforced_hill_climbing();
	  if ( !found_plan ) {
	    printf("\n\nEnforced Hill-climbing failed !");
	    printf("\nswitching to Best-first Search now.\n");
	    found_plan = do_best_first_search();
	  }
	    break;
      }
    case 1 : found_plan = do_best_first_search(); break;
    case 2 : found_plan = do_enforced_hill_climbing_cost(); break;
    case 3 : found_plan = do_anytime_best_first_search(); 
        if (gcmd_line.display_info >= 300){
	  printf ("\n Writing dot file for search tree graph!");
	  data_draw_search_tree();
	}  
      break; 
    case 4 : found_plan = do_anytime_bfs_HA(); break;
    case 5 : found_plan = do_anytime_bfs_HA_adm(); break;
    case 6 : found_plan = do_anytime_bfs_HA_rescue(); break;
    case 7 : found_plan = do_anytime_bfs_HA_rescue_lookahead(); break;
    case 8 : found_plan = do_anytime_bfs_HA_rescue_lookahead_recomputeh(); break;
    case 9 : found_plan = do_anytime_bfs_HA_lookahead(); break;
    case 10 : found_plan = do_depth_first_chronological_backtraking_roller(); break;
    case 11 : found_plan = do_modified_hill_climbing(); break;
    case 12 : found_plan = do_anytime_bfs_roller_policy(); break;
    case 13 : found_plan = do_anytime_bfs_HA_rescue_roller_policy(); break;
     
  case 14 : { 
    found_plan = do_anytime_bfs_bnb_learn();
    print_static_literals();
    execute_learner();
    break;
  }
 case 15 : { 
   found_plan = do_anytime_bfs_bnb_learn_delay_repeat();
   execute_learner();
    
   break;
  }
    
  case 16 : found_plan = do_depth_first_chronological_backtraking_ff(); break;
  case 17 : found_plan = do_anytime_bfs_FF_heuristic_policy(); break;
  case 18 : found_plan = do_anytime_bfs_HA_rescue_FF_heuristic_policy(); break;

  case 19 : exit(1); break; 
  case 20 : exit(1); break; 
  case 21 : 
    {
      printf("\n\nRamdom search with seed = %d", gcmd_line.seed);
      found_plan = do_depth_first_chronological_backtraking_random(); 
      break;
    }
  case 22 : do_anytime_bfs_roller_policy_SEC(); break;
  case 23 : do_anytime_bfs_FF_heuristic_policy_SEC(); break;
  case 24 : do_dptrees_depth_first(TRUE); break; 
  case 25 : do_dptrees_depth_first(FALSE); 
//     pruebaDP();
    break; /*only with HA*/
//   case 26 : do_dptrees_anytime_BFS(); break;
  case 27: 
    found_plan = do_hill_climbing_horizon(); break;
  case 28:
    found_plan = compute_init_state_features(); break;
  case 30: 
    classify_goaltask (); 
    found_plan = do_depth_first_chronological_backtraking_roller(); break;
    break;

  }

  times( &end );
  TIME( gsearch_time );

  if (gcmd_line.search_algorithm == 0 || gcmd_line.search_algorithm == 1 || gcmd_line.search_algorithm == 2 )
    {
    if ( found_plan ) {
      print_plan();
    }

    lfound_plan = found_plan;
    output_planner_info();
    if (gcmd_line.o_file){ 
	output_learner_info_to_file();
    }
    }
  
  if (gcmd_line.search_algorithm == 28){
  char * pch = "";
  pch=strrchr(argv[2],'/');
  int value = strlen(pch);
  char route[150];
  memset(route, '\0', sizeof(strlen(route)));
  char *value2 = argv[2];
  strncpy(route, value2, strlen(value2)-value);

  /* copy to sized buffer (overflow safe): */
    printf(route);
    printf("\n***\n\n");
    output_initfeature_info_to_file(route);
    
  }
   
  if (gcmd_line.search_algorithm == 14 || gcmd_line.search_algorithm == 15)
    {
      output_learner_end();
      if (gcmd_line.learner > 0) 
	output_learner_info_to_file();
    }

  printf("\n\n");

  exit( 0 );

 }










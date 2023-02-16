;; Code to modify and create new problems from previous ones
(in-package "COMMON-LISP-USER")

;; how: split, modify-goals, modify-state, relax-problem, from-probset, last-goals, ...
(defun modify-problem (how domain problem count max-literals actions goal-regression
		       &key (odir "probsets/") (min-literals 1) (randomp t))
  (declare (special *current-problem*))
  (if (not *current-problem*) (load-prob problem))
  (let* ((name (problem-name *current-problem*))
	 ;; so that I do not have to repeat the experiments again. It is just a matter of order of instances
	 (instances (sayphi-problem-objects *current-problem*))
	 ;;   	(instances (if (eq domain 'test-grid) (sayphi-problem-objects-1 *current-problem*) (sayphi-problem-objects *current-problem*)))
	 (state (problem-lit-init-state *current-problem*))
	 (goals (problem-lit-goals *current-problem*))
	 (metric (problem-metric *current-problem*))
	 (new-problem (format nil "~a~a/mod~d-~d-~a" *domain-dir* odir count max-literals (pathname-name problem)))
	 (modify-problem-compiled (concatenate 'string *domain-dir* "modify-problem"))
	 (modify-problem-source (concatenate 'string modify-problem-compiled ".lisp")))
    ;; change here the problem
    (multiple-value-bind (new-instances new-state new-goals)
 	(case how
	  (split (values instances state goals))
 	  (last-goals (values instances state (car (last (coerce goal-regression 'list)))))
 	  (from-probset (values instances state goals))
 	  (relax-problem (values instances state (remove (choose-one goals) goals :test #'equal)))
 	  (modify-goals (load modify-problem-source)
			(compile-file modify-problem-source)
			(load modify-problem-compiled)
			(errt-modify-goals instances state goals max-literals randomp))
 	  (modify-state (load modify-problem-source)
			(compile-file modify-problem-source)
			(load modify-problem-compiled)
			(errt-modify-state instances state goals actions max-literals))
 	  (otherwise (values instances state goals)))
      (case how
	(from-probset (pop *modified-probset*))
	(split (setq new-problem nil)
	       (dolist (new-goals (restricted-combinations goals min-literals max-literals))
		 (incf count)
		 (push (format nil "~a~a/mod~d-~a" *domain-dir* odir count (pathname-name problem)) new-problem)
		 (write-pddl-file name domain new-instances new-state new-goals (car new-problem) metric))
	       (reverse new-problem))
	(otherwise (write-pddl-file name domain new-instances new-state new-goals new-problem metric)
		   new-problem)))))

;; (defun modify-problem (how domain problem count max-literals actions goal-regression)
;;    "/home/dborrajo/planning/sayphi/domains/test-grid/probsets/test.pddl")
;; 	       (dolist (goal goals)
;; 		 (incf count)
;; 		 (push (format nil "~a~a/mod~d-~a" *domain-dir* odir count (pathname-name problem)) new-problem)
;; 		 (write-pddl-file name domain new-instances new-state (list goal) (car new-problem) metric)
;; 		 (dolist (goal1 goals)
;; 		   (unless (equal goal1 goal)
;; 		     (incf count)
;; 		     (push (format nil "~a~a/mod~d-~a" *domain-dir* odir count (pathname-name problem)) new-problem)
;; 		     (write-pddl-file name domain new-instances new-state (list goal goal1) (car new-problem) metric))))

(defun restricted-combinations (list min max)
  (remove-if-not #'(lambda (length) (<= min length max))
		 (parts-set list)
		 :key #'length))

(defun sayphi-problem-objects (problem)
  (let ((result nil))
    (maphash #'(lambda (key val)
		 (setq result (append (reverse (cons key (cons '- (reverse val)))) result)))
	     (problem-objects problem))
    result))

(defun sayphi-problem-objects-1 (problem)
  (let ((result nil))
    (maphash #'(lambda (key val)
		 (setq result `(,@result ,@(reverse (cons key (cons '- val))))))
	     (problem-objects problem))
    result))

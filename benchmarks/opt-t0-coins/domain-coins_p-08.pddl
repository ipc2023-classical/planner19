(define (domain COINS)
(:requirements :negative-preconditions :conditional-effects)
	(:predicates
(kAT_F0_P2)
(kAT_F0_P2__IN_E0_F1)
(kAT_F0_P2__-IN_E0_F1)
(kAT_F0_P3)
(kAT_F0_P3__IN_E1_F1)
(kAT_F0_P3__-IN_E1_F1)
(kHAVE_C0)
(kHAVE_C0__COIN-AT_C0_F0_P3)
(kHAVE_C0__COIN-AT_C0_F0_P2)
(kHAVE_C0__COIN-AT_C0_F0_P0)
(kHAVE_C0__COIN-AT_C0_F0_P1)
(kHAVE_C1)
(kHAVE_C1__COIN-AT_C1_F0_P3)
(kHAVE_C1__COIN-AT_C1_F0_P2)
(kHAVE_C1__COIN-AT_C1_F0_P0)
(kHAVE_C1__COIN-AT_C1_F0_P1)
(kHAVE_C2)
(kHAVE_C2__COIN-AT_C2_F1_P3)
(kHAVE_C2__COIN-AT_C2_F1_P2)
(kHAVE_C2__COIN-AT_C2_F1_P0)
(kHAVE_C2__COIN-AT_C2_F1_P1)
(kHAVE_C3)
(kHAVE_C3__COIN-AT_C3_F0_P3)
(kHAVE_C3__COIN-AT_C3_F0_P2)
(kHAVE_C3__COIN-AT_C3_F0_P0)
(kHAVE_C3__COIN-AT_C3_F0_P1)
(kINSIDE_E0)
(kINSIDE_E0__IN_E0_F1)
(kINSIDE_E0__-IN_E0_F1)
(kINSIDE_E1)
(kINSIDE_E1__IN_E1_F1)
(kINSIDE_E1__-IN_E1_F1)
(kAT_F1_P2)
(kAT_F1_P2__IN_E0_F1)
(kAT_F1_P2__-IN_E0_F1)
(kAT_F1_P3)
(kAT_F1_P3__IN_E1_F1)
(kAT_F1_P3__-IN_E1_F1)
(kIN_E0_F0)
(k-IN_E0_F0)
(kIN_E0_F0__IN_E0_F1)
(kIN_E0_F0__-IN_E0_F1)
(kIN_E0_F1)
(k-IN_E0_F1)
(kIN_E0_F1__IN_E0_F1)
(kIN_E0_F1__-IN_E0_F1)
(kIN_E1_F0)
(k-IN_E1_F0)
(kIN_E1_F0__IN_E1_F1)
(kIN_E1_F0__-IN_E1_F1)
(kIN_E1_F1)
(k-IN_E1_F1)
(kIN_E1_F1__IN_E1_F1)
(kIN_E1_F1__-IN_E1_F1)
(kAT_F0_P0)
(kAT_F0_P1)
(k-COIN-AT_C0_F0_P0)
(kCOIN-AT_C0_F0_P0__COIN-AT_C0_F0_P0)
(k-COIN-AT_C0_F0_P1)
(kCOIN-AT_C0_F0_P1__COIN-AT_C0_F0_P1)
(k-COIN-AT_C0_F0_P2)
(kCOIN-AT_C0_F0_P2__COIN-AT_C0_F0_P2)
(k-COIN-AT_C0_F0_P3)
(kCOIN-AT_C0_F0_P3__COIN-AT_C0_F0_P3)
(k-COIN-AT_C1_F0_P0)
(kCOIN-AT_C1_F0_P0__COIN-AT_C1_F0_P0)
(k-COIN-AT_C1_F0_P1)
(kCOIN-AT_C1_F0_P1__COIN-AT_C1_F0_P1)
(k-COIN-AT_C1_F0_P2)
(kCOIN-AT_C1_F0_P2__COIN-AT_C1_F0_P2)
(k-COIN-AT_C1_F0_P3)
(kCOIN-AT_C1_F0_P3__COIN-AT_C1_F0_P3)
(k-COIN-AT_C2_F1_P1)
(kCOIN-AT_C2_F1_P1__COIN-AT_C2_F1_P1)
(kAT_F1_P1)
(k-COIN-AT_C2_F1_P2)
(kCOIN-AT_C2_F1_P2__COIN-AT_C2_F1_P2)
(k-COIN-AT_C3_F0_P0)
(kCOIN-AT_C3_F0_P0__COIN-AT_C3_F0_P0)
(k-COIN-AT_C3_F0_P1)
(kCOIN-AT_C3_F0_P1__COIN-AT_C3_F0_P1)
(k-COIN-AT_C3_F0_P2)
(kCOIN-AT_C3_F0_P2__COIN-AT_C3_F0_P2)
(k-COIN-AT_C3_F0_P3)
(kCOIN-AT_C3_F0_P3__COIN-AT_C3_F0_P3)
(k-COIN-AT_C2_F1_P3)
(kCOIN-AT_C2_F1_P3__COIN-AT_C2_F1_P3)
(kAT_F1_P0)
(k-COIN-AT_C2_F1_P0)
(kCOIN-AT_C2_F1_P0__COIN-AT_C2_F1_P0)
)
(:action COLLECT_C2_F1_P0
:parameters ()
:precondition (and (kAT_F1_P0))

:effect (and  (k-COIN-AT_C2_F1_P0)
(when (kCOIN-AT_C2_F1_P0__COIN-AT_C2_F1_P0) (and (kHAVE_C2__COIN-AT_C2_F1_P0) (not(kCOIN-AT_C2_F1_P0__COIN-AT_C2_F1_P0)))) ;; Support.  Cancellation. 
))
(:action MOVE-RIGHT_F1_P0_P1
:parameters ()
:precondition (and (kAT_F1_P0))

:effect (and  (not(kAT_F1_P0)) (kAT_F1_P1)
))
(:action MOVE-LEFT_F1_P1_P0
:parameters ()
:precondition (and (kAT_F1_P1))

:effect (and  (not(kAT_F1_P1)) (kAT_F1_P0)
))
(:action COLLECT_C2_F1_P3
:parameters ()
:precondition (and (kAT_F1_P3))

:effect (and  (k-COIN-AT_C2_F1_P3)
(when (kCOIN-AT_C2_F1_P3__COIN-AT_C2_F1_P3) (and (kHAVE_C2__COIN-AT_C2_F1_P3) (not(kCOIN-AT_C2_F1_P3__COIN-AT_C2_F1_P3)))) ;; Support.  Cancellation. 
))
(:action MOVE-RIGHT_F1_P2_P3
:parameters ()
:precondition (and (kAT_F1_P2))

:effect (and  (not(kAT_F1_P2__IN_E0_F1)) (kAT_F1_P3) (not(kAT_F1_P2)) (kAT_F1_P3__IN_E1_F1) (not(kAT_F1_P2__-IN_E0_F1)) (kAT_F1_P3__-IN_E1_F1)
))
(:action MOVE-RIGHT_F1_P1_P2
:parameters ()
:precondition (and (kAT_F1_P1))

:effect (and  (kAT_F1_P2) (kAT_F1_P2__IN_E0_F1) (not(kAT_F1_P1)) (kAT_F1_P2__-IN_E0_F1)
))
(:action MOVE-LEFT_F1_P3_P2
:parameters ()
:precondition (and (kAT_F1_P3))

:effect (and  (not(kAT_F1_P3__IN_E1_F1)) (kAT_F1_P2) (not(kAT_F1_P3)) (kAT_F1_P2__IN_E0_F1) (not(kAT_F1_P3__-IN_E1_F1)) (kAT_F1_P2__-IN_E0_F1)
))
(:action MOVE-LEFT_F1_P2_P1
:parameters ()
:precondition (and (kAT_F1_P2))

:effect (and  (not(kAT_F1_P2__IN_E0_F1)) (not(kAT_F1_P2)) (kAT_F1_P1) (not(kAT_F1_P2__-IN_E0_F1))
))
(:action MOVE-LEFT_F0_P3_P2
:parameters ()
:precondition (and (kAT_F0_P3))

:effect (and  (not(kAT_F0_P3)) (kAT_F0_P2__-IN_E0_F1) (not(kAT_F0_P3__-IN_E1_F1)) (kAT_F0_P2) (not(kAT_F0_P3__IN_E1_F1)) (kAT_F0_P2__IN_E0_F1)
))
(:action MOVE-LEFT_F0_P2_P1
:parameters ()
:precondition (and (kAT_F0_P2))

:effect (and  (not(kAT_F0_P2__-IN_E0_F1)) (not(kAT_F0_P2__IN_E0_F1)) (not(kAT_F0_P2)) (kAT_F0_P1)
))
(:action MOVE-LEFT_F0_P1_P0
:parameters ()
:precondition (and (kAT_F0_P1))

:effect (and  (not(kAT_F0_P1)) (kAT_F0_P0)
))
(:action STEP-OUT_E1_F1_P3
:parameters ()
:precondition (and (kINSIDE_E1))

:effect (and 
(when (kIN_E1_F1)  (kAT_F1_P3)) ;; Support. 
(when (not(k-IN_E1_F1))  (not(kINSIDE_E1))) ;; Cancellation. 
(when (kIN_E1_F1__IN_E1_F1) (and (kAT_F1_P3__IN_E1_F1) (not(kINSIDE_E1__IN_E1_F1)))) ;; Support.  Cancellation. 
(when (kIN_E1_F1__-IN_E1_F1) (and (kAT_F1_P3__-IN_E1_F1) (not(kINSIDE_E1__-IN_E1_F1)))) ;; Support.  Cancellation. 
))
(:action STEP-OUT_E1_F0_P3
:parameters ()
:precondition (and (kINSIDE_E1))

:effect (and 
(when (kIN_E1_F0)  (kAT_F0_P3)) ;; Support. 
(when (not(k-IN_E1_F0))  (not(kINSIDE_E1))) ;; Cancellation. 
(when (kIN_E1_F0__IN_E1_F1) (and (kAT_F0_P3__IN_E1_F1) (not(kINSIDE_E1__IN_E1_F1)))) ;; Support.  Cancellation. 
(when (kIN_E1_F0__-IN_E1_F1) (and (kAT_F0_P3__-IN_E1_F1) (not(kINSIDE_E1__-IN_E1_F1)))) ;; Support.  Cancellation. 
))
(:action STEP-OUT_E0_F1_P2
:parameters ()
:precondition (and (kINSIDE_E0))

:effect (and 
(when (kIN_E0_F1)  (kAT_F1_P2)) ;; Support. 
(when (not(k-IN_E0_F1))  (not(kINSIDE_E0))) ;; Cancellation. 
(when (kIN_E0_F1__IN_E0_F1) (and (kAT_F1_P2__IN_E0_F1) (not(kINSIDE_E0__IN_E0_F1)))) ;; Support.  Cancellation. 
(when (kIN_E0_F1__-IN_E0_F1) (and (kAT_F1_P2__-IN_E0_F1) (not(kINSIDE_E0__-IN_E0_F1)))) ;; Support.  Cancellation. 
))
(:action STEP-OUT_E0_F0_P2
:parameters ()
:precondition (and (kINSIDE_E0))

:effect (and 
(when (kIN_E0_F0)  (kAT_F0_P2)) ;; Support. 
(when (not(k-IN_E0_F0))  (not(kINSIDE_E0))) ;; Cancellation. 
(when (kIN_E0_F0__IN_E0_F1) (and (kAT_F0_P2__IN_E0_F1) (not(kINSIDE_E0__IN_E0_F1)))) ;; Support.  Cancellation. 
(when (kIN_E0_F0__-IN_E0_F1) (and (kAT_F0_P2__-IN_E0_F1) (not(kINSIDE_E0__-IN_E0_F1)))) ;; Support.  Cancellation. 
))
(:action STEP-IN_E1_F0_P3
:parameters ()
:precondition (and (kAT_F0_P3))

:effect (and 
(when (kIN_E1_F0)  (kINSIDE_E1)) ;; Support. 
(when (not(k-IN_E1_F0))  (not(kAT_F0_P3))) ;; Cancellation. 
(when (kIN_E1_F0__IN_E1_F1) (and (kINSIDE_E1__IN_E1_F1) (not(kAT_F0_P3__IN_E1_F1)))) ;; Support.  Cancellation. 
(when (kIN_E1_F0__-IN_E1_F1) (and (kINSIDE_E1__-IN_E1_F1) (not(kAT_F0_P3__-IN_E1_F1)))) ;; Support.  Cancellation. 
))
(:action STEP-IN_E0_F0_P2
:parameters ()
:precondition (and (kAT_F0_P2))

:effect (and 
(when (kIN_E0_F0)  (kINSIDE_E0)) ;; Support. 
(when (not(k-IN_E0_F0))  (not(kAT_F0_P2))) ;; Cancellation. 
(when (kIN_E0_F0__IN_E0_F1) (and (kINSIDE_E0__IN_E0_F1) (not(kAT_F0_P2__IN_E0_F1)))) ;; Support.  Cancellation. 
(when (kIN_E0_F0__-IN_E0_F1) (and (kINSIDE_E0__-IN_E0_F1) (not(kAT_F0_P2__-IN_E0_F1)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C3_F0_P3
:parameters ()
:precondition (and (kAT_F0_P3))

:effect (and  (k-COIN-AT_C3_F0_P3)
(when (kCOIN-AT_C3_F0_P3__COIN-AT_C3_F0_P3) (and (kHAVE_C3__COIN-AT_C3_F0_P3) (not(kCOIN-AT_C3_F0_P3__COIN-AT_C3_F0_P3)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C3_F0_P2
:parameters ()
:precondition (and (kAT_F0_P2))

:effect (and  (k-COIN-AT_C3_F0_P2)
(when (kCOIN-AT_C3_F0_P2__COIN-AT_C3_F0_P2) (and (kHAVE_C3__COIN-AT_C3_F0_P2) (not(kCOIN-AT_C3_F0_P2__COIN-AT_C3_F0_P2)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C3_F0_P1
:parameters ()
:precondition (and (kAT_F0_P1))

:effect (and  (k-COIN-AT_C3_F0_P1)
(when (kCOIN-AT_C3_F0_P1__COIN-AT_C3_F0_P1) (and (kHAVE_C3__COIN-AT_C3_F0_P1) (not(kCOIN-AT_C3_F0_P1__COIN-AT_C3_F0_P1)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C3_F0_P0
:parameters ()
:precondition (and (kAT_F0_P0))

:effect (and  (k-COIN-AT_C3_F0_P0)
(when (kCOIN-AT_C3_F0_P0__COIN-AT_C3_F0_P0) (and (kHAVE_C3__COIN-AT_C3_F0_P0) (not(kCOIN-AT_C3_F0_P0__COIN-AT_C3_F0_P0)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C2_F1_P2
:parameters ()
:precondition (and (kAT_F1_P2))

:effect (and  (k-COIN-AT_C2_F1_P2)
(when (kCOIN-AT_C2_F1_P2__COIN-AT_C2_F1_P2) (and (kHAVE_C2__COIN-AT_C2_F1_P2) (not(kCOIN-AT_C2_F1_P2__COIN-AT_C2_F1_P2)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C2_F1_P1
:parameters ()
:precondition (and (kAT_F1_P1))

:effect (and  (k-COIN-AT_C2_F1_P1)
(when (kCOIN-AT_C2_F1_P1__COIN-AT_C2_F1_P1) (and (kHAVE_C2__COIN-AT_C2_F1_P1) (not(kCOIN-AT_C2_F1_P1__COIN-AT_C2_F1_P1)))) ;; Support.  Cancellation. 
))
(:action STEP-IN_E1_F1_P3
:parameters ()
:precondition (and (kAT_F1_P3))

:effect (and 
(when (kIN_E1_F1)  (kINSIDE_E1)) ;; Support. 
(when (not(k-IN_E1_F1))  (not(kAT_F1_P3))) ;; Cancellation. 
(when (kIN_E1_F1__IN_E1_F1) (and (kINSIDE_E1__IN_E1_F1) (not(kAT_F1_P3__IN_E1_F1)))) ;; Support.  Cancellation. 
(when (kIN_E1_F1__-IN_E1_F1) (and (kINSIDE_E1__-IN_E1_F1) (not(kAT_F1_P3__-IN_E1_F1)))) ;; Support.  Cancellation. 
))
(:action STEP-IN_E0_F1_P2
:parameters ()
:precondition (and (kAT_F1_P2))

:effect (and 
(when (kIN_E0_F1)  (kINSIDE_E0)) ;; Support. 
(when (not(k-IN_E0_F1))  (not(kAT_F1_P2))) ;; Cancellation. 
(when (kIN_E0_F1__IN_E0_F1) (and (kINSIDE_E0__IN_E0_F1) (not(kAT_F1_P2__IN_E0_F1)))) ;; Support.  Cancellation. 
(when (kIN_E0_F1__-IN_E0_F1) (and (kINSIDE_E0__-IN_E0_F1) (not(kAT_F1_P2__-IN_E0_F1)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C1_F0_P3
:parameters ()
:precondition (and (kAT_F0_P3))

:effect (and  (k-COIN-AT_C1_F0_P3)
(when (kCOIN-AT_C1_F0_P3__COIN-AT_C1_F0_P3) (and (kHAVE_C1__COIN-AT_C1_F0_P3) (not(kCOIN-AT_C1_F0_P3__COIN-AT_C1_F0_P3)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C1_F0_P2
:parameters ()
:precondition (and (kAT_F0_P2))

:effect (and  (k-COIN-AT_C1_F0_P2)
(when (kCOIN-AT_C1_F0_P2__COIN-AT_C1_F0_P2) (and (kHAVE_C1__COIN-AT_C1_F0_P2) (not(kCOIN-AT_C1_F0_P2__COIN-AT_C1_F0_P2)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C1_F0_P1
:parameters ()
:precondition (and (kAT_F0_P1))

:effect (and  (k-COIN-AT_C1_F0_P1)
(when (kCOIN-AT_C1_F0_P1__COIN-AT_C1_F0_P1) (and (kHAVE_C1__COIN-AT_C1_F0_P1) (not(kCOIN-AT_C1_F0_P1__COIN-AT_C1_F0_P1)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C1_F0_P0
:parameters ()
:precondition (and (kAT_F0_P0))

:effect (and  (k-COIN-AT_C1_F0_P0)
(when (kCOIN-AT_C1_F0_P0__COIN-AT_C1_F0_P0) (and (kHAVE_C1__COIN-AT_C1_F0_P0) (not(kCOIN-AT_C1_F0_P0__COIN-AT_C1_F0_P0)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C0_F0_P3
:parameters ()
:precondition (and (kAT_F0_P3))

:effect (and  (k-COIN-AT_C0_F0_P3)
(when (kCOIN-AT_C0_F0_P3__COIN-AT_C0_F0_P3) (and (kHAVE_C0__COIN-AT_C0_F0_P3) (not(kCOIN-AT_C0_F0_P3__COIN-AT_C0_F0_P3)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C0_F0_P2
:parameters ()
:precondition (and (kAT_F0_P2))

:effect (and  (k-COIN-AT_C0_F0_P2)
(when (kCOIN-AT_C0_F0_P2__COIN-AT_C0_F0_P2) (and (kHAVE_C0__COIN-AT_C0_F0_P2) (not(kCOIN-AT_C0_F0_P2__COIN-AT_C0_F0_P2)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C0_F0_P1
:parameters ()
:precondition (and (kAT_F0_P1))

:effect (and  (k-COIN-AT_C0_F0_P1)
(when (kCOIN-AT_C0_F0_P1__COIN-AT_C0_F0_P1) (and (kHAVE_C0__COIN-AT_C0_F0_P1) (not(kCOIN-AT_C0_F0_P1__COIN-AT_C0_F0_P1)))) ;; Support.  Cancellation. 
))
(:action COLLECT_C0_F0_P0
:parameters ()
:precondition (and (kAT_F0_P0))

:effect (and  (k-COIN-AT_C0_F0_P0)
(when (kCOIN-AT_C0_F0_P0__COIN-AT_C0_F0_P0) (and (kHAVE_C0__COIN-AT_C0_F0_P0) (not(kCOIN-AT_C0_F0_P0__COIN-AT_C0_F0_P0)))) ;; Support.  Cancellation. 
))
(:action MOVE-RIGHT_F0_P2_P3
:parameters ()
:precondition (and (kAT_F0_P2))

:effect (and  (not(kAT_F0_P2__-IN_E0_F1)) (kAT_F0_P3__-IN_E1_F1) (not(kAT_F0_P2__IN_E0_F1)) (kAT_F0_P3) (not(kAT_F0_P2)) (kAT_F0_P3__IN_E1_F1)
))
(:action MOVE-RIGHT_F0_P1_P2
:parameters ()
:precondition (and (kAT_F0_P1))

:effect (and  (not(kAT_F0_P1)) (kAT_F0_P2__-IN_E0_F1) (kAT_F0_P2) (kAT_F0_P2__IN_E0_F1)
))
(:action MOVE-RIGHT_F0_P0_P1
:parameters ()
:precondition (and (kAT_F0_P0))

:effect (and  (not(kAT_F0_P0)) (kAT_F0_P1)
))
(:action GO-DOWN_E1_F1_F0
:parameters ()
:precondition (and)

:effect (and  (k-IN_E1_F1)
(when (kIN_E1_F1__-IN_E1_F1) (and (kIN_E1_F0__-IN_E1_F1) (not(kIN_E1_F1__-IN_E1_F1)))) ;; Support.  Cancellation. 
(when (kIN_E1_F1) (and (kIN_E1_F0) (k-IN_E1_F1))) ;; Support. 
(when (not(k-IN_E1_F1)) (and (not(k-IN_E1_F0)) (not(kIN_E1_F1)))) ;; Cancellation. 
(when (kIN_E1_F1__IN_E1_F1) (and (kIN_E1_F0__IN_E1_F1) (not(kIN_E1_F1__IN_E1_F1)))) ;; Support.  Cancellation. 
))
(:action GO-DOWN_E0_F1_F0
:parameters ()
:precondition (and)

:effect (and  (k-IN_E0_F1)
(when (kIN_E0_F1__-IN_E0_F1) (and (kIN_E0_F0__-IN_E0_F1) (not(kIN_E0_F1__-IN_E0_F1)))) ;; Support.  Cancellation. 
(when (kIN_E0_F1) (and (kIN_E0_F0) (k-IN_E0_F1))) ;; Support. 
(when (not(k-IN_E0_F1)) (and (not(k-IN_E0_F0)) (not(kIN_E0_F1)))) ;; Cancellation. 
(when (kIN_E0_F1__IN_E0_F1) (and (kIN_E0_F0__IN_E0_F1) (not(kIN_E0_F1__IN_E0_F1)))) ;; Support.  Cancellation. 
))
(:action GO-UP_E1_F0_F1
:parameters ()
:precondition (and)

:effect (and  (k-IN_E1_F0)
(when (kIN_E1_F0__-IN_E1_F1) (and (not(kIN_E1_F0__-IN_E1_F1)) (kIN_E1_F1__-IN_E1_F1))) ;; Support.  Cancellation. 
(when (kIN_E1_F0) (and (k-IN_E1_F0) (kIN_E1_F1))) ;; Support. 
(when (not(k-IN_E1_F0)) (and (not(kIN_E1_F0)) (not(k-IN_E1_F1)))) ;; Cancellation. 
(when (kIN_E1_F0__IN_E1_F1) (and (not(kIN_E1_F0__IN_E1_F1)) (kIN_E1_F1__IN_E1_F1))) ;; Support.  Cancellation. 
))
(:action GO-UP_E0_F0_F1
:parameters ()
:precondition (and)

:effect (and  (k-IN_E0_F0)
(when (kIN_E0_F0__-IN_E0_F1) (and (not(kIN_E0_F0__-IN_E0_F1)) (kIN_E0_F1__-IN_E0_F1))) ;; Support.  Cancellation. 
(when (kIN_E0_F0) (and (k-IN_E0_F0) (kIN_E0_F1))) ;; Support. 
(when (not(k-IN_E0_F0)) (and (not(kIN_E0_F0)) (not(k-IN_E0_F1)))) ;; Cancellation. 
(when (kIN_E0_F0__IN_E0_F1) (and (not(kIN_E0_F0__IN_E0_F1)) (kIN_E0_F1__IN_E0_F1))) ;; Support.  Cancellation. 
))
(:action MERGE_CLAUSES
:parameters ()
:precondition (and)

:effect (and 
(when (kIN_E0_F0)  (k-IN_E0_F1)) ;;reasoning over static clause. 
(when (k-IN_E0_F0)  (kIN_E0_F1)) ;;reasoning over static clause. 
(when (kIN_E0_F1)  (k-IN_E0_F0)) ;;reasoning over static clause. 
(when (kIN_E1_F0)  (k-IN_E1_F1)) ;;reasoning over static clause. 
(when (k-IN_E1_F0)  (kIN_E1_F1)) ;;reasoning over static clause. 
(when (kIN_E1_F1)  (k-IN_E1_F0)) ;;reasoning over static clause. 
(when (k-IN_E0_F1)  (kIN_E0_F0)) ;;reasoning over static clause. 
(when (k-IN_E1_F1)  (kIN_E1_F0)) ;;reasoning over static clause. 
))
(:action MERGE_AT_F1_P3
:parameters ()
:precondition (and)

:effect (and 
(when(and (kAT_F1_P3__IN_E1_F1) (kAT_F1_P3__-IN_E1_F1))  (kAT_F1_P3)) ;;MERGE. 
))
(:action MERGE_AT_F1_P2
:parameters ()
:precondition (and)

:effect (and 
(when(and (kAT_F1_P2__IN_E0_F1) (kAT_F1_P2__-IN_E0_F1))  (kAT_F1_P2)) ;;MERGE. 
))
(:action MERGE_INSIDE_E1
:parameters ()
:precondition (and)

:effect (and 
(when(and (kINSIDE_E1__IN_E1_F1) (kINSIDE_E1__-IN_E1_F1))  (kINSIDE_E1)) ;;MERGE. 
))
(:action MERGE_INSIDE_E0
:parameters ()
:precondition (and)

:effect (and 
(when(and (kINSIDE_E0__IN_E0_F1) (kINSIDE_E0__-IN_E0_F1))  (kINSIDE_E0)) ;;MERGE. 
))
(:action MERGE_HAVE_C3
:parameters ()
:precondition (and)

:effect (and 
(when(and (kHAVE_C3__COIN-AT_C3_F0_P3) (kHAVE_C3__COIN-AT_C3_F0_P2) (kHAVE_C3__COIN-AT_C3_F0_P0) (kHAVE_C3__COIN-AT_C3_F0_P1))  (kHAVE_C3)) ;;MERGE. 
))
(:action MERGE_HAVE_C2
:parameters ()
:precondition (and)

:effect (and 
(when(and (kHAVE_C2__COIN-AT_C2_F1_P3) (kHAVE_C2__COIN-AT_C2_F1_P2) (kHAVE_C2__COIN-AT_C2_F1_P0) (kHAVE_C2__COIN-AT_C2_F1_P1))  (kHAVE_C2)) ;;MERGE. 
))
(:action MERGE_HAVE_C1
:parameters ()
:precondition (and)

:effect (and 
(when(and (kHAVE_C1__COIN-AT_C1_F0_P3) (kHAVE_C1__COIN-AT_C1_F0_P2) (kHAVE_C1__COIN-AT_C1_F0_P0) (kHAVE_C1__COIN-AT_C1_F0_P1))  (kHAVE_C1)) ;;MERGE. 
))
(:action MERGE_HAVE_C0
:parameters ()
:precondition (and)

:effect (and 
(when(and (kHAVE_C0__COIN-AT_C0_F0_P3) (kHAVE_C0__COIN-AT_C0_F0_P2) (kHAVE_C0__COIN-AT_C0_F0_P0) (kHAVE_C0__COIN-AT_C0_F0_P1))  (kHAVE_C0)) ;;MERGE. 
))
(:action MERGE_AT_F0_P3
:parameters ()
:precondition (and)

:effect (and 
(when(and (kAT_F0_P3__IN_E1_F1) (kAT_F0_P3__-IN_E1_F1))  (kAT_F0_P3)) ;;MERGE. 
))
(:action MERGE_AT_F0_P2
:parameters ()
:precondition (and)

:effect (and 
(when(and (kAT_F0_P2__IN_E0_F1) (kAT_F0_P2__-IN_E0_F1))  (kAT_F0_P2)) ;;MERGE. 
))
)

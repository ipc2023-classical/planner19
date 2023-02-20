;; original sequence 1: (1 17 2 12 -19 -9 -21 -8 -7 33 -32 -11 -10 28 -4 -25 -24 -13 -34 -14 -26 -16 -36 -35 -29 -20 -18 3 23 15 30 27 22 6 31 5)
;; original sequence 2: (1 25 2 23 17 12 3 20 6 15 30 27 31 18 -19 -9 -21 -8 -7 33 -28 10 11 32 -4 -24 -13 -34 -14 26 5 35 -22 -29 -16 -36)
;; simplified sequence 1: (1 17 2 12 37 39 -4 -25 38 -26 41 -35 -29 -20 -18 3 23 40 22 6 31 5)
;; simplified sequence 2: (1 25 2 23 17 12 3 20 6 40 31 18 37 -39 -4 38 26 5 35 -22 -29 41)
;; common subsequences: (((-19 -9 -21 -8 -7 33) . 37) ((-24 -13 -34 -14) . 38) ((-32 -11 -10 28) . 39) ((15 30 27) . 40) ((-16 -36) . 41))
;; #safe insertions/deletions: 0
;; sequence 1 (names): ((NORMAL COX1) (NORMAL D) (NORMAL COX2) (NORMAL ATP6) (NORMAL SUB1) (NORMAL SUB3) (INVERTED NAD1) (INVERTED L2) (NORMAL SUB2) (INVERTED M) (NORMAL SUB5) (INVERTED W) (INVERTED Q) (INVERTED G) (INVERTED E) (NORMAL COX3) (NORMAL K) (NORMAL SUB4) (NORMAL I) (NORMAL NAD3) (NORMAL S1) (NORMAL NAD2))
;; sequence 2 (names): ((NORMAL COX1) (NORMAL L2) (NORMAL COX2) (NORMAL K) (NORMAL D) (NORMAL ATP6) (NORMAL COX3) (NORMAL G) (NORMAL NAD3) (NORMAL SUB4) (NORMAL S1) (NORMAL E) (NORMAL SUB1) (INVERTED SUB3) (INVERTED NAD1) (NORMAL SUB2) (NORMAL M) (NORMAL NAD2) (NORMAL W) (INVERTED I) (INVERTED Q) (NORMAL SUB5))

(DEFINE (PROBLEM KATHARINA-TUNICATA-TO-ARTEMIA-FRANCISCANA)
        (:DOMAIN GENOME-EDIT-DISTANCE)
        (:OBJECTS SUB5 SUB4 SUB3 SUB2 SUB1 W S1 Q M L2 K I G E D ATP6
            NAD3 NAD2 NAD1 COX3 COX2 COX1)
        (:INIT (NORMAL COX1) (NORMAL D) (NORMAL COX2) (NORMAL ATP6)
               (NORMAL SUB1) (NORMAL SUB3) (INVERTED NAD1)
               (INVERTED L2) (NORMAL SUB2) (INVERTED M) (NORMAL SUB5)
               (INVERTED W) (INVERTED Q) (INVERTED G) (INVERTED E)
               (NORMAL COX3) (NORMAL K) (NORMAL SUB4) (NORMAL I)
               (NORMAL NAD3) (NORMAL S1) (NORMAL NAD2) (PRESENT COX1)
               (PRESENT D) (PRESENT COX2) (PRESENT ATP6) (PRESENT SUB1)
               (PRESENT SUB3) (PRESENT NAD1) (PRESENT L2)
               (PRESENT SUB2) (PRESENT M) (PRESENT SUB5) (PRESENT W)
               (PRESENT Q) (PRESENT G) (PRESENT E) (PRESENT COX3)
               (PRESENT K) (PRESENT SUB4) (PRESENT I) (PRESENT NAD3)
               (PRESENT S1) (PRESENT NAD2) (CW NAD2 COX1) (CW S1 NAD2)
               (CW NAD3 S1) (CW I NAD3) (CW SUB4 I) (CW K SUB4)
               (CW COX3 K) (CW E COX3) (CW G E) (CW Q G) (CW W Q)
               (CW SUB5 W) (CW M SUB5) (CW SUB2 M) (CW L2 SUB2)
               (CW NAD1 L2) (CW SUB3 NAD1) (CW SUB1 SUB3)
               (CW ATP6 SUB1) (CW COX2 ATP6) (CW D COX2) (CW COX1 D)
               (IDLE) (= (TOTAL-COST) 0))
        (:GOAL (AND (NORMAL COX1) (NORMAL L2) (NORMAL COX2) (NORMAL K)
                    (NORMAL D) (NORMAL ATP6) (NORMAL COX3) (NORMAL G)
                    (NORMAL NAD3) (NORMAL SUB4) (NORMAL S1) (NORMAL E)
                    (NORMAL SUB1) (INVERTED SUB3) (INVERTED NAD1)
                    (NORMAL SUB2) (NORMAL M) (NORMAL NAD2) (NORMAL W)
                    (INVERTED I) (INVERTED Q) (NORMAL SUB5)
                    (CW SUB5 COX1) (CW Q SUB5) (CW I Q) (CW W I)
                    (CW NAD2 W) (CW M NAD2) (CW SUB2 M) (CW NAD1 SUB2)
                    (CW SUB3 NAD1) (CW SUB1 SUB3) (CW E SUB1) (CW S1 E)
                    (CW SUB4 S1) (CW NAD3 SUB4) (CW G NAD3) (CW COX3 G)
                    (CW ATP6 COX3) (CW D ATP6) (CW K D) (CW COX2 K)
                    (CW L2 COX2) (CW COX1 L2)))
        (:METRIC MINIMIZE (TOTAL-COST)))
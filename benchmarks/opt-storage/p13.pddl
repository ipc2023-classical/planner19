; Domain designed by Alfonso Gerevini and Alessandro Saetti
; This file has been automatically generated by the generator available from
; http://zeus.ing.unibs.it/ipc-5/generators/index.html
;
; Map of the Depots:                             
; *=*=*2=*=* *=* * * * * *=* 
;--------------------------- 
; 48: depot48 area
; 49: depot49 area
; 50: depot50 area
; 51: depot51 area
; 52: depot52 area
; 53: depot53 area
; 54: depot54 area
; 55: depot55 area
; 56: depot56 area
; 57: depot57 area
; 65: depot65 area
; 66: depot66 area
; 67: depot67 area
; *: Depot access point
; =: Transit area

(define (problem storage-1)
(:domain Storage-Propositional)
(:objects
	depot48-1-1 depot49-1-1 depot50-1-1 depot50-1-2 depot51-1-1 depot52-1-1 depot53-1-1 depot54-1-1 depot55-1-1 depot56-1-1 depot57-1-1 depot65-1-1 depot66-1-1 depot67-1-1 container-0-0 container-0-1 container-0-2 container-0-3 container-1-0 container-1-1 container-1-2 container-1-3 container-2-0 container-2-1 container-2-2 container-2-3 container-3-0 container-3-1 - storearea
	hoist0 hoist1 - hoist
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 - crate
	container0 container1 container2 container3 - container
	depot48 depot49 depot50 depot51 depot52 depot53 depot54 depot55 depot56 depot57 depot65 depot66 depot67 - depot
	loadarea transit0 transit1 transit2 transit3 transit4 transit5 - transitarea)

(:init
	(connected depot50-1-1 depot50-1-2)
	(connected depot50-1-2 depot50-1-1)
	(connected transit0 depot48-1-1)
	(connected transit0 depot49-1-1)
	(connected transit1 depot49-1-1)
	(connected transit1 depot50-1-1)
	(connected transit2 depot50-1-2)
	(connected transit2 depot51-1-1)
	(connected transit3 depot51-1-1)
	(connected transit3 depot52-1-1)
	(connected transit4 depot53-1-1)
	(connected transit4 depot54-1-1)
	(connected transit5 depot66-1-1)
	(connected transit5 depot67-1-1)
	(in depot48-1-1 depot48)
	(in depot49-1-1 depot49)
	(in depot50-1-1 depot50)
	(in depot50-1-2 depot50)
	(in depot51-1-1 depot51)
	(in depot52-1-1 depot52)
	(in depot53-1-1 depot53)
	(in depot54-1-1 depot54)
	(in depot55-1-1 depot55)
	(in depot56-1-1 depot56)
	(in depot57-1-1 depot57)
	(in depot65-1-1 depot65)
	(in depot66-1-1 depot66)
	(in depot67-1-1 depot67)
	(on crate0 container-0-0)
	(on crate1 container-0-1)
	(on crate2 container-0-2)
	(on crate3 container-0-3)
	(on crate4 container-1-0)
	(on crate5 container-1-1)
	(on crate6 container-1-2)
	(on crate7 container-1-3)
	(on crate8 container-2-0)
	(on crate9 container-2-1)
	(on crate10 container-2-2)
	(on crate11 container-2-3)
	(on crate12 container-3-0)
	(on crate13 container-3-1)
	(in crate0 container0)
	(in crate1 container0)
	(in crate2 container0)
	(in crate3 container0)
	(in crate4 container1)
	(in crate5 container1)
	(in crate6 container1)
	(in crate7 container1)
	(in crate8 container2)
	(in crate9 container2)
	(in crate10 container2)
	(in crate11 container2)
	(in crate12 container3)
	(in crate13 container3)
	(in container-0-0 container0)
	(in container-0-1 container0)
	(in container-0-2 container0)
	(in container-0-3 container0)
	(in container-1-0 container1)
	(in container-1-1 container1)
	(in container-1-2 container1)
	(in container-1-3 container1)
	(in container-2-0 container2)
	(in container-2-1 container2)
	(in container-2-2 container2)
	(in container-2-3 container2)
	(in container-3-0 container3)
	(in container-3-1 container3)
	(connected loadarea container-0-0) 
	(connected container-0-0 loadarea)
	(connected loadarea container-0-1) 
	(connected container-0-1 loadarea)
	(connected loadarea container-0-2) 
	(connected container-0-2 loadarea)
	(connected loadarea container-0-3) 
	(connected container-0-3 loadarea)
	(connected loadarea container-1-0) 
	(connected container-1-0 loadarea)
	(connected loadarea container-1-1) 
	(connected container-1-1 loadarea)
	(connected loadarea container-1-2) 
	(connected container-1-2 loadarea)
	(connected loadarea container-1-3) 
	(connected container-1-3 loadarea)
	(connected loadarea container-2-0) 
	(connected container-2-0 loadarea)
	(connected loadarea container-2-1) 
	(connected container-2-1 loadarea)
	(connected loadarea container-2-2) 
	(connected container-2-2 loadarea)
	(connected loadarea container-2-3) 
	(connected container-2-3 loadarea)
	(connected loadarea container-3-0) 
	(connected container-3-0 loadarea)
	(connected loadarea container-3-1) 
	(connected container-3-1 loadarea)  
	(connected depot48-1-1 loadarea)
	(connected loadarea depot48-1-1)
	(connected depot49-1-1 loadarea)
	(connected loadarea depot49-1-1)
	(connected depot50-1-1 loadarea)
	(connected loadarea depot50-1-1)
	(connected depot51-1-1 loadarea)
	(connected loadarea depot51-1-1)
	(connected depot52-1-1 loadarea)
	(connected loadarea depot52-1-1)
	(connected depot53-1-1 loadarea)
	(connected loadarea depot53-1-1)
	(connected depot54-1-1 loadarea)
	(connected loadarea depot54-1-1)
	(connected depot55-1-1 loadarea)
	(connected loadarea depot55-1-1)
	(connected depot56-1-1 loadarea)
	(connected loadarea depot56-1-1)
	(connected depot57-1-1 loadarea)
	(connected loadarea depot57-1-1)
	(connected depot65-1-1 loadarea)
	(connected loadarea depot65-1-1)
	(connected depot66-1-1 loadarea)
	(connected loadarea depot66-1-1)
	(connected depot67-1-1 loadarea)
	(connected loadarea depot67-1-1)  
	(clear depot48-1-1)
	(clear depot49-1-1)
	(clear depot50-1-1)
	(clear depot50-1-2)
	(clear depot51-1-1)
	(clear depot52-1-1)
	(clear depot53-1-1)
	(clear depot54-1-1)
	(clear depot55-1-1)
	(clear depot56-1-1)
	(clear depot65-1-1)
	(clear depot66-1-1)  
	(at hoist0 depot57-1-1)
	(available hoist0)
	(at hoist1 depot67-1-1)
	(available hoist1))

(:goal (and
	(in crate0 depot48)
	(in crate1 depot49)
	(in crate2 depot50)
	(in crate3 depot50)
	(in crate4 depot51)
	(in crate5 depot52)
	(in crate6 depot53)
	(in crate7 depot54)
	(in crate8 depot55)
	(in crate9 depot56)
	(in crate10 depot57)
	(in crate11 depot65)
	(in crate12 depot66)
	(in crate13 depot67)))
)

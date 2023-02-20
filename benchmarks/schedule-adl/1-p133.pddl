


(define (problem schedule-p9-s2-c1-w1-o2)
(:domain schedule)
(:objects 
    P0
    P1
    P2
    P3
    P4
    P5
    P6
    P7
    P8
 - part
    CIRCULAR
    OBLONG
 - ashape
    BLUE
 - colour
    ONE
 - width
    FRONT
    BACK
 - anorient
)
(:init
(HAS-PAINT IMMERSION-PAINTER BLUE)
(HAS-PAINT SPRAY-PAINTER BLUE)
(CAN-ORIENT DRILL-PRESS FRONT)
(CAN-ORIENT PUNCH FRONT)
(CAN-ORIENT DRILL-PRESS BACK)
(CAN-ORIENT PUNCH BACK)
(HAS-BIT DRILL-PRESS ONE)
(HAS-BIT PUNCH ONE)
(SHAPE P0 CIRCULAR)
(SURFACE-CONDITION P0 SMOOTH)
(HAS-HOLE P0 ONE BACK)
(TEMPERATURE P0 COLD)
(SHAPE P1 OBLONG)
(SURFACE-CONDITION P1 SMOOTH)
(PAINTED P1 BLUE)
(TEMPERATURE P1 COLD)
(SHAPE P2 OBLONG)
(SURFACE-CONDITION P2 POLISHED)
(PAINTED P2 BLUE)
(HAS-HOLE P2 ONE BACK)
(TEMPERATURE P2 COLD)
(SHAPE P3 OBLONG)
(SURFACE-CONDITION P3 POLISHED)
(TEMPERATURE P3 COLD)
(SHAPE P4 OBLONG)
(SURFACE-CONDITION P4 SMOOTH)
(HAS-HOLE P4 ONE FRONT)
(TEMPERATURE P4 COLD)
(SHAPE P5 CYLINDRICAL)
(SURFACE-CONDITION P5 ROUGH)
(PAINTED P5 BLUE)
(TEMPERATURE P5 COLD)
(SHAPE P6 OBLONG)
(SURFACE-CONDITION P6 ROUGH)
(PAINTED P6 BLUE)
(TEMPERATURE P6 COLD)
(SHAPE P7 CIRCULAR)
(SURFACE-CONDITION P7 POLISHED)
(PAINTED P7 BLUE)
(TEMPERATURE P7 COLD)
(SHAPE P8 OBLONG)
(SURFACE-CONDITION P8 SMOOTH)
(PAINTED P8 BLUE)
(TEMPERATURE P8 COLD)
)
(:goal
(and
(SHAPE P0 CYLINDRICAL)
(SURFACE-CONDITION P0 ROUGH)
(PAINTED P0 BLUE)
(HAS-HOLE P0 ONE FRONT)
(PAINTED P1 BLUE)
(HAS-HOLE P1 ONE BACK)
(SHAPE P2 CYLINDRICAL)
(HAS-HOLE P2 ONE FRONT)
(SURFACE-CONDITION P3 ROUGH)
(PAINTED P3 BLUE)
(HAS-HOLE P3 ONE BACK)
(HAS-HOLE P4 ONE BACK)
(SHAPE P5 CYLINDRICAL)
(PAINTED P5 BLUE)
(SHAPE P6 CYLINDRICAL)
(SURFACE-CONDITION P7 SMOOTH)
(PAINTED P7 BLUE)
(HAS-HOLE P7 ONE BACK)
(SHAPE P8 CYLINDRICAL)
(HAS-HOLE P8 ONE FRONT)
)
)
)


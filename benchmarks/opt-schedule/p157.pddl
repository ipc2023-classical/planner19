


(define (problem schedule-p10-s2-c1-w1-o2)
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
    P9
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
(SHAPE P0 CYLINDRICAL)
(SURFACE-CONDITION P0 POLISHED)
(HAS-HOLE P0 ONE FRONT)
(TEMPERATURE P0 COLD)
(SHAPE P1 OBLONG)
(SURFACE-CONDITION P1 POLISHED)
(TEMPERATURE P1 COLD)
(SHAPE P2 CIRCULAR)
(SURFACE-CONDITION P2 ROUGH)
(PAINTED P2 BLUE)
(TEMPERATURE P2 COLD)
(SHAPE P3 OBLONG)
(SURFACE-CONDITION P3 POLISHED)
(HAS-HOLE P3 ONE BACK)
(TEMPERATURE P3 COLD)
(SHAPE P4 OBLONG)
(SURFACE-CONDITION P4 ROUGH)
(TEMPERATURE P4 COLD)
(SHAPE P5 CIRCULAR)
(SURFACE-CONDITION P5 ROUGH)
(PAINTED P5 BLUE)
(TEMPERATURE P5 COLD)
(SHAPE P6 CYLINDRICAL)
(SURFACE-CONDITION P6 ROUGH)
(PAINTED P6 BLUE)
(TEMPERATURE P6 COLD)
(SHAPE P7 OBLONG)
(SURFACE-CONDITION P7 SMOOTH)
(HAS-HOLE P7 ONE FRONT)
(TEMPERATURE P7 COLD)
(SHAPE P8 OBLONG)
(SURFACE-CONDITION P8 POLISHED)
(PAINTED P8 BLUE)
(TEMPERATURE P8 COLD)
(SHAPE P9 CIRCULAR)
(SURFACE-CONDITION P9 POLISHED)
(PAINTED P9 BLUE)
(HAS-HOLE P9 ONE FRONT)
(TEMPERATURE P9 COLD)
)
(:goal
(and
(SHAPE P0 CYLINDRICAL)
(PAINTED P0 BLUE)
(SURFACE-CONDITION P2 ROUGH)
(SURFACE-CONDITION P3 ROUGH)
(HAS-HOLE P3 ONE FRONT)
(SHAPE P4 CYLINDRICAL)
(HAS-HOLE P4 ONE BACK)
(PAINTED P5 BLUE)
(SURFACE-CONDITION P6 SMOOTH)
(HAS-HOLE P6 ONE FRONT)
(SHAPE P7 CYLINDRICAL)
(SURFACE-CONDITION P7 POLISHED)
(PAINTED P7 BLUE)
(HAS-HOLE P7 ONE BACK)
(PAINTED P8 BLUE)
(SHAPE P9 CYLINDRICAL)
(SURFACE-CONDITION P9 POLISHED)
(PAINTED P9 BLUE)
)
)
)






(define (problem schedule-p10-s2-c3-w1-o2)
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
    YELLOW
    RED
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
(HAS-PAINT IMMERSION-PAINTER YELLOW)
(HAS-PAINT SPRAY-PAINTER YELLOW)
(HAS-PAINT IMMERSION-PAINTER RED)
(HAS-PAINT SPRAY-PAINTER RED)
(CAN-ORIENT DRILL-PRESS FRONT)
(CAN-ORIENT PUNCH FRONT)
(CAN-ORIENT DRILL-PRESS BACK)
(CAN-ORIENT PUNCH BACK)
(HAS-BIT DRILL-PRESS ONE)
(HAS-BIT PUNCH ONE)
(SHAPE P0 OBLONG)
(SURFACE-CONDITION P0 SMOOTH)
(PAINTED P0 BLUE)
(TEMPERATURE P0 COLD)
(SHAPE P1 CIRCULAR)
(SURFACE-CONDITION P1 ROUGH)
(TEMPERATURE P1 COLD)
(SHAPE P2 CIRCULAR)
(SURFACE-CONDITION P2 POLISHED)
(PAINTED P2 YELLOW)
(HAS-HOLE P2 ONE FRONT)
(TEMPERATURE P2 COLD)
(SHAPE P3 OBLONG)
(SURFACE-CONDITION P3 SMOOTH)
(PAINTED P3 RED)
(HAS-HOLE P3 ONE BACK)
(TEMPERATURE P3 COLD)
(SHAPE P4 CIRCULAR)
(SURFACE-CONDITION P4 POLISHED)
(TEMPERATURE P4 COLD)
(SHAPE P5 CIRCULAR)
(SURFACE-CONDITION P5 SMOOTH)
(PAINTED P5 BLUE)
(HAS-HOLE P5 ONE FRONT)
(TEMPERATURE P5 COLD)
(SHAPE P6 CYLINDRICAL)
(SURFACE-CONDITION P6 ROUGH)
(PAINTED P6 RED)
(TEMPERATURE P6 COLD)
(SHAPE P7 CIRCULAR)
(SURFACE-CONDITION P7 POLISHED)
(PAINTED P7 RED)
(HAS-HOLE P7 ONE BACK)
(TEMPERATURE P7 COLD)
(SHAPE P8 CIRCULAR)
(SURFACE-CONDITION P8 POLISHED)
(TEMPERATURE P8 COLD)
(SHAPE P9 CIRCULAR)
(SURFACE-CONDITION P9 ROUGH)
(PAINTED P9 BLUE)
(HAS-HOLE P9 ONE FRONT)
(TEMPERATURE P9 COLD)
)
(:goal
(and
(SURFACE-CONDITION P0 ROUGH)
(PAINTED P0 YELLOW)
(HAS-HOLE P0 ONE FRONT)
(SHAPE P1 CYLINDRICAL)
(HAS-HOLE P1 ONE BACK)
(HAS-HOLE P2 ONE BACK)
(PAINTED P3 BLUE)
(SURFACE-CONDITION P4 ROUGH)
(HAS-HOLE P4 ONE BACK)
(SURFACE-CONDITION P6 SMOOTH)
(PAINTED P6 BLUE)
(SHAPE P7 CYLINDRICAL)
(SURFACE-CONDITION P7 SMOOTH)
(PAINTED P7 YELLOW)
(HAS-HOLE P7 ONE BACK)
(SHAPE P8 CYLINDRICAL)
(PAINTED P8 RED)
(HAS-HOLE P8 ONE FRONT)
(SHAPE P9 CYLINDRICAL)
(SURFACE-CONDITION P9 POLISHED)
)
)
)



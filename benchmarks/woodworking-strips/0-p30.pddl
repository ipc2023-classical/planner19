; woodworking task with 22 parts and 150% wood
; Machines:
;   1 highspeed-saw
;   1 glazer
;   1 grinder
;   1 immersion-varnisher
;   1 planer
;   1 saw
;   1 spray-varnisher

(define (problem wood-prob)
  (:domain woodworking)
  (:objects
    highspeed-saw0 - highspeed-saw
    glazer0 - glazer
    grinder0 - grinder
    immersion-varnisher0 - immersion-varnisher
    planer0 - planer
    saw0 - saw
    spray-varnisher0 - spray-varnisher
    red green blue mauve white black - acolour
    cherry oak beech mahogany teak walnut - awood
    p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 - part
    b0 b1 b2 b3 b4 b5 b6 b7 - board
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - aboardsize
  )
  (:init
    (grind-treatment-change varnished colourfragments)
    (grind-treatment-change glazed untreated)
    (grind-treatment-change untreated untreated)
    (grind-treatment-change colourfragments untreated)
    (is-smooth smooth)
    (is-smooth verysmooth)
    (= (total-cost) 0)
    (boardsize-successor s0 s1)
    (boardsize-successor s1 s2)
    (boardsize-successor s2 s3)
    (boardsize-successor s3 s4)
    (boardsize-successor s4 s5)
    (boardsize-successor s5 s6)
    (boardsize-successor s6 s7)
    (boardsize-successor s7 s8)
    (boardsize-successor s8 s9)
    (empty highspeed-saw0)
    (has-colour glazer0 green)
    (has-colour glazer0 black)
    (has-colour glazer0 natural)
    (has-colour glazer0 blue)
    (has-colour glazer0 white)
    (has-colour glazer0 red)
    (has-colour immersion-varnisher0 natural)
    (has-colour immersion-varnisher0 white)
    (has-colour immersion-varnisher0 green)
    (has-colour immersion-varnisher0 black)
    (has-colour spray-varnisher0 natural)
    (has-colour spray-varnisher0 white)
    (has-colour spray-varnisher0 green)
    (has-colour spray-varnisher0 black)
    (unused p0)
    (goalsize p0 large)
    (= (spray-varnish-cost p0) 15)
    (= (glaze-cost p0) 20)
    (= (grind-cost p0) 45)
    (= (plane-cost p0) 30)
    (available p1)
    (treatment p1 colourfragments)
    (surface-condition p1 verysmooth)
    (wood p1 mahogany)
    (colour p1 white)
    (goalsize p1 medium)
    (= (spray-varnish-cost p1) 10)
    (= (glaze-cost p1) 15)
    (= (grind-cost p1) 30)
    (= (plane-cost p1) 20)
    (unused p2)
    (goalsize p2 small)
    (= (spray-varnish-cost p2) 5)
    (= (glaze-cost p2) 10)
    (= (grind-cost p2) 15)
    (= (plane-cost p2) 10)
    (unused p3)
    (goalsize p3 small)
    (= (spray-varnish-cost p3) 5)
    (= (glaze-cost p3) 10)
    (= (grind-cost p3) 15)
    (= (plane-cost p3) 10)
    (unused p4)
    (goalsize p4 medium)
    (= (spray-varnish-cost p4) 10)
    (= (glaze-cost p4) 15)
    (= (grind-cost p4) 30)
    (= (plane-cost p4) 20)
    (available p5)
    (treatment p5 colourfragments)
    (surface-condition p5 rough)
    (wood p5 oak)
    (colour p5 black)
    (goalsize p5 medium)
    (= (spray-varnish-cost p5) 10)
    (= (glaze-cost p5) 15)
    (= (grind-cost p5) 30)
    (= (plane-cost p5) 20)
    (unused p6)
    (goalsize p6 medium)
    (= (spray-varnish-cost p6) 10)
    (= (glaze-cost p6) 15)
    (= (grind-cost p6) 30)
    (= (plane-cost p6) 20)
    (unused p7)
    (goalsize p7 medium)
    (= (spray-varnish-cost p7) 10)
    (= (glaze-cost p7) 15)
    (= (grind-cost p7) 30)
    (= (plane-cost p7) 20)
    (unused p8)
    (goalsize p8 large)
    (= (spray-varnish-cost p8) 15)
    (= (glaze-cost p8) 20)
    (= (grind-cost p8) 45)
    (= (plane-cost p8) 30)
    (unused p9)
    (goalsize p9 large)
    (= (spray-varnish-cost p9) 15)
    (= (glaze-cost p9) 20)
    (= (grind-cost p9) 45)
    (= (plane-cost p9) 30)
    (unused p10)
    (goalsize p10 small)
    (= (spray-varnish-cost p10) 5)
    (= (glaze-cost p10) 10)
    (= (grind-cost p10) 15)
    (= (plane-cost p10) 10)
    (unused p11)
    (goalsize p11 medium)
    (= (spray-varnish-cost p11) 10)
    (= (glaze-cost p11) 15)
    (= (grind-cost p11) 30)
    (= (plane-cost p11) 20)
    (unused p12)
    (goalsize p12 medium)
    (= (spray-varnish-cost p12) 10)
    (= (glaze-cost p12) 15)
    (= (grind-cost p12) 30)
    (= (plane-cost p12) 20)
    (unused p13)
    (goalsize p13 medium)
    (= (spray-varnish-cost p13) 10)
    (= (glaze-cost p13) 15)
    (= (grind-cost p13) 30)
    (= (plane-cost p13) 20)
    (unused p14)
    (goalsize p14 medium)
    (= (spray-varnish-cost p14) 10)
    (= (glaze-cost p14) 15)
    (= (grind-cost p14) 30)
    (= (plane-cost p14) 20)
    (available p15)
    (treatment p15 varnished)
    (surface-condition p15 smooth)
    (wood p15 oak)
    (colour p15 black)
    (goalsize p15 small)
    (= (spray-varnish-cost p15) 5)
    (= (glaze-cost p15) 10)
    (= (grind-cost p15) 15)
    (= (plane-cost p15) 10)
    (unused p16)
    (goalsize p16 small)
    (= (spray-varnish-cost p16) 5)
    (= (glaze-cost p16) 10)
    (= (grind-cost p16) 15)
    (= (plane-cost p16) 10)
    (unused p17)
    (goalsize p17 large)
    (= (spray-varnish-cost p17) 15)
    (= (glaze-cost p17) 20)
    (= (grind-cost p17) 45)
    (= (plane-cost p17) 30)
    (available p18)
    (treatment p18 varnished)
    (surface-condition p18 rough)
    (wood p18 beech)
    (colour p18 green)
    (goalsize p18 medium)
    (= (spray-varnish-cost p18) 10)
    (= (glaze-cost p18) 15)
    (= (grind-cost p18) 30)
    (= (plane-cost p18) 20)
    (unused p19)
    (goalsize p19 large)
    (= (spray-varnish-cost p19) 15)
    (= (glaze-cost p19) 20)
    (= (grind-cost p19) 45)
    (= (plane-cost p19) 30)
    (available p20)
    (treatment p20 glazed)
    (surface-condition p20 verysmooth)
    (wood p20 beech)
    (colour p20 red)
    (goalsize p20 large)
    (= (spray-varnish-cost p20) 15)
    (= (glaze-cost p20) 20)
    (= (grind-cost p20) 45)
    (= (plane-cost p20) 30)
    (unused p21)
    (goalsize p21 small)
    (= (spray-varnish-cost p21) 5)
    (= (glaze-cost p21) 10)
    (= (grind-cost p21) 15)
    (= (plane-cost p21) 10)
    (boardsize b0 s9)
    (wood b0 oak)
    (surface-condition b0 smooth)
    (available b0)
    (boardsize b1 s9)
    (wood b1 oak)
    (surface-condition b1 rough)
    (available b1)
    (boardsize b2 s3)
    (wood b2 oak)
    (surface-condition b2 smooth)
    (available b2)
    (boardsize b3 s5)
    (wood b3 cherry)
    (surface-condition b3 rough)
    (available b3)
    (boardsize b4 s7)
    (wood b4 teak)
    (surface-condition b4 rough)
    (available b4)
    (boardsize b5 s7)
    (wood b5 teak)
    (surface-condition b5 smooth)
    (available b5)
    (boardsize b6 s8)
    (wood b6 beech)
    (surface-condition b6 rough)
    (available b6)
    (boardsize b7 s5)
    (wood b7 walnut)
    (surface-condition b7 rough)
    (available b7)
  )
  (:goal
    (and
    (available p0)
    (wood p0 oak)
    (surface-condition p0 smooth)
    (treatment p0 varnished)
    (colour p0 natural)
    (available p1)
    (treatment p1 varnished)
    (colour p1 green)
    (available p2)
    (wood p2 oak)
    (surface-condition p2 verysmooth)
    (treatment p2 glazed)
    (colour p2 green)
    (available p3)
    (wood p3 cherry)
    (surface-condition p3 smooth)
    (treatment p3 varnished)
    (colour p3 black)
    (available p4)
    (wood p4 teak)
    (treatment p4 glazed)
    (colour p4 red)
    (available p5)
    (wood p5 oak)
    (colour p5 natural)
    (available p6)
    (surface-condition p6 smooth)
    (treatment p6 glazed)
    (colour p6 natural)
    (available p7)
    (wood p7 teak)
    (treatment p7 varnished)
    (available p8)
    (wood p8 beech)
    (surface-condition p8 smooth)
    (available p9)
    (wood p9 oak)
    (surface-condition p9 verysmooth)
    (treatment p9 glazed)
    (colour p9 black)
    (available p10)
    (wood p10 beech)
    (treatment p10 varnished)
    (colour p10 green)
    (available p11)
    (wood p11 oak)
    (surface-condition p11 smooth)
    (treatment p11 glazed)
    (colour p11 blue)
    (available p12)
    (surface-condition p12 smooth)
    (treatment p12 varnished)
    (available p13)
    (wood p13 cherry)
    (surface-condition p13 smooth)
    (colour p13 white)
    (available p14)
    (treatment p14 glazed)
    (colour p14 natural)
    (available p15)
    (wood p15 oak)
    (surface-condition p15 verysmooth)
    (treatment p15 varnished)
    (available p16)
    (wood p16 walnut)
    (surface-condition p16 verysmooth)
    (available p17)
    (wood p17 teak)
    (surface-condition p17 verysmooth)
    (treatment p17 glazed)
    (colour p17 natural)
    (available p18)
    (surface-condition p18 verysmooth)
    (colour p18 white)
    (available p19)
    (wood p19 oak)
    (surface-condition p19 verysmooth)
    (treatment p19 glazed)
    (colour p19 green)
    (available p20)
    (surface-condition p20 verysmooth)
    (colour p20 green)
    (available p21)
    (wood p21 beech)
    (surface-condition p21 smooth)
    (treatment p21 varnished)
    (colour p21 green)
    )
  )
  (:metric minimize (total-cost))
)

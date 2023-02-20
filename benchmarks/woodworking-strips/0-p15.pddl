; woodworking task with 18 parts and 125% wood
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
    green white black blue mauve red - acolour
    beech cherry teak pine - awood
    p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 - part
    b0 b1 b2 b3 b4 b5 - board
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 - aboardsize
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
    (boardsize-successor s9 s10)
    (empty highspeed-saw0)
    (has-colour glazer0 green)
    (has-colour glazer0 blue)
    (has-colour glazer0 white)
    (has-colour glazer0 natural)
    (has-colour glazer0 mauve)
    (has-colour glazer0 red)
    (has-colour immersion-varnisher0 mauve)
    (has-colour immersion-varnisher0 green)
    (has-colour immersion-varnisher0 blue)
    (has-colour immersion-varnisher0 white)
    (has-colour immersion-varnisher0 natural)
    (has-colour immersion-varnisher0 red)
    (has-colour spray-varnisher0 mauve)
    (has-colour spray-varnisher0 green)
    (has-colour spray-varnisher0 blue)
    (has-colour spray-varnisher0 white)
    (has-colour spray-varnisher0 natural)
    (has-colour spray-varnisher0 red)
    (unused p0)
    (goalsize p0 large)
    (= (spray-varnish-cost p0) 15)
    (= (glaze-cost p0) 20)
    (= (grind-cost p0) 45)
    (= (plane-cost p0) 30)
    (unused p1)
    (goalsize p1 small)
    (= (spray-varnish-cost p1) 5)
    (= (glaze-cost p1) 10)
    (= (grind-cost p1) 15)
    (= (plane-cost p1) 10)
    (available p2)
    (treatment p2 glazed)
    (surface-condition p2 smooth)
    (wood p2 beech)
    (colour p2 white)
    (goalsize p2 small)
    (= (spray-varnish-cost p2) 5)
    (= (glaze-cost p2) 10)
    (= (grind-cost p2) 15)
    (= (plane-cost p2) 10)
    (unused p3)
    (goalsize p3 medium)
    (= (spray-varnish-cost p3) 10)
    (= (glaze-cost p3) 15)
    (= (grind-cost p3) 30)
    (= (plane-cost p3) 20)
    (unused p4)
    (goalsize p4 medium)
    (= (spray-varnish-cost p4) 10)
    (= (glaze-cost p4) 15)
    (= (grind-cost p4) 30)
    (= (plane-cost p4) 20)
    (available p5)
    (treatment p5 colourfragments)
    (surface-condition p5 smooth)
    (wood p5 beech)
    (colour p5 black)
    (goalsize p5 small)
    (= (spray-varnish-cost p5) 5)
    (= (glaze-cost p5) 10)
    (= (grind-cost p5) 15)
    (= (plane-cost p5) 10)
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
    (goalsize p10 large)
    (= (spray-varnish-cost p10) 15)
    (= (glaze-cost p10) 20)
    (= (grind-cost p10) 45)
    (= (plane-cost p10) 30)
    (unused p11)
    (goalsize p11 medium)
    (= (spray-varnish-cost p11) 10)
    (= (glaze-cost p11) 15)
    (= (grind-cost p11) 30)
    (= (plane-cost p11) 20)
    (unused p12)
    (goalsize p12 large)
    (= (spray-varnish-cost p12) 15)
    (= (glaze-cost p12) 20)
    (= (grind-cost p12) 45)
    (= (plane-cost p12) 30)
    (unused p13)
    (goalsize p13 medium)
    (= (spray-varnish-cost p13) 10)
    (= (glaze-cost p13) 15)
    (= (grind-cost p13) 30)
    (= (plane-cost p13) 20)
    (available p14)
    (treatment p14 glazed)
    (surface-condition p14 verysmooth)
    (wood p14 cherry)
    (colour p14 green)
    (goalsize p14 medium)
    (= (spray-varnish-cost p14) 10)
    (= (glaze-cost p14) 15)
    (= (grind-cost p14) 30)
    (= (plane-cost p14) 20)
    (unused p15)
    (goalsize p15 small)
    (= (spray-varnish-cost p15) 5)
    (= (glaze-cost p15) 10)
    (= (grind-cost p15) 15)
    (= (plane-cost p15) 10)
    (unused p16)
    (goalsize p16 large)
    (= (spray-varnish-cost p16) 15)
    (= (glaze-cost p16) 20)
    (= (grind-cost p16) 45)
    (= (plane-cost p16) 30)
    (unused p17)
    (goalsize p17 small)
    (= (spray-varnish-cost p17) 5)
    (= (glaze-cost p17) 10)
    (= (grind-cost p17) 15)
    (= (plane-cost p17) 10)
    (boardsize b0 s9)
    (wood b0 cherry)
    (surface-condition b0 smooth)
    (available b0)
    (boardsize b1 s10)
    (wood b1 cherry)
    (surface-condition b1 rough)
    (available b1)
    (boardsize b2 s10)
    (wood b2 pine)
    (surface-condition b2 smooth)
    (available b2)
    (boardsize b3 s3)
    (wood b3 pine)
    (surface-condition b3 smooth)
    (available b3)
    (boardsize b4 s7)
    (wood b4 beech)
    (surface-condition b4 rough)
    (available b4)
    (boardsize b5 s4)
    (wood b5 teak)
    (surface-condition b5 rough)
    (available b5)
  )
  (:goal
    (and
    (available p0)
    (surface-condition p0 smooth)
    (wood p0 cherry)
    (colour p0 mauve)
    (available p1)
    (surface-condition p1 smooth)
    (treatment p1 varnished)
    (wood p1 pine)
    (available p2)
    (treatment p2 glazed)
    (colour p2 natural)
    (available p3)
    (wood p3 cherry)
    (colour p3 mauve)
    (available p4)
    (surface-condition p4 verysmooth)
    (treatment p4 glazed)
    (wood p4 cherry)
    (colour p4 blue)
    (available p5)
    (treatment p5 varnished)
    (wood p5 beech)
    (colour p5 mauve)
    (available p6)
    (surface-condition p6 verysmooth)
    (wood p6 cherry)
    (colour p6 green)
    (available p7)
    (surface-condition p7 verysmooth)
    (wood p7 pine)
    (available p8)
    (treatment p8 glazed)
    (surface-condition p8 verysmooth)
    (available p9)
    (treatment p9 varnished)
    (wood p9 beech)
    (colour p9 blue)
    (available p10)
    (surface-condition p10 verysmooth)
    (treatment p10 varnished)
    (wood p10 pine)
    (colour p10 natural)
    (available p11)
    (surface-condition p11 smooth)
    (colour p11 white)
    (available p12)
    (treatment p12 varnished)
    (wood p12 teak)
    (colour p12 mauve)
    (surface-condition p12 smooth)
    (available p13)
    (treatment p13 varnished)
    (colour p13 natural)
    (surface-condition p13 smooth)
    (available p14)
    (surface-condition p14 verysmooth)
    (colour p14 red)
    (available p15)
    (treatment p15 varnished)
    (surface-condition p15 smooth)
    (available p16)
    (surface-condition p16 verysmooth)
    (wood p16 cherry)
    (colour p16 blue)
    (available p17)
    (treatment p17 varnished)
    (colour p17 natural)
    )
  )
  (:metric minimize (total-cost))
)
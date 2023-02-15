(define (problem strips-mprime-l8-f4-s2-v6-c2)
(:domain mprime-strips)
(:objects f0 f1 f2 f3 f4 - fuel
          s0 s1 s2 - space
          l0 l1 l2 l3 l4 l5 l6 l7 - location
          v0 v1 v2 v3 v4 v5 - vehicle
          c0 c1 - cargo)
(:init
(not-equal l0 l1)
(not-equal l0 l2)
(not-equal l0 l3)
(not-equal l0 l4)
(not-equal l0 l5)
(not-equal l0 l6)
(not-equal l0 l7)
(not-equal l1 l0)
(not-equal l1 l2)
(not-equal l1 l3)
(not-equal l1 l4)
(not-equal l1 l5)
(not-equal l1 l6)
(not-equal l1 l7)
(not-equal l2 l0)
(not-equal l2 l1)
(not-equal l2 l3)
(not-equal l2 l4)
(not-equal l2 l5)
(not-equal l2 l6)
(not-equal l2 l7)
(not-equal l3 l0)
(not-equal l3 l1)
(not-equal l3 l2)
(not-equal l3 l4)
(not-equal l3 l5)
(not-equal l3 l6)
(not-equal l3 l7)
(not-equal l4 l0)
(not-equal l4 l1)
(not-equal l4 l2)
(not-equal l4 l3)
(not-equal l4 l5)
(not-equal l4 l6)
(not-equal l4 l7)
(not-equal l5 l0)
(not-equal l5 l1)
(not-equal l5 l2)
(not-equal l5 l3)
(not-equal l5 l4)
(not-equal l5 l6)
(not-equal l5 l7)
(not-equal l6 l0)
(not-equal l6 l1)
(not-equal l6 l2)
(not-equal l6 l3)
(not-equal l6 l4)
(not-equal l6 l5)
(not-equal l6 l7)
(not-equal l7 l0)
(not-equal l7 l1)
(not-equal l7 l2)
(not-equal l7 l3)
(not-equal l7 l4)
(not-equal l7 l5)
(not-equal l7 l6)
(fuel-neighbor f0 f1)
(fuel-neighbor f1 f2)
(fuel-neighbor f2 f3)
(fuel-neighbor f3 f4)
(space-neighbor s0 s1)
(space-neighbor s1 s2)
(conn l0 l1)
(conn l1 l0)
(conn l1 l2)
(conn l2 l1)
(conn l2 l3)
(conn l3 l2)
(conn l3 l4)
(conn l4 l3)
(conn l4 l5)
(conn l5 l4)
(conn l5 l6)
(conn l6 l5)
(conn l6 l7)
(conn l7 l6)
(conn l7 l0)
(conn l0 l7)
(has-fuel l0 f2)
(has-fuel l1 f2)
(has-fuel l2 f0)
(has-fuel l3 f4)
(has-fuel l4 f3)
(has-fuel l5 f1)
(has-fuel l6 f0)
(has-fuel l7 f1)
(has-space  v0 s1)
(has-space  v1 s1)
(has-space  v2 s2)
(has-space  v3 s1)
(has-space  v4 s2)
(has-space  v5 s2)
(at v0 l7)
(at v1 l6)
(at v2 l1)
(at v3 l3)
(at v4 l1)
(at v5 l7)
(at c0 l2)
(at c1 l4)
)
(:goal
(and
(at c0 l1)
(at c1 l5)
)
)
)

(define (problem DLOG-1-1-9)
	(:domain driverlog)
	(:objects
	driver1 - driver
	truck1 - truck
	package1 - obj
	package2 - obj
	package3 - obj
	package4 - obj
	package5 - obj
	package6 - obj
	package7 - obj
	package8 - obj
	package9 - obj
	s0 - location
	s1 - location
	s2 - location
	s3 - location
	s4 - location
	s5 - location
	s6 - location
	s7 - location
	s8 - location
	s9 - location
	s10 - location
	s11 - location
	s12 - location
	p0-3 - location
	p0-5 - location
	p0-6 - location
	p0-9 - location
	p0-11 - location
	p0-12 - location
	p1-6 - location
	p2-8 - location
	p2-11 - location
	p4-7 - location
	p4-12 - location
	p5-0 - location
	p6-3 - location
	p6-4 - location
	p6-9 - location
	p7-11 - location
	p9-10 - location
	p10-6 - location
	p11-0 - location
	p11-6 - location
	p12-1 - location
	p12-2 - location
	p12-3 - location
	p12-11 - location
	)
	(:init
	(at driver1 s3)
	(at truck1 s9)
	(empty truck1)
	(at package1 s0)
	(at package2 s4)
	(at package3 s12)
	(at package4 s4)
	(at package5 s1)
	(at package6 s1)
	(at package7 s2)
	(at package8 s7)
	(at package9 s2)
	(path s0 p0-3)
	(path p0-3 s0)
	(path s3 p0-3)
	(path p0-3 s3)
	(path s0 p0-5)
	(path p0-5 s0)
	(path s5 p0-5)
	(path p0-5 s5)
	(path s0 p0-6)
	(path p0-6 s0)
	(path s6 p0-6)
	(path p0-6 s6)
	(path s0 p0-9)
	(path p0-9 s0)
	(path s9 p0-9)
	(path p0-9 s9)
	(path s0 p0-11)
	(path p0-11 s0)
	(path s11 p0-11)
	(path p0-11 s11)
	(path s0 p0-12)
	(path p0-12 s0)
	(path s12 p0-12)
	(path p0-12 s12)
	(path s1 p1-6)
	(path p1-6 s1)
	(path s6 p1-6)
	(path p1-6 s6)
	(path s2 p2-8)
	(path p2-8 s2)
	(path s8 p2-8)
	(path p2-8 s8)
	(path s2 p2-11)
	(path p2-11 s2)
	(path s11 p2-11)
	(path p2-11 s11)
	(path s4 p4-7)
	(path p4-7 s4)
	(path s7 p4-7)
	(path p4-7 s7)
	(path s4 p4-12)
	(path p4-12 s4)
	(path s12 p4-12)
	(path p4-12 s12)
	(path s6 p6-3)
	(path p6-3 s6)
	(path s3 p6-3)
	(path p6-3 s3)
	(path s6 p6-4)
	(path p6-4 s6)
	(path s4 p6-4)
	(path p6-4 s4)
	(path s6 p6-9)
	(path p6-9 s6)
	(path s9 p6-9)
	(path p6-9 s9)
	(path s7 p7-11)
	(path p7-11 s7)
	(path s11 p7-11)
	(path p7-11 s11)
	(path s9 p9-10)
	(path p9-10 s9)
	(path s10 p9-10)
	(path p9-10 s10)
	(path s10 p10-6)
	(path p10-6 s10)
	(path s6 p10-6)
	(path p10-6 s6)
	(path s11 p11-6)
	(path p11-6 s11)
	(path s6 p11-6)
	(path p11-6 s6)
	(path s12 p12-1)
	(path p12-1 s12)
	(path s1 p12-1)
	(path p12-1 s1)
	(path s12 p12-2)
	(path p12-2 s12)
	(path s2 p12-2)
	(path p12-2 s2)
	(path s12 p12-3)
	(path p12-3 s12)
	(path s3 p12-3)
	(path p12-3 s3)
	(path s12 p12-11)
	(path p12-11 s12)
	(path s11 p12-11)
	(path p12-11 s11)
	(link s0 s3)
	(link s3 s0)
	(link s0 s11)
	(link s11 s0)
	(link s1 s3)
	(link s3 s1)
	(link s2 s1)
	(link s1 s2)
	(link s2 s3)
	(link s3 s2)
	(link s2 s6)
	(link s6 s2)
	(link s2 s12)
	(link s12 s2)
	(link s3 s4)
	(link s4 s3)
	(link s3 s5)
	(link s5 s3)
	(link s3 s8)
	(link s8 s3)
	(link s3 s10)
	(link s10 s3)
	(link s3 s11)
	(link s11 s3)
	(link s4 s0)
	(link s0 s4)
	(link s4 s1)
	(link s1 s4)
	(link s4 s2)
	(link s2 s4)
	(link s4 s8)
	(link s8 s4)
	(link s4 s10)
	(link s10 s4)
	(link s4 s12)
	(link s12 s4)
	(link s5 s1)
	(link s1 s5)
	(link s5 s2)
	(link s2 s5)
	(link s5 s9)
	(link s9 s5)
	(link s5 s12)
	(link s12 s5)
	(link s6 s1)
	(link s1 s6)
	(link s6 s8)
	(link s8 s6)
	(link s6 s10)
	(link s10 s6)
	(link s6 s12)
	(link s12 s6)
	(link s7 s2)
	(link s2 s7)
	(link s7 s5)
	(link s5 s7)
	(link s8 s2)
	(link s2 s8)
	(link s8 s5)
	(link s5 s8)
	(link s8 s7)
	(link s7 s8)
	(link s8 s9)
	(link s9 s8)
	(link s8 s10)
	(link s10 s8)
	(link s8 s12)
	(link s12 s8)
	(link s9 s2)
	(link s2 s9)
	(link s10 s9)
	(link s9 s10)
	(link s11 s2)
	(link s2 s11)
	(link s12 s11)
	(link s11 s12)
)
	(:goal (and
	(at driver1 s5)
	(at package1 s2)
	(at package2 s6)
	(at package3 s9)
	(at package4 s11)
	(at package5 s11)
	(at package6 s11)
	(at package7 s10)
	(at package8 s1)
	(at package9 s5)
	))


)

(define (problem maintenance-scheduling-1-3-50-70-6-1)
 (:domain maintenance-scheduling-domain)
 (:objects d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 d17 d18 d19 d20 d21 d22 d23 d24 d25 d26 d27 d28 d29 d30 d31 d32 d33 d34 d35 d36 d37 d38 d39 d40 d41 d42 d43 d44 d45 d46 d47 d48 d49 d50 d51 - day
   FRA BER HAM - airport
   ap1 ap2 ap3 ap4 ap5 ap6 ap7 ap8 ap9 ap10 ap11 ap12 ap13 ap14 ap15 ap16 ap17 ap18 ap19 ap20 ap21 ap22 ap23 ap24 ap25 ap26 ap27 ap28 ap29 ap30 ap31 ap32 ap33 ap34 ap35 ap36 ap37 ap38 ap39 ap40 ap41 ap42 ap43 ap44 ap45 ap46 ap47 ap48 ap49 ap50 ap51 ap52 ap53 ap54 ap55 ap56 ap57 ap58 ap59 ap60 ap61 ap62 ap63 ap64 ap65 ap66 ap67 ap68 ap69 ap70 - plane)
 (:init
  (today d1)  (today d2)  (today d3)  (today d4)  (today d5)  (today d6)  (today d7)  (today d8)  (today d9)  (today d10)  (today d11)  (today d12)  (today d13)  (today d14)  (today d15)  (today d16)  (today d17)  (today d18)  (today d19)  (today d20)  (today d21)  (today d22)  (today d23)  (today d24)  (today d25)  (today d26)  (today d27)  (today d28)  (today d29)  (today d30)  (today d31)  (today d32)  (today d33)  (today d34)  (today d35)  (today d36)  (today d37)  (today d38)  (today d39)  (today d40)  (today d41)  (today d42)  (today d43)  (today d44)  (today d45)  (today d46)  (today d47)  (today d48)  (today d49)  (today d50)  (at ap1 d14 FRA)
  (at ap1 d20 FRA)
  (at ap1 d21 FRA)
  (at ap1 d11 BER)
  (at ap1 d39 BER)
  (at ap1 d30 HAM)
  (at ap2 d44 FRA)
  (at ap2 d45 FRA)
  (at ap2 d47 FRA)
  (at ap2 d21 BER)
  (at ap2 d31 HAM)
  (at ap2 d44 HAM)
  (at ap3 d8 FRA)
  (at ap3 d25 FRA)
  (at ap3 d31 FRA)
  (at ap3 d49 FRA)
  (at ap3 d3 HAM)
  (at ap3 d46 HAM)
  (at ap4 d41 FRA)
  (at ap4 d44 FRA)
  (at ap4 d10 BER)
  (at ap4 d26 BER)
  (at ap4 d36 BER)
  (at ap4 d50 BER)
  (at ap5 d2 FRA)
  (at ap5 d38 FRA)
  (at ap5 d38 BER)
  (at ap5 d2 HAM)
  (at ap5 d34 HAM)
  (at ap5 d49 HAM)
  (at ap6 d13 BER)
  (at ap6 d17 BER)
  (at ap6 d43 BER)
  (at ap6 d11 HAM)
  (at ap6 d29 HAM)
  (at ap6 d41 HAM)
  (at ap7 d11 FRA)
  (at ap7 d14 FRA)
  (at ap7 d20 FRA)
  (at ap7 d29 FRA)
  (at ap7 d45 FRA)
  (at ap7 d24 HAM)
  (at ap8 d27 FRA)
  (at ap8 d45 FRA)
  (at ap8 d3 BER)
  (at ap8 d15 BER)
  (at ap8 d37 BER)
  (at ap8 d7 HAM)
  (at ap9 d5 BER)
  (at ap9 d20 BER)
  (at ap9 d22 BER)
  (at ap9 d14 HAM)
  (at ap9 d25 HAM)
  (at ap9 d32 HAM)
  (at ap10 d39 FRA)
  (at ap10 d12 BER)
  (at ap10 d39 BER)
  (at ap10 d4 HAM)
  (at ap10 d10 HAM)
  (at ap10 d30 HAM)
  (at ap11 d31 FRA)
  (at ap11 d18 BER)
  (at ap11 d34 BER)
  (at ap11 d37 BER)
  (at ap11 d40 BER)
  (at ap11 d2 HAM)
  (at ap12 d28 BER)
  (at ap12 d36 BER)
  (at ap12 d37 BER)
  (at ap12 d11 HAM)
  (at ap12 d17 HAM)
  (at ap12 d32 HAM)
  (at ap13 d38 FRA)
  (at ap13 d40 FRA)
  (at ap13 d23 BER)
  (at ap13 d41 BER)
  (at ap13 d13 HAM)
  (at ap13 d49 HAM)
  (at ap14 d1 FRA)
  (at ap14 d22 FRA)
  (at ap14 d29 FRA)
  (at ap14 d2 BER)
  (at ap14 d5 BER)
  (at ap14 d13 BER)
  (at ap15 d33 FRA)
  (at ap15 d34 BER)
  (at ap15 d45 BER)
  (at ap15 d4 HAM)
  (at ap15 d28 HAM)
  (at ap15 d33 HAM)
  (at ap16 d1 FRA)
  (at ap16 d50 FRA)
  (at ap16 d21 BER)
  (at ap16 d19 HAM)
  (at ap16 d22 HAM)
  (at ap16 d45 HAM)
  (at ap17 d3 FRA)
  (at ap17 d19 FRA)
  (at ap17 d41 FRA)
  (at ap17 d21 BER)
  (at ap17 d50 BER)
  (at ap17 d1 HAM)
  (at ap18 d12 FRA)
  (at ap18 d41 FRA)
  (at ap18 d49 FRA)
  (at ap18 d16 BER)
  (at ap18 d36 BER)
  (at ap18 d29 HAM)
  (at ap19 d2 FRA)
  (at ap19 d26 FRA)
  (at ap19 d20 BER)
  (at ap19 d21 BER)
  (at ap19 d20 HAM)
  (at ap19 d23 HAM)
  (at ap20 d1 FRA)
  (at ap20 d25 FRA)
  (at ap20 d45 FRA)
  (at ap20 d20 BER)
  (at ap20 d43 HAM)
  (at ap20 d44 HAM)
  (at ap21 d20 FRA)
  (at ap21 d23 FRA)
  (at ap21 d26 FRA)
  (at ap21 d50 FRA)
  (at ap21 d44 BER)
  (at ap21 d13 HAM)
  (at ap22 d23 FRA)
  (at ap22 d29 FRA)
  (at ap22 d40 BER)
  (at ap22 d44 BER)
  (at ap22 d17 HAM)
  (at ap22 d24 HAM)
  (at ap23 d13 FRA)
  (at ap23 d48 FRA)
  (at ap23 d6 BER)
  (at ap23 d21 BER)
  (at ap23 d22 BER)
  (at ap23 d40 HAM)
  (at ap24 d2 FRA)
  (at ap24 d13 FRA)
  (at ap24 d17 FRA)
  (at ap24 d8 HAM)
  (at ap24 d12 HAM)
  (at ap24 d37 HAM)
  (at ap25 d8 FRA)
  (at ap25 d41 FRA)
  (at ap25 d45 FRA)
  (at ap25 d46 FRA)
  (at ap25 d2 BER)
  (at ap25 d39 HAM)
  (at ap26 d35 BER)
  (at ap26 d37 BER)
  (at ap26 d13 HAM)
  (at ap26 d24 HAM)
  (at ap26 d26 HAM)
  (at ap26 d43 HAM)
  (at ap27 d13 FRA)
  (at ap27 d17 FRA)
  (at ap27 d23 FRA)
  (at ap27 d1 BER)
  (at ap27 d20 BER)
  (at ap27 d29 HAM)
  (at ap28 d2 FRA)
  (at ap28 d34 FRA)
  (at ap28 d49 FRA)
  (at ap28 d1 BER)
  (at ap28 d46 BER)
  (at ap28 d43 HAM)
  (at ap29 d32 FRA)
  (at ap29 d5 BER)
  (at ap29 d7 BER)
  (at ap29 d20 BER)
  (at ap29 d14 HAM)
  (at ap29 d22 HAM)
  (at ap30 d11 FRA)
  (at ap30 d15 BER)
  (at ap30 d38 BER)
  (at ap30 d42 BER)
  (at ap30 d48 BER)
  (at ap30 d25 HAM)
  (at ap31 d15 FRA)
  (at ap31 d28 FRA)
  (at ap31 d35 FRA)
  (at ap31 d50 FRA)
  (at ap31 d1 BER)
  (at ap31 d10 HAM)
  (at ap32 d35 FRA)
  (at ap32 d4 BER)
  (at ap32 d34 BER)
  (at ap32 d10 HAM)
  (at ap32 d13 HAM)
  (at ap32 d22 HAM)
  (at ap33 d21 FRA)
  (at ap33 d42 FRA)
  (at ap33 d47 FRA)
  (at ap33 d12 BER)
  (at ap33 d38 BER)
  (at ap33 d4 HAM)
  (at ap34 d25 FRA)
  (at ap34 d27 FRA)
  (at ap34 d46 FRA)
  (at ap34 d2 HAM)
  (at ap34 d23 HAM)
  (at ap34 d42 HAM)
  (at ap35 d18 FRA)
  (at ap35 d27 BER)
  (at ap35 d30 BER)
  (at ap35 d30 BER)
  (at ap35 d45 BER)
  (at ap35 d49 HAM)
  (at ap36 d30 FRA)
  (at ap36 d30 FRA)
  (at ap36 d50 FRA)
  (at ap36 d19 HAM)
  (at ap36 d39 HAM)
  (at ap36 d39 HAM)
  (at ap37 d19 FRA)
  (at ap37 d20 BER)
  (at ap37 d21 BER)
  (at ap37 d34 BER)
  (at ap37 d12 HAM)
  (at ap37 d38 HAM)
  (at ap38 d19 FRA)
  (at ap38 d14 BER)
  (at ap38 d19 BER)
  (at ap38 d29 BER)
  (at ap38 d47 BER)
  (at ap38 d7 HAM)
  (at ap39 d22 FRA)
  (at ap39 d28 FRA)
  (at ap39 d4 BER)
  (at ap39 d4 BER)
  (at ap39 d5 BER)
  (at ap39 d20 BER)
  (at ap40 d11 FRA)
  (at ap40 d16 FRA)
  (at ap40 d19 FRA)
  (at ap40 d21 FRA)
  (at ap40 d33 BER)
  (at ap40 d32 HAM)
  (at ap41 d30 FRA)
  (at ap41 d14 BER)
  (at ap41 d17 BER)
  (at ap41 d28 BER)
  (at ap41 d34 BER)
  (at ap41 d35 BER)
  (at ap42 d7 FRA)
  (at ap42 d18 FRA)
  (at ap42 d25 FRA)
  (at ap42 d15 BER)
  (at ap42 d37 HAM)
  (at ap42 d45 HAM)
  (at ap43 d6 FRA)
  (at ap43 d11 FRA)
  (at ap43 d36 FRA)
  (at ap43 d3 BER)
  (at ap43 d7 BER)
  (at ap43 d11 BER)
  (at ap44 d1 FRA)
  (at ap44 d1 BER)
  (at ap44 d4 BER)
  (at ap44 d36 BER)
  (at ap44 d35 HAM)
  (at ap44 d36 HAM)
  (at ap45 d3 FRA)
  (at ap45 d18 FRA)
  (at ap45 d29 BER)
  (at ap45 d29 BER)
  (at ap45 d50 BER)
  (at ap45 d40 HAM)
  (at ap46 d46 FRA)
  (at ap46 d7 BER)
  (at ap46 d15 BER)
  (at ap46 d20 BER)
  (at ap46 d27 BER)
  (at ap46 d22 HAM)
  (at ap47 d21 BER)
  (at ap47 d25 BER)
  (at ap47 d45 BER)
  (at ap47 d2 HAM)
  (at ap47 d9 HAM)
  (at ap47 d32 HAM)
  (at ap48 d9 FRA)
  (at ap48 d34 FRA)
  (at ap48 d50 FRA)
  (at ap48 d15 BER)
  (at ap48 d48 BER)
  (at ap48 d40 HAM)
  (at ap49 d39 BER)
  (at ap49 d44 BER)
  (at ap49 d13 HAM)
  (at ap49 d22 HAM)
  (at ap49 d37 HAM)
  (at ap49 d39 HAM)
  (at ap50 d14 FRA)
  (at ap50 d37 BER)
  (at ap50 d42 BER)
  (at ap50 d43 BER)
  (at ap50 d11 HAM)
  (at ap50 d26 HAM)
  (at ap51 d5 FRA)
  (at ap51 d29 BER)
  (at ap51 d30 BER)
  (at ap51 d33 BER)
  (at ap51 d38 HAM)
  (at ap51 d48 HAM)
  (at ap52 d47 FRA)
  (at ap52 d17 BER)
  (at ap52 d22 BER)
  (at ap52 d34 HAM)
  (at ap52 d35 HAM)
  (at ap52 d39 HAM)
  (at ap53 d37 FRA)
  (at ap53 d9 BER)
  (at ap53 d14 BER)
  (at ap53 d3 HAM)
  (at ap53 d13 HAM)
  (at ap53 d25 HAM)
  (at ap54 d13 FRA)
  (at ap54 d38 FRA)
  (at ap54 d46 FRA)
  (at ap54 d36 BER)
  (at ap54 d32 HAM)
  (at ap54 d32 HAM)
  (at ap55 d20 FRA)
  (at ap55 d40 FRA)
  (at ap55 d50 FRA)
  (at ap55 d23 BER)
  (at ap55 d9 HAM)
  (at ap55 d16 HAM)
  (at ap56 d3 FRA)
  (at ap56 d31 FRA)
  (at ap56 d26 BER)
  (at ap56 d45 BER)
  (at ap56 d31 HAM)
  (at ap56 d36 HAM)
  (at ap57 d32 FRA)
  (at ap57 d35 FRA)
  (at ap57 d43 FRA)
  (at ap57 d2 BER)
  (at ap57 d9 BER)
  (at ap57 d43 HAM)
  (at ap58 d23 FRA)
  (at ap58 d23 BER)
  (at ap58 d36 BER)
  (at ap58 d11 HAM)
  (at ap58 d30 HAM)
  (at ap58 d42 HAM)
  (at ap59 d14 FRA)
  (at ap59 d15 FRA)
  (at ap59 d29 FRA)
  (at ap59 d32 FRA)
  (at ap59 d6 BER)
  (at ap59 d6 BER)
  (at ap60 d17 FRA)
  (at ap60 d15 BER)
  (at ap60 d23 BER)
  (at ap60 d44 BER)
  (at ap60 d5 HAM)
  (at ap60 d19 HAM)
  (at ap61 d18 FRA)
  (at ap61 d40 FRA)
  (at ap61 d33 BER)
  (at ap61 d39 BER)
  (at ap61 d20 HAM)
  (at ap61 d44 HAM)
  (at ap62 d21 FRA)
  (at ap62 d41 FRA)
  (at ap62 d43 FRA)
  (at ap62 d10 BER)
  (at ap62 d16 BER)
  (at ap62 d11 HAM)
  (at ap63 d2 FRA)
  (at ap63 d3 FRA)
  (at ap63 d4 BER)
  (at ap63 d14 BER)
  (at ap63 d50 BER)
  (at ap63 d9 HAM)
  (at ap64 d20 FRA)
  (at ap64 d33 FRA)
  (at ap64 d3 BER)
  (at ap64 d4 BER)
  (at ap64 d30 BER)
  (at ap64 d17 HAM)
  (at ap65 d27 FRA)
  (at ap65 d3 BER)
  (at ap65 d23 BER)
  (at ap65 d6 HAM)
  (at ap65 d30 HAM)
  (at ap65 d37 HAM)
  (at ap66 d37 BER)
  (at ap66 d49 BER)
  (at ap66 d18 HAM)
  (at ap66 d27 HAM)
  (at ap66 d28 HAM)
  (at ap66 d41 HAM)
  (at ap67 d4 BER)
  (at ap67 d14 BER)
  (at ap67 d42 BER)
  (at ap67 d43 BER)
  (at ap67 d23 HAM)
  (at ap67 d34 HAM)
  (at ap68 d34 FRA)
  (at ap68 d10 BER)
  (at ap68 d16 BER)
  (at ap68 d9 HAM)
  (at ap68 d11 HAM)
  (at ap68 d31 HAM)
  (at ap69 d5 FRA)
  (at ap69 d9 FRA)
  (at ap69 d13 FRA)
  (at ap69 d28 BER)
  (at ap69 d46 BER)
  (at ap69 d27 HAM)
  (at ap70 d13 FRA)
  (at ap70 d21 FRA)
  (at ap70 d28 FRA)
  (at ap70 d8 BER)
  (at ap70 d8 HAM)
  (at ap70 d38 HAM)
)
  (:goal (and
 (done ap1)
 (done ap2)
 (done ap3)
 (done ap4)
 (done ap5)
 (done ap6)
 (done ap7)
 (done ap8)
 (done ap9)
 (done ap10)
 (done ap11)
 (done ap12)
 (done ap13)
 (done ap14)
 (done ap15)
 (done ap16)
 (done ap17)
 (done ap18)
 (done ap19)
 (done ap20)
 (done ap21)
 (done ap22)
 (done ap23)
 (done ap24)
 (done ap25)
 (done ap26)
 (done ap27)
 (done ap28)
 (done ap29)
 (done ap30)
 (done ap31)
 (done ap32)
 (done ap33)
 (done ap34)
 (done ap35)
 (done ap36)
 (done ap37)
 (done ap38)
 (done ap39)
 (done ap40)
 (done ap41)
 (done ap42)
 (done ap43)
 (done ap44)
 (done ap45)
 (done ap46)
 (done ap47)
 (done ap48)
 (done ap49)
 (done ap50)
 (done ap51)
 (done ap52)
 (done ap53)
 (done ap54)
 (done ap55)
 (done ap56)
 (done ap57)
 (done ap58)
 (done ap59)
 (done ap60)
 (done ap61)
 (done ap62)
 (done ap63)
 (done ap64)
 (done ap65)
 (done ap66)
 (done ap67)
 (done ap68)
 (done ap69)
 (done ap70)
  ))
  )

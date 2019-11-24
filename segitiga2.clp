(defrule generate-garis
	(titik ?x1 ?y1)
	(titik ?x2 ?y2)
	(titik ?x3 ?y3)
	(test (> (sqrt(+(*(- ?x2 ?x1)(- ?x2 ?x1))(*(- ?y2 ?y1)(- ?y2 ?y1)))) 0))
	(test (> (sqrt(+(*(- ?x2 ?x3)(- ?x2 ?x3))(*(- ?y2 ?y3)(- ?y2 ?y3)))) 0))
	(test (> (sqrt(+(*(- ?x3 ?x1)(- ?x3 ?x1))(*(- ?y3 ?y1)(- ?y3 ?y1)))) 0))
	=>
	(assert (garis 1 (sqrt(+(*(- ?x2 ?x1)(- ?x2 ?x1))(*(- ?y2 ?y1)(- ?y2 ?y1))))))
	(assert (garis 2 (sqrt(+(*(- ?x2 ?x3)(- ?x2 ?x3))(*(- ?y2 ?y3)(- ?y2 ?y3))))))
	(assert (garis 3 (sqrt(+(*(- ?x3 ?x1)(- ?x3 ?x1))(*(- ?y3 ?y1)(- ?y3 ?y1))))))
	)

(defrule generate-sudut
	(garis ?identifier1 ?g1)
	(garis ?identifier2 ?g2)
	(garis ?identifier3 ?g3)
	(test(neq ?identifier1 ?identifier2))
	(test(neq ?identifier3 ?identifier2))
	(test(neq ?identifier1 ?identifier3))
	=>
	(assert (sudut 1 (rad-deg (acos(/ (+ (* ?g1 ?g1) (- (* ?g2 ?g2)(* ?g3 ?g3))) (* 2 ?g1 ?g2))))))
	(assert (sudut 2 (rad-deg (acos(/ (+ (* ?g3 ?g3) (- (* ?g2 ?g2)(* ?g1 ?g1))) (* 2 ?g3 ?g2))))))
	(assert (sudut 3 (rad-deg (acos(/ (+ (* ?g1 ?g1) (- (* ?g3 ?g3)(* ?g2 ?g2))) (* 2 ?g1 ?g3))))))
	)

(defrule segitiga-lancip
	(sudut ?identifier1 ?s1)
	(sudut ?identifier2 ?s2)
	(sudut ?identifier3 ?s3)
	(test(neq ?identifier1 ?identifier2))
	(test(neq ?identifier3 ?identifier2))
	(test(neq ?identifier1 ?identifier3))
	(test (< ?s1 89))
	(test (< ?s2 89))
	(test (< ?s2 89))
	=>
	(assert (segitiga lancip))
	)

(defrule segitiga-tumpul
	(sudut ?identifier1 ?s1)
	(sudut ?identifier2 ?s2)
	(sudut ?identifier3 ?s3)
	(test(neq ?identifier1 ?identifier2))
	(test(neq ?identifier3 ?identifier2))
	(test(neq ?identifier1 ?identifier3))
	(or (and (> ?s1 91)(< ?s1 180)) (and (> ?s2 91)(< ?s2 180))(and (> ?s3 91)(< ?s3 180)))
	=>
	(assert(segitiga tumpul))
	)

(defrule segitiga-sama-sisi
	(garis ?identifier1 ?g1)
	(garis ?identifier2 ?g2)
	(garis ?identifier3 ?g3)
	(test(neq ?identifier1 ?identifier2))
	(test(neq ?identifier3 ?identifier2))
	(test(neq ?identifier1 ?identifier3))
	(== ?g1 ?g2 ?g3)
	=>
	(assert (segitiga sama-sisi))
)

(defrule segitiga-siku-siku
	(sudut ?identifier1 ?s1)
	(test (and (> ?s1 89) (< ?s1 91)))
	=>
	(assert (segitiga siku-siku))
)

;;;======================================================
;;;TUGAS BESAR 2 ARTIFICIAL INTELLIGENCE
;;;
;;; Created by :
;;; Pandyaka Aptanagi - 13517003
;;; I Putu Gede Wirasut - 13517015
;;; Rifky I. Bariansyah - 13517081
;;; Gardahadi - 13517144
;;;======================================================

; Rules To check what type of shape it is
(defrule check_triangle
    (point ?x1 ?y1)
    (point ?x2 ?y2)
    (point ?x3 ?y3)
    =>
    (assert (is_trangle))
    )

(defrule check_quadrilateral
    (point ?x1 ?y1)
    (point ?x2 ?y2)
    (point ?x3 ?y3)
    (point ?x4 ?y4)
    =>
    (assert (is_quadrilateral))
    )

(defrule check_pentagonl
    (point ?x1 ?y1)
    (point ?x2 ?y2)
    (point ?x3 ?y3)
    (point ?x4 ?y4)
    (point ?x5 ?y5)
    =>
    (assert (is_pentagon))
    )

; Rules to generate extra information from points
(defrule line_from_points
    (point ?x1 ?y1)
    (point ?x2 ?y2)
    (point ?x3 ?y3)
    =>
    (assert (line 1 (sqrt(+(*(- ?x2 ?x1)(- ?x2 ?x1))(*(- ?y2 ?y1)(- ?y2 ?y1))))))
    (assert (line 2 (sqrt(+(*(- ?x2 ?x1)(- ?x2 ?x1))(*(- ?y2 ?y1)(- ?y2 ?y1))))))
    (assert (line 3 (sqrt(+(*(- ?x2 ?x1)(- ?x2 ?x1))(*(- ?y2 ?y1)(- ?y2 ?y1))))))
    )


(defrule angle_from_grad
    (is_trangle)
    (gradient ?id1 ?m1)
    (gradient ?id2 ?m2)
    (gradient ?id3 ?m2) 
    (test(neq ?id1 ?id2))
	(test(neq ?id3 ?id2))
	(test(neq ?id1 ?id3))
    =>
    (assert (angle 1 (rad-deg (atan (abs (/ (- m2 m1) (+ 1 (* m1 m2 ))) ) ) ) ) )
    (assert (angle 2 (rad-deg (atan (abs (/ (- m3 m1) (+ 1 (* m3 m1 ))) ) ) ) ) )
    (assert (angle 3 (rad-deg (atan (abs (/ (- m3 m2) (+ 1 (* m3 m2 ))) ) ) ) ) )     

(defrule acute_triangle
    (is_triangle)
    (


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
    (n_lines 3)
    =>
    (assert (is_trangle))
    )

(defrule check_quadrilateral
    (n_lines 4)
    =>
    (assert (is_quadrilateral))
    )

(defrule check_pentagonl
    (n_lines 5)
    =>
    (assert (is_pentagon))
    )

(defrule check_hexagon
    (n_lines 6)
    =>
    (assert (is_hexagon))
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

;;;;======================================================
;;; RULES FOR TRIANGLES
;;;======================================================


(defrule get_3_angle
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
    )

(defrule is_acute
    (is_triangle)
    (angle ?id1 ?deg1)
    (angle ?id2 ?deg2)
    (angle ?id3 ?deg3)
    (neq ?id1 ?id2))
	(neq ?id3 ?id2))
	(neq ?id1 ?id3))
    (= (+ ?deg1 (+ ?deg2 ?deg3) 180 )
    (test (< ?deg1 89))
	(test (< ?deg2 89))
	(test (< ?deg3 89))
    =>
    (assert (triangle acute))
    )

(defrule is_obtuse
    (is_triangle)
    (angle ?id1 ?deg1)
    (angle ?id2 ?deg2)
    (angle ?id3 ?deg3)
    (test(neq ?id1 ?id2))
	(test(neq ?id3 ?id2))
	(test(neq ?id1 ?id3))
    (or
        ( > ?deg1 90)
        ( > ?deg2 90)
        ( > ?deg3 90)
    )
    =>
    (assert(triangle obtuse))
    )

(defrule is_right
    (is_triangle)
    (line ?id1 ?l1)
    (line ?id2 ?l2)
    (line ?id3 ?l3)
    (neq ?id1 ?id2))
	(neq ?id3 ?id2))
	(neq ?id1 ?id3))
    (== ?l1 ?l1 l2?))


;;;;======================================================
;;; RULES FOR QUADRILATERALS
;;;======================================================


;;;;======================================================
;;; RULES FOR PENTAGONS
;;;======================================================


;;;;======================================================
;;; RULES FOR HEXAGONS
;;;======================================================

;;;;======================================================
;;; RULES FOR other stuff
;;;======================================================

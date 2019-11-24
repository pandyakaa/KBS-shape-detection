(defrule MAIN::check_triangle
   (adjacent 3)
   =>
   (assert (triangle)))

(defrule MAIN::check_quadrilateral
   (adjacent 4)
   =>
   (assert (quadrilateral)))

(defrule MAIN::check_pentagonl
   (adjacent 5)
   =>
   (assert (pentagon)))

(defrule MAIN::check_hexagon
   (adjacent 6)
   =>
   (assert (hexagon)))

(defrule MAIN::line_from_points
   (point ?x1 ?y1)
   (point ?x2 ?y2)
   (point ?x3 ?y3)
   =>
   (assert (line 1 (sqrt (+ (* (- ?x2 ?x1) (- ?x2 ?x1)) (* (- ?y2 ?y1) (- ?y2 ?y1))))))
   (assert (line 2 (sqrt (+ (* (- ?x2 ?x1) (- ?x2 ?x1)) (* (- ?y2 ?y1) (- ?y2 ?y1))))))
   (assert (line 3 (sqrt (+ (* (- ?x2 ?x1) (- ?x2 ?x1)) (* (- ?y2 ?y1) (- ?y2 ?y1)))))))

(defrule MAIN::get_3_angle
   (triangle)
   (gradient ?id1 ?m1)
   (gradient ?id2 ?m2)
   (gradient ?id3 ?m3)
   (test (neq ?id1 ?id2))
   (test (neq ?id3 ?id2))
   (test (neq ?id1 ?id3))
   =>
   (assert (angle 1 (rad-deg (atan (abs (/ (- ?m2 ?m1) (+ 1 (* ?m1 ?m2))))))))
   (assert (angle 2 (rad-deg (atan (abs (/ (- ?m3 ?m1) (+ 1 (* ?m3 ?m1))))))))
   (assert (angle 3 (rad-deg (atan (abs (/ (- ?m3 ?m2) (+ 1 (* ?m3 ?m2)))))))))

(defrule MAIN::is_isosceles
   (triangle)
   (line ?id1 ?l1)
   (line ?id2 ?l2)
   (line ?id3 ?l3)
   (test (neq ?id1 ?id2))
   (test (neq ?id3 ?id2))
   (test (neq ?id1 ?id3))
   (or  (and (eq ?l1 ?l2)
             (neq ?l1 ?l3))
        (and (eq ?l1 ?l3)
             (neq ?l1 ?l2))
        (and (eq ?l2 ?l3)
             (neq ?l1 ?l3)))
   =>
   (assert (is_isosceles)))

(defrule MAIN::is_acute
   (triangle)
   (angle ?id1 ?deg1)
   (angle ?id2 ?deg2)
   (angle ?id3 ?deg3)
   (test (neq ?id1 ?id2))
   (test (neq ?id3 ?id2))
   (test (neq ?id1 ?id3))
   (test (< ?deg1 89))
   (test (< ?deg2 89))
   (test (< ?deg3 89))
   =>
   (assert (is_acute)))

(defrule MAIN::is_obtuse
   (triangle)
   (angle ?id1 ?deg1)
   (angle ?id2 ?deg2)
   (angle ?id3 ?deg3)
   (test (neq ?id1 ?id2))
   (test (neq ?id3 ?id2))
   (test (neq ?id1 ?id3))
   (or  (> ?deg1 90)
        (> ?deg2 90)
        (> ?deg3 90))
   =>
   (assert (is_obtuse)))

(defrule MAIN::is_equilateral
   (triangle)
   (line ?id1 ?l1)
   (line ?id2 ?l2)
   (line ?id3 ?l3)
   (eq ?l1 ?l2)
   =>
   (assert (is_equilateral)))


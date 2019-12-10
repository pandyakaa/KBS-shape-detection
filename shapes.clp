(deffunction get_angle (?m1 ?m2) 
    (rad-deg (atan ( abs ( / (- ?m2 ?m1) (+ 1 (* ?m1 ?m2)) ) ) ) )
);

(defrule check_triangle
    (adjacent 3)   
     =>
    (assert (triangle))
);

(defrule check_quadrilateral
    (adjacent 4)
    =>
    (assert (quadrilateral))
);

(defrule check_pentagonl
    (adjacent 5)
    =>
    (assert (pentagon))
);

(defrule check_hexagon
    (adjacent 6)
    =>
    (assert (hexagon))
);

(defrule get_3_angle
    (triangle)
    (line ?id1 ?l1 ?m1)
    (line ?id2 ?l2 ?m2)
    (line ?id3 ?l3 ?m3) 
    (test(neq ?id1 ?id2))
	(test(neq ?id3 ?id2))
	(test(neq ?id1 ?id3))
    =>
    (assert (angle 1 (rad-deg (acos (/ (+ (* ?l1 ?l1) (- (* ?l2 ?l2)(* ?l3 ?l3))) (* 2 ?l1 ?l2))))))
    (assert (angle 2 (rad-deg (acos (/ (+ (* ?l3 ?l3) (- (* ?l2 ?l2)(* ?l1 ?l1))) (* 2 ?l3 ?l2))))))
    (assert (angle 3 (rad-deg (acos (/ (+ (* ?l1 ?l1) (- (* ?l3 ?l3)(* ?l2 ?l2))) (* 2 ?l1 ?l3))))))     
);

(defrule is_isosceles
    (triangle)
    (line ?id1 ?l1 ?m1)
    (line ?id2 ?l2 ?m2)
    (line ?id3 ?l3 ?m3)
    (test(neq ?id1 ?id2))
	(test(neq ?id3 ?id2))
	(test(neq ?id1 ?id3))
    (test(< (abs(- ?l1 ?l2)) 10))
    =>
    (assert
        (is_isosceles)
    )
);

(defrule is_acute
    (triangle)
    (angle ?id1 ?deg1)
    (angle ?id2 ?deg2)
    (angle ?id3 ?deg3)
    (test(neq ?id1 ?id2))
	(test(neq ?id3 ?id2))
	(test(neq ?id1 ?id3))
    (and
        (test (< ?deg1 87))
        (test (< ?deg2 87))
        (test (< ?deg3 87))
    )
    =>
    (assert (is_acute))
);
(defrule is_obtuse
    (triangle)
    (angle ?id1 ?deg1)
    (angle ?id2 ?deg2)
    (angle ?id3 ?deg3)
    (test(neq ?id1 ?id2))
	(test(neq ?id3 ?id2))
	(test(neq ?id1 ?id3))
    (or
        (test( > ?deg1 93))
        (test( > ?deg2 93))
        (test( > ?deg3 93))
    )
    =>
    (assert(is_obtuse))
);
(defrule is_equilateral
    (triangle)
    (line ?id1 ?l1 ?m1)
    (line ?id2 ?l2 ?m2)
    (line ?id3 ?l3 ?m3)
    (test(neq ?id1 ?id2))
	(test(neq ?id3 ?id2))
	(test(neq ?id1 ?id3))
    (test(< (abs(- ?l1 ?l2)) 10))
    (test(< (abs(- ?l2 ?l3)) 10))
    =>
    (assert 
        (is_equilateral)
    )
);

<<<<<<< HEAD
=======
(defrule is_right
    (triangle)
    (angle ?id1 ?deg1)
    (angle ?id2 ?deg2)
    (angle ?id3 ?deg3)
    (test(neq ?id1 ?id2))
	(test(neq ?id3 ?id2))
	(test(neq ?id1 ?id3))
    (and
        (test( < ?deg1 93))
        (test( > ?deg1 87))
    )
    =>
    (assert(is_right))
);

>>>>>>> de14cdedacb697389ec7c94bba2e44a5a32769a6
(defrule is_square
    (quadrilateral)
    (line ?id1 ?l1 ?m1)
    (line ?id2 ?l2 ?m2)
    (line ?id3 ?l3 ?m3)
    (line ?id4 ?l4 ?m4)
    (meet ?id1 ?id2)
    (meet ?id1 ?id4)
    (meet ?id2 ?id3)
    (meet ?id4 ?id3)
    (test(neq ?id1 ?id2))
    (test(neq ?id1 ?id3))
    (test(neq ?id1 ?id4))
    (test(neq ?id3 ?id2))
    (test(neq ?id4 ?id2))
    (test(neq ?id3 ?id4))
    (test (< (abs (- ?l1 ?l3)) 6))
    (test (< (abs (- ?l2 ?l4)) 6))
    =>
    (assert
        (is_square)
    )
);

(defrule is_kite 
    (quadrilateral)
    (point ?x1 ?y1)
    (point ?x2 ?y2)
    (point ?x3 ?y3)
    (point ?x4 ?y4)
    (line ?id1 ?l1 ?m1)
    (line ?id2 ?l2 ?m2)
    (line ?id3 ?l3 ?m3)
    (line ?id4 ?l4 ?m4)
    (test(neq ?id1 ?id2))
    (test(neq ?id3 ?id2))
    (test(neq ?id4 ?id2))
    (test(neq ?id1 ?id3))
    (test(neq ?id1 ?id4))
    (test(neq ?id3 ?id4))
    (meet ?id1 ?id2)
    (meet ?id1 ?id4)
    (meet ?id2 ?id3)
    (meet ?id4 ?id3) 
    (test (< (abs (- ?l1 ?l4)) 6))
    (test (< (abs (- ?l2 ?l3)) 6))
    (test (> (abs (- ?l1 ?l2)) 3))
    (test (> (abs (- ?l1 ?l3)) 3))
    (test (< (abs (- ?x1 ?x3)) 6))
    (test (< (abs (- ?y2 ?y4)) 6))
    =>
    (assert (kite))
);   

(defrule trapezoid
    (quadrilateral)
    (line ?id1 ?l1)
    (line ?id2 ?l2)
    (line ?id3 ?l3)
    (line ?id4 ?l4)
    (test(neq ?id1 ?id2))
    (test(neq ?id1 ?id3))
    (test(neq ?id1 ?id4))
    (test(neq ?id3 ?id2))
    (test(neq ?id4 ?id2))
    (test(neq ?id3 ?id4))
    (meet ?id1 ?id2)
    (meet ?id1 ?id4)
    (meet ?id2 ?id3)
    (meet ?id4 ?id3) 
    (test (< (abs (- ?l2 ?l4)) 6))
    (test (> (abs (- ?l1 ?l3)) 3))
    =>
    (assert(trapezoid))
    (assert(is_isosceles))
);

(defrule trapezoid_left_side
    (quadrilateral)
    (line ?id1 ?l1 ?m1)
    (line ?id2 ?l2 ?m2)
    (line ?id3 ?l3 ?m3)
    (line ?id4 ?l4 ?m4)
    (test(neq ?id1 ?id2))
    (test(neq ?id3 ?id2))
    (test(neq ?id4 ?id2))
    (test(neq ?id1 ?id3))
    (test(neq ?id1 ?id4))
    (test(neq ?id3 ?id4))
    (meet ?id1 ?id2)
    (meet ?id1 ?id4)
    (meet ?id2 ?id3)
    (meet ?id4 ?id3) 

    (test 
        (and
            (or  
                ( > (get_angle ?m1 ?m4) 89) 
                ( < (get_angle ?m1 ?m4) 91) 
            )
            (or  
                ( > (get_angle ?m4 ?m3) 89) 
                ( < (get_angle ?m4 ?m3) 91) 
            ) 
        ) 
    )
    (test ( < ?m2 0))
    =>
    (assert (trapezoid))
    (assert (left-side-right))
);

(defrule trapezoid_right_side
    (quadrilateral)
    (line ?id1 ?l1 ?m1)
    (line ?id2 ?l2 ?m2)
    (line ?id3 ?l3 ?m3)
    (line ?id4 ?l4 ?m4)
    (test(neq ?id1 ?id2))
    (test(neq ?id3 ?id2))
    (test(neq ?id4 ?id2))
    (test(neq ?id1 ?id3))
    (test(neq ?id1 ?id4))
    (test(neq ?id3 ?id4))
    (meet ?id1 ?id2)
    (meet ?id1 ?id4)
    (meet ?id2 ?id3)
    (meet ?id4 ?id3) 

    (test 
        (and
            (or  
                ( > (get_angle ?m1 ?m4) 89) 
                ( < (get_angle ?m1 ?m4) 91) 
            )
            (or  
                ( > (get_angle ?m4 ?m3) 89) 
                ( < (get_angle ?m4 ?m3) 91) 
            ) 
        ) 
    )
    (test ( > ?m2 0))
    =>
    (assert (trapezoid))
    (assert (right-side-right))
);



(defrule is_equilateral
    (pentagon)
    (line ?id1 ?l1)
    (line ?id2 ?l2)
    (line ?id3 ?l3)
    (line ?id4 ?l4)
    (line ?id5 ?l5)
    (test (neq ?id1 ?id2))
    (test (neq ?id1 ?id3))
    (test (neq ?id1 ?id4))
    (test (neq ?id1 ?id5))
    (test (neq ?id2 ?id3))
    (test (neq ?id2 ?id4))
    (test (neq ?id2 ?id5))
    (test (neq ?id3 ?id4))
    (test (neq ?id3 ?id5))
    (test (neq ?id4 ?id5))
    (test (< (abs (- ?l1 ?l2)) 6))
    (test (< (abs (- ?l2 ?l3)) 6))
    (test (< (abs (- ?l3 ?l4)) 6))
    (test (< (abs (- ?l4 ?l5)) 6))
    =>
    (assert (is_equilateral))
);


(defrule is_equilateral
    (hexagon)
    (line ?id1 ?l1)
    (line ?id2 ?l2)
    (line ?id3 ?l3)
    (line ?id4 ?l4)
    (line ?id5 ?l5)
    (line ?id6 ?l6)
    (test (neq ?id1 ?id2))
    (test (neq ?id1 ?id3))
    (test (neq ?id1 ?id4))
    (test (neq ?id1 ?id5))
    (test (neq ?id1 ?id6))
    (test (neq ?id2 ?id3))
    (test (neq ?id2 ?id4))
    (test (neq ?id2 ?id5))
    (test (neq ?id2 ?id6))
    (test (neq ?id3 ?id4))
    (test (neq ?id3 ?id5))
    (test (neq ?id3 ?id6))
    (test (neq ?id4 ?id5))
    (test (neq ?id4 ?id6))
    (test (neq ?id5 ?id6))
    (test (< (abs (- ?l1 ?l2)) 6))
    (test (< (abs (- ?l2 ?l3)) 6))
    (test (< (abs (- ?l3 ?l4)) 6))
    (test (< (abs (- ?l4 ?l5)) 6))
    (test (< (abs (- ?l5 ?l6)) 6))
    =>
    (assert (is_equilateral))
)

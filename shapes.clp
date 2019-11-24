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

(defrule line_from_points_3
    (triangle)
    (point ?x1 ?y1)
    (point ?x2 ?y2)
    (point ?x3 ?y3)
    =>
    (assert (line 1 (sqrt(+(*(- ?x2 ?x1)(- ?x2 ?x1))(*(- ?y2 ?y1)(- ?y2 ?y1))))))
    (assert (line 2 (sqrt(+(*(- ?x3 ?x1)(- ?x3 ?x1))(*(- ?y3 ?y1)(- ?y3 ?y1))))))
    (assert (line 3 (sqrt(+(*(- ?x2 ?x3)(- ?x2 ?x3))(*(- ?y2 ?y3)(- ?y2 ?y3))))))
);

(defrule line_from_points_4
    (triangle)
    (point ?x1 ?y1)
    (point ?x2 ?y2)
    (point ?x3 ?y3)
    (point ?x4 ?y4)
    =>
    (assert (line 1 (sqrt(+(*(- ?x2 ?x1)(- ?x2 ?x1))(*(- ?y2 ?y1)(- ?y2 ?y1))))))
    (assert (line 2 (sqrt(+(*(- ?x3 ?x2)(- ?x3 ?x2))(*(- ?y3 ?y2)(- ?y3 ?y2))))))
    (assert (line 3 (sqrt(+(*(- ?x3 ?x4)(- ?x4 ?x3))(*(- ?y4 ?y3)(- ?y4 ?y3))))))
    (assert (line 3 (sqrt(+(*(- ?x1 ?x4)(- ?x4 ?x1))(*(- ?y4 ?y1)(- ?y4 ?y1))))))

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
    (test
        (or 
            (and (eq ?l1 ?l2)(neq ?l1 ?l3) )
            (and (eq ?l1 ?l3)(neq ?l1 ?l2) )
            (and (eq ?l2 ?l3)(neq ?l1 ?l3) )
        )
    )
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
        (test (< ?deg1 89))
        (test (< ?deg2 89))
        (test (< ?deg3 89))
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
        (test( > ?deg1 91))
        (test( > ?deg2 91))
        (test( > ?deg3 91))
    )
    =>
    (assert(is_obtuse))
);
(defrule is_equilateral
    (triangle)
    (line ?id1 ?l1 ?m1)
    (line ?id2 ?l2 ?m2)
    (line ?id3 ?l3)
    (test(neq ?id1 ?id2))
	(test(neq ?id3 ?id2))
	(test(neq ?id1 ?id3))
    (test(eq ?l1 ?l2))
    (test(eq ?l1 ?l3))
    =>
    (assert 
        (is_equilateral)
    )
);
(defrule is_square
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
    (test(eq ?l1 ?l2))
    (test(eq ?l1 ?l3))
    (test(eq ?l3 ?l4))
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
    (line ?id1 ?l1)
    (line ?id2 ?l2)
    (line ?id3 ?l3)
    (line ?id4 ?l4)
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
            (eq ?id1 ?id4)
            (eq ?id2 ?id3)
            (neq ?id1 ?id2)
            (neq ?id1 ?id3)
        )
    )
    (test
        (and  
            (eq ?x1 ?x3)
            (eq ?y2 ?y4)
        )
    )
    =>
    (assert (kite))
)   

(defrule trapezoid
    (quadrilateral)
    (line ?id1 ?l1)
    (line ?id2 ?l2)
    (line ?id3 ?l3)
    (line ?id4 ?l4)
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
    (test(= ?l2 ?l4))
    (test(<> ?l3 ?l1))
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
(test(neq ?id1 ?id2))
(test(neq ?id1 ?id3))
(test(neq ?id1 ?id4))
(test(neq ?id1 ?id5))
(test(neq ?id2 ?id3))
(test(neq ?id2 ?id4))
(test(neq ?id2 ?id5))
(test(neq ?id3 ?id4))
(test(neq ?id3 ?id5))
(test(neq ?id4 ?id5))
(test(= ?l1 ?l2))
(test(= ?l2 ?l3))
(test(= ?l3 ?l4))
(test(= ?l4 ?l5))
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
(test(neq ?id1 ?id2))
(test(neq ?id1 ?id3))
(test(neq ?id1 ?id4))
(test(neq ?id1 ?id5))
(test(neq ?id1 ?id6))
(test(neq ?id2 ?id3))
(test(neq ?id2 ?id4))
(test(neq ?id2 ?id5))
(test(neq ?id2 ?id6))
(test(neq ?id3 ?id4))
(test(neq ?id3 ?id5))
(test(neq ?id3 ?id6))
(test(neq ?id4 ?id5))
(test(neq ?id4 ?id6))
(test(neq ?id5 ?id6))
(test(eq ?l1 ?l2))
(test(eq ?l2 ?l3))
(test(eq ?l3 ?l4))
(test(eq ?l4 ?l5))
(test(eq ?l5 ?l6))
=>
(assert (is_equilateral))
)

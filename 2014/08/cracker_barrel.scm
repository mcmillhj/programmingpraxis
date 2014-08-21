;; list of all possible-moves
(define possible-moves 
  '((0 1 3) (0 2 5)
    (1 3 6) (1 4 8)
    (2 4 7) (2 5 9)
    (3 1 0) (3 4 5) (3 6 10) (3 7 12)
    (4 7 11) (4 8 13)
    (5 2 0) (5 4 3) (5 8 11) (5 9 14)
    (6 3 1) (6 7 8)
    (7 4 2) (7 8 9)
    (8 4 1) (8 7 6)
    (9 5 2) (9 8 7)
    (10 6 3) (10 11 12)
    (11 7 4) (11 12 13)
    (12 7 3) (12 8 5) (12 11 10) (12 13 14)
    (13 12 11) (13 8 4)
    (14 9 5) (14 13 12)))

;; we can see from above that many of these triplets share the same
;; middle digit, we can use these to reduce the size of our list of moves
;; (0 1 3)  <=> (3 1 0)
;; (0 2 5)  <=> (5 2 0)
;; (1 4 8)  <=> (8 4 1)
;; (2 4 7)  <=> (7 4 2)
;; (2 5 9)  <=> (9 5 2)
;; (3 4 5)  <=> (5 3 4)
;; (3 6 10) <=> (10 6 3)
;; (3 7 12) <=> (12 7 3)
;; ...
;; we can now say that a triplet (a b c) represents both the moves
;; (a b c) AND (c b a)
;; this allows us to reduce our list of moves from 36 -> 19
(define compressed-possible-moves 
  '((0 1 3) (0 2 5)
    (1 3 6) (1 4 8)
    (2 4 7) (2 5 9)
    (3 4 5) (3 6 10) (3 7 12)
    (4 7 11) (4 8 13)
    (5 8 11) (5 9 14)
    (6 7 8)
    (7 8 9)
    (10 11 12)
    (11 12 13)
    (12 8 5) (12 13 14)))

(define initial-board '((1 2 3 4 5 6 7 8 9 10 11 12 13 14)))

;; given a board b we can make a move (a b c)
;; if a and b are on the board and c is not
;; or c and b are on the board and a is not
(define (can-move? board move)
  (let ((from (car move))
        (over (cadr move))
        (to   (caddr move))
        (b    (car board)))
    (display b)
    (newline)
    (or (and (member from b)
             (member over b)
             (not (member to b)))
        (and (member to   b)
             (member over b)
             (not (member from b))))))



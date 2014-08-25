;; This sorting algorithm derives its name from the game of Patience (that’s the British name, we call it Solitaire in the United States) 
;; because it is implemented by analogy to sorting a shuffled deck of cards:
;;
;; Starting with no piles, add the next card from the deck to the first pile with top card greater than the next card from the deck. 
;; If the next card from the deck is greater than the top card of all the piles, start a new pile. 
;; When the deck is exhausted, collect the cards in order by selecting the smallest visible card at each step.
;;
;; For instance, consider sorting the list (4 3 9 1 5 2 7 8 6). 
;; The first stack gets 4 and 3. Since 9 is larger than 3, it starts a second stack, 1 goes on the first stack, then 5 and 2 go on the second stack. 
;; At this point the first stack (top to bottom) consists of (1 3 4), the second stack consists of (2 5 9), and the remaining deck consists of (7 8 6). 
;; Now 7 goes on a third stack, 8 goes on a fourth stack, and 6 goes on top of the 7 in the third stack. 
;; With all the cards dealt: 
;;    1 is collected from the first stack, 2 from the second stack, 3 and 4 from the first stack, 5 from the second stack, 
;;    6 and 7 from the third stack, 8 from the fourth stack, and 9 from the second stack. 
;; The algorithm has complexity O(n log n).
;;
;; Your task is to implement the patience sorting algorithm. 
;; When you are finished, you are welcome to read or run a suggested solution, or to post your own solution or discuss the exercise in the comments below.
(define deck '(4 3 9 1 5 2 7 8 6))
(define (build-stacks deck)
  (build-stacks-helper deck (list)))
(define (build-stacks-with-existing deck stacks)
  (build-stacks-helper deck stacks))
(define (build-stacks-helper deck stacks)
  (define (aux deck buffer stacks)
    (cond ((null? deck) stacks)  ; no cards left in deck
          ((null? stacks)        ; add a new stack
           ;; recurse
           ;; remove top card from deck
           ;; buffer is empty because we are adding a stack
           ;; append new stack to the END of any stacks we were already holding 
           ;; in buffer
           (aux (cdr deck) 
                (list) 
                (reverse (cons (list (car deck)) buffer))))
          ((< (car deck) (caar stacks)) ; card should go in this stack
           ;; recurse
           ;; remove top card from deck 
           ;; buffer is empty because we are adding to an existing stack
           ;; insert card into existing stack between to remainder of 
           ;; stacks and any cards we have stored in buffer
           (aux (cdr deck)
                (list)
                (append (reverse buffer)
                        (list (cons (car deck) (car stacks)))
                        (cdr stacks))))
          (else ; wrong stack
           ;; recurse
           ;; deck stays the same
           ;; add the current stack to the buffer
           ;; look at next stack 
           (aux deck 
                (cons (car stacks) buffer) 
                (cdr stacks)))))
  (aux deck (list) stacks))

; sorting
; since all of the stacks are held in increasing order by the above code
; we can "sort" by taking the top value from the first stack then 
; re-build the remainder of the first stack over the other stacks
(define (sort-stacks deck)
  (define (aux sorted-deck stacks)
    (display sorted-deck) (newline)
    (display stacks) (newline)
    (if (null? stacks) 
        sorted-deck
        (aux (append sorted-deck (list (caar stacks)))
             (build-stacks-with-existing (reverse (cdar stacks)) (cdr stacks)))))
  (aux (list) (build-stacks deck)))
  

(define (factorial n)
  (let loop ((n n) (acc 1))
    (if (< n 2)
        acc
        (loop (- n 1) (* acc n))))
  (loop n 1))

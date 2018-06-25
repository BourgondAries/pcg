#lang racket/base

;; PCG implementation ported from pcg-basic
;; The functions `pcg` and `pcg-view` are pcg-step-64 and PCG-XSG-RR (the view function) respectively, as recommended
;; by the paper
;; http://www.pcg-random.org/pdf/hmc-cs-2014-0905.pdf, section 6.3.1
(provide (rename-out [pcg-step-64         pcg]
                     [output-xsh-rr-64-32 pcg-view]))

;;;; Utilities
(define << arithmetic-shift)
(define (>> a b) (arithmetic-shift a (- b)))

;; Truncate a value to b bits
(define (cast value b)
  (modulo value (expt 2 b)))

;;;; PCG
(define default-multiplier-64 6364136223846793005)
(define default-increment-64  1442695040888963407)

;; Generic rotation function
(define (rotr n value rot)
  (cast
    (bitwise-ior
      (>> value rot)
      (<< value (bitwise-and (- rot) (sub1 n))))
    32))

;; Output function
(define (output-xsh-rr-64-32 state)
  (rotr 32
        (cast (>> (bitwise-xor (>> state 18) state) 27) 32)
        (>> state 59)))

;; Step function
(define (pcg-step-64 state)
  (cast (+
          (cast (* state default-multiplier-64) 64)
          default-increment-64)
        64))

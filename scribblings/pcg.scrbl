#lang scribble/manual
@require[@for-label[pcg
                    racket/base]]

@title{pcg}
@author{kefin}

@defmodule[pcg]

Permuted congruential generators (PCG) are a class of pseudo-random number generators (PRNGs) that provide high statistical quality whilst being fast, simple, and memory-efficient.

@(require racket/sandbox scribble/example)
@examples[#:label #f
  (require pcg)
  (define state (pcg 3912))
  (pcg-view state)]

@defproc[(pcg [state natural?]) natural?]{
  Advances the state by 1 iteration.
  Note that you should not use the return value directly in your program, instead, one must filter this value through @racket[pcg-view] in order to get the statistical properties associated with PCG, otherwise the randomness is in accordance with an linear congruential generator (LCG).

  This step uses the 64-bit LCG.
}

@defproc[(pcg-view [state natural?]) natural?]{
  Transform the state into its view.
  The view is PCG-XSG-RR.
}

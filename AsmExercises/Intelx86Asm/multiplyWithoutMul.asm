; http://www.binarymath.info/binary-multiplication.php

; .device atmega168

ldi r8,$4 ; one multiplicand, try other values!
ldi r9,$5 ; the other multiplicand, try other values!

; My code
; -----------------------
ldi r10, 0 ; set collector to zero just in case.
lid r11

; ##### Loop starting point #####
:loop

; ##### Obtain 'adding' bit #####
mov 

; ##### Do the 'multiplication' #####

; ##### Add result to collector #####
add rdx, r10

; ##### Loop till counter hits 3, cause there are 4 bits (and zero counts).
cmp r11, 3
jne loop

; -----------------------



; call sendr16tolaptop ; send calculation result to laptop

; again:
;     rjmp again ; finished, go into infinite loop.

; include "rs232link.in
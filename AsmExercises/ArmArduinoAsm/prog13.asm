; Tells compiler what cpu we are using?
.device atmega168

; Needed in order to be able to send stuff to the laptop over serial.
.include "rs232link.inc"

; variables for the locations of the data-direction/port registers.
.equ DDRB = 4
.equ PORTB = 5

; load on ON & OFF  
ldi r16, $20
ldi r17, $0

; set out mode on pin
out DDRB,r16 

; loop max
ldi r18, $FF

rjmp main

; Main loop section
; -----------------------------------------------------------
main:

    out     PORTB, r16      ; Turn ON
    call    sleep
    call    sleep
    call    sleep

    out     PORTB, r17      ; Turn OFF
    call    sleep
    call    sleep
    call    sleep

    call sendr16tolaptop    ; send r16 over serial everytime loop restarts.

    rjmp    main            ; restart main loop

; Sleep subroutine to make the ALU wait around for a bit.
; -----------------------------------------------------------
sleep:

    ldi r19, 0              ; set counter to zero.
    loop:
    inc r19                 ; increment counter

        ldi r20, 0          ; set counter2 to zero
        loop2:
        inc r20             ; increment counter2

        nop                 ; Just some nop's
        nop                 ; <---
        nop                 ; 

        cp r20, r18
        brne loop2
    
    cp r19, r18             ; check if the counter has reached the maxium value yet.
    BRNE loop               ; if not go back to loop label.
    
    ret                     ; return to previous place.

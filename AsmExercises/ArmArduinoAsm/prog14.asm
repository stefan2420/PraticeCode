; Sept 5 2019
;
; Matthijs & Stefan (group 89)
;
; 1.14 assignment
;
; The Aruino runs at 16Mhz = 16 million instructions per second
; 
; First few notes of Beethoven's 'Fur Elise':
; 
; E  - 329.63 hz - (16000000 - 329.63 * 2) / 2 = 7999670 (<= needed instructions between turning on and off).
; D# - 311.13 hz - (16000000 - 311.13 * 2) / 2 = 7999689
; E  - 329.63 hz
; D# - 311.13 hz
; B  - 246.94 hz - (16000000 - 246.94 * 2) / 2 = 7999753
; D  - 293.66 hz - (16000000 - 293.66 * 2) / 2 = 7999706
; C  - 261.63 hz - (16000000 - 261.63 * 2) / 2 = 7999738
; A  - 220.00 hz - (16000000 - 220.00 * 2) / 2 =  7999780
;
; NOTE: We're doubling the frequenty of the notes (effectivily moving the 
; notes up one octave) to make the mellody more clear and to create a 
; bigger difference between the clock cycles inbetween the turning on and
; off of the speaker pin.
; 

; Tells compiler what cpu we are using.
.device atmega168

; Needed in order to be able to send stuff to the laptop over serial.
.include "rs232link.inc"

; Variables for the locations of the data-direction/port registers.
.equ DDRB = 4
.equ PORTB = 5

; Variables for the low/high state of the pin.
ldi     r23, 0
ldi     r24, $10

; Variable for how long to play the note.
ldi     r25, $A

; Start executing main code
rjmp main

; Main section (only executed once).
; -----------------------------------------------------------
main:
    out     DDRB, r24       ; Set mode 'output' on pin 12. 

    ; NOTE: values for r16, r17, and r18 have been chosen by
    ; a custom Python script that helps calculate how many 
    ; loops to use to occelate at a certain frequenty.

    ldi     r16, 122        ; Play an E (329 hz)
    ldi     r17, 119
    ldi     r18, 183
    call    playNote 

    ldi     r16, 80         ; Play a D# (311 hz)
    ldi     r17, 173
    ldi     r18, 192
    call    playNote

    ldi     r16, 122        ; Play an E (329 hz)
    ldi     r17, 119
    ldi     r18, 183
    call    playNote 

    ldi     r16, 80         ; Play a D# (311 hz)
    ldi     r17, 173
    ldi     r18, 192
    call    playNote

    ldi     r16, 128        ; Play a B  (247 hz)
    ldi     r17, 252
    ldi     r18, 82
    call    playNote

    ldi     r16, 158        ; Play a D (294 hz)
    ldi     r17, 197
    ldi     r18, 85
    call    playNote

    ldi     r16, 127        ; Play a C (262 hz)
    ldi     r17, 174
    ldi     r18, 120
    call    playNote

    ldi     r16, 185        ; Play an A (220 hz)
    ldi     r17, 92
    ldi     r18, 156
    call    playNote

    call sendr16tolaptop    ; send r16 over serial when the 'song' ends (for debuging purposes)

    endOfCode:              ; Infinite loop cause we want the 
        jmp endOfCode       ; mellody to play once.

; The 'play note' subroutine.
; -----------------------------------------------------------
playNote:
    ldi     r20, 0          ; Three loops that will ensure
    loop0:                  ; that the note is played for a
    inc     r20             ; sufficient amount of time.
    ldi     r21, 0          ; 
    loop1:                  ;
    inc     r21             ;
    ldi     r22, 0          ; 
    loop2:                  ; 
    inc     r22             ; 

        out     PORTB, r24  ; Turn ON
        call    sleep
        out     PORTB, r23  ; Turn OFF
        call    sleep

    cp r22, r25             ; Bottom of the loop bodies, this 
    brne loop2              ; code will restart the loops if
    cp r21, r25             ; necessary.
    brne loop1              ;
    cp r20, r25             ;
    brne loop0              ;

    ret                     ; return from subroutine

; The 'sleep' subroutine. (performs a amount of instructions
; based on values of TEMP TEMP)
; -----------------------------------------------------------
sleep:
    ldi     r29, 0          ; Three loops that will ensure
    loop3:                  ; that the note is played for a
    inc     r29             ; sufficient amount of time.
    ldi     r30, 0          ; 
    loop4:                  ;
    inc     r30             ;
    ldi     r31, 0          ; 
    loop5:                  ; 
    inc     r31             ; 

        nop                 ; nop operation to waste instruction cycles.

    cp r31, r18             ; Bottom of the loop bodies, this 
    brne loop5              ; code will restart the loops if
    cp r30, r17             ; necessary.
    brne loop4              ;
    cp r29, r16             ;
    brne loop3              ;

    ret                     ; return from subroutine

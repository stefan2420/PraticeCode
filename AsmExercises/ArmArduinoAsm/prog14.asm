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
; E  - 329.63 hz - 
; D# - 311.13 hz - 
; E  - 329.63 hz
; D# - 311.13 hz
; B  - 246.94 hz - 
; D  - 293.66 hz - 
; C  - 261.63 hz - 
; A  - 220.00 hz - (16000000-2) / (220 * 2) = 36364
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
ldi     r24, $20

; Variable for how long to play the note.
ldi     r25, $7

; Start executing main code
rjmp main

; Main section (only executed once).
; -----------------------------------------------------------
main:
    out     DDRB, r24       ; Set mode 'output' on pin 12. 

    ; NOTE: values for r16, r17, and r18 have been chosen by
    ; a custom Python script that helps calculate how many 
    ; loops to use to occelate at a certain frequenty.

    ldi     r16, 7          ; Play an E4 (329 hz)
    ldi     r17, 216
    ldi     r18, 253
    call    playNote 

    ldi     r16, 7          ; Play a D# (311 hz)
    ldi     r17, 236
    ldi     r18, 210
    call    playNote

    ldi     r16, 7          ; Play an E4 (329 hz)
    ldi     r17, 216
    ldi     r18, 253
    call    playNote 

    ldi     r16, 7          ; Play a D# (311 hz)
    ldi     r17, 236
    ldi     r18, 210
    call    playNote

     ldi     r16, 7          ; Play an E4 (329 hz)
    ldi     r17, 216
    ldi     r18, 253
    call    playNote 

    ldi     r16, 9          ; Play a B  (247 hz)
    ldi     r17, 234
    ldi     r18, 236
    call    playNote

    ldi     r16, 7          ; Play a D (294 hz)
    ldi     r17, 251
    ldi     r18, 215
    call    playNote

    ldi     r16, 8          ; Play a C4 (262 hz)
    ldi     r17, 246
    ldi     r18, 246
    call    playNote

    ldi     r16, 11        ; Play an A (220 hz)
    ldi     r17, 221
    ldi     r18, 186
    call    playNote

     ldi     r16, 17        ; Play an C3 (130.81 hz)
    ldi     r17, 244
    ldi     r18, 245
    call    playNote

     ldi     r16, 13        ; Play an E3 (164.81 hz)
    ldi     r17, 250
    ldi     r18, 244    
    call    playNote


    ldi     r16, 11        ; Play an A (220 hz)
    ldi     r17, 221
    ldi     r18, 186
    call    playNote

     ldi     r16, 9          ; Play a B  (247 hz)
    ldi     r17, 234
    ldi     r18, 236
    call    playNote

    ldi     r16, 13        ; Play an E3 (164.81 hz)
    ldi     r17, 250
    ldi     r18, 244    
    call    playNote


    ldi     r16, 10       ; Play an G#3 (207.65 hz)
    ldi     r17, 253
    ldi     r18, 251    
    call    playNote

      ldi     r16, 9          ; Play a B  (247 hz)
    ldi     r17, 234
    ldi     r18, 236
    call    playNote

    ldi     r16, 8          ; Play a C4 (262 hz)
    ldi     r17, 246
    ldi     r18, 246
    call    playNote

     ldi     r16, 13        ; Play an E3 (164.81 hz)
    ldi     r17, 250
    ldi     r18, 244    
    call    playNote

     ldi     r16, 7          ; Play an E4 (329 hz)
    ldi     r17, 216
    ldi     r18, 253
    call    playNote 

    ldi     r16, 7          ; Play a D# (311 hz)
    ldi     r17, 236
    ldi     r18, 210
    call    playNote

    ldi     r16, 7          ; Play an E4 (329 hz)
    ldi     r17, 216
    ldi     r18, 253
    call    playNote 

    ldi     r16, 7          ; Play a D# (311 hz)
    ldi     r17, 236
    ldi     r18, 210
    call    playNote

     ldi     r16, 7          ; Play an E4 (329 hz)
    ldi     r17, 216
    ldi     r18, 253
    call    playNote 

    ldi     r16, 9          ; Play a B  (247 hz)
    ldi     r17, 234
    ldi     r18, 236
    call    playNote

    ldi     r16, 7          ; Play a D (294 hz)
    ldi     r17, 251
    ldi     r18, 215
    call    playNote

    ldi     r16, 8          ; Play a C4 (262 hz)
    ldi     r17, 246
    ldi     r18, 246
    call    playNote

    ldi     r16, 11        ; Play an A (220 hz)
    ldi     r17, 221
    ldi     r18, 186
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

    ldi         r29, 0      ; Two loops that will ensure
    loop3:                  ; that the note is played for a
        inc     r29         ; sufficient amount of time.
        ldi     r30, 0      
        loop4:              
            inc r30     

            nop             ; Waste time with a nop

            cp r30, r17         ; end of loop 4
            brne loop4          

        cp r29, r16             ; end of loop 3
        brne loop3              

    ; second loop to get the last few instructions.
    ldi     r31, 0   
    loop5:                 
        inc     r31          
        cp r31, r18             ; Bottom of the loop bodies, this 
        brne loop5              ; code will restart the loops if

    ret                     ; return from subroutine

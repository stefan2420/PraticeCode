; Sept 5 2019
;
; Matthijs & Stefan (group 89)
;
; 1.14 bonus assignment

.device atmega168

ldi     r17,$4      ; one multiplicand, try other values!
ldi     r18,$5      ; the other multiplicand, try other values!
ldi     r16, 0
ldi     r20, 3

; ############### MY CODE ###############
loop:
    
    sbrc    r18, 0    ; skip next if bit is set
    add     r16, r17    ; add thing
    lsl     r17         ; shift (= multiply by 2) r17
    lsr     r18

    ; END OF LOOP
    inc     r19         ; increment counter
    cp      r19, r20    ; stop if counter hits (cause 4 bit numbers)
    brne    loop        ; branch if not equal

; #######################################

call sendr16tolaptop ; send calculation result to laptop

again:
    rjmp again ; finished, go into infinite loop
    
.include "rs232link.inc"

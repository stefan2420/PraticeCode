; 02-09-2019
; 
; Let is be known that this was the first assembly code I've ever writen. 
; - Matthijs Reyers
;
; Assemble:
; nasm -f elf64 stuff.asm && ld stuff.o -o stuff
; 

; Define variables/constants in the data section
SECTION .DATA
	message db 'Hello world!', 0xa      ; (0xa is a null byte/string terminator)
	messageLength equ $-message

; Code goes in the text section
SECTION .TEXT
	GLOBAL _start 

_start:

	mov rbx, 0
	jmp _loop

_loop:
	; Print hello world message
	; -----------------------------------------------------
	mov rax, 1              ; system call (1 = write?)
	mov rdi, 1              ; file descriptor 1 = STDOUT
	mov rsi, message 
	mov rdx, messageLength
	syscall                 ; call system

	; If rbx == 5 we exit the loop by jumping to _exit.
	; -----------------------------------------------------
	inc rbx					; increment rbx register by 1.
	cmp rbx, 5				; compare rbx with '5'.
	je _exit
	jmp _loop

_exit:
	; Terminate program
    ; -----------------------------------------------------
	mov rax, 60             ; system call (60 = exit)
	mov rdi, 0              ; exit code 0 (no error)
	syscall                 ; call system

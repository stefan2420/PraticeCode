; 02-09-2019
; 
; Let is be known that this was the first assembly code I've ever writen. 
; - Matthijs Reyers
;

; Define variables/constants in the data section
SECTION .DATA
	message db 'Hello world!', 0xa      ; (0xa is a null byte/string terminator)
	messageLength equ $-message

; Code goes in the text section
SECTION .TEXT
	GLOBAL _start 

_start:
	mov rax, 1              ; system call (1 = write?)
	mov rdi, 1              ; file descriptor 1 = STDOUT
	mov rsi, message 
	mov rdx, messageLength
	syscall                 ; call system

	; Terminate program
	mov rax, 60             ; system call (1 = exit)
	mov rdi, 0              ; exit code 0 (no error)
	syscall                 ; call system


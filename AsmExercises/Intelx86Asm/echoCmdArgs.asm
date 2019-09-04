; 02-09-2019
; 
; The goal of this exercises was to retrieve and print all the commandline args. 
; As well as to learn a couple of new instructions :)
;
; Assemble:
; nasm -f elf64 echoCmdArgs.asm && ld echoCmdArgs.o -o echoCmdArgs
; 

SECTION .DATA
	; Other consts the progam uses.
	openMsg db 'Recieved these commands:',0xa

	; The print function needs these.
	printMsg dd ''
	printMsgLength = 0

SECTION .TEXT
	global _start

.printRSI:
	mov printMsg, rsi
	sub printMsgLength = $ - printMsg ;Calculate length of thing to be printed
	mov rdx, printMsgLength
	mov rax, 1              ; system call (1 = write?)
	mov rdi, 1              ; file descriptor 1 = STDOUT
	syscall                 ; call system
	ret

_exit:
	; Terminate program
	mov rax, 60             ; system call (60 = exit)
	mov rdi, 0              ; exit code 0 (no error)
	syscall                 ; call system
	
_start:
	
	mov rsi, openMsg 
	call .printRSI
	syscall                 ; call system
	jmp _exit

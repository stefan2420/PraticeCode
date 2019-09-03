; 02-09-2019
; 
; The goal of this exercises was to retrieve and print all the commandline args. 
; As well as to learn a couple of new instructions :)
;
; Assemble:
; nasm -f elf64 echoCmdArgs.asm && ld echoCmdArgs.o -o echoCmdArgs
; 

SECTION .DATA
	openMsg db 'Recieved these commands:',0xa
	openMsgLen equ $-openMsg

SECTION .TEXT
	global _start

_exit:
	; Terminate program
	mov rax, 60             ; system call (60 = exit)
	mov rdi, 0              ; exit code 0 (no error)
	syscall                 ; call system

_start:
	jmp _exit

section .data 
    msg1 db "write first number: ", 0
    msg1len equ $-msg1
    msg2 db "write second number: ", 0
    msg2len equ $-msg2
    msg3 db "answer: ", 0
    msg3len equ $-msg3
    errorIsNotNum db "Is not number!", 0
    errorIsNotNumLen equ $-errorIsNotNum

%define maxChar 255

section .bss
    inpbuf resb maxChar
    outbuf resb maxChar

section .text
    global _start

; includes with syscall depend
%include "syscall/x86.asm"
%include "stdio/x86.asm"
; includes with stdio depend
%include "errors/x86.asm"

; other
%include "strings/ascii/x86.asm"
%include "strings/utils/x86.asm"

%macro inputNum 2
    print %1, %2
    getchars inpbuf, maxChar

    countToChar inpbuf, 10
    asciiToInt inpbuf, eax
%endmacro

_start:
    inputNum msg1, msg1len
    cmp eax, -1
    je _isNotNumError
    push eax

    inputNum msg2, msg2len
    cmp eax, -1
    je _isNotNumError
    pop edx
    add eax, edx

    asciiFormatInt eax, outbuf
    print msg3, msg3len
    println outbuf, eax

    exit 0

_isNotNumError:
    panic errorIsNotNum, errorIsNotNumLen

%macro _syscall 1
    push eax
    mov eax, %1
    int 80h
    pop eax
%endmacro

%define _exit _syscall 0x1
%define _write _syscall 0x4
%define _read _syscall 0x3

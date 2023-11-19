; DEPENDS syscall

%macro pushio 0
    push ebx
    push ecx
    push edx
%endmacro

%macro popio 0
    pop edx
    pop ecx
    pop ebx
%endmacro

_print:
    pushio

    mov ebx, 0x1
    mov ecx, [esp + 20]
    mov edx, [esp + 16]
    _write

    popio
    ret

%macro print 2
    push %1
    push %2
    call _print
    add esp, 8
%endmacro

_putchar:
    push ebp
    push edx

    mov dl, [esp + 12]
    push edx
    print esp, 1

    add esp, 4
    pop edx
    pop ebp
    ret

%macro putchar 1
    push %1
    call _putchar
    add esp, 4
%endmacro

%macro println 2
    print %1, %2
    putchar 10
%endmacro

_getchars:
    pushio

    mov ebx, 0x1
    mov ecx, [esp + 20]
    mov edx, [esp + 16]
    _read

    popio
    ret

%macro getchars 2
    push %1
    push %2
    call _getchars
    add esp, 8
%endmacro
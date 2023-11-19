; _countToChar(char *str, char sym) -> len: int
_countToChar:
    push ecx
    push ebx
    push edx

    mov ebx, [esp + 20]
    mov dl, [esp + 16]

    xor ecx, ecx
    xor eax, eax
    _countToChar_loop:
        mov al, [ebx + ecx]
        cmp al, dl
        je _countToChar_loop_end
        inc ecx
        jmp _countToChar_loop
    _countToChar_loop_end:

    mov eax, ecx

    pop edx
    pop ebx
    pop ecx
    ret

%macro countToChar 2
    push %1
    push %2
    call _countToChar
    add esp, 8
%endmacro
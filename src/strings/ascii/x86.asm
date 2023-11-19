; _ascii_formatInt(int num, char* out) -> len: int
_ascii_formatInt:
    push edx
    push ebx
    push ebp
    mov ebp, esp

    mov ecx, 1
    push 0
    mov eax, [ebp + 20]
    _ascii_formatInt_f_loop:
        inc ecx
        xor edx, edx
        mov ebx, 10
        div ebx
        add dl, '0'
        push edx
        test eax, eax
        jnz _ascii_formatInt_f_loop

    mov eax, ecx
    mov ebx, [ebp + 16]
    _ascii_formatInt_w_loop:
        pop edx
        mov byte [ebx], dl
        dec ecx
        inc ebx
        test ecx, ecx
        jnz _ascii_formatInt_w_loop
    
    mov esp, ebp
    pop ebx
    pop ebp
    pop edx
    ret

%macro asciiFormatInt 2
    push %1
    push %2
    call _ascii_formatInt
    add esp, 8
%endmacro

;_ascii_toInt(char* str, int len) -> num: int
_ascii_toInt:
    push ecx
    push edx
    push ebx

    mov ebx, [esp + 20]
    mov ecx, [esp + 16]

    xor edx, edx
    xor eax, eax
    _ascii_toInt_loop:
        test ecx, ecx
        jz _ascii_toInt_loop_end
        mov edx, 10
        mul edx
        xor edx, edx
        mov dl, [ebx]
        sub dl, '0'
        cmp dl, 9
        ja _ascii_toInt_error
        add eax, edx
        inc ebx
        dec ecx
        jmp _ascii_toInt_loop
    _ascii_toInt_loop_end:

    jmp _ascii_toInt_end

    _ascii_toInt_error: 
        mov eax, -1 

    _ascii_toInt_end:
    pop ebx
    pop edx
    pop ecx     
    ret

%macro asciiToInt 2
    push %1
    push %2
    call _ascii_toInt
    add esp, 8
%endmacro
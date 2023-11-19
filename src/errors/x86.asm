; DEPENDS stdio

%macro exit 1
    mov ebx, %1
    _exit
%endmacro 

%macro panic 2
    println %1, %2
    exit 1
%endmacro
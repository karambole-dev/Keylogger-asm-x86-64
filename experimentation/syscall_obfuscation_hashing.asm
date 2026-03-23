section .data
    h dq 5381
    temp_digit dq 0

section .text
    global _start

_start:
    mov r9, 61
    mov r10, 5859909 ; 60 hashed

    jmp loop

loop:
    cmp r9, 0
    je exit

    dec r9

    mov [temp_digit], r9
    jmp hash_temp_digit

    jmp loop

hash_temp_digit:
    cmp byte [temp_digit], 0
    jbe test_temp_digit_hash

    mov rax, [temp_digit]
    xor rdx, rdx
    mov rbx, 10
    div rbx ; rax=quotient / rdx=rest

    mov [temp_digit], rax ; digit=quotient

    ; h = (h * 33) + rest
    mov rax, [h]
    mov rbx, 33
    mul rbx         ; rax = rax * rbx
    add rax, rdx
    mov [h], rax

    jmp hash_temp_digit

test_temp_digit_hash:
    cmp [h], r10
    je exit
    mov dword [h], 5381
    jmp loop

exit:
    mov rax, r9
    mov rdi, rdi
    syscall

; nasm -f elf64 syscall_obfuscation_hashing.asm ; ld syscall_obfuscation_hashing.o -o syscall_obfuscation_hashing ; ./syscall_obfuscation_hashing
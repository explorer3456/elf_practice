.text
b start

str:
    .asciz "Hello world"
    .equ nul, 0
    .equ test, 40

start:
    ldr r0, =str
    mov r1, #0
loop:
    ldrb r2, [r0], #1
    add r1, r1, #1
    cmp r2, #nul
    bne loop

    sub r1, r1, #1
stop:
    b stop

.text
entry: b start  @ skip over the data
arr: .byte 10, 20, 25  @ read only array of byte
eoa:

.align
start:
    ldr r0, =eoa
    ldr r1, =arr
    mov r3, #0
loop:
    ldrb r2, [r1], #1
    add r3, r2, r3
    cmp r1, r0
    bne loop
stop:
    b stop

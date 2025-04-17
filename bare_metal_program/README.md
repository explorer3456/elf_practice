# bare metal program using QEMU basic setting
**Environment**
>qemu enviornment
>qemu will use Connex machine with ARM 32 bit machine. Also, Connex us 16MB flash memory and start execution at address at 0
>below code is creating flash image. when executing qemu, there must be 16MB flash binary to be flashed.
>
```
dd if=/dev/zero of=flash.bin bs=4096 count=4096
qemu-system-arm -M connex -pflash flash.bin -serial /dev/null -nographic
```

**Assembler**
>compile process for assembly code
>during assembler, assembler create symbol table.
> symbol table create label and address correlation.
> and symbol section placement information. ( Text, Data, .. etc )
```
arm-none-eabi-as -o add.o add.s ( assembler )
arm-none-eabi-ld -Ttext=0x0 -o add.elf add.o ( linking )
arm-none-eabi-nm -n add.elf ( check symbol table )
```
>Symbol table syntax
```
T is global symbol. It can be viewed from other files
t is local symbol. It cannot be viewed from other files.
```

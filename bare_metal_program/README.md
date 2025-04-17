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

**Convert ELF file into binary**
> since we want to test with bare metal programming environment,
> we cannot load ELF file into QEMU directly. 
> we should load binary file( text section and data section only ) into QEMU.
> you can see the size of text and data section using readelf -t elffile to check text and data section size.
> In order to do that, we should use objcopy to convert ELF file into binary.
```
arm-none-eabi-objcopy -O binary input_elf output_binary

cf) readelf -t input_elf  // this show the size of elf section size.
```

> Also, in order to QEMU connex machine to run, you should put your image as 16MB flash image
> because connex machine only ditects 16MB image for flash image.
```
dd if=/dev/zero of=flash.bin bs=4096 count=4096
dd if=add.bin of=flash.bin bs=4096 conv=notruc
```

**QEMU basic command**
> basic QEMU command
```
info registers @ display current registers
xp /<count><format><size> @ display physical memory
xp /4i @ disaply as arm instruction set
xp /4x @ disaply as hexdeicmal format.
```

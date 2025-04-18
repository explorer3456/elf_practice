# Linker script Note
**How to check ELF header file**
> to check VMA and LMA of ELF sections, use this command
```
arm-none-eabi-objdump -h elffile
```

# C programming pre-requisites 
> so far we have done implementing vector, copying data section to RAM.
> so when do we can use C program on our project?
> in order to use C program, there are some pre-requisites.
>
**Stack initialization**
> First, C program is compiled with GCC compiler, which follows AAPCS rule.
> - Hence, stack should be available, which can be done initialize SP registers to end of RAM. 
> - Or define basic behviour of stack( Empry descending .. etc )
>
**BSS and rodata initialization**
> Second, C program compiled with new sections( .rodata, .bss ).
> - Hence, we should initialize BSS section with zero in VMA area.
> - Also, we need to define rodata section as well.
**Notice about Vector section**
> If is found that explicitly created vector section, which is placed in front of text section,
> objcopy doesnt copy the vector section when creating binary file
> hence, you should put vector section in text section.



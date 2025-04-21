# ELF file checking practice
**Quick usful commands box**
```
1. check ELF header
readelf -h elf

2. check ELF section
( sections are what linker links with )
readelf -S --wide elf

3. check ELF segments
(segemtns are used when actual program is executed )
readelf -l --wide elf

4. check LMA/VMA information of sections
objdump -h --wide elf

5. check symbol table information of ELF file
nm -n elf

6. Extract actual loadable program from ELF file
objcopy -O binary elf elf.bin
```

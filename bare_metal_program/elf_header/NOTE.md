# Important information from ELF header.
**ELF file contents**
> ELF header
> Section header
> Program header
> Object code
>
**ELF header**
> ELF header contains various information
> you can check ELF header using following command
```
readelf -h elf_file
```
> ELF magic number
> - 0x7F, 0x45, 0x4C, 0x46 at the beginning of ELF header is a value that indicates it is ELF file
>
> ELF Type
> - Type is one of these( DYN, EXEC, REL );
>   - DYN : DYN means the file is dynamic linkable file
>   - EXEC : When static build, the file can be executable. 
>   - REL : it is object file before linking stage.
>
> Program/Section header count/offset
> - Information about program and section header.
>
> Entry address
> - The entry address is address where program first instruction located. mostly, in general C program, it is address 
> of "start" address.
> 
**Check library dependency**
> you can check ELF file library dependancy (DYN elf file ) using following command
```
ldd elf_file
```
**Entry address**
> In ELF file, you can check Entry address.
> The entry address is where first insturction of program is located.
**General flow calling main**
> execve -> start -> C library -> Call your main function.


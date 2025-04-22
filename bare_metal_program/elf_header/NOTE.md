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
> You can check ELF header code in following file
```
elf.h
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

# Important information from Section header.
**Section header contents**
> Section's address in memory layout ( Address ) 
> Section's size in memory layout ( Size)
> Section offset in ELF file. Section is also components of ELF file, So section offset should be known. ( Offset )
**Section attributes**
> * Type
>   * PROGBIT / NOBITS 
> * FLAG
>   * Executable / Allocatble 
> Note that only sections that its flags contain Allocatable are actually used for program.
> Those sections which is allocatable will be located in memory.
> There are various sections (rela.dyn. rela.plt .. etc ) but those are not Allocatable
> Note that sections with flag 'A' is allocatable.
```
There are 16 section headers, starting at offset 0x20894:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        00000000 010000 000108 00  AX  0   0  4
  [ 2] .rodata           PROGBITS        00000108 010108 000004 00   A  0   0  4
  [ 3] .data             PROGBITS        a0000000 020000 000018 00  WA  0   0  4
  [ 4] .bss              NOBITS          a0000018 020018 000004 00  WA  0   0  4
  [ 5] .debug_info       PROGBITS        00000000 020018 0000c7 00      0   0  1
  [ 6] .debug_abbrev     PROGBITS        00000000 0200df 000082 00      0   0  1
  [ 7] .debug_aranges    PROGBITS        00000000 020168 000040 00      0   0  8
  [ 8] .debug_line       PROGBITS        00000000 0201a8 0000bd 00      0   0  1
  [ 9] .debug_str        PROGBITS        00000000 020265 0000df 01  MS  0   0  1
  [10] .comment          PROGBITS        00000000 020344 000033 01  MS  0   0  1
  [11] .ARM.attributes   ARM_ATTRIBUTES  00000000 020377 000028 00      0   0  1
  [12] .debug_frame      PROGBITS        00000000 0203a0 000028 00      0   0  4
  [13] .symtab           SYMTAB          00000000 0203c8 000370 10     14  46  4
  [14] .strtab           STRTAB          00000000 020738 0000c2 00      0   0  1
  [15] .shstrtab         STRTAB          00000000 0207fa 00009a 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  D (mbind), y (purecode), p (processor specific)

```
> This explains why customzied sections such as ".vectors" were not included in objcopy output.
> because vectors section was not defined as allocatable or executable in linker script.

**DWARF data**
> DWARF is an acronym for "Debugging With Arbitrary Record Formats"
> When a program is compiled with debug information (with the -g flag).
> this information will be written into special .debug_ ELF sections 
>
> if you compile code with -g option, the DWARF information is stored in 
> .debug_info, .debug_line
> information
```
  [ 5] .debug_info       PROGBITS        00000000 020018 0000c7 00      0   0  1
  [ 6] .debug_abbrev     PROGBITS        00000000 0200df 000082 00      0   0  1
  [ 7] .debug_aranges    PROGBITS        00000000 020168 000040 00      0   0  8
  [ 8] .debug_line       PROGBITS        00000000 0201a8 0000bd 00      0   0  1
  [ 9] .debug_str        PROGBITS        00000000 020265 0000df 01  MS  0   0  1
```

**Symbol table**
> there are two types of symbol table.
> .symtab
> .dynsymtab
> symtab is legacy symbol table that I already know. It is label <-> Address/Value table when 
> assembly code is compiled. Using symbol table, various files can be comipled together
>
> dynsymtab is symbol table that is used in dynamic linking. 
> Note that it is loaded on memory during program excution.  Because other library should be linked
> in order to program to be run.
```
jhkim@jhkim-Inspiron-14-5430:elf_header$ readelf -S --wide hello
There are 31 section headers, starting at offset 0x3698:

Section Headers:
  [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
  [ 1] .interp           PROGBITS        0000000000000318 000318 00001c 00   A  0   0  1
  [ 2] .note.gnu.property NOTE            0000000000000338 000338 000030 00   A  0   0  8
  [ 3] .note.gnu.build-id NOTE            0000000000000368 000368 000024 00   A  0   0  4
  [ 4] .note.ABI-tag     NOTE            000000000000038c 00038c 000020 00   A  0   0  4
  [ 5] .gnu.hash         GNU_HASH        00000000000003b0 0003b0 000024 00   A  6   0  8
  [ 6] .dynsym           DYNSYM          00000000000003d8 0003d8 0000a8 18   A  7   1  8
  [ 7] .dynstr           STRTAB          0000000000000480 000480 00008d 00   A  0   0  1
  [ 8] .gnu.version      VERSYM          000000000000050e 00050e 00000e 02   A  6   0  2
  [ 9] .gnu.version_r    VERNEED         0000000000000520 000520 000030 00   A  7   1  8
  [10] .rela.dyn         RELA            0000000000000550 000550 0000c0 18   A  6   0  8
  [11] .rela.plt         RELA            0000000000000610 000610 000018 18  AI  6  24  8
  [12] .init             PROGBITS        0000000000001000 001000 00001b 00  AX  0   0  4
  [13] .plt              PROGBITS        0000000000001020 001020 000020 10  AX  0   0 16
  [14] .plt.got          PROGBITS        0000000000001040 001040 000010 10  AX  0   0 16
  [15] .plt.sec          PROGBITS        0000000000001050 001050 000010 10  AX  0   0 16
  [16] .text             PROGBITS        0000000000001060 001060 000107 00  AX  0   0 16
  [17] .fini             PROGBITS        0000000000001168 001168 00000d 00  AX  0   0  4
  [18] .rodata           PROGBITS        0000000000002000 002000 00000a 00   A  0   0  4
  [19] .eh_frame_hdr     PROGBITS        000000000000200c 00200c 000034 00   A  0   0  4
  [20] .eh_frame         PROGBITS        0000000000002040 002040 0000ac 00   A  0   0  8
  [21] .init_array       INIT_ARRAY      0000000000003db8 002db8 000008 08  WA  0   0  8
  [22] .fini_array       FINI_ARRAY      0000000000003dc0 002dc0 000008 08  WA  0   0  8
  [23] .dynamic          DYNAMIC         0000000000003dc8 002dc8 0001f0 10  WA  7   0  8
  [24] .got              PROGBITS        0000000000003fb8 002fb8 000048 08  WA  0   0  8
  [25] .data             PROGBITS        0000000000004000 003000 000010 00  WA  0   0  8
  [26] .bss              NOBITS          0000000000004010 003010 000008 00  WA  0   0  1
  [27] .comment          PROGBITS        0000000000000000 003010 00002b 01  MS  0   0  1
  [28] .symtab           SYMTAB          0000000000000000 003040 000360 18     29  18  8
  [29] .strtab           STRTAB          0000000000000000 0033a0 0001db 00      0   0  1
  [30] .shstrtab         STRTAB          0000000000000000 00357b 00011a 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  D (mbind), l (large), p (processor specific)

```

**Is section header required during execution?**
> Note that section header presents for linker.
> Linker should know where the sections are and perform sections merging or symbol resolution.
> So, section header itself is not necessary for program execution.
> What matters during program execution is program header.

# important information from program header
**Program header contents**
> Those segment offset, information ( VMA, LMA ) and Flag( Read/Write/Executable ) are located at program header.
> Not that program header is necessary for running program, wheras section header is needed for linking object files.
**What is segment**
> Code segment
> some sections are combined into some segment
> ex) text and rodata sections are combined into segment 0, and this segment is loadable
> ( Loadable segment can be loaded into memory and can be executed ).
>
> Data segment
> data section and bss section are combined into other segment
> 
> Some section may not be included in creating segment.
> Also, seom section such as interpreter can be included in more than one segments.
>
> Loadable segment will be exectued by OS.
> Linux kernel will fetch ELF header and Program header from ELF file.
> then handle program execution.
>
> How to check segment information?
```
readelf -l elf_file
```
> output example
> Note that 
```
jhkim@jhkim-Inspiron-14-5430:linker_script$ readelf -l c_prog.elf

Elf file type is EXEC (Executable file)
Entry point 0x9c
There are 2 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  LOAD           0x010000 0x00000000 0x00000000 0x0010c 0x0010c R E 0x10000
  LOAD           0x020000 0xa0000000 0x0000010c 0x00018 0x0001c RW  0x10000

 Section to Segment mapping:
  Segment Sections...
   00     .text .rodata
   01     .data .bss

```
**BSS section difference on file and memory**
> You can notice that data segment size is different in Filesize(LMA) and Memsize(VMA).
> Because LMA doesn't count BSS section size because it is zero.
> VMA does count BSS section, which is initialized to zero by startup code etc.
>
> Note that filesize and Memsize difference
```
jhkim@jhkim-Inspiron-14-5430:elf_header$ cat ../linker_script/dseg_test_large_bss.segment

Elf file type is EXEC (Executable file)
Entry point 0x9c
There are 2 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  LOAD           0x010000 0x00000000 0x00000000 0x0010c 0x0010c R E 0x10000
  LOAD           0x020000 0xa0000000 0x0000010c 0x00018 0x0201c RW  0x10000

```
**Useful debug tools to analyze ELF file**
> you can use dumpelf elf_file to check offset of certain components( Section/Program header).
> From ELF file
> Then, use hexedit like tools to edit or modify header
> You can see that section header #15 is located at offset of 0x22B44 from c_prog.elf
```
dumpelf c_prog.elf

/* Section Header #15 '.shstrtab' 0x22B44 */
{
	.sh_name      = 17         ,
	.sh_type      = 3          , /* [SHT_STRTAB] */
	.sh_flags     = 0          ,
	.sh_addr      = 0x0        ,
	.sh_offset    = 141392     , /* (bytes) */
	.sh_size      = 154        , /* (bytes) */
	.sh_link      = 0          ,
	.sh_info      = 0          ,
	.sh_addralign = 1          ,
	.sh_entsize   = 0
},

```


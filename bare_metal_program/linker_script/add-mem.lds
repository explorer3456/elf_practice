SECTIONS {
        . = 0x00000000;
        .text : {
                *(.text);
        }
        etext = .;

        . = 0xA0000000;
        .data : AT (etext) {
                *(.data);
        } 
}

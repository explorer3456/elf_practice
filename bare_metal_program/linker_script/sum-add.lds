SECTIONS {

        . = 0x0;
        .vector : {
                *(.vectors);
        }

        .text : {
                *(.text);
        }
        flash_sdata = .;

        . = 0xA0000000;
        ram_sdata = .;
        .data : AT (flash_sdata) {
                *(.data);
        }
        ram_edata = .;

        data_size = ram_edata - ram_sdata;
}

SECTIONS {
        . = 0x00000000;
        .text :{
                /*
                sum-data.o (.text);
                */

                *(.text);
        }
        . = 0x00000400;
        .data : {
                /*
                sum-data.o (.data);
                */
                *(.data);
        }
}

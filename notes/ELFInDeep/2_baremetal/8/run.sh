dd if=/dev/zero of=flash.bin bs=4096 count=4096
dd if=add.bin of=flash.bin bs=4096 conv=notrunc
qemu-system-arm -M connex -pflash flash.bin -serial /dev/null -nographic

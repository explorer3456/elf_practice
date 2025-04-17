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

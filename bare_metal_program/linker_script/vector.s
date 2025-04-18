.section    ".vectors"
reset:  b   _reset
undef:  b   _undef
swi:    b   _swi
pabt:   b   _pabt
dabt:   b   _dabt
        nop
irq:    b   _irq
fiq:    b   _fiq

_reset:
        b  .
_undef:
        b  .
_swi:
        b  .
_pabt:
        b  .
_dabt:
        b  .
_irq:
        b  .
_fiq:
        b  .

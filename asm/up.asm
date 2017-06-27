; hl = screen address, b = x, c = y

include 'alive_test.asm'

dec c
bit 7, c
jr z, nowrap

ld c, 47
ld a, l
add 224
ld l, a
inc h
inc h
jr test

nowrap:
bit 0, c
jr z, test

ld a, l
sub 32
ld l, a
jr nc, test
dec h

test:
ince_if_alive

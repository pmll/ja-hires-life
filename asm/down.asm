; hl = screen address, b = x, c = y

include 'alive_test.asm'

inc c
ld a, c
cp 48
jr nz, nowrap

ld c, 0
ld a, l
sub 224
ld l, a
dec h
dec h
jr test

nowrap:
bit 0, c
jr nz, test

ld a, l
add a, 32
ld l, a
jr nc, test
inc h

test:
ince_if_alive

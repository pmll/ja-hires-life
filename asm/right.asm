; hl = screen address, b = x, c = y

include 'alive_test.asm'

inc b
bit 6, b
jr z, nowrap

ld b,0
ld a, l
sub 31
ld l, a
jr test

nowrap:
bit 0, b
jr nz, test

inc hl

test:
ince_if_alive

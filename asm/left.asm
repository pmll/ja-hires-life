; hl = screen address, b = x, c = y

include 'alive_test.asm'

dec b
bit 7, b
jr z, nowrap

ld b, 63
ld a, l
add a, 31   ; there will be no carry for a screen line
ld l, a
jr test

nowrap:
bit 0, b
jr z, test
dec hl

test:
ince_if_alive

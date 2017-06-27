; inline "is alive?" routine

is_alive: macro
; cell at x, y co-ordinates b,c is alive? hl contains screen address
; uses a

; transform byte at screen address to a bitmap of points plotted there
; where 1 = top left, 0 = top right, 3 = bottom left, 2 = bottom right
ld a, (hl)
bit 7, a
jr z, 3 + $     ; not_inverse  - labels don't seem to work inside macros

cpl

not_inverse:

; if y coord is even, take bits 0 and 1, otherwise bits 2 and 3
bit 0, c
jr z, 4 + $     ; use_bits01

; bits 2 and 3
rra
rra

use_bits01:

; if x coord is even, take bit 1, otherwise bit 0
bit 0, b
jr nz, 3 + $    ; use_bit0

; bit 1
rra

use_bit0:
rra   ; is alive result -> c, set is alive, unset is dead
endm


ince_if_alive: macro 
is_alive 
ret nc
inc e
ret
endm

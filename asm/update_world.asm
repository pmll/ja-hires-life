; update life frame

include 'alive_test.asm'

; substitute these with correct address
neighbour_count: equ 0x01ED
world_bitmap2: equ 0x03ED
right: equ 0x04ED
down: equ 0x05ED

world_bitmap1: equ 0x2701
screen: equ 9216

;
; generate new world from screen to bitmap
;
ld hl, world_bitmap1
push hl
ld hl, screen

ld c, 0
ld b, 0

world_loop:

; use left nibble if (b div 2) mod 2 = 0
ld d, 1
bit 1, b
jr nz, right_nibble

ld d, 16

right_nibble:
; within nibble, use right half if c mod 2 = 0
bit 0, c
jr z, right_nibble_half    ; nz -> z

sla d
sla d

right_nibble_half:

; within nibble half, use upper bit if b mod 2 = 0
bit 0, b
jr nz, lower

sla d

lower:

call neighbour_count    ; neighbour count -> e
is_alive                ; alive? -> c

ex (sp), hl             ; bitmap address -> hl

jr nc, dead_cell

; live cell
ld a, e
cp 2
jr c, cell_dies
cp 4
jr nc, cell_dies
jr cell_lives

dead_cell:
; we have a dead cell
ld a, e
cp 3
jr nz, cell_dies

cell_lives:
ld a, (hl)
or d
jr set_cell

cell_dies:
ld a, d
cpl
and (hl)

set_cell:
ld (hl), a

ex (sp), hl     ; screen address -> hl

call right
ld a, b
and 11b
jr nz, same_bm_addr

pop de      ; bitmap addr -> de
inc de

; check for transition to alt bitmap store
bit 0, c
jr z, no_bm_trans
ld a, e
cp 0xF1
jr nz, no_bm_trans
ld a, d
cp 0x27
jr nz, no_bm_trans
ld de, world_bitmap2
no_bm_trans:

push de

same_bm_addr:
ld a, b
cp 0
jr nz, world_loop

call down
bit 0, c
jr z, new_bm_row

pop de      ; bitmap addr -> de
ld a, e
sub 16
ld e, a
jr nc, nocarry
dec d
nocarry:
push de

new_bm_row:
ld a, c
cp 0
jr nz, world_loop

pop hl

;
; copy bitmap to screen
;

ld de, world_bitmap1
ld hl, screen
ld c, 2

outer_loop:

ld b, 192

inner_loop:

; left nibble to screen
ld a, (de) 
srl a
srl a
srl a
srl a
bit 3, a
jr z, not_inverse

xor 1111b
or 128

not_inverse:
or 16
ld (hl), a

inc hl

; right nibble to screen
ld a, (de)
and 1111b
bit 3, a
jr z, not_inverse2

xor 1111b
or 128

not_inverse2:
or 16
ld (hl), a

inc hl
inc de

; check for transition to alt bitmap store
ld a, e
cp 0xF1
jr nz, no_bm_trans2
ld a, d
cp 0x27
jr nz, no_bm_trans2
ld de, world_bitmap2
no_bm_trans2:

djnz inner_loop

dec c
jr nz, outer_loop

jp (iy)


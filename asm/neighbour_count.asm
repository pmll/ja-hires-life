; neighbour count -> e
; enter with screen address in hl and x,y coords in b,c

; substitute these with correct addresses
left: equ 0x02ED
right: equ 0x03ED
up: equ 0x04ED
down: equ 0x05ED

push bc
push hl

; reset e which will contain neighbour count
ld e, 0
call right
call down
call left
call left
call up
call up
call right
call right

pop hl
pop bc
ret


; text scroller, 69 bytes
; John Metcalf

org 32768

scrolly:
    ld hl,message

nextchar:
    ld a,(hl)
    or a
    jr z,scrolly
    push hl

; get bitmap for glyph

    ld l,a
    ld h,0
    add hl,hl
    add hl,hl
    add hl,hl
    ld de,(23606)
    add hl,de

; copy glyph to workspace

    ld de,tempchar
    ld bc,8
    ld a,c
    ldir

scroll:
    halt
    ld hl,050FFh
    ld de,tempchar
    ld c,8
nextrow:
    ex de,hl
    rl (hl)
    ex de,hl
    ld b,32
    push hl
scrollrow:
    rl (hl)
    dec l
    djnz scrollrow
    pop hl
    inc h
    inc de
    dec c
    jr nz,nextrow
    dec a
    jr nz,scroll

    pop hl
    inc hl

; test for keypress

    ld bc,07FFEh
    in a,(c)
    rrca
    jr c,nextchar
    ret

message:
    db "Z80 Assembly for the ZX Spectrum...    ",0

tempchar:
db      0,0,0,0,0,0,0,0

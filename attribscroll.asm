; attribute scroller, 79 bytes
; John Metcalf

    org 32768

attrscr:
    ld hl,message

nextchar:
    ld a,(hl)
    or a
    jr z,attrscr
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
    push af
    halt

; shift everything left by 1 attribute

    ld de,05900h
    ld hl,05901h
    ld c,0FFh
    ldir

; copy a column of bits from the glyph to the attributes

    ld de,tempchar
    ld hl,0591Fh
    ld a,8
    ld c,32
nextrow:
    ld (hl),b
    ex de,hl
    rl (hl)
    ex de,hl
    jr nc,zerobit
    ld (hl),54
zerobit:
    add hl,bc
    inc de
    dec a
    jr nz,nextrow
    pop af
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
    db 0,0,0,0,0,0,0,0

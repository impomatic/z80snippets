; 16 bit signed multiply by John Metcalf
; 32 bytes, average approx ~1090 cycles

; call with bc, de = 16 bit signed numbers to multiply
; returns   de:hl = 32 bit signed product
; corrupts  a

; de:hl = bc*de

multiply:
  xor a
  ld h,a
  ld l,a
  bit 7,d
  jr z,muldpos
  sbc hl,bc
muldpos:
  ld a,b
  sra a
  and 0C0h
  add a,d
  ld d,a

  ld a,16
mulloop:
  add hl,hl
  rl e
  rl d
  jr nc,mul0bit
  add hl,bc
  jr nc,mul0bit
  inc de
mul0bit:
  dec a
  jr nz,mulloop

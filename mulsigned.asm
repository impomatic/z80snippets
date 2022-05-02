; 16 bit signed multiply by John Metcalf
;31 bytes
;min: 928cc
;max: 1257cc
;avg: 1088.5cc

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

  or b
  jp p,mulbpos
  sbc hl,de
mulbpos:

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

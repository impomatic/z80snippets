; 16 bit signed multiply by John Metcalf
; 36 bytes, average approx ~1150 cycles

; call with bc, de = signed numbers to multiply
; returns   hl:de = signed product
; corrupts  a, bc

; hl:de = bc*de

multiply:
  ld hl,0
  push hl
  bit 7,b
  jr z,mulbpos
  add hl,de
mulbpos:
  bit 7,d
  jr z,muldpos
  add hl,bc
muldpos:
  ex (sp),hl
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

  ex de,hl
  pop bc
  or a
  sbc hl,bc

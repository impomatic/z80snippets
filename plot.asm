; self-modifying plot by John Metcalf
; plot d = x-axis, e = y-axis, self-modifying code

  ld a,d
  cpl
  add a,a
  add a,a
  add a,a
  or %11000110
  ld (PLOTBIT+1),a
  ld a,e
  rra
  scf
  rra
  or a
  rra
  ld l,a
  xor e
  and %11111000
  xor e
  ld h,a
  ld a,l
  xor d
  and %11111000
  xor l
  rrca
  rrca
  rrca
  ld l,a
PLOTBIT:
  set 0,(hl)   ; modified
  ret

; abs(hl) by John Metcalf
; 10 bytes, 20/39 cycles

; call with hl = signed number
; returns   hl = abs(hl)
; corrupts   a

  bit 7,h
  jr z,absdone
  sub a
  sub l
  ld l,a
  sbc a,a
  sub h
  ld h,a
absdone:

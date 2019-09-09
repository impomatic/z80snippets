; fast 16-bit isqrt by Zeda Thomas
; 87 bytes, 333-370 clock cycles (average 351.5)

; call with hl = number to square root
; returns    a = square root
; corrupts hl, de

  ld de,05040h
  ld a,h
  sub e
  jr nc,sq7
  add a,e
  ld d,16
sq7:


  cp d
  jr c,sq6
  sub d
  set 5,d
sq6:
  res 4,d
  srl d

  set 2,d
  cp d
  jr c,sq5
  sub d
  set 3,d
sq5:
  srl d


  inc a
  sub d
  jr nc,sq4
  dec d
  add a,d
  dec d   ;this resets the low bit of D, so `srl d` resets carry.
sq4:

  srl d
  ld h,a


  sbc hl,de
  ld a,e
  jr nc,sq3
  add hl,de
sq3:
  ccf
  rra
  srl d
  rra
  ld e,a

  sbc hl,de
  jr c,sq2
  or 20h
  db 254   ;start of `cp *` which is 7cc to skip the next byte.
sq2:
  add hl,de
  xor 18h
  srl d
  rra
  ld e,a


  sbc hl,de
  jr c,sq1
  or 8
  db 254   ;start of `cp *` which is 7cc to skip the next byte.
sq1:
  add hl,de
  xor 6
  srl d
  rra
  ld e,a
  sbc hl,de

 sbc a,255
 srl d
 rra

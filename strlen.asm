; strlen(hl) by John Metcalf
; 11 bytes, 52+21*strlen cycles

; call with hl = address of zero-terminated string
; returns   hl = length of string
; corrupts   a

  xor a
  ld b,a
  ld c,a
  cpir

; hl = ~bc

  ld a,c
  cpl
  ld l,a
  ld a,b
  cpl
  ld h,a

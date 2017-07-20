; 16 bit isqrt by John Metcalf
; 29 bytes, 652-722 cycles (average 687)

; call with hl = number to square root
; returns    a = square root
; corrupts  hl, de, b

; note: I've seem similar code credited to Milos Bazelides,
; Ricardo Bittencourt and uncredited. This implementation works
; with the bitwise complement of the root to save a few cycles.

  ld de,0FFC0h ; 10
  ld a,l       ; 4
  ld l,h       ; 4
  ld h,0       ; 7
  ld b,7       ; 7
sqrloop:
  add hl,de    ; 11
  jr c,sqrbit  ; 12 / 7
  sbc hl,de    ; 15
sqrbit:
  ccf          ; 4
  rl d         ; 8
  add a,a      ; 4
  adc hl,hl    ; 15
  add a,a      ; 4
  adc hl,hl    ; 15
  djnz sqrloop ; 13 / 8

  ld a,d       ; 4
  cpl          ; 4
  add hl,de    ; 11
  rla          ; 4

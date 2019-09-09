; fast 16 bit isqrt by John Metcalf
; 89 bytes, 335-375 cycles (average 355.5)
; v2 - saved 3 cycles with a tweak suggested by Russ McNulty

; call with hl = number to square root
; returns    a = square root
; corrupts hl, de

; ----------

  ld a,h        ; 4
  ld de,0B0C0h  ; 10
  add a,e       ; 4
  jr c,sq7      ; 12 / 7
  ld a,h        ; 4
  ld d,0F0h     ; 7
sq7:

; ----------

  add a,d       ; 4
  jr nc,sq6     ; 12 / 7
  res 5,d       ; 8
  db 254        ; 7
sq6:
  sub d         ; 4
  sra d         ; 8

; ----------

  set 2,d       ; 8
  add a,d       ; 4
  jr nc,sq5     ; 12 / 7
  res 3,d       ; 8
  db 254        ; 7
sq5:
  sub d         ; 4
  sra d         ; 8

; ----------

  inc d         ; 4
  add a,d       ; 4
  jr nc,sq4     ; 12 / 7
  res 1,d       ; 8
  db 254        ; 7
sq4:
  sub d         ; 4
  sra d         ; 8
  ld h,a        ; 4

; ----------

  xor a         ; 4
  add hl,de     ; 11
  jr c,sq3      ; 12 / 7
  sbc hl,de     ; 15
sq3:
  rra           ; 4
  add a,e       ; 4
  sra d         ; 8
  rra           ; 4

; ----------

  or 010h       ; 7
  ld e,a        ; 4
  add hl,de     ; 11
  jr nc,sq2     ; 12 / 7
  and 0DFh      ; 7
  db 218        ; 10
sq2:
  sbc hl,de     ; 15
  sra d         ; 8
  rra           ; 4

; ----------

  or 04h        ; 7
  ld e,a        ; 4
  add hl,de     ; 11
  jr nc,sq1     ; 12 / 7
  and 0F7h      ; 7
  db 218        ; 10
sq1:
  sbc hl,de     ; 15
  sra d         ; 8
  rra           ; 4

; ----------

  ld e,a        ; 4
  inc e         ; 4
  add hl,de     ; 11
  sbc a,0       ; 7
  sra d         ; 8
  rra           ; 4
  cpl           ; 4

; ----------

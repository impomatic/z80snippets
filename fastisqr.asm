; fast 16 bit isqrt by John Metcalf
; 92 bytes
; 348-381 cycles (average 365)

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

  add hl,de     ; 11
  jr nc,sq3     ; 12 / 7
  ld e,040h     ; 7
  db 210        ; 10
sq3:
  sbc hl,de     ; 15
  sra d         ; 8
  rr e          ; 8

; ----------

  set 4,e       ; 8
  add hl,de     ; 11
  jr nc,sq2     ; 12 / 7
  res 5,e       ; 8
  db 210        ; 10
sq2:
  sbc hl,de     ; 15
  sra d         ; 8
  rr e          ; 8

; ----------

  set 2,e       ; 8
  add hl,de     ; 11
  jr nc,sq1     ; 12 / 7
  res 3,e       ; 8
  db 210        ; 10
sq1:
  sbc hl,de     ; 15
  sra d         ; 8
  rr e          ; 8

; ----------

  inc e         ; 4
  ld a,e        ; 4
  add hl,de     ; 11
  jr nc,sq0     ; 12 / 7
  and 0FDh      ; 7
sq0:
  sra d         ; 8
  rra           ; 4
  cpl           ; 4

; ----------

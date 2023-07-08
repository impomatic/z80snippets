; draw lines using self-modifying Bresenham's algorithm
; by John Metcalf and Arcadiy Gobuzov
; de = end1 (d = x-axis, e = y-axis)
; hl = end2 (h = x-axis, l = y-axis)

DRAW:
  ld a,d
  sub h
  ex de,hl     ; swap ends so de (temporarily) has the lowest x-axis coord
  jr c,DRAW
  push af

  ld bc,$1C16  ; b = inc e / c-1 = dec d

SWAP:
  dec c        ; c-1 -> dec d, c-2 -> inc d 
  ld a,e
  sub l
  ex de,hl     ; swap ends so de has the lowest y-axis coord
  jr c,SWAP

  pop hl       ; h = x-length of line (delta_x)
  ld l,a       ; l = y-length of line (delta_y)

  cp h
  jr nc,SHALLOW
  ld b,c
  ld c,$1C     ; c = $1C inc e
  ld l,h       ; swap deltas
  ld h,a
  ld a,l
  or a
SHALLOW:

  ld (ADVANCE),bc
  rra          ; a = max(delta_x,delta_y) / 2
  ld b,l
  inc b        ; b = max(delta_x,delta_y) + 1

LOOP:
  ld c,a

; -----------------------------------------------

; plot d = x-axis, e = y-axis, self-modifying code

  push hl
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
  pop hl

; -----------------------------------------------

  ld a,c
  sub h
  jr nc,ADVANCE+1
  add a,l
ADVANCE:
  inc d        ; modified
  inc e        ; modified
  djnz LOOP
  ret

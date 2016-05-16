; FAST FILLED CIRCLES - Sinclair Spectrum, displays filled circles
; on entry, d = x-centre, e = y-centre, c = radius
; on exit, a, bc, de, hl corrupt
; Length 106 - John Metcalf, Sun 28 Feb 1999

; Draws filled circles very quickly. An assortment of tricks have
; been used to achieve this. This new version is over 10% faster
; than the previous after further optimizing the inner loops.


  org 40000
  ld de,96*257
  ld c,64

  ld b,0
  ld a,e       ; subtract radius from y-centre
  inc c
  sub c
  ld e,a

  ld h,b       ; hl = 0
  ld l,b

NEXT:
  push bc
  push hl

  ld bc,65280  ; triangular root :-)
CALC:
  dec c
  add hl,bc
  jr c,CALC

  ld a,e       ; calc pos in screen memory
  cp 192
  jr nc,OFFSCR
  rrca
  scf
  rra
  rrca
  ld l,a
  xor e
  and 88
  xor e
  and 95
  ld h,a

  ld a,d
  add a,c
  rl c
  ld b,a
  xor l
  and 7
  xor b
  rrca
  rrca
  rrca
  ld l,a

  xor a        ; calc first part byte (if any)
  sub b
  and 7
  jr z,NOHALF
  ld b,a
  xor a
  dec c
VAIN:
  inc c
  jr z,ROTB
  scf
  rla
  djnz VAIN
  inc c
  or (hl)
  ld (hl),a
  inc hl
NOHALF:
  xor a        ; calc full bytes (if any)
  sub c
  rrca
  rrca
  rrca
  and 31
  jr z,NOFULL
  ld b,a
  ld a,255
DRAW:
  ld (hl),a
  inc hl
  djnz DRAW
NOFULL:
  ld a,c       ; calc final part byte (if any)
  and 7
  jr z,OFFSCR
  ld b,a
  ld a,255
ROTB:
  add a,a
  djnz ROTB
DISPLAY:
  or (hl)
  ld (hl),a

OFFSCR:
  pop hl
  pop bc
  inc e        ; next line
  dec c
  jr nz,SKIP
  dec bc
SKIP:
  adc hl,bc
  jr nz,NEXT
  ret

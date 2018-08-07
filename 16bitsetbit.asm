; set bit a (0..15) of the bc register (bc |= 2^a)
; self-modifying code

  rlca
  rlca
  cp %00100000
  rla
  or %11000000
  ld (SETBIT+1),a
SETBIT:
  set 0,b ; this instruction gets modified

; REVERSEBITS - reverse the bits in a
; on entry: a = bit pattern to reverse
; on exit: a = reversed bits, l = corrupt, other registers preserved
; author: John Metcalf
; length: 17 bytes
; time: 66 cycles
; http://www.retroprogramming.com/2014/01/fast-z80-bit-reversal.html

  ld l,a    ; a = 76543210
  rlca
  rlca      ; a = 54321076
  xor l
  and 0xAA
  xor l     ; a = 56341270
  ld l,a
  rlca
  rlca
  rlca      ; a = 41270563
  rrc l     ; l = 05634127
  xor l
  and 0x66
  xor l     ; a = 01234567
  

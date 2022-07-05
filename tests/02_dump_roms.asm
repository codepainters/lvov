; 
; Dump ROM area via PIO. 
;

.org    0xC000

    JP      l1
l1: NOP

    ; configure 8255 - all outputs, mode 0, set PB2 = 0
    LD      A, 0x80
    OUT     (0xC3), A
    LD      A, 0x00
    OUT     (0xC1), A
    

    LD      HL, 0xC000      ; ROM starts at 0xC000

loop:
    LD      A, (HL)
    OUT     (0xC0), A

    ; pulse strobe (PB2)
    LD      A, 0x04
    OUT     (0xC1), A
    LD      A, 0x00
    OUT     (0xC1), A
    NOP
    NOP   
 
    INC     HL             ; INC HL (INX H) doesn't update flags!

    LD      A, H
    CP      0x00
    JP      NZ, loop
    LD      A, L
    CP      0x00
    JP      NZ, loop

    ; endless loop when done
done:
    JP      done

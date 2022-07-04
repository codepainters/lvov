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
    

    ; feel first half of RAM with pattern
    LD      HL, 0x0000
    LD      BC, 0x8000
    LD      DE, 0xFFFF
feel1:
    ; TODO
    INC     HL
    DEC     BC
    JP      NZ, feel1

    ; switch memory mapping, so second half of RAM is 
    ; mapped from address 0
    ; TODO

    ; feel second half of RAM 
    ; TODO

    ; switch memory mapping back, so first half of RAM
    ; is available
    ; TODO

    ; dump first half of RAM
    LD      HL, 0x0000 
    LD      BC, 0x8000
dump_l1:
    LD      A, (HL)
    OUT     (0xC0), A

    ; pulse strobe (PB2)
    LD      A, 0x04
    OUT     (0xC1), A
    LD      A, 0x00
    OUT     (0xC1), A
    NOP
    NOP   
 
    INC     HL
    DEC     BC                    
    JP      NZ, dump_l1

    ; switch mapping
    ; TODO

    ; dump first half of RAM
    LD      HL, 0x0000 
    LD      BC, 0x8000
dump_l2:
    LD      A, (HL)
    OUT     (0xC0), A

    ; pulse strobe (PB2)
    LD      A, 0x04
    OUT     (0xC1), A
    LD      A, 0x00
    OUT     (0xC1), A
    NOP
    NOP   
 
    INC     HL
    DEC     BC                    
    JP      NZ, dump_l2

    ; endless loop when done
done:
    JP      done

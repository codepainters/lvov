;
; Test RAM memory.
;
; The code writes whole RAM with pseudorandom pattern,
; then dump it back via PIO.
;
; Note: when PC1 is set to 1, RAM is mapped in the CPU address space 
;   "as is", which means that address space chunk 0xC000..0xFFFF 
;   (last 16kB) is shadowed by ROM. 
;   If PC1 is set to 0, A15 is always set to 1, thus RAM area 
;   0x8000..0xFFFF is available starting at 0x0000.
;

.org    0xC000

    JP      l1
l1: NOP

    ; configure 8255 - all outputs, mode 0, set PB2 = 0
    LD      A, 0x80
    OUT     (0xC3), A
    LD      A, 0x00
    OUT     (0xC1), A

    ; disable RAM mapping
    LD      A, 0x02
    OUT     (0xC2), A

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
    LD      A, 0x00
    OUT     (0xC2), A

    ; feel second half of RAM
    ; TODO

    ; switch memory mapping back, so first half of RAM
    ; is available
    LD      A, 0x02
    OUT     (0xC2), A

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
    LD      A, 0x00
    OUT     (0xC2), A

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


tab:
    incbin "gen/crc_table"

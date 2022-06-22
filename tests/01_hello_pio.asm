; 
; Simple test toggling PA[7..0] outputs endlessly, avoiding RAM access.
;

; Note: at reset ROM is mapped at address 0 and gets remapped after first I/O write

.org    0xC000

    ; configure 8255 - all outputs, mode 0
    LD      A, 0x80
    OUT     (0xC3), A
    NOP
    NOP
        
loop:
    LD      A, 0xAA
    OUT     (0xC0), A
    LD      A, 0x55
    OUT     (0xC0), A
    JP      loop

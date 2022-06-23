; 
; Simple test toggling PA[7..0] outputs endlessly, avoiding RAM access.
;

; Note: at reset ROM is mapped 4 times at 0, 0x4000, 0x8000 and 0xC000 
; and gets remapped after first I/O write. Execution starts at 0,
; so we first have to jump to change the PC to 0xC..., then we can issue
; first I/O write.

.org    0xC000

    JP      l1
l1: NOP

    ; configure 8255 - all outputs, mode 0
    LD      A, 0x80
    OUT     (0xC3), A

loop:
    LD      A, 0xAA
    OUT     (0xC0), A
    LD      A, 0x55
    OUT     (0xC0), A
    JP      loop

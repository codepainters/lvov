; 
; Simple test toggling PB0 output endlessly, avoiding RAM access.
;

.org    0xC000

; at reset ROM is mapped at address 0 and gets remapped after first I/oW write
    nop
    nop
        


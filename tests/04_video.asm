;
; Test video output.
;
; The code fills video buffer with a pattern.
;

.org    0xC000

    JP      l1
l1: NOP

    ; configure 8255 - all outputs, mode 0, set PB2 = 0
    LD      A, 0x80
    OUT     (0xC3), A
    LD      A, 0x00
    OUT     (0xC1), A
    
    ; switch memory mapping, so second half of RAM is
    ; mapped from address 0
    LD      A, 0x00
    OUT     (0xC2), A

    LD      HL, 0x4000  ; target address
    LD      BC, tab
    LD 	    D, 0

line:
    LD      A, (BC)	; load next byte 
    INC     BC

    ; ...and fill a line with it

    LD      E, 64
pix:
    LD      (HL), A     ; store it
    INC     HL          ; 
   
    DEC     E 
    JP      NZ, pix

    INC	    D		; increment line counter
    JP      NZ, line	; repeat, until line counter wraps
    

    ; endless loop when done
done:
    JP      done


tab:
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A 
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A 
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A 
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A 
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A 
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A 
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A 
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A 
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A 
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A 
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A 
    db 0x35, 0x35, 0x35, 0x6A, 0x6A, 0x6A, 0xC5, 0xC5, 0xC5, 0x9A, 0x9A, 0x9A
    db 0x35, 0x35, 0x35, 0x6A

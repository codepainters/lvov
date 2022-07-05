OBJS=01_hello_pio.rom 02_dump_roms.rom 03_test_ram.rom 04_video.rom

%.rom : %.asm
	zasm -wu --8080 $<

all: $(OBJS)


.PHONY: clean
clean:
	rm -f ${OBJS}
	rm -f *.lst

OBJS=01_hello_pio.rom

%.rom : %.asm
	zasm -wu --8080 $<

all: $(OBJS)


.PHONY: clean
clean:
	rm -f ${OBJS}
	rm -f *.lst

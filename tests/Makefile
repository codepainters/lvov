OBJS=01_hello_pio.rom

%.rom : %.asm
	zasm -wu $<

all: $(OBJS)


.PHONY: clean
clean:
	rm -f ${OBJS}
	rm -f *.lst

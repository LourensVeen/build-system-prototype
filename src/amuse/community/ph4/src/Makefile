.PHONY: amuse
amuse: libph4.a

libph4.a: ph4.o
	$(AR) $(ARFLAGS) $@ $^

.PHONY: clean
clean:
	rm -f *.a *.o


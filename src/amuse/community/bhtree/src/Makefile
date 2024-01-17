.PHONY: amuse
amuse: libbhtree.a

libbhtree.a: bhtree.o
	$(AR) $(ARFLAGS) $@ $^

.PHONY: clean
clean:
	rm -f *.a *.o


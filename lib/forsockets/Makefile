ALL = forsockets.so forsockets.mod

INSTALLED_FILES = $(PREFIX)/lib/forsockets.so
INSTALLED_FILES += $(PREFIX)/include/forsockets.mod


.PHONY: all
all: $(ALL)

.PHONY: install
install: $(INSTALLED_FILES)

.PHONY: clean
clean:
	rm -f *.so *.o *.mod

forsockets.so: forsockets.o
	$(FC) -shared -o $@ $(LDFLAGS) $< $(LDLIBS)

%.o %.mod &: %.f90
	$(FC) -c -o $@ $(FFLAGS) $<

$(PREFIX)/lib/%.so: %.so
	install -m 755 $< $@

$(PREFIX)/include/%.mod: %.mod
	install -m 644 $< $@


ALL = simple_hash.so simple_hash.h

INSTALLED_FILES = $(PREFIX)/lib/simple_hash.so
INSTALLED_FILES += $(PREFIX)/include/simple_hash.h


.PHONY: all
all: $(ALL)

.PHONY: install
install: $(INSTALLED_FILES)

clean:
	rm -f *.so *.o

simple_hash.so: simple_hash.o
	$(CC) -shared -o $@ $(LDFLAGS) $^ $(LDLIBS)

$(PREFIX)/lib/%.so: %.so
	install -m 755 $< $@

$(PREFIX)/include/%.h: %.h
	install -m 644 $< $@


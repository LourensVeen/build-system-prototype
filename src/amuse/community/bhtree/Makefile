ifneq (,$(filter-out clean distclean, $(MAKECMDGOALS)))
include support/config.mk
endif


# Detecting dependencies
support/config.mk:
	cd support && ./configure


# Building the code into a static library
CODELIB = src/libbhtree.a
LDFLAGS +=
LDLIBS +=

$(CODELIB):
	$(MAKE) -C src amuse


# Building the workers
cpu_worker: cpu_worker.o $(CODELIB)
	$(CC) -o cpu_worker $(LDFLAGS) $^ $(CODELIB) $(LDLIBS)


# Which packages contain which workers?
amuse-bhtree_contains: cpu_worker


# Building and installing packages
develop-%: %_contains $(CODELIB)
	support/shared/uninstall.sh $*
	python -m pip install -e packages/$*

install-%: %_contains $(CODELIB)
	support/shared/uninstall.sh $*
	python -m pip install packages/$*


# Cleaning up
.PHONY: clean
clean:
	$(MAKE) -C src clean
	rm -rf *.o *worker

.PHONY: distclean
distclean: clean
	-$(MAKE) -C src distclean
	rm -f support/config.mk support/config.log support/config.status
	rm -rf support/autom4te.cache


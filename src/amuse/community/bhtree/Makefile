ifneq (,$(filter-out clean distclean, $(MAKECMDGOALS)))
include support/config.mk
endif

CODELIB = src/libbhtree.a
LDFLAGS +=
LDLIBS +=


# Detecting dependencies
support/config.mk:
	cd support && ./configure


# Building the code into a static library
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
	python -m pip install -e ./$*

install-%: %_contains $(CODELIB)
	support/shared/uninstall.sh $*
	python -m pip install ./$*


# Cleaning up
.PHONY: clean
clean:
	$(MAKE) -C src clean
	rm -rf *worker *.o
	rm -rf amuse-bhtree/build amuse-bhtree/*.egg-info

.PHONY: distclean
distclean: clean
	$(MAKE) -C src distclean


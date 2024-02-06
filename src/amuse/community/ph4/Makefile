ifneq (,$(filter-out clean distclean, $(MAKECMDGOALS)))
include support/config.mk
endif

export VERSION = 2024.4.0

CODELIB = src/libph4.a
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

gpu_worker: gpu_worker.o $(CODELIB)
	$(CC) -o gpu_worker $(LDFLAGS) $^ $(CODELIB) $(CUDA_LIBS) $(LDLIBS)


# Which packages contain which workers?
amuse-ph4-cpu_contains: cpu_worker
amuse-ph4-gpu_contains: cpu_worker gpu_worker


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
	rm -rf amuse-*/dist amuse-*/*.egg-info *.o *worker

.PHONY: distclean
distclean: clean
	-$(MAKE) -C src distclean
	rm -f support/config.mk


# Support logic for Conda and virtualenv environments

# Detect environment
ENV_TYPE =

ifneq (,$(VIRTUAL_ENV))
ENV_TYPE = virtualenv
ENV_NAME = $(VIRTUAL_ENV)

HAVE_WHEEL = $(shell pip list | grep '^wheel')
HAVE_PIP = $(shell pip list | grep '^pip')

endif

ifneq (,$(CONDA_DEFAULT_ENV))
ENV_TYPE = conda
ENV_NAME = $(CONDA_DEFAULT_ENV)

HAVE_PYPI_WHEEL = $(shell conda list | grep pypi | grep '^wheel')
HAVE_PYPI_PIP = $(shell conda list | grep pypi | grep '^pip')

HAVE_WHEEL = $(shell conda list | grep -v pypi | grep '^wheel')
HAVE_PIP = $(shell conda list | grep -v pypi | grep '^pip')

endif

ifneq (,$(HAVE_PIP))
ifneq (,$(HAVE_WHEEL))

HAVE_PIP_WHEEL = 1

endif
endif


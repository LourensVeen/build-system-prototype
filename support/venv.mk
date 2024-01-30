# Support logic for Conda and virtualenv environments

# Detect environment
ENV_TYPE =

ifneq (,$(VIRTUAL_ENV))
ENV_TYPE = virtualenv
ENV_NAME = $(VIRTUAL_ENV)
endif

ifneq (,$(CONDA_DEFAULT_ENV))
ENV_TYPE = conda
ENV_NAME = $(CONDA_DEFAULT_ENV)
endif



include support/format.mk
include support/venv.mk


define ENVIRONMENT_HELP :=

$(BOLD)* Create and activate an environment *$(END_BOLD)

To install any packages, you need to create and activate a Conda environment
or a Python virtualenv. If you have an environment into which you'd like to
install AMUSE, you should activate it now. To create a new environment, use

    conda create -n my-amuse-env

Then you activate it using

    conda activate my-amuse-env

You can name the environment anything you like instead of my-amuse-env.

To create a Python virtualenv, use

    python -m venv ~/Envs/my-amuse-env

Then you can activate it using

    source ~/Envs/my-amuse-env/bin/activate

You can put the environment anywhere you like, but do make sure that the
directory it will be in exists, or you'll get an error message.

Once you have an environment active, type

    make configure

again to continue.

endef

ENVIRONMENT_HELP := $(subst $(newline),\n,$(subst ','\'',$(ENVIRONMENT_HELP)))


define DISABLED_PACKAGES_MESSAGE :=

$(BOLD)* Enable more packages *$(END_BOLD)

Some packages are disabled due to missing features. You can enable more packages by
installing additional software. Some software does require specific hardware, for
example CUDA requires an nVidia GPU to work.

To enable a package that is listed as disabled above, look up the missing features
above and use the commands below to install the corresponding software.

endef

ifneq ($(ENVIRONMENT_TYPE), conda)
define DISABLED_PACKAGES_MESSAGE +=

Creating and activating a Conda environment will allow you to install the missing
software using Conda. To do that, follow the instructions above and run

    make configure

again.

endef
endif

DISABLED_PACKAGES_MESSAGE := $(subst $(newline),\n,$(subst ','\'',$(DISABLED_PACKAGES_MESSAGE)))


define MACPORTS_MESSAGE :=

We seem to be running on a Mac with MacPorts installed. Here's how to install the
required packages for each missing feature:

endef

MACPORTS_MESSAGE := $(subst $(newline),\n,$(subst ','\'',$(MACPORTS_MESSAGE)))



define HOMEBREW_MESSAGE :=

We seem to be running on a Mac with Homebrew installed. Here's how to install the
required packages for each missing feature.

endef

HOMEBREW_MESSAGE := $(subst $(newline),\n,$(subst ','\'',$(HOMEBREW_MESSAGE)))


define APT_MESSAGE :=

We seem to be running on Ubuntu or a similar Linux distribution that uses APT.
Here's how to install the required packages for each missing feature.

endef

APT_MESSAGE := $(subst $(newline),\n,$(subst ','\'',$(APT_MESSAGE)))


define YUM_MESSAGE :=

We seem to be running on RedHat or a similar Linux distribution that uses YUM.
Here's how to install the required packages for each missing feature.

endef

YUM_MESSAGE := $(subst $(newline),\n,$(subst ','\'',$(YUM_MESSAGE)))



define INSTALL_HELP :=

$(BOLD)* Install AMUSE *$(END_BOLD)

To install the AMUSE framework and all of the enabled packages into the active
$(ENVIRONMENT_TYPE) environment $(ENVIRONMENT_NAME), type

    make install-packages

endef

INSTALL_HELP := $(subst $(newline),\n,$(subst ','\'',$(INSTALL_HELP)))


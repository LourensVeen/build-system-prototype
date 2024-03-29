# Default target, in case the user types 'make' without saying what they want
please_specify_a_goal:
	@echo Please specify what to do. Try
	@echo
	@echo '    make configure'
	@echo
	@echo to get started.


.PHONY: configure
configure:
	rm -f support/features.mk
	$(MAKE) show-config


ifneq (,$(filter-out configure clean distclean, $(MAKECMDGOALS)))

include support/amuse.mk
include support/dependencies.mk
include support/format.mk
include support/help.mk
include support/venv.mk

.PHONY: show-config
show-config:
	@echo
	@echo
	@printf '%b\n' '$(COLOR_CYAN)*** Configuration complete ***$(COLOR_END)'
	@echo
	@printf 'Detected features: $(FEATURES)\n'
	@echo
	@printf '%b\n' '$(COLOR_GREEN)** Enabled packages **$(COLOR_END)'
	@printf '$(ENABLED_PACKAGES)\n'
	@echo
	@printf '%b\n' '$(COLOR_RED)** Disabled packages **$(COLOR_END)'
	@printf '$(DISABLED_PACKAGES)\n'
	@echo
	@printf '%b\n' '$(COLOR_CYAN)*** Next steps ***$(COLOR_END)'
ifeq (,$(ENV_TYPE))
	@printf '%b\n' '$(ENVIRONMENT_HELP)'
endif
ifneq (,$(NEED_PIP_WHEEL))
	@printf '%b\n' '$(NO_PIP_WHEEL_MESSAGE)'
endif
ifneq (, $(DISABLED_PACKAGES))
	@printf '%b\n' '$(DISABLED_PACKAGES_MESSAGE)'
endif
ifneq (,$(ENV_TYPE))
	@printf '%b\n' '$(INSTALL_HELP)'
endif

# TODO: figure out dependencies between community codes and libs and framework
# install-packages and develop-packages


.PHONY: install-framework
install-framework:
	cd src && pip install .

.PHONY: develop-framework
develop-framework:
	cd src && pip install -e .

.PHONY: install-libs
install-libs:
	$(MAKE) -C lib install

.PHONY: install-packages

.PHONY: develop-packages

.PHONY: install
install: install-framework install-libs install-packages

endif

.PHONY: clean
clean:
	$(MAKE) -C lib clean
	$(MAKE) -C src/amuse/community clean

.PHONY: distclean
distclean: clean


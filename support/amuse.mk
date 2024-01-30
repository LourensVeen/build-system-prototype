# Default target, in case the user types 'make' without saying what they want
please_specify_a_goal:
	@echo Please specify what to do. Try
	@echo
	@echo '    make configure'
	@echo
	@echo to get started.


# Detect what features we have
ifeq (, $(filter configure clean, $(MAKECMDGOALS)))

support/features.mk:
	cd support && ./configure $(CONFIGOPTS)

include support/features.mk

endif


# List of enabled packages, filled by the .amuse_dep.mk files
ENABLED_PACKAGES :=

# List of disabled packages and reasons, filled by the .amuse_dep.mk files
DISABLED_PACKAGES :=

# Detect community codes and their required features
COMMUNITY_CODES = $(filter-out Makefile, $(subst src/amuse/community/,,$(wildcard src/amuse/community/*)))

# List of worker metadata files for all community codes
COMM_DEPS = $(foreach d,$(wildcard src/amuse/community/*), $(wildcard $d/*.amuse_deps))

# List of makefile snippets produced from the metadata files
COMM_DEPS_MK = $(patsubst src/amuse/community/%, support/comm_deps_mk/%.mk, $(COMM_DEPS))

# Include the makefile snippets to complete the packages targets
include $(COMM_DEPS_MK)

# Creates a makefile snippet that adds targets for the package, and adds those targets
# as a prerequisites of the 'develop-packages' and 'install-packages' targets, but only
# if FEATURES contains all the dependencies of the worker. As a result, when making
# 'install-packages' we will only try to build the packages that we have the
# dependencies for and expect to build cleanly.
support/comm_deps_mk/%.mk: src/amuse/community/%
	@mkdir -p $(dir $@)
	@rm -f $@
	@echo include support/format.mk >>$@
	@echo >>$@
	@echo PACKAGE_NAME = $(notdir $(patsubst %.amuse_deps,%,$*)) >>$@
	@echo >>$@
	@echo 'REQUIRED_FEATURES := $(file < $<)' >>$@
	@echo 'MISSING_FEATURES := $$(filter-out $$(FEATURES), $$(REQUIRED_FEATURES))' >>$@
	@echo >>$@
	@echo 'ifeq (,$$(MISSING_FEATURES))' >>$@
	@echo >>$@
	@echo 'ENABLED_PACKAGES += \\n$(notdir $(patsubst %.amuse_deps,%,$*))' >>$@
	@echo >>$@
	@echo '%-$(notdir $(patsubst %.amuse_deps,%,$*)):' >>$@
	@echo '\tmake -C $(dir $<)' $$\@ >>$@
	@echo >>$@
	@echo 'develop-packages: develop-$(notdir $(patsubst %.amuse_deps,%,$*))' >>$@
	@echo >>$@
	@echo 'install-packages: install-$(notdir $(patsubst %.amuse_deps,%,$*))' >>$@
	@echo >>$@
	@echo else >>$@
	@echo >>$@
	@echo 'DISABLED_PACKAGES += \\n$(notdir $(patsubst %.amuse_deps,%,$*)) (missing features: $(COLOR_RED)$$(MISSING_FEATURES)$(COLOR_END))' >>$@
	@echo endif >>$@


# Extend the 'distclean' target to clean up the files we made above
.PHONY: distclean
distclean: clean_comm_deps clean_features

.PHONY: clean_features
clean_features:
	rm -f support/features.mk support/config.status support/config.log
	rm -rf support/autom4te.cache

.PHONY: clean_comm_deps
clean_comm_deps:
	rm -f $(COMM_DEPS_MK)


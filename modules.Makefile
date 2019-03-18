TOP = ..


M_DIRS:=$(sort $(dir $(wildcard */)))


all: modules

modules: release
#	BASE[o]
	$(MAKE) -C $(M_AUTOSAVE)
	$(MAKE) -C $(M_IOCSTATS)
	$(MAKE) -C $(M_ASYN)
	cd $(M_STREAM) && git submodule update --init --reference ./
	$(MAKE) -C $(M_STREAM)



release:
#	BASE[o]
	echo "EPICS_BASE=$(EPICS_BASE)"  > $(M_AUTOSAVE)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)"  > $(M_IOCSTATS)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)"  > $(M_ASYN)/configure/RELEASE
	echo "ASYN=$(M_ASYN)"            > $(M_STREAM)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)" >> $(M_STREAM)/configure/RELEASE


clean: $(M_DIRS)

$(M_DIRS):
	$(MAKE) -C $@ clean


dirs:
	@echo $(M_DIRS) || true
	@echo $(findstring asyn, $(M_DIRS))


.PHONY: all modules release clean dirs $(M_DIRS) 

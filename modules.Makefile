TOP = ..


#BASE[o]
M_AUTOSAVE=$(EPICS_MODULES)/autosave
M_IPAC=$(EPICS_MODULES)/ipac
M_DEVLIB2=$(EPICS_MODULES)/devlib2
M_SNCSEQ=$(EPICS_MODULES)/seq
M_SNMP=$(EPICS_MODULES)/snmp
#BASE[o], SNCSEQ[o]
M_IOCSTATS=$(EPICS_MODULES)/iocStats
M_SSCAN=$(EPICS_MODULES)/sscan
#BASE[o], IPAC[o], SNCSEQ[o]
M_ASYN=$(EPICS_MODULES)/asyn
#BASE[o], ASYN[o]
M_BUSY=$(EPICS_MODULES)/busy
M_MODBUS=$(EPICS_MODULES)/modbus
M_STREAM=$(EPICS_MODULES)/stream
M_STD=$(EPICS_MODULES)/std
#BASE[o], SSCAN[o], SNCSEQ[o]
M_CALC=$(EPICS_MODULES)/calc
M_IP=$(EPICS_MODULES)/ip
#BASE[o], ASYN[o], BUSY[o], IPAC[o], SNCSEQ[o]
M_MOTOR=$(EPICS_MODULES)/motor
#BASE[o], DEVLIB2[o], DEVIOCSTATS[o], AUTOSAVE[x], CAPUTLOG[x]
M_MRFIOC2=$(EPICS_MODULES)/mrfioc2




M_DIRS:=$(sort $(dir $(wildcard */)))


all: modules

modules: release
#	BASE[o]
	$(MAKE) -C $(M_AUTOSAVE)
	$(MAKE) -C $(M_IPAC)
	$(MAKE) -C $(M_DEVLIB2)
	$(MAKE) -C $(M_SNCSEQ)
	$(MAKE) -C $(M_SNMP)
#	BASE[o], SNCSEQ[o]
	$(MAKE) -C $(M_IOCSTATS)
	$(MAKE) -C $(M_SSCAN)
#	BASE[o], IPAC[o], SNCSEQ[o]
	$(MAKE) -C $(M_ASYN)
#	BASE[o], ASYN[o]
	$(MAKE) -C $(M_BUSY)
	$(MAKE) -C $(M_MODBUS)
	cd $(M_STREAM) && git submodule update --init --reference ./
	$(MAKE) -C $(M_STREAM)
#	BASE[o], SSCAN[o], SNCSEQ[o]
	$(MAKE) -C $(M_CALC)
	$(MAKE) -C $(M_STD)
	$(MAKE) -C $(M_IP)
#	BASE[o], ASYN[o], BUSY[o], IPAC[o], SNCSEQ[o]
	$(MAKE) -C $(M_MOTOR)
#	BASE[o], DEVLIB2[o], DEVIOCSTATS[o], AUTOSAVE[x], CAPUTLOG[x]
	$(MAKE) -C $(M_MRFIOC2)



release:
#	BASE[o]
	echo "EPICS_BASE=$(EPICS_BASE)"  > $(M_AUTOSAVE)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)"  > $(M_IPAC)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)"  > $(M_DEVLIB2)/configure/RELEASE.local
	echo "EPICS_BASE=$(EPICS_BASE)"  > $(M_SNCSEQ)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)"  > $(M_SNMP)/configure/RELEASE
#	BASE[o], SNCSEQ[o]
	echo "SNCSEQ=$(M_SNCSEQ)"        > $(M_IOCSTATS)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)" >> $(M_IOCSTATS)/configure/RELEASE
	echo "SNCSEQ=$(M_SNCSEQ)"        > $(M_SSCAN)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)" >> $(M_SSCAN)/configure/RELEASE
#	BASE[o], IPAC[o], SNCSEQ[o]
	echo "IPAC=$(M_IPAC)"            > $(M_ASYN)/configure/RELEASE
	echo "SNCSEQ=$(M_SNCSEQ)"       >> $(M_ASYN)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)" >> $(M_ASYN)/configure/RELEASE
#	BASE[o], ASYN[o]
	echo "ASYN=$(M_ASYN)"            > $(M_BUSY)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)" >> $(M_BUSY)/configure/RELEASE
	echo "ASYN=$(M_ASYN)"            > $(M_MODBUS)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)" >> $(M_MODBUS)/configure/RELEASE
	echo "ASYN=$(M_ASYN)"            > $(M_STREAM)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)" >> $(M_STREAM)/configure/RELEASE

#	BASE[o], SSCAN[o], SNCSEQ[o]
	echo "SSCAN=$(M_SSCAN)"          > $(M_CALC)/configure/RELEASE
	echo "SNCSEQ=$(M_SNCSEQ)"       >> $(M_CALC)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)" >> $(M_CALC)/configure/RELEASE
#	BASE[o], ASYN[o] SNCSEQ[o]
	echo "ASYN=$(M_ASYN)"            > $(M_STD)/configure/RELEASE
	echo "SNCSEQ=$(M_SNCSEQ)"       >> $(M_STD)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)" >> $(M_STD)/configure/RELEASE
#	BASE[o], SSCAN[o], SNCSEQ[o],  ASYN[o]
	echo "ASYN=$(M_ASYN)"            > $(M_IP)/configure/RELEASE
	echo "SSCAN=$(M_SSCAN)"         >> $(M_IP)/configure/RELEASE
	echo "SNCSEQ=$(M_SNCSEQ)"       >> $(M_IP)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)" >> $(M_IP)/configure/RELEASE
#	BASE[o], ASYN[o], BUSY[o], IPAC[o], SNCSEQ[o]
	echo "ASYN=$(M_ASYN)"            > $(M_MOTOR)/configure/RELEASE
	echo "SNCSEQ=$(M_SNCSEQ)"       >> $(M_MOTOR)/configure/RELEASE
	echo "IPAC=$(M_IPAC)"           >> $(M_MOTOR)/configure/RELEASE
	echo "BUSY=$(M_BUSY)"           >> $(M_MOTOR)/configure/RELEASE
	echo "EPICS_BASE=$(EPICS_BASE)" >> $(M_MOTOR)/configure/RELEASE
#	BASE[o], DEVLIB2[o], DEVIOCSTATS[o], AUTOSAVE[o], CAPUTLOG[x]
	echo "DEVLIB2=$(M_DEVLIB2)"       > $(M_MRFIOC2)/configure/RELEASE.local
	echo "DEVIOCSTATS=$(M_IOCSTATS)" >> $(M_MRFIOC2)/configure/RELEASE.local
	echo "AUTOSAVE=$(M_AUTOSAVE)"    >> $(M_MRFIOC2)/configure/RELEASE.local
	echo "EPICS_BASE=$(EPICS_BASE)"  >> $(M_MRFIOC2)/configure/RELEASE.local


clean: $(M_DIRS)

$(M_DIRS):
	$(MAKE) -C $@ clean


dirs:
	@echo $(M_DIRS) || true
	@echo $(findstring asyn, $(M_DIRS))


.PHONY: all modules release clean dirs $(M_DIRS) 

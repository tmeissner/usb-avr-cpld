PROJECT = cpldtestt

MAKE_WORKDIR := $(shell mkdir -p work)

WORKDIR = ${CURDIR}/work

all : sim wave

.PHONY:
sim : $(PROJECT).ghw


$(PROJECT).ghw : ../src/*.vhd $(PROJECT).vhd
	cd $(WORKDIR); ghdl -a ../../src/*.vhd ../$(PROJECT).vhd
	cd $(WORKDIR); ghdl -e $(PROJECT)
	cd $(WORKDIR); ghdl -r $(PROJECT) --wave=../$(PROJECT).ghw --assert-level=error --stop-time=150us

wave : $(PROJECT).ghw $(PROJECT).tcl
	gtkwave -T $(PROJECT).tcl $(PROJECT).ghw
	
clean :
	echo "# cleaning simulation files"
	rm -f $(PROJECT).ghw
	rm -rf $(WORKDIR)

# variables
DESIGN     = cpldtest
PART       = xc9572xl-10-vq44

CURDIR     = $(shell pwd)
CONFDIR    = ${CURDIR}/config
UCFDIR     = ${CURDIR}/constraints
WORKDIR    = ${CURDIR}/work
NETLISTDIR = ${CURDIR}/netlist
BINDIR     = ${CURDIR}/binary
REPORTS    = ${CURDIR}/reports

SRC_LIST = $(shell cat $(CONFDIR)/$(DESIGN).prj | sed -r 's:^.*"../(.*)":\1:')

# synthesis options
XSTFLAGS = run -ifmt VHDL -ofmt NGC -opt_level 2 -fsm_encoding sequential -pld_xp yes -pld_mp yes \
           -keep_hierarchy yes -safe_implementation no -wysiwyg yes -ifn $(CONFDIR)/$(DESIGN).prj \
           -p $(PART) -ofn $(DESIGN) -top $(DESIGN)E -tmpdir xsttmp -xsthdpdir xsthdpdir

NGDFLAGS = -nt timestamp -verbose -dd ngd -p $(PART) \
           -uc $(UCFDIR)/$(DESIGN).ucf -sd $(NETLISTDIR) 

FITFLAGS = -loc on -optimize speed -nomlopt -wysiwyg -unused float -keepio -slew fast -p $(PART)

TFLAGS   = -detail -iopath


# create directories
DUMMY:=$(shell mkdir -p $(WORKDIR))
DUMMY:=$(shell mkdir -p $(BINDIR))
DUMMY:=$(shell mkdir -p $(REPORTS))

.PHONY: all clean

all : programmingfile

programmingfile : $(WORKDIR)/$(DESIGN).jed 
	cp $(WORKDIR)/$(DESIGN).jed $(BINDIR)/

# generate script for xst in command line mode
$(WORKDIR)/xst.conf : $(CONFDIR)/$(DESIGN).prj
	touch $(WORKDIR)/xst.conf
	echo $(XSTFLAGS) >> $(WORKDIR)/xst.conf

# generate netlist constraints file
$(WORKDIR)/$(DESIGN).ngc: $(SRC_LIST)  $(WORKDIR)/xst.conf
	cd $(WORKDIR); xst -ifn xst.conf
	cp $(WORKDIR)/xst.srp $(REPORTS)/$(DESIGN)_xst.txt

# generate native generic database file (ngd)
$(WORKDIR)/$(DESIGN).ngd : $(WORKDIR)/$(DESIGN).ngc $(UCFDIR)/$(DESIGN).ucf
	cd $(WORKDIR); ngdbuild $(NGDFLAGS) $(DESIGN).ngc $(DESIGN).ngd
	cp $(WORKDIR)/$(DESIGN).bld $(REPORTS)/$(DESIGN).bld

# generate vm6 file
$(WORKDIR)/$(DESIGN).vm6 : $(WORKDIR)/$(DESIGN).ngd
	cd $(WORKDIR); cpldfit $(FITFLAGS) $(DESIGN).ngd 
	cp $(WORKDIR)/$(DESIGN).rpt $(REPORTS)/$(DESIGN).rpt

# generate programming file
$(WORKDIR)/$(DESIGN).jed : $(WORKDIR)/$(DESIGN).vm6
	cd $(WORKDIR); hprep6 -i $(DESIGN).vm6


# clean all
clean :
	rm -rf $(WORKDIR)/*
	rm -rf $(BINDIR)/$(DESIGN).jed
	rm -rf $(REPORTS)/$(DESIGN).trp

distclean : 
	rm -rf $(WORKDIR)
	rm -rf $(BINDIR)
	rm -rf $(REPORTS)

#
#  Copyright (c) 2018 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# 
# Author  : 
# email   : 
# Date    : Thursday, March 14 23:34:19 CET 2019
# version : 0.0.1 
#
## The following lines are mandatory, please don't change them.
where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(E3_REQUIRE_CONFIG)/DECOUPLE_FLAGS



# If one would like to use the module dependency restrictly,
# one should look at other modules makefile to add more
# In most case, one should ignore the following lines:

ifneq ($(strip $(ASYN_DEP_VERSION)),)
asyn_VERSION=$(ASYN_DEP_VERSION)
endif

ifneq ($(strip $(NDS3_DEP_VERSION)),)
nds3_VERSION=$(NDS3_DEP_VERSION)
endif

ifneq ($(strip $(NDS3EPICS_DEP_VERSION)),)
nds3epics_VERSION=$(NDS3EPICS_DEP_VERSION)
endif

ifneq ($(strip $(TSCLIB_DEP_VERSION)),)
tsclib_VERSION=$(TSCLIB_DEP_VERSION)
endif


ifneq ($(strip $(ADSUPPORT_DEP_VERSION)),)
ADSupport_VERSION=$(ADSUPPORT_DEP_VERSION)
endif



#EXCLUDE_ARCHS += linux-ppc64e6500
#EXCLUDE_ARCHS += linux-corei7-poky
#EXCLUDE_ARCHS +=linux-x86_64

APP:=src
APPSRC:=$(APP)
APPDB:=db


USR_INCLUDES += -I$(where_am_I)$(APPSRC)
USR_INCLUDES += -I$(where_am_I)$(APPSRC)/include
USR_INCLUDES += -I/usr/include

USR_CFLAGS   += -DIS_EEE_MODULE
# set -DIS_EEE_MODULE_NO_TRACE for no trace
USR_CXXFLAGS += -std=c++1y -DIS_EEE_MODULE -DIS_EEE_MODULE_NO_TRACE -fpermissive

## Unfornately, CentOs 7 devtoolset 8 cannot support gnu+14/17
#ifeq ($(T_A),linux-x86_64)
#USR_CXXFLAGS += -std=gnu++11
#else
#USR_CXXFLAGS += -std=gnu++17
#endif

#USR_CXXFLAGS += -DIS_EEE_MODULE
#USR_CXXFLAGS += -DIS_EEE_MODULE_NO_TRACE
#USR_CXXFLAGS += -fpermissive

# Set local (in /lib64) HDF5 libraries for CT, remove this when PPC
#USR_LDFLAGS  += -lhdf5
#USR_LDFLAGS  += -lhdf5_cpp
## If the above statement is true, please use this for CentOS
#LIB_SYS_LIBS += hdf5
#LIB_SYS_LIBS += hdf5_hl
#
#ifeq ($(T_A),linux-x86_64)
#
#USR_INCLUDES += -I/usr/include
## The following header path is only valid for Debian based system
#USR_INCLUDES += -I/usr/include/hdf5/serial
#
## The followin LDGLAGSs are used for CentOS and Debian together
## It will be no harm in other based OS one.
#USR_LDFLAGS  += -L/usr/local/lib
#USR_LDFLAGS  += -L/usr/lib/x86_64-linux-gnu/hdf5/serial
#else
#USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include
#endif



TEMPLATES += $(wildcard $(APPDB)/*.db)


SOURCES   += $(wildcard $(APPSRC)/*.cpp)
SOURCES   += $(wildcard $(APPSRC)/*.c)

DBDS      += $(APPSRC)/nblmapp_asub.dbd
DBDS      += $(APPSRC)/IFC14AIChannelGroup.dbd

SCRIPTS   += $(wildcard ../iocsh/*.iocsh)



USR_DBFLAGS += -I . -I ..
USR_DBFLAGS += -I $(EPICS_BASE)/db
USR_DBFLAGS += -I $(APPDB)

SUBS=$(wildcard $(APPDB)/*.substitutions)
#TMPS=$(wildcard $(APPDB)/*.template)
TMPS= 

db: $(SUBS) $(TMPS)


$(SUBS):
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db -S $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db -S $@

$(TMPS):
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db $@


.PHONY: db $(SUBS) $(TMPS)


vlibs:

.PHONY: vlibs




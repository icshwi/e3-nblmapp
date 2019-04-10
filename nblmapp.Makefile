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



APP:=src
APPSRC:=$(APP)
APPDB:=db


USR_INCLUDES += -I$(where_am_I)$(APPSRC)
USR_INCLUDES += -I$(where_am_I)$(APPSRC)/include

USR_CFLAGS   += -DIS_EEE_MODULE
USR_CXXFLAGS += -std=c++0x -DIS_EEE_MODULE -DIS_EEE_MODULE_NO_TRACE -fpermissive


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




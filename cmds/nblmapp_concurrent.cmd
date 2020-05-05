################################################
# IOC running command on the Concurrent board  #
# cmds/nblmapp_concurrent.cmd                  #
################################################

require ADSupport,1.9.0 ## for HDF5 library ##
#require nblmapp,1.0.5
require nblmapp,master
require nds3epics,1.0.1

# Constant definitions
epicsEnvSet(TRIG0_PV,           "$(TRIG0_PV=MTCA-EVR:EvtECnt-I.TIME)")
#epicsEnvSet(TIMESTAMP,          "null")
epicsEnvSet(TIMESTAMP,          "$(TIMESTAMP=MTCA-EVR:Time-I.TIME)")
epicsEnvSet(PREFIX,             "$(PREFIX=PBI-nBLM00)")
epicsEnvSet(DEVICE,             "$(DEVICE=PBI-AMC-)")
# The tens of AMC gives the card in slot 3
epicsEnvSet(AMC1,               "$(AMC1=130)")
# The tens of AMC gives the card in slot 5
epicsEnvSet(AMC2,               "$(AMC2=150)")
##################### Only one board ##############################
epicsEnvSet(AMCs,               "$(AMC1)")
################# or with several IFC1410 #########################
#epicsEnvSet(AMCs,               "$(AMC1)_$(AMC2)")
###################################################################


epicsEnvSet(EPICS_CA_MAX_ARRAY_BYTES, 400000000)

# Set maximum number of samples: SCOPE_RAW_DATA_SAMPLES_MAX for the scope in the code
epicsEnvSet(NELM, 5000)

var onAMCOne 1

# ################## acquisition  ##############################
# IFC1410 in AMC Slot 3 and 5
# MB_DOD is the total DOD size allocated for each IFC1410 (in MBytes)
ndsCreateDevice(nblm, $(PREFIX), chGrp=${DEVICE}, grpNb=${AMCs}, MB_DOD="64")

dbLoadRecords("trigTime.db", "TIMESTAMP=${TRIG0_PV}")


dbLoadRecords("nblm_group.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC1},TIMESTAMP=${TIMESTAMP}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC1},CH_ID=CH0, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC1},CH_ID=CH1, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC1},CH_ID=CH2, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC1},CH_ID=CH3, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC1},CH_ID=CH4, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC1},CH_ID=CH5, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")

################# Test with a 2nd IFC1410 #########################
#dbLoadRecords("nblm_group.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC2},TIMESTAMP=${TIMESTAMP}")
#dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC2},CH_ID=CH0, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
#dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC2},CH_ID=CH1, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
#dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC2},CH_ID=CH2, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
#dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC2},CH_ID=CH3, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
#dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC2},CH_ID=CH4, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
#dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}${AMC2},CH_ID=CH5, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
###################################################################

iocInit

# neutron detection and scope configuration
# Pulse processing
dbpf ${PREFIX}:${DEVICE}${AMC1}:STAT "ON"

################# Test with a 2nd IFC1410 #########################
#dbpf ${PREFIX}:${DEVICE}${AMC2}:STAT "ON"
###################################################################

################################################
# IOC running command on the IFC1410 board     #
# cmds/nblmapp.cmd                             #
################################################

#require ADSupport,1.9.0 ## for HDF5 library ##
require nds3epics,1.0.1
#require nblmapp,1.0.5
require nblmapp,develop

# Constant definitions
epicsEnvSet(TRIG0_PV,           "$(TRIG0_PV=MTCA-EVR:EvtECnt-I.TIME)")
epicsEnvSet(TIMESTAMP,          "$(TIMESTAMP=MTCA-EVR:Time-I.TIME)")
epicsEnvSet(PREFIX,             "$(PREFIX=FEBx)")
epicsEnvSet(DEVICE,             "$(DEVICE=PBI-nBLM)")
epicsEnvSet(EPICS_CA_MAX_ARRAY_BYTES, 400000000)

# Set maximum number of samples: SCOPE_RAW_DATA_SAMPLES_MAX for the scope in the code
epicsEnvSet(NELM, 5000)

# ################## acquisition  ##############################
ndsCreateDevice(ifc14, ${PREFIX}, card=0, fmc=1, chGrp=${DEVICE})

dbLoadRecords("trigTime.db", "TIMESTAMP=${TRIG0_PV}")
dbLoadRecords("nblm_group.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE},TIMESTAMP=${TIMESTAMP}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE},CH_ID=CH0, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE},CH_ID=CH1, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE},CH_ID=CH2, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE},CH_ID=CH3, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE},CH_ID=CH4, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE},CH_ID=CH5, NELM=${NELM},TIMESTAMP=${TIMESTAMP}")

iocInit

# neutron detection and scope configuration
# Pulse processing
dbpf ${PREFIX}:${DEVICE}-STAT "ON"

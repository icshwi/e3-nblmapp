###############################################################
# IOC running command on the IFC1410 board                    #
# iocsh /opt/epics/modules/nblmapp/1.0.0/startup/nblmapp.cmd  #
###############################################################

require asyn,4.33.0
require nds3epics,1.0.0
require tsclib,3.0.0
require nblmapp,master

# Constant definitions
epicsEnvSet(PREFIX,             "$(PREFIX=MEBT)")   # default prefix is "IFC1410_nBLM"
epicsEnvSet(DEVICE,             "$(DEVICE=PBI-nBLM)")  	    # default device is "PROTO"
epicsEnvSet(EPICS_CA_MAX_ARRAY_BYTES, 400000000)

# Set maximum number of samples: SCOPE_RAW_DATA_SAMPLES_MAX for the scope in the code
epicsEnvSet(NELM, 5000)

# ################## acquisition  ##############################
ndsCreateDevice(ifc14, ${PREFIX}, card=0, fmc=1, chGrp=${DEVICE})

dbLoadRecords("nblm_group.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE},CH_ID=CH0, NELM=${NELM}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE},CH_ID=CH1, NELM=${NELM}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE},CH_ID=CH2, NELM=${NELM}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE},CH_ID=CH3, NELM=${NELM}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE},CH_ID=CH4, NELM=${NELM}")
dbLoadRecords("nblm.db", "PREFIX=${PREFIX},CH_GRP_ID=${DEVICE},CH_ID=CH5, NELM=${NELM}")

iocInit

# neutron detection and scope configuration
# Pulse processing
dbpf ${PREFIX}:${DEVICE}-STAT "ON"

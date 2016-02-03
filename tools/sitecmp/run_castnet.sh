#!/bin/sh
#
# RCS file, release, date & time of last delta, author, state, [and locker]
# $Header: /nas01/depts/ie/cempd/apps/CMAQ/v5.0.1/CMAQv5.0.1/models/TOOLS/src/sitecmp/run_castnet.sh,v 1.1.1.1 2012/04/19 19:48:37 sjr Exp $ 
#
# what(1) key, module and SID; SCCS file; date and time of last delta:
# %W% %P% %G% %U%
#
# script for running the site compare program on Unix
#
#  comparing the CMAQ model run I2a dataset with CASTNET dataset
#

BASE=/project/model_evalb/extract_util
 
EXECUTION_ID=sitecmp; export EXECUTION_ID
 
EXEC=${BASE}/bin/${EXECUTION_ID}.exe


# Set TABLE TYPE
TABLE_TYPE=CASTNET; export TABLE_TYPE

# Specify the variable names used in your observation inputs
# and model output files for each of the species you are analyzing below.
# 
# variable format:
#    Obs_expression, Obs_units, [Mod_expression], [Mod_unit], [Variable_name]
#
# The expression is in the form:
#       [factor1]*Obs_name1 [+][-] [factor2]*Obs_name2 ... 
#
# If you do not need one of the species listed, comment out the first column.


# AEROSOL Variables (1-10)  - compute average over time

   AERO_1="tso4,ug/m3,ASO4T,,sulfate";  export AERO_1     ;# sulfate
   AERO_2="tno3,ug/m3,ANO3T,,nitrate";  export AERO_2     ;# nitrate
   AERO_3="tnh4,ug/m3,ANH4T,,ammonium"; export AERO_3     ;# ammonium

# GAS Variables (1-10)  - compute average over time
# Model output was originally in ppm, but conversions were already
# made in the combine extract to convert to ug/m3.

   GAS_1="wso2,ug/m3,SO2_UGM3,,sulfur dioxide"; export GAS_1 ;# sulfur dioxide
   GAS_2="nhno3,ug/m3,HNO3_UGM3,,nitric acid";  export GAS_2 ;# nitric acid


# Wet Concentration Variables (1-10) - compute volume-weighted average (VWAVG) in mg/l
# Observed values are already volume-weighted averages for the collection
# period.  Original model output is hourly wet deposition. To calculate
# VWAVG, the modeled wet deposition is accumulated for the collection time
# period, divided by the total precipitation (mm), and * 100. Resultingi
# units are mg/l.
 
#  WETCON_1="NH4,mg/l,WDEP_NHX,mg/l"; export WETCON_1    ;# Ammonium wet concentration (mg/l)
#  WETCON_2="NO3,mg/l,WDEP_ANO3T,mg/l"; export WETCON_2  ;# Nitrate wet concentration (mg/l)
#  WETCON_3="SO4,mg/l,WDEP_ASO4T,mg/l"; export WETCON_3  ;# Sulfate wet concentration (mg/l)
 
 
# Wet Deposition Variables (1-10) - compute accumulated wet deposition in kg/ha
# Observed values are volume-weighted average wet concentrations for thei
# collection period (mg/l). To convert to wet deposition, multiply the wet
# concentration values by the total observed precip (Sub Ppt in mm), and then
# divide by 100. Original model output is hourly wet deposition. The modeled
# wet deposition is accumulated for the collection time period.

 
#  WETDEP_1="NH4,kg/ha,WDEP_NHX,kg/ha"; export WETDEP_1   ;# Ammonium wet deposition
#  WETDEP_2="NO3,kg/ha,WDEP_ANO3T,kg/ha"; export WETDEP_2 ;# Nitrate wet deposition
#  WETDEP_3="SO4,kg/ha,WDEP_ASO4T,kg/ha"; export WETDEP_3 ;# Sulfate wet deposition


# Precipitation Variables (1-10) - compute accumulated precipitation

#  PREC_1="Sub Ppt,mm,10*RT,mm,Precip"; export PREC_1    ;# Precipitation
 

## define time window
  START_DATE=2001001;  export START_DATE
  END_DATE=2001031   export END_DATE

  START_TIME=0;        export START_TIME
  END_TIME=230000;     export END_TIME

## adjust for daylight savings 
  APPLY_DLS=N; export APPLY_DLS 

## set missing value string
  MISSING="-999"; export MISSING


## Projection sphere type (use type #19 to match CMAQ)
  IOAPI_ISPH=19; export IOAPI_ISPH

#############################################################
#  Input files
#############################################################

# ioapi input files containing VNAMES (max of 10)                                     
M3_FILE_1=${BASE}/cmaq_data/CCTM_I2a.std.200101.conc;  export M3_FILE_1
#M3_FILE_2=${BASE}/cmaq_data/CCTM_I2a.std.200102.conc;  export M3_FILE_2

#  SITE FILE containing site-id, longitude, latitude (tab delimited)
SITE_FILE=${BASE}/castnet/obs/castnet_sites.txt; export SITE_FILE

# : input table (exported file from Excel) 
#   containing site-id, time-period, and data fields
IN_TABLE=${BASE}/castnet/obs/drychem.csv; export IN_TABLE


#############################################################
#  Output files
#############################################################

#  output table (tab delimited text file importable to Excel)
OUT_TABLE=${BASE}/castnet/output/I2a.sitecmpV1.0.castnet.200101.csv; export OUT_TABLE

 ${EXEC}

echo run completed, output file = ${OUT_TABLE}


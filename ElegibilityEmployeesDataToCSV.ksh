#!/bin/ksh

####################################
# Output Filename
####################################
export SYSTEMDATE=`date +%Y%m%d`
export FILENAME="Eligibility_File_${SYSTEMDATE}.csv"

java -jar ./XsltTransform.jar ElegibilityEmployeesDataToCSV.xslt EmployeesData.xml ${FILENAME}

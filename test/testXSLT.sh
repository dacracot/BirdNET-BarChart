#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
# ---------------------------------------------------
# source the configuration file
# it must be edited and copied as ".BirdNET-BarChart" to you home directory
CONFIG_FILE=${HOME}/.BirdNET-BarChart
if [ -f "${CONFIG_FILE}" ]; then
    source ${CONFIG_FILE}
else 
	echo " "
    echo "${CONFIG_FILE} does not exist."
    echo "Run the config.sh script to create."
	echo " "
	exit 1
fi
# ---------------------------------------------------
{
# ===================================================
java -classpath ${XSLT_JAR} net.sf.saxon.Transform -s:${BARCHART_HOME}/test/test.xml -xsl:${BARCHART_HOME}/test/test.xsl > ${BARCHART_HOME}/test/output.html
diff ${BARCHART_HOME}/test/test.html ${BARCHART_HOME}/test/output.html
RESULT=$?
if [ $RESULT -eq 0 ]
then
	echo "test PASSED" > /dev/tty
elif [ $RESULT -eq 1 ]
then
	{
	echo "=================================="
	echo "=================================="
	echo "test FAILED"
	echo "=================================="
	echo "=================================="
	} > /dev/tty
else
	{
	echo "=================================="
	echo "=================================="
	echo "Something is wrong with the diff command."
	echo "=================================="
	echo "=================================="
	} > /dev/tty
fi
# ===================================================
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-testXSLT.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-testXSLT.err

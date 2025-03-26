#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
# ---------------------------------------------------
# ---------------------------------------------------
{



# does the CONFIG_FILE already exist?
CONFIG_FILE=${HOME}/.BirdNET-BarChart
if [ -f "${CONFIG_FILE}" ]; then

	# warn file exists

    # read file for defaults

fi



# set LAT LON... no initial default

# set BARCHART_HOME... default current directory

# set ANALYZER_HOME... no initial default

# set WEB_HOME... /var/www/html/

# set PERCENTSTORAGEALLOWED... 60%

# set BACKUP_HOME... default to read values
	# set backup user
	# set backup server
	# set backup directory


# set BACKUP_PASSWORD... no initial default


# create crontab?


# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-config.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-config.err

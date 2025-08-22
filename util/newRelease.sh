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
RELEASE=$(cat ${BARCHART_HOME}/util/updates/release.txt)
pushd ${BARCHART_HOME}
TAG=$(git tag | tail -n 1)
WHEN=$(git show --date=format:'%A, %d %B %Y at %H:%M' --stat ${TAG} | sed -n '3p' | cut -d' ' -f4,5,6,7,8,9)
VERSION=$(git show --date=format:'%A, %d %B %Y at %H:%M' --stat ${TAG} | sed -n '5,7p' | awk 'NF')
popd
# ---------------------------------------------------
echo "You are about to stage a release." > /dev/tty
echo "Current tag (${TAG}) vs release (${RELEASE})." > /dev/tty
echo "You should have recently tagged the dev branch with a tag greater than the release." > /dev/tty
echo "Do you wish to continue (y/n)?" > /dev/tty
read YORN
case "$YORN" in 
  y|Y ) echo "yes";;
  n|N ) echo "no"; exit;;
  * ) echo "Please answer Y or N" > /dev/tty; exit;;
esac
# ---------------------------------------------------
echo "$TAG" > ${BARCHART_HOME}/util/updates/release.txt
echo "${VERSION} ${WHEN}" > ${BARCHART_HOME}/util/updates/signature.txt
sed "s,@@TAG@@,${TAG},g" "${BARCHART_HOME}/util/updates/update-#-tasks.sh" > "${BARCHART_HOME}/util/updates/update-${TAG}-tasks.sh"
chmod 750 "${BARCHART_HOME}/util/updates/update-${TAG}-tasks.sh"
echo "Update tasks ready for editing of "${BARCHART_HOME}/util/updates/update-${TAG}-tasks.sh"." > /dev/tty
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-update-#-tasks.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-update-#-tasks.err
# ---------------------------------------------------

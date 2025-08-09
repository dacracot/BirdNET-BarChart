#!/bin/bash
echo " " > /dev/tty
echo ${MESSAGE} > /dev/tty
sleep ${WAITINTERVAL}s
echo " " > /dev/tty
# ---------------------------------------------------
while [ -f "${SEMAPHORE}" ];
do
	echo -n "." > /dev/tty
	sleep ${WAITINTERVAL}s
done
# ---------------------------------------------------
echo " " > /dev/tty
echo "Finished Waiting" > /dev/tty
echo " " > /dev/tty
# ---------------------------------------------------

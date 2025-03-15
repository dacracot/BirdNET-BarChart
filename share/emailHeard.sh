#!/bin/bash
{
WHEN=`date '+%Y-%m-%d--%H:%M'`
echo "--------------"
echo $WHEN
echo "--------------"
    RECIPIENTS="dacracot@yahoo.com"
    MAILBODY="heard table content goes here"
    SENDER="dacracot@birding.local"
    SUBJECT="Copy of HEARD from $HOSTNAME at "
    echo -e "${MAILBODY}" | mailx -S smtp=SMTP.gmail.com:25 -s "${SUBJECT} ${WHEN}" -r ${SENDER} ${RECIPIENTS}
    echo "the end"
echo "=============="
} >> emailHeard.out 2>> emailHeard.err
#!/bin/bash
# ---------------------------------------------------
# remove barchart scripts from cron if there
crontab -l 2>/dev/null | grep -v "${BARCHART_HOME}" | crontab -
echo "crontab cleared"
# ---------------------------------------------------

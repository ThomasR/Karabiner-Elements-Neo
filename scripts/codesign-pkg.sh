#!/bin/bash

CODESIGN_IDENTITY='D497CAAC851FC0B463D7D33B87D09CF169C6B3CD'

# ------------------------------------------------------------
PATH=/bin:/sbin:/usr/bin:/usr/sbin; export PATH

if [ ! -e "$1" ]; then
    echo "[ERROR] Invalid argument: '$1'"
    exit 1
fi

# ------------------------------------------------------------
# sign
logfile="`dirname $0`/productsign.log"
if 1>"$logfile" 2>&1 productsign --sign "$CODESIGN_IDENTITY" "$1" "$1".signed; then
    cat $logfile
    mv "$1".signed "$1"
else
    echo -ne '\033[31;40m'
    cat $logfile
    echo -ne '\033[0m'
fi
rm -f "$logfile"
rm -f "$1".signed

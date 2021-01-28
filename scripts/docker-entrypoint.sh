#!/bin/sh
set -e

if [ "$1" = 'backup' ]; then
    exec "/scripts/backup.sh"
    exit
fi

if [ "$1" = 'run' ]; then
    mcrcon -H $RCON_SERVER -P $RCON_PORT -p $RCON_PASS $2
    exit
fi

echo "Run an arbitrary RCON command:"
echo "   Usage: docker run futuralogic/mcrcon {cmd}"
echo ""
echo "Backup a server:"
echo "Usage: docker run -e {see below} -v {see below} futuralogic/mcrcon backup"
echo ""
echo "ENV:"
echo "   RCON_SERVER=servername"
echo "   RCON_PORT=50000"
echo "   RCON_PASS=pass"
echo "   MC_WORLD=myworld"
echo ""
echo "VOL:"
echo "   /data/from = bind to world folder you want backed up"
echo "   /data/to   = bind to destination folder you want the ZIP file placed in"
#!/bin/sh

WORLD=$MC_WORLD
CWD=/data/from
BACKUP_FROM=.
BACKUP_TO=/data/to
BACKUP_FILENAME="${WORLD}-backup-$(date '+%F-%H-%M-%S').zip"

MC_SERVER=$RCON_SERVER
MC_RCON_PORT=$RCON_PORT
MC_RCON_PWD=$RCON_PASS
KEEPDAYS=$KEEP_DAYS

echo "Switching to world folder"
cd $CWD

echo "Disabling MC automatic save"
# First, disable auto-save
mcrcon -H $MC_SERVER -P $MC_RCON_PORT -p $MC_RCON_PWD save-off

echo "Running MC force save"
# Save
mcrcon -H $MC_SERVER -P $MC_RCON_PORT -p $MC_RCON_PWD save-all

echo "Creating ZIP archive of world snapshot"
zip -r -dc -9 $BACKUP_TO/$BACKUP_FILENAME $BACKUP_FROM -x cache/ cache/*

echo "Renabling MC automatic save"
# Re-enable auto save
# Save
mcrcon -H $MC_SERVER -P $MC_RCON_PORT -p $MC_RCON_PWD save-on

# Cleaning up files older than X days
echo "Cleaning up backups older than $KEEPDAYS days"
let KEEPMIN=$KEEPDAYS*1440 # minutes in a day times number of days
find /data/to/$WORLD-backup* -maxdepth 0 -mmin +$KEEPMIN -delete

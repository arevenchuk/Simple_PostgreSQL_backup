#!/bin/bash

BACKUP_DIR="`pwd`/`date +%F_%H-%M`"
PSQL="psql -At postgres"

mkdir $BACKUP_DIR
if [ $? != 0 ]; then exit 1; fi

echo "`date` Backup configuration files:"
echo "[config]" >> $BACKUP_DIR/.backup.history
(echo "SHOW config_file; SHOW ident_file; SHOW hba_file;"|$PSQL)|
while read fn; do
 cd ${fn%/*}
 tar -rf $BACKUP_DIR/config_files.tar ${fn##*/} &&
 echo $fn >> $BACKUP_DIR/.backup.history;
 echo "`date` $fn"
done

exit 0

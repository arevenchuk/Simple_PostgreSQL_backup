#!/bin/bash

BACKUP_DIR="`pwd`/`date +%F_%H-%M`"
PSQL="psql -At postgres"
TAR="tar -rf"

mkdir $BACKUP_DIR
if [ $? != 0 ]; then exit 1; fi

# Add to backup files: postgresql.conf, pg_hba.conf, pg_ident.conf
echo "`date` Backup configuration files:"
echo "[config]" >> "$BACKUP_DIR"/.backup.history
# (echo "SHOW config_file; SHOW ident_file; SHOW hba_file;"|$PSQL)|
# while read fn; do
for fn in $(echo "SHOW config_file; SHOW ident_file; SHOW hba_file;"|$PSQL) do
 cd ${fn%/*}
 $TAR "$BACKUP_DIR"/config_files.tar ${fn##*/} &&
 echo $fn >> "$BACKUP_DIR"/.backup.history;
 echo "`date` $fn"
done

exit 0


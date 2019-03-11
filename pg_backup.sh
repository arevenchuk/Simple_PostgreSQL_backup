#!/bin/bash

PSQL="psql -At postgres"
tar -cvf zz.tar $(echo "SHOW config_file; SHOW ident_file; SHOW hba_file;"|$PSQL) 2>/dev/null
exit 0

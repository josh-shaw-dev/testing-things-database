#!/bin/bash

# run the setup script to create the DB
# do this in a loop because the timing for when the SQL instance is ready is indeterminate

QUERY="IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = '${DB_DATABASE}') BEGIN CREATE DATABASE ${DB_DATABASE} EXEC sp_defaultdb 'sa', '${DB_DATABASE}' END"
echo "Attempting to run query: ${QUERY}"

for i in {1..60};
do
    /opt/mssql-tools/bin/sqlcmd -S $DB_HOST -U sa -P $DB_PASSWORD -d master -Q "${QUERY}"
    if [ $? -eq 0 ]
    then
        echo "setup completed"
        break
    else
        echo "not ready yet..."
        sleep 1
    fi
done

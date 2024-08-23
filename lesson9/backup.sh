#!/bin/bash
TIMESTAMP=$(date +"%F_%H-%M-%S")
BACKUP_DIR="/opt/mysql_backup"
DATABASE="mydatabase"
mysqldump $DATABASE > $BACKUP_DIR/$DATABASE-$TIMESTAMP.sql


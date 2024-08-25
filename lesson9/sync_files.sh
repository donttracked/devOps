#!/bin/bash

SOURCE_DIR="/opt/mysql_backup/"
DEST_USER="store"
DEST_HOST="192.168.2.86"
DEST_DIR="/opt/store/mysql"

# Команда rsync
rsync -avz --delete "$SOURCE_DIR" "$DEST_USER@$DEST_HOST:$DEST_DIR"

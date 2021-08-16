#!/bin/bash

cp -Rp /var/lib/mysql-container /data/mysql
cp -Rp /var/lib/mysql-files-container /data/mysql-files
echo "Copied mysql files to shared directory"

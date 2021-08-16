DATETIME=`date +%Y%m%d-%H%M%S`
echo $DATETIME
HOST=`hostname`;
echo $HOST;
cd /backups/
mkdir /backups/
chmod 777 /backups/

for I in $(mysql -u root -e 'show databases' -s --skip-column-names);
  do
  echo $I;
  mysqldump --lock-all-tables --add-drop-table -u root $I > "/backups/mysql-$HOST-$I-$DATETIME.sql";
  gzip /backups/mysql-$HOST-$I-$DATETIME.sql
done

#!/bin/bash

DIR=/backups
DATABASES=(student-progress keycloak)

if [ ! -d "$DIR" ];
   then
       echo "Backup directory $DIR doesn't exist, creating it now!"
       mkdir $DIR
fi

for db in "${DATABASES[@]}"
do
  echo "Backing up $db"
  DBDIR="$DIR/$db"

  if [ ! -d "$DBDIR" ];
    then
      echo "Backup db directory $DBDIR doesn't exist, creating it now!"
      mkdir $DBDIR
  fi

  cd $DBDIR
  docker exec postgres-db pg_dump $db -U timodb -W > $(date +%Y%m%d_%H%M%S)-$db.bak
  echo "Done backup up $db"
done

echo "Going to put files to cloud"
rclone copy /backups drive:Backups/home-server-1/postgres

echo "Done uploading!"

rm -rf $DIR

echo "Removed backup dir"

echo "Done backing up"
exit 0

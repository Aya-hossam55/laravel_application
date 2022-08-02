#!/bin/bash

## Mention your database container name

container_name=db

## Mention your mysql root password

mysql_root_password=your_mysql_root_password

## Mention database name

dbname=laravel

echo "starting db backup"

day="$(date +'%A')"


docker exec $container_name mysqldump -u root -p$mysql_root_password $dbname > $dbname-$day.sql && tar -zcvf $dbname-$day.tar.gz $dbname-$day.sql && rm $dbname-$day.sql && echo "$dbname-$day.tar.gz has been created on `date`" >> database_backup.log

echo "backup completed"

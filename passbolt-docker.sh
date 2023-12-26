#!/bin/bash

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "This script for create a backup of docker passbolt passwords"
    echo "Usage: $0 database_container_name passbolt_container_name /path/to/save/dump/ /path/to/python/script/main.py /path/to/yandex/folder"
    exit 0
fi

if [ "$#" -ne 5 ]; then
    echo "Error: not enough arguments."
    echo "Usage: $0 database_container_name passbolt_container_name /path/to/save/dump/ /path/to/python/script/main.py /path/to/yandex/folder"
    exit 1
fi



# End script when cath error
set -e

database_container_name=$1
passbolt_container_name=$2
path_to_save_dump=$3
path_to_python_file=$4
yandex_folder=$5

docker exec -i $database_container_name bash -c \
'mysqldump -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE}' \
> $path_to_save_dump/backup.sql

docker cp $passbolt_container_name:/etc/passbolt/gpg/serverkey_private.asc \
    $path_to_save_dump/serverkey_private.asc

docker cp $passbolt_container_name:/etc/passbolt/gpg/serverkey.asc \
    $path_to_save_dump/serverkey.asc

current_datetime=$(date +"%Y-%m-%d_%H-%M-%S")

cd $path_to_save_dump

archive_name=passbolt_dump_${current_datetime}

tar -czf $archive_name  serverkey.asc serverkey_private.asc backup.sql && rm serverkey.asc serverkey_private.asc backup.sql

echo "Backup succesfull created!"

directory_path_python_file="$(dirname "$path_to_python_file")"

cd $directory_path_python_file

source venv/bin/activate

python3 $path_to_python_file ${path_to_save_dump}$archive_name $yandex_folder


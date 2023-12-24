#!/bin/bash

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "This script for create dump of docker postgres database."
    echo "Usage: $0 container_name database_name database_user /path/to/save/dump/ /path/to/python/script/main.py /path/to/yandex/folder"
    exit 0
fi

if [ "$#" -ne 6 ]; then
    echo "Error: not enough arguments."
    echo "Usage: $0 container_name database_name database_user /path/to/save/dump/ /path/to/python/script/main.py /path/to/yandex/folder"
    exit 1
fi

# End script when cath error
set -e

container_name=$1
database_name=$2
database_user=$3
path_to_save_dump=$4
path_to_python_file=$5
yandex_folder=$6


docker exec $container_name sh -c "pg_dump -U $database_user $database_name > /tmp/postgres.sql"
docker cp $container_name:/tmp/postgres.sql $path_to_save_dump
docker exec $container_name sh -c "rm /tmp/postgres.sql"

current_datetime=$(date +"%Y-%m-%d_%H-%M-%S")

cd $path_to_save_dump

archive_name=postgres_dump_${current_datetime}

tar -czf $archive_name  postgres.sql && rm postgres.sql

echo "Backup succesfull created!"

directory_path_python_file="$(dirname "$path_to_python_file")"

cd $directory_path_python_file

source venv/bin/activate

python3 $path_to_python_file ${path_to_save_dump}$archive_name $yandex_folder


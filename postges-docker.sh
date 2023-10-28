#!/bin/bash

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "This script for create dump of docker postgres database."
    echo "Usage: $0 container_name database_name database_user path_to_save_dump path_to_python_file"
    exit 0
fi

if [ "$#" -ne 5 ]; then
    echo "Error: need two arguments: 'container_name', 'path_to_save_dump' and 'database_name'"
    echo "Usage: $0 container_name database_name database_user path_to_save_dump path_to_python_file"
    exit 1
fi

# End script when cath error
set -e

container_name=$1
database_name=$2
database_user=$3
path_to_save_dump=$4
path_to_python_file=$5



docker exec $container_name sh -c "pg_dump -U $database_user $database_name > /tmp/postgres.sql"
docker cp $container_name:/tmp/postgres.sql $path_to_save_dump
docker exec $container_name sh -c "rm /tmp/postgres.sql"

current_datetime=$(date +"%Y-%m-%d_%H-%M-%S")

cd $path_to_save_dump

tar -czf dump_${current_datetime}  postgres.sql

echo "Backup succesfull created!"

$path_to_python_file dump_${current_datetime} /publicdictionary_backup


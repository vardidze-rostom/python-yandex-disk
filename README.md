# python-yandex-disk
Program for upload files to Yandex Disk.
### Note:
Yandex can slow down upload speed when you try to upload files with that extensions:
```
data (.db, .dat, etc.)

compressed (.zip, .gz, .tgz, .rar, .etc)

video (.3gp, .mp4, .avi, etc.)
```
And you will get Timeout Exeption.

To fix the issue, just rename your file without an extension and upload.

# Run Python script:
### 1. Create Python environment in the same folder where is the python script and activate:
```bash
python3 -m venv venv

source venv/bin/activate
```

### 2. Install requirements:
```bash
pip3 install -r requirements.txt
```

### 2. Specifi your Yandex Disk token in environment variable YANDEX_DISK_TOKEN 

### 3. Add permission to run the file: 
```bash
chmod +x main.py
```

### 4. Run the program: 
```bash
./main.py file_to_upload /folder_in_yandex_disk
```

# Run bash scripts:
## postgres-docker:
### 1. Add permission to run the file:
```bash
chmod +x postges-docker.sh 
```
### 2. Run the script:
```bash
./postges-docker.sh container_name database_name database_user /path/to/save/dump/ /path/to/python/script/main.py /path/to/yandex/folder
```
**Note:** This bash script creates archives without extensions for uploading to Yandex Disk. In fact, the archives have extensions **.sql.tar.gz** .

You can create Crontab job for upload backups any time you need. Here is example to upload backups at 23:00 on day-of-month 1:
```bash
0 23 1 * * YANDEX_DISK_TOKEN=here_is_your_token /path/to/postges-docker.sh postgres_container_name database_name database_user /path/to/save/dump/ /path/to/main.py /path/to/folder/in/yandex >> /path/to/save/logs/logfile.log 2>&1
```

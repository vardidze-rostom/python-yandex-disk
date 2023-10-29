# python-yandex-disk
Program for upload files to Yandex Disk.
### Note:
Yandex can Slow down upload speed when you try to upload files with that extensions:
```
data (.db, .dat, etc.)

compressed (.zip, .gz, .tgz, .rar, .etc)

video (.3gp, .mp4, .avi, etc.)
```
And you will get Timeout Exeption.

To fix the issue, just rename your file without an extension and upload.

# Run Python script:
### 1. Create Python environment and activate:
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


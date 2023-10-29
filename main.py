import yadisk
from os import environ, path
from argparse import ArgumentParser


if __name__ == "__main__":
    parser = ArgumentParser(description="Python script for upload files to Yandex Disk.")

    parser.add_argument('file', type=str, help='The file to need upload.')
    parser.add_argument('folder', type=str, help='Full path to folder in Yandex Disk to upload the file. \
                        Filesystem in Yandex Disk Like in Linux, start with "/".')

    args = parser.parse_args()

    file_path_with_name = args.file
    folder_path = args.folder

    token = environ.get("YANDEX_DISK_TOKEN")
    if token is None:
        print("Environment of Yandex Disk token is not defined. Please define 'YANDEX_DISK_TOKEN' environment variable.")
        exit(-1)

    y = yadisk.YaDisk(token=token)

    if y.check_token():
        print("Token is valid")
    else:
        print("Token is not valid")
        exit(-1)

    filename = path.basename(file_path_with_name)

    y.upload(f"{file_path_with_name}", f"{folder_path}/{filename}")

    print(f"{file_path_with_name} successfully uploaded!")

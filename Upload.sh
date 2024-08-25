#!/bin/bash
#ThEeLxD192 - Victor Hugo
#Script to upload saves to google drive

path=$1
folder=$2
route_drive=$3
route="$path/$folder"

upload_to_drive() {
    (cd "$route" && zip -r "$folder.zip" * > /dev/null 2>&1)
    rclone copy "$route/$folder.zip" "$route_drive/"
    rm "$route/$folder.zip"
}

main() {
    if zip -v > /dev/null 2>&1 && rclone version > /dev/null 2>&1; then
        upload_to_drive
    else
        echo "Need to have zip and rclone"
    fi
}

if ping -c 1 -W 5 8.8.8.8 > /dev/null 2>&1; then
    if [[ -n $folder && -n $path && -n $route_drive ]]; then
        main
    else
        echo "You need to put a path, folder and drive route from where upload"
    fi
else
    echo "No internet conection."
fi
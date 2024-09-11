#!/bin/bash
#ThEeLxD192 - Victor Hugo
#Script to download saves from google drive

path=$1
folder=$2
route_drive=$3
route="$path/$folder"

download_from_drive() {
    if [ -f "$route.txt" ]; then
        if grep -q "Internet Error" "$route.txt"; then
            echo "Before have a internet error, nothing to sync."
        fi
    else
        if rclone lsf "$route_drive/$folder.zip" > /dev/null 2>&1; then
            rclone copy "$route_drive/$folder.zip" "$path"
            unzip -o "$route.zip" -d "${route%.zip}" > /dev/null 2>&1
            rm "$route.zip"
        else
            echo "Drive doesn't have saves to download."
        fi
    fi
}

main() {
    if unzip -v > /dev/null 2>&1 && rclone version > /dev/null 2>&1; then
        download_from_drive
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
#!/bin/bash
#ThEeLxD192 - Victor Hugo
#Script to Sync saves between devices

#Important this script to sync saves from google drive 
#downloaded data is from google drive and this override
#your local files if this is necesary, this script only
#need to be run when turn on that device you need to sync
#no when you finish to play.

#If google drive files are empty this script will upload your local files.

route=$1
route_drive=$2

merge_files() {
    rclone copy "$route_drive/" "$route"
    zips=$(find "$route" -name "*.zip")
    IFS=$'\n' read -r -d '' -a zip_array <<< "$zips"
    for i in "${zip_array[@]}"
    do
        unzip -o "$i" -d "${i%.zip}" > /dev/null 2>&1
        rm "$i"
    done
    folders=$(ls "$route")
    upload_to_drive "$folders"
}

upload_to_drive() {
    folders=$1
    for i in $folders
    do
        (cd "$route/$i" && zip -r "$i.zip" * > /dev/null 2>&1 && mv "$i.zip" "$route")
        rclone copy "$route/$i.zip" "$route_drive/"
        rm "$route/$i.zip"
    done
}

check_files() {
    drive_folders=$(rclone lsf "$route_drive/")
    if [[ -n $drive_folders ]]; then
        merge_files
    else
        upload_to_drive "$1"
    fi
}

download_from_drive() {
    drive_folders=$(rclone lsf "$route_drive/")
    if [[ -n $drive_folders ]]; then
        rclone copy "$route_drive/" "$route"
        zips=$(find "$route" -name "*.zip")
        IFS=$'\n' read -r -d '' -a zip_array <<< "$zips"
        for i in "${zip_array[@]}"
        do
            unzip "$i" -d "${i%.zip}" > /dev/null 2>&1
            rm "$i"
        done
    else
        echo "Drive dont have folders, nothing to sync."
    fi
}

main() {
    if zip -v > /dev/null 2>&1 && rclone version > /dev/null 2>&1 && unzip -v > /dev/null 2>&1; then
        folders=$(ls "$route")
        if [[ -n $folders ]]; then
            check_files "$folders"
        else
            download_from_drive
        fi
    else
        echo "Need to have zip, unzip and rclone"
    fi
}

if ping -c 1 -W 5 8.8.8.8 > /dev/null 2>&1; then
    if [[ -n $route && -n $route_drive ]]; then
        main
    else
        echo "You need to put a route and drive route where your saves are"
    fi
else
    echo "No internet conection."
fi
#!/bin/bash
#ThEeLxD192 - Victor Hugo
#File to always sync when emulator open and close

emulator_route=$(dirname "$0") # <--- This can be renplaced with route where emulator is.
route_scripts=""
route_saves=""
folder=""
route_drive=""

#Script to donwload
"$route_scripts/Download.sh" "$route_saves" "$folder" "$route_drive"

#Emulator
"$emulator_route/DuckStation-x64.AppImage" # <--- This is the emulator .AppImage, executable, etc.

#Script to upload
"$route_scripts/Upload.sh" "$route_saves" "$folder" "$route_drive"

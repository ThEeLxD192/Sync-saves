# Sync saves
This repository help you to have sync your saves games from emulator between devices, this can be use to sync more kind or files, example saves from steam games  what doesn't have cloud save (example: Dark Souls 3, Spelunky, etc)

### Prerequisites
You need the following installed to be use in console, you can check if you have using commands like zip -v.
- zip (zip -v)
- unzip (unzip -v)
- rclone (rclone version)

### Usage
clone this repository in your favorite folder
- git clone https://github.com/ThEeLxD192/Sync-emulator-saves.git

locate Emulator_example.sh make a copy of it, open it and change this things
- emulator_route=$(dirname "$0") <---- You need to change this if your emulator are in different folder that your .sh.
- route_scripts="" <---- This has to be your route where you clone this repository. (example: /home/scripts/)
- route_saves="" <----  This is where are your or where will be your saves. (example: /home/saves/)
- folder="" <----  This is what is the name of your save from this emulator or game. (example: PS1)
- route_drive="" <---- This is the route what your configure from your drive and rclone. (example: emulator:Saves without /)
- "$script_dir/DuckStation-x64.AppImage" <---- You need to remplace this for your emulator or game.

when you finish copy it to another folder and change name to whatever for example DuckStaion .sh

you can change this script or make a new one, this thing do the following:
- first download your saves from google drive and put into the folder you specific.
- second open a emulator after before process finish.
- third when user close its emulator upload your save to google drive.

### Things to do
- Make scripts or change it to make it work in windows
- Make a script/s to automatic generate .sh without make a copy from the Emulator_example.sh
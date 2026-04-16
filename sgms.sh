#!/bin/bash

#initial setup 
DB_DIR="./sgms_data"
if [ ! -D "$BD_DIR"];
then 
    mkdir "$BD_DIR"
fi
#source helpers file
source ./lib/helpers.sh


#source validation file
source ./lib/validate.sh

#source main file
source ./modules/main_menu.sh
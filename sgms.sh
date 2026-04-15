#!/bin/bash

#initial setup 
DB_DIR="./sgms_data"
if [ ! -D "$BD_DIR"];
then 
    mkdir "$BD_DIR"
fi

source ./modules/main_menu.sh
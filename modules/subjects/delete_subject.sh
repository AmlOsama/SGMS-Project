#!/bin/bash

read -p "Enter the Subject ID: " sub_code
#current IDs
if [[ -f "$TABLE_DATA_PATH/$sub_code.sub" ]];
then
    printSubject $TABLE_DATA_PATH/$sub_code.sub
    read -p "Are you sure ? y/n" flag
    if [[ $flag == "y" || $flag == "Y" ]]
    then
        rm -f $TABLE_DATA_PATH/$sub_code.sub
        echo "Subject was deleted"
        read -rp "Press Enter to continue..."
    fi
else
    echo "Subject with this code doesn't exist"
    read -rp "Press Enter to continue..."

fi


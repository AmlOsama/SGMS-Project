#!/bin/bash

read -p "Enter the student ID: " stu_id
#current IDs
if [[ -f "$TABLE_DATA_PATH/$stu_id.stu" ]];
then
    printStudent $TABLE_DATA_PATH/$stu_id.stu
    read -p "Are you sure ? y/n" flag
    if [[ $flag == "y" || $flag == "Y" ]]
    then
        rm -f $TABLE_DATA_PATH/$stu_id.stu
        echo "Student was deleted"
        read -rp "Press Enter to continue..."
    fi
else
    echo "Student with this id doesn't exist"
    read -rp "Press Enter to continue..."

fi


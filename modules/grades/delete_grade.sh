#!/bin/bash
clear
read -p "Enter the Subject ID: " sub_code
read -p "Enter the Student ID: " stu_id
#current IDs

FILEPATH=$TABLE_DATA_PATH/$sub_code.grd
if [[ -f "$FILEPATH" ]];
then
    cat $FILEPATH
    target_student=0
    target_student=$( awk -F"|" -v student_id="$stu_id" ' $1 == student_id {print NR}' $FILEPATH )
    if [[ $target_student == 0 ]]
    then
        echo "Target student not found"
    else
        read -p "Are you sure ? y/n" flag
        if [[ $flag == "y" || $flag == "Y" ]]
        then
            sed -i "${target_student}d" $FILEPATH
            echo "Target student deleted"
        else
            echo "Student deletion skipped"
        fi
    fi
    read -rp "Press Enter to continue..."
else
    echo "Target subject grades doesn't exist"
    read -rp "Press Enter to continue..."
fi


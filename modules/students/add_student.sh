#!/bin/bash
#IDstu One file per student — ID, Name, Email,Year
clear
NEWFILE=''
#student id insertion
while true ;
do
    id_flag="false";
    read -p "Enter new student ID: " stu_id
    if [[ -z $stu_id || $( validateNum $stu_id ) == "false" ]]
    then 
        echo "Invalid input, Please enter only numeric values"
        continue ;
    fi
    #current IDs
    if [[ -f "$TABLE_DATA_PATH/$stu_id.stu" ]];
    then
        echo "Duplicate key, please provide unique key"
        id_flag="true"
        continue;
    fi
    if [[ "$id_flag" == "false" ]];
    then
        NEWFILE="$TABLE_DATA_PATH/$stu_id.stu"
        touch "$NEWFILE"
        echo "$stu_id" >> "$NEWFILE"
        break;
    fi
done
#student name insertion
while true ;
do
    read -p "Enter new student Name: " stu_name
    if [[ -z $stu_name || $( validateName $stu_name ) == "false" ]]
    then 
        echo "Invalid input, Please enter only Characters  values"
        continue ;
    fi
    echo "$stu_name" >> "$NEWFILE"
    break;
done
#student Email insertion
while true ;
do
    read -p "Enter new student Email: " stu_email
    if [[ -z $stu_email || $( validateEmail $stu_email ) == "false" ]]
    then 
        echo "Invalid input, Please enter a valid email "
        continue ;
    fi
    echo "$stu_email" >> "$NEWFILE"
    break;
done
#student Year insertion
while true ;
do
    read -p "Enter new student Year: " stu_year
    if [[ -z $stu_year || $( validateYear $stu_year ) == "false" ]]
    then 
        echo "Invalid input, Please enter a valid email "
        continue ;
    fi
    echo "$stu_year" >> "$NEWFILE"
    break;
done

echo "-----------------------------------"
echo "Success: New record inserted."
echo "New Student Added: $stu_id $stu_name  $stu_email $stu_year"
echo "-----------------------------------"
echo ""
read -rp "Press Enter to continue..."
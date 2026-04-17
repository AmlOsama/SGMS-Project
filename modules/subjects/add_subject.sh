#!/bin/bash
#IDstu One file per Subject — Code, Name, Credits
clear
NEWFILE=''
#Subject code insertion
while true ;
do
    id_flag="false";
    read -p "Enter new Subject Code: " sub_code
    if [[ -z $sub_code || $( validateCode $sub_code ) == "false" ]]
    then 
        echo "Invalid input, e.g. CS101, MATH203"
        continue ;
    fi
    #current Codes
    if [[ -f "$TABLE_DATA_PATH/$sub_code.sub" ]];
    then
        echo "Duplicate key, please provide unique Code"
        id_flag="true"
        continue;
    fi
    if [[ "$id_flag" == "false" ]];
    then
        NEWFILE="$TABLE_DATA_PATH/$sub_code.sub"
        touch "$NEWFILE"
        echo "$sub_code" >> "$NEWFILE"
        break;
    fi
done
#Subject name insertion
while true ;
do
    read -p "Enter new Subject Name: " sub_name
    if [[ -z $sub_name ]]
    then 
        echo "Invalid input, Subject name cant be empty"
        continue ;
    fi
    echo "$sub_name" >> "$NEWFILE"
    break;
done
#Subject Credits insertion
while true ;
do
    read -p "Enter new Subject Credits: " sub_credits
    if [[ -z $sub_credits || $( validateCredits $sub_credits ) == "false" ]]
    then 
        echo "Invalid input, Please enter a valid credits [1-6] "
        continue ;
    fi
    echo "$sub_credits" >> "$NEWFILE"
    break;
done

echo "-----------------------------------"
echo "Success: New record inserted."
echo "New Subject Added: $sub_code $sub_name  $sub_credits"
echo "-----------------------------------"
echo ""
read -rp "Press Enter to continue..."
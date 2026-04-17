#!/bin/bash
clear
read -p "Enter the Subject ID: " sub_code
#current IDs
if [[ -f "$TABLE_DATA_PATH/$sub_code.sub" ]];
then
    printSubject $TABLE_DATA_PATH/$sub_code.sub
    FILEPATH=$TABLE_DATA_PATH/$sub_code.sub
    #Subject name Reinsertion
    while true ;
    do
        read -p "Enter new Subject Name : " sub_name
        if [[ -z $sub_name ]]
        then 
            echo "Invalid input, Subject name cant be empty"
            continue ;
        fi
        sed -i "2s/.*/$sub_name/" "$FILEPATH"
        break;
    done
    #Subject Credits insertion
    while true ;
    do
        read -p "Enter new Subject Credits: " sub_credits
        if [[ -z $sub_credits || $( validateCredits $sub_credits ) == "false" ]]
        then 
            echo "Invalid input, Please enter a valid credits [1-7] "
            continue ;
        fi
        sed -i "3s/.*/$sub_credits/" "$FILEPATH"
        break;
    done

    echo "-----------------------------------"
    echo "Success: New record inserted."
    echo "New Subject Added: $sub_code $sub_name  $sub_credits"
    echo "-----------------------------------"
    echo ""
    read -rp "Press Enter to continue..."
else
    echo "Subject with this code doesn't exist"
    read -rp "Press Enter to continue..."

fi


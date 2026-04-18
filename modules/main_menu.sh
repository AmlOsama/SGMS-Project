#!/bin/bash

PS3=$'\nChoose an option [1,2,3,....]: '
while true;
do
clear
    echo "======================================"
    echo "============ Main Menu ==============="
    echo "======================================"
    select choice in "Manage Students" "Manage Subjects" "Manage Grades" "Reports & Statistics" "Exit"
    do
    case $choice in
    "Manage Students")
    source ./modules/students/students_menu.sh
    break
    ;;
    "Manage Subjects")
    source ./modules/subjects/subjects_menu.sh
    break
    ;;
    "Manage Grades")
    source ./modules/grades/grades_menu.sh
    break
    ;;
    "Reports & Statistics")
    source ./modules/reports/reports_menu.sh
    break
    ;;
    "Exit")echo "Goodbye!"; exit 0 ;;
    *) 
        echo "Invalid option." 
            ;;
    esac
    done
done
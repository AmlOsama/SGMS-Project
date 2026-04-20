#! /bin/bash

source ./modules/students/add_student.sh
source ./modules/students/list_students.sh
source ./modules/students/update_student.sh
source ./modules/students/search_student.sh
source ./modules/students/delete_student.sh

PS3=$'\nChoose an option [1,2,3,....]: '
while true
do
    clear
    echo "======================================"
    echo "============ Students Menu ==============="
    echo "======================================"
    select option in "Add Student" "List Students" "Update Student"  "Delete Student" "Back to Main Menu"
    do
        case $option in
            "Add Student")
               add_stu
                break
                ;;
            "List Students")
                list_stu
                break
                ;;
            "Update Student")
                update_stu
                break
                ;;
            
            "Delete Student")
                delete_stu
                break
                ;;
            "Back to Main Menu")
                return
                ;;
            *)
                echo "Invalid option. Please choose a number between 1 and 6."
                ;;
        esac
    done
done
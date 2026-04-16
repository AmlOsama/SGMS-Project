#!/bin/bash

function delete_stu {

    # check if any students exist
    local files=("$DB_DIR/students/"*.stu)
    if [ ! -f "${files[0]}" ]
    then
        echo "No students found"
        read -p "Press Enter to continue..."
        return
    fi
    while true
    do
        read -p "Enter student id to delete: " id

        if [[ ! $id =~ ^[0-9]{1,10}$ ]]
        then
            echo "Invalid student id. Please enter a numeric id with up to 10 digits."
            continue
        fi

        if [ ! -f "$DB_DIR/students/$id.stu" ]
        then
            echo "Student with id $id not found!"
            continue
        fi

        break
    done

    #show student info before delete
    local student_file="$DB_DIR/students/$id.stu"

    name=$(sed -n '2p' "$student_file")
    email=$(sed -n '3p' "$student_file")
    year=$(sed -n '4p' "$student_file")

    echo "========================================="
    echo "  Student found:"
    echo "========================================="
    echo "║  ID    : $id"
    echo "║  Name  : $name"
    echo "║  Email : $email"
    echo "║  Year  : $year"
    echo "-----------------------------------------"

    #confirm before delete
    while true
    do
        read -p "Are you sure you want to delete this student? (y/n): " confirm

        case $confirm in
            y|Y)
                rm "$student_file"

                # Delete grades from ALL .grd files
                for grade_file in "$DB_DIR/grades/"*.grd
                do
                    if [ -f "$grade_file" ]
                    then
                        sed -i "/^$id|/d" "$grade_file"
                    fi
                done

                echo ""
                echo "Student '$name' (ID: $id) deleted successfully!"
                break
                ;;
            n|N)
                echo "Delete cancelled."
                break
                ;;
            *)
                echo "Please enter y or n"
                ;;
        esac
    done

    read -p "Press Enter to continue..."
}
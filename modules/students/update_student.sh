#!/bin/bash

function update_stu {
clear
    local files=("$DB_DIR/students/"*.stu)
    if [ ! -f "${files[0]}" ]
    then
        echo "No students found!"
        read -p "Press Enter to continue..."
        return
    fi

    while true
    do
        read -p "Enter student ID to update: " id

        if [[ ! $id =~ ^[0-9]{1,10}$ ]]
        then
            echo "Invalid student ID. Please enter a numeric ID."
            continue
        fi

        local student_file="$DB_DIR/students/$id.stu"
        if [ ! -f "$student_file" ]
        then
            echo "Student with ID $id not found!"
            continue
        fi

        break
    done

    current_name=$(sed -n '2p' "$student_file")
    current_email=$(sed -n '3p' "$student_file")
    current_year=$(sed -n '4p' "$student_file")

    echo ""
    echo "========================================="
    echo "  Current Student Information:"
    echo "========================================="
    echo "  ID    : $id"
    echo "  Name  : $current_name"
    echo "  Email : $current_email"
    echo "  Year  : $current_year"
    echo "========================================="

# update fields one by one
    #user presses enter to keep current value)
    
    echo ""
    echo "Update Fields (Press Enter to skip):"
    echo "========================================="


    while true
    do
        read -p "Enter new name (or press Enter to keep '$current_name'): " new_name

        
        if [ -z "$new_name" ]
        then
            new_name=$current_name
            echo "Keeping name: $current_name"
            break
        fi
        first_name=$(echo "$new_name" | awk '{print $1}')
        last_name=$(echo "$new_name" | awk '{print $2}')
        word_count=$(echo "$new_name" | wc -w)

        if [ "$word_count" -ne 2 ]
        then
            echo "  Error: Enter exactly first and last name!"
        elif [ ${#first_name} -lt 2 ]
        then
            echo "  Error: First name must be at least 2 characters!"
        elif [ ${#last_name} -lt 2 ]
        then
            echo "  Error: Last name must be at least 2 characters!"
        else
            echo "  → Updating name to: $new_name"
            break
        fi
    done

  #email─
    while true
    do
        read -p "Enter new email (or press Enter to keep '$current_email'): " new_email

   
        if [ -z "$new_email" ]
        then
            new_email=$current_email
            echo "  Keeping email: $current_email"
            break
        fi

        if ! [[ "$new_email" =~ ^[^@]+@[^@]+\..+$ ]]
        then
            echo "  Error: Invalid email format!"
        else
            echo "  Updating email to: $new_email"
            break
        fi
    done
    while true
    do
        read -p "Enter new year (or press Enter to keep '$current_year'): " new_year

        if [ -z "$new_year" ]
        then
            new_year=$current_year
            echo "   Keeping year: $current_year"
            break
        fi

        
        if ! [[ "$new_year" =~ ^[1-6]$ ]]
        then
            echo "  Error: Year must be between 1 and 6!"
        else
            echo "  Updating year to: $new_year"
            break
        fi
    done

   
    echo "$id" > "$student_file"
    echo "$new_name" >> "$student_file"
    echo "$new_email" >> "$student_file"
    echo "$new_year" >> "$student_file"

    echo ""
    echo "========================================="
    echo "Student updated successfully!"
    echo "========================================="
read -p "Press Enter to continue..."
}

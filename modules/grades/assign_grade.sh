#!/bin/bash


function assign_grade() {
    clear
    #id check for stu
    local stu_files=("$DB_DIR/students/"*.stu)
    if [ ! -f "${stu_files[0]}" ]
    then
        echo "No students found! Please add students first."
        read -p "Press Enter to continue..."
        return
    fi

    #course files check
    local sub_files=("$DB_DIR/subjects/"*.sub)
    if [ ! -f "${sub_files[0]}" ]
    then
        echo "No subjects found! Please add subjects first."
        read -p "Press Enter to continue..."
        return
    fi

    echo "==========================================="
    echo "        Assign Grade to Student          "
    echo "==========================================="

    local student_id
    while true
    do
        read -p "Enter Student ID: " student_id
        if [[ ! $student_id =~ ^[0-9]{1,10}$ ]]
        then
            echo "Error: Student ID must be numeric (up to 10 digits)!"
            continue
        elif ! validate_student_exists "$student_id"
        then
            echo "Error: Student ID doesn't exist !"
            continue  
        else
            break
        fi
    done
##############
    # Get subject code + validate
    local code
    while true
    do
        read -p "Enter Subject Code: " code
        if [[ ! $code =~ ^[a-zA-Z]{2,5}[0-9]{2,4}$ ]]
        then
            echo "Invalid input, e.g. CS101, MATH203"
            continue
        elif ! validate_subject_exists "$code"
        then
            echo "Error: Subject ID doesn't exist !"
        continue  
        else
            break
        fi
    done

#############

    if grade_already_exists "$student_id" "$code"
    then
        echo "Error: Grade already exists for this student in '$code'!"
        echo "Use 'Update Grade' instead."
        read -p "Press Enter to continue..."
    else
    #-------------
    #get score
    local score
    while true
        do
            read -p "Enter Score (0.0 - 100.0): " score
            #check formatinteger or float
            if [[ ! $score =~ ^[0-9]+(\.[0-9]+)?$ ]]
            then
                echo "Error: Score must be a number (e.g.,85 or 85.5)!"
                continue
            fi
            #check range 
            local in_range=$(awk -v s="$score" 'BEGIN {
                if (s >= 0 && s <= 100) print 1
                else print 0
            }')

            if [ "$in_range" -ne 1 ]
            then
                echo "Error: Score must be between 0.0 and 100.0!"
                continue
            fi

            break
        done

    ###########
    local letter=$(convert_score_to_letter "$score")
    #add to grade file
    local grade_file="$DB_DIR/grades/$code.grd"
    echo "$student_id|$score|$letter" >> "$grade_file"

    echo ""
        echo "==========================================="
        echo "     Grade Assigned Successfully!        "
        echo "==========================================="
        echo "New Grade Added: $student_id | $score | $letter"
        echo "==========================================="
        read -p "Press Enter to continue..."
    fi

}

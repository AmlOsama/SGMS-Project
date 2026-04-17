#!/bin/bash

source ./grade_validate.sh

function assign_grade {
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


    while true
    do
        read -p "Enter Student ID: " id
        if [[ ! $id =~ ^[0-9]{1,10}$ ]]
        then
            echo "Error: Student ID must be numeric (up to 10 digits)!"
            continue
        fi

        if ! validate_student_exists "$id"
        then
            continue  
        fi
        break
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
            fi

            if ! validate_subject_exists "$code"
            then
                continue  
            fi
            break
    done

#############

if grade_already_exists "$id" "$code"
        then
            echo "Error: Grade already exists for this student in '$code'!"
            echo "Use 'Update Grade' instead."
            continue
        fi

        break
    done


#-------------
#get score
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
#get stu name abnd sub code for confirmation 
    local student_name=$(sed -n '2p' "$DB_DIR/students/$id.stu")
    local subject_name=$(sed -n '2p' "$DB_DIR/subjects/$code.sub")

echo ""
    echo "==========================================="
    echo "     Grade Assigned Successfully!        "
    echo "==========================================="
    echo "  Student : $student_id - $student_name"
    echo "  Subject : $subject_code - $subject_name"
    echo "  Score   : $score"
    echo "  Letter  : $letter"
    echo "==========================================="
    read -p "Press Enter to continue..."

}
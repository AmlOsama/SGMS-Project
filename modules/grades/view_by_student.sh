#!/bin/bash
source ./modules/grades/grade_validate.sh

function view_grades_by_student()
{
    clear
    #validate student exists
    local stu_file=("$DB_DIR/students/"*.stu)
   if [ ! -f "${stu_files[0]}" ]
    then
        echo "No students found!"
        read -p "Press Enter to continue..."
        return
    fi
    #get id 
    local id=""
    while true 
    do 
    read -p "Enter student ID: " id
    if ! validate_student_exists "$id"
        then
            continue
        fi

        break
    done




    #get the name of student
    local name=$(sed -n "2p" "$DB_DIR/students/$id.stu")

    echo ""
    echo " ===================================================="
    echo " Total grades for student: $name (ID: $id)"
    echo " ===================================================="
    echo "Course Name (Code) | Score | Letter Grade"
    echo "------------------------------------------------------"


    local total_points=0
    local count=0
    local found_any=0

    # Loop through all grade files and display grades for the student
    for grade_file in "$DB_DIR/grades/"*.grd
    do
    if [ ! -f "$grade_file" ]
    then
        continue
    fi
    #search for the id in grade file
    local line=$(grep "^$id|" "$grade_file")

    #check if the student in this subject
    if [ -z "$line" ]
    then
        continue  
    fi

    #extract data from the line
    local s_id=$(echo "$line" | cut -d'|' -f1)
    local score=$(echo "$line" | cut -d'|' -f2)
    local letter=$(echo "$line" | cut -d'|' -f3)

    #extract subject code from grade file name
    sub_code=$(echo "$grade_file" | cut -d'/' -f3 | cut -d'.' -f1)

    #get subject name  
    local sub_name="[DELETED SUBJECT]"
    if [ -f "$DB_DIR/subjects/$sub_code.sub" ]
        then
            sub_name=$(sed -n '2p' "$DB_DIR/subjects/$sub_code.sub")
        fi


    echo "$sub_name ($sub_code) | $score | $letter"

    #total points
    local points=$(letter_to_points "$letter")

        total_points=$(awk -v t="$total_points" -v p="$points" 'BEGIN { print t + p }')
        count=$((count + 1))
        found_any=1
    echo "------------------------------------------------------"

    done
   if [ "$found_any" -eq 0 ]
    then
        echo " No grades recorded for this student yet."
    else
        local gpa=$(awk -v t="$total_points" -v c="$count" 'BEGIN { printf "%.2f", t/c }')
        echo " Total Subjects: $count"
        echo " GPA: $gpa"
    fi

    echo "============================================================"
    read -p "Press Enter to continue..."

}
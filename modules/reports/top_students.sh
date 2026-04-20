#!/bin/bash
source ./modules/grades/grade_validate.sh

function top_students_by_gpa {
    clear

   #validate student exists
    local stu_files=("$DB_DIR/students/"*.stu)
   if [ ! -f "${stu_files[0]}" ]
    then
        echo "No students found!"
        read -p "Press Enter to continue..."
        return
    fi
       
    # if any grades exist
    local grade_files=("$DB_DIR/grades/"*.grd)
    if [ ! -f "${grade_files[0]}" ]
    then
        echo "No grades recorded yet!"
        read -p "Press Enter to continue..."
        return
    fi

    echo "Calculating GPAs for all students..."
    echo ""

  
    #temp file for sorting
    local temp_file=$(mktemp)

    # gpa for each student
    for stu_file in "$DB_DIR/students/"*.stu
    do
        local id=$(sed -n '1p' "$stu_file")
        local name=$(sed -n '2p' "$stu_file")

        local gpa=$(calculate_student_gpa "$id")

      
        if [ "$gpa" == "0.00" ]
        then
            continue
        fi

        #Save 
        echo "$gpa|$id|$name" >> "$temp_file"
    done

    # check if anyone has grades
    if [ ! -s "$temp_file" ]
    then
        echo "No students with grades found!"
        rm -f "$temp_file"
        read -p "Press Enter to continue..."
        return
    fi


    #sort by top gpa
    
    local sorted_file=$(mktemp)
    sort -t'|' -k1 -nr "$temp_file" > "$sorted_file"

    echo "============================================="
    echo " Top Students by GPA"
    echo "============================================="
    echo  "Rank" "ID" "Name" "GPA"
    echo "---------------------------------------------"

    local rank=1
    while IFS='|' read -r gpa id name
    do
        echo "$rank" "$id" "$name" "$gpa"
        rank=$((rank + 1))
    done < "$sorted_file"

    echo "============================================="


    # clean temporary files
    rm -f "$temp_file" "$sorted_file"

    read -p "Press Enter to continue..."
}
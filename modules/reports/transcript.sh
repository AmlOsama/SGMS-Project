#!/bin/bash

source ./modules/grades/grade_validate.sh 

function student_transcript() {
    clear
    local stu_files=("$DB_DIR/students/"*.stu)
    if [ ! -f "${stu_files[0]}" ]
    then
        echo "No students found!"
        read -p "Press Enter to continue..."
        return
    fi
    local student_id=""
    while true
    do
        read -p "Enter Student ID: " student_id
        
        if ! validate_student_exists "$student_id"
        then
            continue
        fi
        break
    done
    
    # student info
    local student_file="$DB_DIR/students/$student_id.stu"
    local stu_id=$(sed -n '1p' "$student_file")
    local stu_name=$(sed -n '2p' "$student_file")
    local stu_email=$(sed -n '3p' "$student_file")
    local stu_year=$(sed -n '4p' "$student_file")

    echo ""
    echo "════════════════════════════════════════════════════════"
    echo "                   Student Transcript"
    echo "════════════════════════════════════════════════════════"
    echo "Student Name:   $stu_name"
    echo "Student ID:     $stu_id"
    echo "Email:          $stu_email"
    echo "Academic Year:  $stu_year"
    echo "════════════════════════════════════════════════════════"
    echo "Subject Code" "Subject Name" "Score" "Letter" "GPA Pts"
    echo "────────────────────────────────────────────────────────"
    
    local total_score=0
    local total_gpa_points=0
    local subject_count=0
    local found_any=0
 
    for grade_file in "$DB_DIR/grades/"*.grd
    do
        if [ ! -f "$grade_file" ] || [ ! -s "$grade_file" ]
        then
            continue
        fi
        
        #search the student i need
        local line=$(grep "^$student_id|" "$grade_file")
        
        if [ -z "$line" ]
        then
            continue
        fi
        
        local score=$(echo "$line" | cut -d'|' -f2)
        local letter=$(echo "$line" | cut -d'|' -f3)
        
        #get sub code from filename
        sub_code=$(echo "$grade_file" | cut -d'/' -f4 | cut -d'.' -f1)
        #  local sub_code="${grade_file##*/}" #cs50.grd
        # sub_code="${sub_code%.grd}" #cs50
        
        #sub name
        local sub_name="[DELETED SUBJECT]"
        if [ -f "$DB_DIR/subjects/$sub_code.sub" ]
        then
            sub_name=$(sed -n '2p' "$DB_DIR/subjects/$sub_code.sub")
        fi
        
        #letter to gpa points
        local gpa_points=$(letter_to_points "$letter")

        echo  "$sub_code" "$sub_name" "$score" "$letter" "$gpa_points"
    
        total_score=$(awk -v t="$total_score" -v s="$score" 'BEGIN { print t + s }')
        total_gpa_points=$(awk -v t="$total_gpa_points" -v p="$gpa_points" 'BEGIN { print t + p }')
        subject_count=$((subject_count + 1))
        found_any=1
    done
    
    echo "────────────────────────────────────────────────────────"
    

    #summary
  
    if [ "$found_any" -eq 0 ]
    then
        echo "No grades recorded for this student yet."
    else
        local avg_score=$(awk -v total="$total_score" -v count="$subject_count" 'BEGIN { printf "%.2f", total/count }')
        local overall_gpa=$(awk -v total="$total_gpa_points" -v count="$subject_count" 'BEGIN { printf "%.2f", total/count }')
        
        echo ""
        echo "  Summary:"
        echo "  Total Subjects:      $subject_count"
        echo "  Average Score:       $avg_score"
        echo "  Overall GPA:         $overall_gpa"
    fi
    
    echo "════════════════════════════════════════════════════════"
    read -p "Press Enter to continue..."
}


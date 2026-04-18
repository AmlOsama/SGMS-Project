#!/bin/bash
source ./modules/grades/grade_validate.sh


function view_by_subject {
    clear
    
    #if any sub exisists
    local sub_files=("$DB_DIR/subjects/"*.sub)
       if [ ! -f "${sub_files[0]}" ]
    then
        echo "No subjects found!"
        read -p "Press Enter to continue..."
        return
    fi

    #sub code
    while true
    do
        read -p "Enter sublect code : " sub_code

        if  ! validate_subject_exists "$sub_code"
        then
            continue    
        fi
        break
    done

    #if grade file exists

    local grade_file="$DB_DIR/grades/$sub_code.grd"
    if [ ! -f "$grade_file" ] || [ ! -s "$grade_file" ]
    then
        echo "No grades found for subject $sub_code!"
        read -p "Press Enter to continue..."
        return
    fi

    #get subject namefor display
    # $(sed -n '2p' "$DB_DIR/subjects/$subject_code.sub")
    local sub_name=$(awk 'NR==2' "$DB_DIR/subjects/$sub_code.sub")

    echo ""
    echo " ================================"
    echo " Grades for Subject: $sub_name ($sub_code)"
    echo " ================================"
    echo "ID |  Name | Score | Letter "
    echo "--------------------------------"
    

    #display the grades
    local total_score=0
    local count=0

    while IFS='|' read -r id score letter
    do
        #get student name
        local student_file="$DB_DIR/students/$id.stu"
        if [ -f "$student_file" ]
        then
          local name=$(sed -n '2p' "$student_file")
          else 
           local name="DELETED STUDENT"
        fi
    
    echo "$id | $name | $score | $letter"

    total_score=$(awk -v t="$total_score" -v s="$score" 'BEGIN { print t + s }')
    count=$((count + 1))
    done < "$grade_file"



    echo "--------------------------------"
       if [ "$count" -gt 0 ]
    then
        local average=$(awk -v t="$total_score" -v c="$count" 'BEGIN { printf "%.2f", t/c }')
        echo "  Total Students: $count"
        echo "  Average Score:  $average"
    fi
    # local average=$(awk -v t="$total_score" -v c="$count" 'BEGIN { if (c > 0) print t / c; else print 0 }')
    echo "================================"
    read -p "Press Enter to continue..."
}
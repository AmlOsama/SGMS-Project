#!/bin/bash



function convert_score_to_letter() {
    local score=$1

    local letter=$(awk -v s="$score" 'BEGIN {
    if (s >= 90) print "A+"
    else if (s >= 85) print "A"
    else if (s >= 80) print "A-"
    else if (s >= 75) print "B+"
    else if (s >= 70) print "B"
    else if (s >= 65) print "B-"
    else if (s >= 60) print "C+"
    else if (s >= 55) print "C"
    else if (s >= 50) print "C-"
    else if (s >= 45) print "D"
    else print "F"
}')

    echo "$letter"  

}

function letter_to_points {
    local letter=$1
    local points=0

    case $letter in
        "A+"|"A") points=4.0 ;;
        "A-")     points=3.7 ;;
        "B+")     points=3.3 ;;
        "B")      points=3.0 ;;
        "B-")     points=2.7 ;;
        "C+")     points=2.3 ;;
        "C")      points=2.0 ;;
        "C-")     points=1.7 ;;
        "D")      points=1.0 ;;
        "F")      points=0.0 ;;
    esac

    echo "$points"
}

function validate_student_exists() {
    local student_id=$1
    if [ ! -f "$DB_DIR/students/$student_id.stu" ]
    then
        echo "Error: Student $student_id not found!"
        return 1
    fi
    return 0
}

function validate_subject_exists() {
    local subject_code=$1
    if [ ! -f "$DB_DIR/subjects/$subject_code.sub" ]
    then
        echo "Error: Subject $subject_code not found!"
        return 1
    fi
    return 0
}


function grade_already_exists() {
    local student_id=$1
    local subject_code=$2
    local grade_file="$DB_DIR/grades/$subject_code.grd"

    if [ ! -f "$grade_file" ]
    then
        return 1
    fi

    if grep -q "^${student_id}|" "$grade_file"
    then
        return 0   
    else
        return 1   
    fi
}



function calculate_student_gpa {
    local student_id=$1
    local total_points=0
    local count=0
    for grade_file in "$DB_DIR/grades/"*.grd
    do
        #skip if no .grd 
        if [ ! -f "$grade_file" ]
        then
            continue
        fi
        local line=$(grep "^$student_id|" "$grade_file")
        if [ -z "$line" ]
        then
            continue
        fi
        #extract letter grade
        local letter=$(echo "$line" | cut -d'|' -f3)
        #convert letter to GPA points
        local points=$(letter_to_points "$letter")
        total_points=$(awk -v t="$total_points" -v p="$points" 'BEGIN { print t + p }')
        count=$((count + 1))
    done
    if [ "$count" -eq 0 ]
    then
        echo "0.00"
    else
        awk -v t="$total_points" -v c="$count" 'BEGIN { printf "%.2f", t/c }'
    fi
}


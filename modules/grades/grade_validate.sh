#!/bin/bash



function convert_score_to_letter() {
    local score=$1

    #comarisson of floating point 
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

function validate_student_exists() {
    local student_id=$1
    if [ ! -f "$DB_DIR/students/$student_id.stu" ]
    then
        echo "Error: Student $student_id not found!"
        return 1
    fi
    return 0
}

function validate_subject_exists {
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

    #if file exists first 
    if [ ! -f "$grade_file" ]
    then
        return 1   
    fi

    #  line starting with student_id| exists
    # if grep "^$student_id|" "$grade_file" > /dev/null
    if grep -q "^$student_id|" "$grade_file"
    then
    return 0  
    else
    return 1   
    fi
}
#!/bin/bash
clear
read -p "Enter the Subject ID: " sub_code
read -p "Enter the Student ID: " stu_id
#current IDs

FILEPATH=$TABLE_DATA_PATH/$sub_code.grd
if [[ -f "$FILEPATH" ]];
then
    cat $FILEPATH
    target_student=0
    target_student=$( awk -F"|" -v student_id="$stu_id" ' $1 == student_id {print NR}' $FILEPATH )
    if [[ $target_student == 0 ]]
    then
        echo "Target student not found"
    else
        while true
        do
            read -p "Enter New Score (0.0 - 100.0): " score
            #check format integer or float
            if [[ ! $score =~ ^[0-9]+(\.[0-9]+)?$ ]]
            then
                echo "Error: Score must be a number (e.g.,85 or 85.5)!"
                continue
            fi
            #check range 
            in_range=$(awk -v s="$score" 'BEGIN {
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

        letter=$(convert_score_to_letter "$score")
        #add to grade file
        sed -i "${target_student}s/.*/'$student_id|$score|$letter'/" $FILEPATH

        echo ""
        echo "==========================================="
        echo "     Grade Updated Successfully!        "
        echo "==========================================="
        echo "New Grade Added: $student_id | $score | $letter"
        echo "==========================================="
    fi
    read -rp "Press Enter to continue..."
else
    echo "Target subject grades doesn't exist"
    read -rp "Press Enter to continue..."

fi


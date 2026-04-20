#!/bin/bash
source ./modules/grades/grade_validate.sh

function failing_students {
    clear

    local grade_files=("$DB_DIR/grades/"*.grd)
    if [ ! -f "${grade_files[0]}" ]
    then
        echo "No grades recorded yet!"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo "============================================================"
    echo " Failing Students Report (Score < 44)"
    echo "============================================================"
    echo "ID" "Name" "Subject" "Score" "Letter"
    echo "------------------------------------------------------------"

    local failing_count=0

    for grade_file in "$DB_DIR/grades/"*.grd
    do
        if [ ! -f "$grade_file" ]
        then
            continue
        fi

       
        # sub_code=$(echo "$grade_file" | cut -d'/' -f3 | cut -d'.' -f1) #hard coded
        local sub_code="${grade_file##*/}"    
        sub_code="${sub_code%.grd}"

        #get sub name
        local sub_name="[DELETED SUBJECT]"
        if [ -f "$DB_DIR/subjects/$sub_code.sub" ]
        then
            sub_name=$(sed -n '2p' "$DB_DIR/subjects/$sub_code.sub")
        fi

        while IFS='|' read -r id score letter
        do
            #if score < 44 (failing)
            local is_failing=$(awk -v s="$score" 'BEGIN { 
                if (s < 44) print 1
                else print 0 
            }')

            if [ "$is_failing" -eq 1 ]
            then
                local stu_name="[DELETED STUDENT]"
                if [ -f "$DB_DIR/students/$id.stu" ]
                then
                    stu_name=$(sed -n '2p' "$DB_DIR/students/$id.stu")
                fi

              
                 echo "$id" "$stu_name" "$sub_code" "$score" "$letter"

                failing_count=$((failing_count + 1))
            fi
        done < "$grade_file"
    done

   
    echo "------------------------------------------------------------"

    if [ "$failing_count" -eq 0 ]
    then
        echo "No failing students! Everyone is passing!"
    else
        echo " Total Failing Records: $failing_count"
    fi

    echo "============================================================"
    read -p "Press Enter to continue..."
}
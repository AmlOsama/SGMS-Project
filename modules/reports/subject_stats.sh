#!/bin/bash

source ./modules/grades/grade_validate.sh

clear

#if any subject exists
sub_files=("$DB_DIR/subjects/"*.sub)
if [ ! -f "${sub_files[0]}" ]
then
    echo "No subjects found!"
    read -p "Press Enter to continue..."
    return
fi

read -p "Enter subject code : " sub_code
grade_file="$DB_DIR/grades/$sub_code.grd"

if [ ! -f "$grade_file" ]
then
    echo "No grades found for subject $sub_code!"
    read -p "Press Enter to continue..."
    return
fi
    
awk -F"|" '
    BEGIN{
        total = 0
        high = -1
        low = 101
        pass_count = 0
        fail_count = 0
        }
    {
        total+=$2
        if ( $2 < low)
            low = $2;
        if ( $2 > high)
            high = $2
        if ( $2 >= 50 )
            pass_count++
        else 
            fail_count++
    }
    END{
        avg = (NR > 0) ? total / NR : 0
        print("============================================") 
        print("Statistics for: Programming (CS101)")  
        print("============================================") 
        print("Total Students:   " NR) 
        print("Highest Score:    "high) 
        print("Lowest Score:     "low) 
        print("Average Score:    "avg) 
        print("Pass Count:       " pass_count) 
        print("Fail Count:       " fail_count) 
        print("============================================") 
    }
' "$grade_file"
read -p "Press Enter to continue..."
return

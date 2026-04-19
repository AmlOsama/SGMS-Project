#!/bin/bash

while true;
do
clear
    echo "======================================"
    echo "============ Reports Menu ==========="
    echo "======================================"
    select choice in "Student Transcript + GPA" "Subject Statistics" "Top Students by GPA" "Failing Students Report" "Full Grade Matrix" "Back to Main Menu"
    do
    case $choice in
    "Student Transcript + GPA")
    source ./modules/reports/transcript.sh
    break
    ;;
    "Subject Statistics")
    source ./modules/reports/subject_stats.sh
    break
    ;;
    "Top Students by GPA")
    source ./modules/reports/top_students.sh
    break
    ;;
    "Failing Students Report")
    source ./modules/reports/failing_report.sh
    break
    ;;
    "Full Grade Matrix")
    source ./modules/reports/grade_matrix.sh
    break
    ;;
    "Back to Main Menu")
    source ./modules/main_menu.sh
    ;;
    esac
    done
done

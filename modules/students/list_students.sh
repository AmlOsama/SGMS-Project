#!/bin/bash

clear
echo "==========================="
echo "List of available students."
current_students=$( ls $TABLE_DATA_PATH )
for student in $current_students
do
    printStudent $TABLE_DATA_PATH/$student
done
echo "==========================="
echo ""
read -rp "Press Enter to continue..."

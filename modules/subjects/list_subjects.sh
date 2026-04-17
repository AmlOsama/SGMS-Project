#!/bin/bash

clear
echo "==========================="
echo "List of available Subjects."
current_subjects=$( ls $TABLE_DATA_PATH )
for subject in $current_subjects
do
    printSubject $TABLE_DATA_PATH/$subject
done
echo "==========================="
echo ""
read -rp "Press Enter to continue..."

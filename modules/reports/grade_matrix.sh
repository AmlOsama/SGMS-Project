
#!/bin/bash

clear
# Validate student exists

grade_files=("$DB_DIR/grades/"*.grd)
if [ ! -f $grade_files ]
then
    echo "No Grades yet!"
    read -p "Press Enter to continue..."
    return
fi
student_files=("$DB_DIR/students/"*.stu)
subjects_files=("$DB_DIR/subjects/"*.sub)
#loop over all students files 
subjects=''
for subject in "${subjects_files[@]}"
do
    subjects+="| "
    subjects+=$(awk 'NR==2' "$subject")
done
    echo "=============================================="
    echo "Full Grade Matrix"
    echo "=============================================="
{
echo "Student          $subjects"
for student in "${student_files[@]}"
do
    student_name=$(awk 'NR==2' "$student") 
    student_id=$(awk 'NR==1' "$student") 
    grades=""
    for subject in "${subjects_files[@]}"
    do
        sub_code=$(basename "$subject" .sub)
        grade='-'
        grade_file="$DB_DIR/grades/$sub_code.grd"
        if [[ ! -f $grade_file ]]
        then
            grades+="| $grade "
            continue
        fi
        grade=$(awk -F"|" -v id=$student_id '$1 == id{print $3}' $grade_file )
        grades+="| $grade "
    done
    echo "$student_name $grades"
done
} | column -t -s '|' 
# used ai to get a way to enhance table view (the same logic bur enhanced table view)
echo "=============================================="
read -p "Press Enter to continue..."
return


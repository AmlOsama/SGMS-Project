#!/bin/bash
function list_stu {
    
    # check the existance of student files
    local files=("$DB_DIR/students/"*.stu)
    if [ ! -f "${files[0]}" ]
    then
        echo "No students found!"
        read -p "Press Enter to continue..."
        return
    fi

    local count=0

    echo "==============================================="
    echo "║            Student List                      ║"
    echo "================================================"

    for file in "$DB_DIR/students/"*.stu
    do
       
        id=$(sed -n '1p' "$file")   #= id
        name=$(sed -n '2p' "$file")  # name
        email=$(sed -n '3p' "$file")   # email
        year=$(sed -n '4p' "$file")    # year
        count=$((count + 1))

        echo "║  Student #$count "                               
        echo "║  ID    : $id"
        echo "║  Name  : $name"
        echo "║  Email : $email"
        echo "║  Year  : $year"
        echo "-----------------------------------------------"
    done

    echo "║  Total Students: $count                      ║"
    echo "================================================="

    read -p "Press Enter to continue..."


  
}

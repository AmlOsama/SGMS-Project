
TABLE_DATA_PATH="$DB_DIR/students"

while true;
do
clear
    echo "======================================"
    echo "============ Students Menu ==========="
    echo "======================================"
    select choice in "Add Student" "List Students" "Update Student" "Delete Student" "Exit"
    do
    case $choice in
    "Add Student")
    source ./modules/students/add_student.sh
    break
    ;;
    "List Students")
    source ./modules/subjects/list_students.sh
    break
    ;;
    "Update Student")
    source ./modules/grades/update_student.sh
    break
    ;;
    "Delete Student")
    source ./modules/reports/delete_student.sh
    break
    ;;
    "Exit")
    Exit 0
    ;;
    esac
    done
done

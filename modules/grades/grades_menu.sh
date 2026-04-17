
TABLE_DATA_PATH="$DB_DIR/grades"

while true;
do
clear
    echo "======================================"
    echo "============ Grades Menu ==========="
    echo "======================================"
    select choice in "Assign Grade to Student" "Update Existing Grade" "Delete a Grade" "View Grades by Subject" "View Grades by Student" "Exit"
    do
    case $choice in
    "Assign Grade to Student")
    source ./modules/grades/assign_grade.sh
    break
    ;;
    "Update Existing Grade")
    source ./modules/grades/update_grade.sh
    break
    ;;
    "Delete a Grade")
    source ./modules/grades/delete_grade.sh
    break
    ;;
    "View Grades by Subject")
    source ./modules/grades/view_by_subject.sh
    break
    ;;
    "View Grades by Student")
    source ./modules/grades/view_by_student.sh
    break
    ;;
    "Back to Main Menu")
    source ./modules/main_menu.sh
    ;;
    esac
    done
done

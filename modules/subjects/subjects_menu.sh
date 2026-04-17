
TABLE_DATA_PATH="$DB_DIR/subjects"
source ./helper_functions.sh


while true;
do
clear
    echo "======================================"
    echo "============ Subjects Menu ==========="
    echo "======================================"
    select choice in "Add Subject" "List Subjects" "Update Subject" "Delete Subject" "Exit"
    do
    case $choice in
    "Add Subject")
    source ./modules/subjects/add_subject.sh
    break
    ;;
    "List Subjects")
    source ./modules/subjects/list_subjects.sh
    break
    ;;
    "Update Subject")
    source ./modules/subjects/update_subject.sh
    break
    ;;
    "Delete Subject")
    source ./modules/subjects/delete_subject.sh
    break
    ;;
    "Exit")
    Exit 0
    ;;
    esac
    done
done

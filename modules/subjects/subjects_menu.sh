
TABLE_DATA_PATH="$DB_DIR/subjects"
source ./modules/subjects/helper_functions.sh


while true;
do
clear
    echo "======================================"
    echo "============ Subjects Menu ==========="
    echo "======================================"
    select choice in "Add Subject" "List Subjects" "Update Subject" "Delete Subject" "Back to Main Menu"
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
    "Back to Main Menu")
    source ./modules/main_menu.sh
    ;;
    esac
    done
done

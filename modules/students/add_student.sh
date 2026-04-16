#! /usr/bin/bash

function add_stu {
    while true
    do
        #get stu id
        read -p "Enter student id : (make sure it's unique and up to 10 digits): " id

        #check the constraints of the id numeric and up to 10 digits
        if [[ ! $id =~ ^[0-9]{1,10}$ ]];
        then
            echo "Invalid student id. Please enter a unique numeric id with up to 10 digits."
            continue
        fi


        #validate is it unique or not
       if [ -f "$DB_DIR/students/$id.stu" ]
        then 
            echo "the id $id already exists please add a unique one"
            continue
        fi

        else 
        break


    done

    #get full name
    while true 
    do
        read -p "Enter Full Name (First Last): " full_name

        #name should be alphabetic and the first and last name should be at least 2 characters


        first_name=$(echo "$full_name" | awk '{print $1}')
        last_name=$(echo "$full_name" | awk '{print $2}')
        word_count=$(echo "$full_name" | wc -w)

        if [ -z "$full_name" ]
        then
            echo "error: Name cannot be empty!"
        elif [ "$word_count" -ne 2 ]
        then
            echo "error: Enter exactly first name and last name! example: omar osama"
        elif [ ${#first_name} -lt 2 ]
        then
            echo "error: first name must be at least 2 characters"
        elif [ ${#last_name} -lt 2 ]
        then
            echo "error: last name must be at least 2 characters"
        else
            break
        fi
    done

    #get email
      while true
      do
        read -p "Enter Email (e.g., user@domain.com): " email
       
        if ! [[ "$email" =~ ^[^@]+@[^@]+\..+$ ]]
         then
            echo "Invalid email format."
        else
            break
        fi
    done


    #acadimic year
    while true
    do
        read -p "enter academic year (1, 2, 3, 4,5,6): " acad_year
        if ! [[ "$acad_year" =~ ^[1-6]$ ]]
        then
            echo " academic year must be a number between 1 and 6"
        else
            break
        fi
    done


#load the stu data to the file
 stu_file="$DB_DIR/students/$id.stu"

    echo "$id" > "$stu_file"
    echo "$full_name" >> "$stu_file"
    echo "$email" >> "$stu_file"
    echo "$acad_year" >> "$stu_file"


    echo "-----------------------------------"
    echo "Student '$full_name' added successfully!"
    read -p "Press Enter to continue..."

}
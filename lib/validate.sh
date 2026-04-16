#!/bin/bash
validateNum(){
    if [[ "$1" =~ ^[0-9][0-9]*$ ]]
    then
        echo "true"
    else 
        echo "false"
    fi
}

validateName(){
    if [[ "$1" =~ ^[a-zA-Z[:space:]]+$ ]]
    then
        echo "true"
    else 
        echo "false"
    fi
}

validateEmail(){
    if [[ "$1" =~ ^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,6}$ ]]
    then
        echo "true"
    else 
        echo "false"
    fi
}

validateYear(){
    if [[ "$1" =~ ^[0-9]{4}$ ]]
    then
        echo "true"
    else 
        echo "false"
    fi
    
}
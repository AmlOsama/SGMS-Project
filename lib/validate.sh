#!/bin/bash
validateCode(){
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

validateCredits(){
    if [[ "$1" =~ ^[1-5]+$ ]]
    then
        echo "true"
    else 
        echo "false"
    fi
    
}
#!/bin/bash
validateCode(){
    if [[ "$1" =~ ^[a-zA-Z]{2,5}[0-9]{2,4}$ ]]
    then
        echo "true"
    else 
        echo "false"
    fi
}

validateCredits(){
    if [[ "$1" =~ ^[1-6]+$ ]]
    then
        echo "true"
    else 
        echo "false"
    fi
    
}
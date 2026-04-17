#!/bin/bash

printSubject(){
        awk '
        BEGIN{ print "===========================" }
        NR==1{ print "Code: " $0 }
        NR==2{ print "Name: " $0 }
        NR==3{ print "Credits: " $0 }
    ' $1
}
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
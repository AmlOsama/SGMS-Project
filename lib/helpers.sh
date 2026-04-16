#!/bin/bash

printStudent(){
        awk '
        BEGIN{ print "===========================" }
        NR==1{ print "ID: " $0 }
        NR==2{ print "Name: " $0 }
        NR==3{ print "Email: " $0 }
        NR==4{ print "Year: " $0 }
    ' $1
}
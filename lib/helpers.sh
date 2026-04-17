#!/bin/bash

printSubject(){
        awk '
        BEGIN{ print "===========================" }
        NR==1{ print "Code: " $0 }
        NR==2{ print "Name: " $0 }
        NR==3{ print "Credits: " $0 }
    ' $1
}
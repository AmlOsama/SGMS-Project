#!/bin/bash

# Initial setup
DB_DIR="./sgms_data"
# -p creates parent directories and doesn't error if they exist
mkdir -p "$DB_DIR/students"
mkdir -p "$DB_DIR/subjects"
mkdir -p "$DB_DIR/grades"

# load modules
source ./modules/main_menu.sh


main_menu

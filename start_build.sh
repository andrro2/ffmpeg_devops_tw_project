#!/bin/bash

if [ $# -gt 1 ]
then CHANGED_FILE=$1
else CHANGED_FILE="none"
fi

awk -f script.awk -v changed_file=$CHANGED_FILE makefile.txt
./script.sh

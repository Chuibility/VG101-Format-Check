#!/bin/bash

error=0

dirs=$(ls -l ./ |awk '/^d/ {print $NF}')
for dir in $dirs; do
    temp=$(echo $dir | grep "^ex[0-9][0-9]*$")
    if [ -n "$temp" ]; then
        echo Directory $dir detected!
        cd $dir
        files=$(ls ./)
        exfile=0
        for file in $files; do
            cfile=$(echo $file | grep "^$dir.c$")
            if [ -n "$cfile" ]; then
                echo C Source file $file found.
                exfile=1
            fi
            cxxfile=$(echo $file | grep "^$dir.cpp$")
            if [ -n "$cxxfile" ]; then
                echo C++ Source file $file found.
                exfile=1
            fi
        done
        if [ $exfile == 0 ]; then
            echo Error: No Source file found in $dir.
            error=1
        fi
        cd ..
    else
        echo Error: Directory $dir invalid.
        error=1
    fi
    echo
done

if [ $error == 0 ]; then
    echo Congratulations! All tests passed.
else
    echo Error found. Please check your files again!
fi

read -p "Press any key to continue."

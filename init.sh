#!/usr/bin/env bash

if [ "$#" -ne 1 ]
then
    echo "Error: too few or too many parameters"

elif [ -d  "$1" ]
    then
        echo "Error: user already exists."

    else
        ./P.sh "$1"
        echo "process locked"
        sleep 5

        mkdir "$1"
        echo "OK: user created"

        ./V.sh "$1"
        echo "process unlocked"

    fi
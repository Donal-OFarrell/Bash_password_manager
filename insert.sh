#!/bin/bash


user=$1
service=$2
payload=$4


directory=`dirname "$service"`
file=`basename "$service"`


if [ "$#" -ne 4 ]; then
        echo "Error: parameters problem"
        exit 1
elif [[ ! -d $user  ]]
        then
                echo "Error: the user does not exist "
                exit 2
        elif [[ -f "$user/$directory/$file" ]] && [ "$3" != "f" ]
                then
                        echo "Error: the service already exists"
                        exit 3
                else
                        ./P.sh "$user"
                        echo "process locked"
                        sleep 5

                        if [[ ! -d "$user/$directory" ]]; then
                                mkdir "$user/$directory"

        fi
        if [ -f "$user/$directory/$file" ] && [ "$3" = "f" ]
        then
                echo -e "$payload" > "$user/$directory/$file"
                echo "OK: service updated"
                ./V.sh "$user"
                echo "process unlocked"
        else
                echo -e "$payload" > "$user/$directory/$file"
                echo "OK: service created"

                ./V.sh "$user"
                echo "process unlocked"

        fi


fi
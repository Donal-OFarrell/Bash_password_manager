#!/bin/bash

user=$1
service=$2
directory=`dirname "$service"`
file=`basename "$service"`

if [ "$#" -ne 2 ]
then
	echo "Parameters problem"

elif [ ! -d "$user" ]
	then 
		echo "user does not exist"

	elif [ ! -f "$user/$service" ]
		then 
			echo "service does not exist"

		else
			./P.sh "$user"
			echo "process locked"
			sleep 5
			
			cd "$user/$directory"
			rm -r "$file"
			echo "OK: service removed"
			
			cd -
			./V.sh "$user"
			echo "process unlocked"
		fi
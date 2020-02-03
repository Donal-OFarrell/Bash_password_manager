#!/bin/bash


user=$1
service=$2
directory=`dirname "$service"`
file=`basename "$service"`
full_file_path="$user/$directory/$file"

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

       
	grep  "pass" "$full_file_path"
	grep  "login" "$full_file_path"

fi
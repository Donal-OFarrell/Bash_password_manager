#!/bin/bash

user=$1
folder=$2
directory=`dirname "$folder"`
file=`basename "$folder"`

if [ "$#" -lt 1  ] || [ "$#" -gt 2 ]
  then
    echo "Parameters problem"
    exit 1

elif [ ! -d "$user" ]
	then 
		echo "user does not exist"
		exit 2

elif [ ! -d "$user/$folder" ]
	then 
		echo "folder does not exist"
		exit 3 

else
	

	if [ "$#" = 1  ]
	then 
	cd "$user"
	tree


	else
		cd "$user/$folder"
		tree
	
	fi
fi
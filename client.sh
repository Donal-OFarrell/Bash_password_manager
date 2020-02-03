#!/bin/bash


client=$1
req=$2
id=$3
args=$4
directory=`dirname "$args"`
file=`basename "$args"`
service="$directory/$file"



if [ "$#" -lt 2 ] 
then
	echo "Error: too few parameters"
else 
	input=$req 
fi
case "$input" in
	init)
if [ "$#" -lt 3 ]
then
	echo "Error: parameter problem."	
	
else	
	mkfifo $client.pipe
	echo "$req" "$id" "$client" > server.pipe
	cat $client.pipe
	rm $client.pipe 
fi    
;; 
insert)	
if [ "$#" -lt 3 ]
then
	echo 'Error: parameter problem'
else
	
	mkfifo $client.pipe

	login_stem='\nlogin:'
	password_stem="password:"

	echo Please write login:
	read login
	echo Please write password:
	read password
	echo args
	echo "$args"
	echo service
	echo "$service"

	echo "$req" "$id" "$service" "$password_stem" "$password" "$login_stem" "$login" "$client"  > server.pipe
	cat $client.pipe
	rm $client.pipe
fi
;;

show)
if [ "$#" -lt 3 ]
then
	echo 'Error: parameter problem'
else
	mkfifo $client.pipe
	
	echo "$req" "$id" "$service" "$client" >  server.pipe  
	all_pass=$(cat "$client".pipe)
	field_2=$(echo $all_pass | cut -d ":" -f 2 )
	passw_=$(echo $field_2 | cut -d " " -f 1)
	login_=$(echo $all_pass | cut -d ":" -f 3 )
	echo "$id" login for "$service" is "$login_"
	echo "$id" password for "$service" is "$passw_"
	
	
	rm $client.pipe 
fi   
;;

ls) 
if [ "$#" -lt 2 ] 
then
	echo 'Error: parameter problem'
else
	mkfifo $client.pipe
	echo "$req" "$id" "$service" "$client" > server.pipe 	
	cat $client.pipe
	rm $client.pipe
fi 	
;; 
edit)
if [ "$#" -lt 3 ]
then
	echo 'Error: parameter problem.'
else	
	mkfifo $client.pipe
	echo "show" "$id" "$service" "$client" >  server.pipe
	content=$(cat $client.pipe)
	temp_file=$(mktemp)
	echo -e $content > "$temp_file"
	rm $client.pipe
	vi $temp_file
	mkfifo $client.pipe
	up_pass=$(grep "pass" "$temp_file")
	field_2_edit=$(echo $up_pass | cut -d " " -f 2)
	field_4_edit=$(echo $up_pass | cut -d " " -f 4)
		echo $field_2_edit #password
		echo $field_4_edit #login 
		
		login_stem_up='\nlogin:'
		password_stem_up="password:"
		
		echo "$payload"
		echo "update" "$id" "$service" "$password_stem_up" "$field_2_edit" "$login_stem_up" "$field_4_edit" "$client" > server.pipe
		cat $client.pipe
		
	fi    
	;; 
	rm)
if [ "$#" -lt 3 ]
then
	echo "Error: parameter problem"
else
	mkfifo $client.pipe
	echo "$req" "$id" "$service" "$client" > server.pipe
	cat $client.pipe
	rm $client.pipe
fi     
;;

shutdown)
if [ "$#" -lt 2 ]
then
	echo "Error: parameter problem."
else
	mkfifo "$client".pipe
	echo "$req" "$client" > server.pipe
	cat "$client".pipe
	rm "$client".pipe
fi    
;; 
*)
esac
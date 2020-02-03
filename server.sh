#!/bin/bash

while true; do
	mkfifo server.pipe
	read -r -a arr < server.pipe
	client_id="${arr[-1]}" #this will always be the last element passed
	unset arr[-1]
	test_1="${arr[@]:3}" # this represents the payload
	input="$(echo "${arr[0]}")" #this will always be req

	case "$input" in
		init) 
./init.sh "${arr[@]:1}" > "$client_id".pipe & 

rm server.pipe


;;
insert) 
./insert.sh "${arr[@]:1:2}" "space" "$test_1" > "$client_id".pipe & 
rm server.pipe            

;;
update)
./insert.sh "${arr[@]:1:2}" "f" "$test_1" > "$client_id".pipe &
rm server.pipe	  


;;
show)
rm server.pipe
./show.sh "${arr[1]}" "${arr[2]}" > "$client_id".pipe &
mkfifo server.pipe

;;

rm)
./rm.sh "${arr[1]}" "${arr[2]}" > "$client_id".pipe &   
rm server.pipe	 

;;
ls)
./ls.sh "${arr[1]}" "${arr[2]}" > "$client_id".pipe &
rm server.pipe	

;;
shutdown)
echo 'server shutdown' > "$client_id".pipe 
rm server.pipe
exit 0

;;
*)
echo "Error: bad request"
exit 1

esac
done
#!/bin/bash
clear
echo  "/000000  /00                                 /00      /00 /00           "
echo "/00__  00| 00                                | 000    /000|__/           "
echo "| 00  \__/| 0000000   /000000  /00   /00      | 0000  /0000 /00 /00   /00"
echo "| 00      | 00__  00 /00__  00|  00 /00/      | 00 00/00 00| 00|  00 /00/"
echo "| 00      | 00  \ 00| 00000000 \  0000/       | 00  000| 00| 00 \  0000/ "
echo "| 00    00| 00  | 00| 00_____/  >00  00       | 00\  0 | 00| 00  >00  00 "
echo "|  000000/| 00  | 00|  0000000 /00/\  00      | 00 \/  | 00| 00 /00/\  00"
echo " \______/ |__/  |__/ \_______/|__/  \__/      |__/     |__/|__/|__/  \__/"
echo "                    Proxy checker by FuelDaFlame/Eclipse                 "
                                                                                                                                            
if ! type "proxycheck" > /dev/null; then
	echo "It appears you are missing some dependencies, let me install them for you!"
	printf "Press any key to continue... "
        read
	sudo apt-get install proxycheck

	clear

	echo "Do you want to input a list or a single proxy?"
	printf "Type 'list' or 'single': "
	read -r input_type

	if [ "$input_type" = "list" ]
	then	
		printf "List: "
		read -r list
		printf "Output File: "
		read -r output_file
		clear
		echo "This could take a while, get some coffee... "
		proxycheck -vv -d 208.64.38.55:80 -c chat:send:expect -i $list 2>&1 | tee log.txt
		grep "(200)" log.txt 2>&1 | tee $output_file
		rm log.txt
		clear
		echo "Output stored to $output_file!"
	elif [ "$input_type" = "single" ]
	then
		printf "Host: "
		read -r host
		printf "Port: "
		read -r port
		clear
		proxycheck -vv $host:$port -c chat:send:expect -d 208.64.38.55:80
	else  
		echo "'$input_type' wasn't an option. Make sure you typed 'list' or 'single'. Remember, it is 			case sensitive "
	fi  
else
	echo "Do you want to input a list or a single proxy?"
	printf "Type 'list' or 'single': "
	read -r input_type

	if [ "$input_type" = "list" ]
	then
		printf "List: "
		read -r list
		printf "Output File: "
		read -r output_file
		clear
		echo "This could take a while, get some coffee... "
		proxycheck -vv -d 208.64.38.55:80 -c chat:send:expect -i $list 2>&1 | tee log.txt
		grep "(200)" log.txt 2>&1 | tee $output_file
		rm log.txt
		clear
		echo "Output stored to $output_file!"
	elif [ "$input_type" = "single" ] 
	then
		printf "Host: "
		read host
		printf "Port: "
		read port
		clear
		proxycheck -vv $host:$port -c chat:send:expect -d 208.64.38.55:80
	else  
		echo "'$input_type' wasn't an option. Make sure you typed 'list' or 'single'. Remember, it is 			case sensitive "
	fi  
fi

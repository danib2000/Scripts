#!/bin/bash

ipToPing=$1
exit=0
TTL=1

while [ $exit -eq 0 -a $TTL -ne 100 ] 
	do
		ping $ipToPing -t $TTL -c 1 > output.txt 
		rc=$?
		cat output.txt | grep icmp
		if [ $rc -eq 0 ]; then
			exit=1
			echo "finished!"
		fi 
		((TTL++))
	done
if [ $exit -eq 1 ] ; then                  # Make final determination.
	echo "found route to ${ipToPing}, it took ${TTL} jumps!"
else
    echo "say Timeout."
fi
rm output.txt


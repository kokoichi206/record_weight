#!/bin/sh
#
# Description
# 	1. Record weight and make a graph to local files
#	2. Post weight and graph to
# 		- Line
#		- twitter
# 
# Usage:
# 	./record_weight.sh <weight>
#

re='^[0-9]+([.][0-9]+)?$'
path_to_html="./graph/test.html"

if [[ $1 =~ $re ]]; then

	echo 'OK' > OK.txt

	# regard 764 as 76.4
	if [ $1 -gt 100 ]; then 
		weight=`echo "scale=1; $1/10"|bc`
	else
		weight=$1
	fi
	date=`date +%s`
	echo $date $weight >> weight.txt

	python3 tweet.py $weight

 	gnuplot weight_all_days.plt
	img = all_weight_from_1225.png
	python3 ./line/send.py $weight $img

	# update charts
	sed -i '.bak' -E "s@(data = \[(\[[0-9]*, [0-9]\.?[0-9]?\][,]?)+)@\1,[$date, $weight]@g" $path_to_html
	rm $path_to_html.bat
	## for linux
	# sed -i -E "s@(data = \[(\[[0-9]*, [0-9]\.?[0-9]?\][,]?)+)@\1,[$date, $weight]@g" $path_to_html

else
	echo "------- Usage: -------"
	echo "bash record_weight.sh <weight>"
fi

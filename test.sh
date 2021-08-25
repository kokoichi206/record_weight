#!/bin/sh

datee=42
weight=3.2
path_to_html="./graph/test.html"

date=`date +%s`
echo $date $weight 
sed -i '.bak' -E "s@(data = \[(\[[0-9]*, [0-9]\.?[0-9]?\][,]?)+)@\1,[$date, $weight]@g" $path_to_html
rm $path_to_html.bak
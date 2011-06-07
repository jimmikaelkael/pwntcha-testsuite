#!/bin/bash

if (($# < 2))
then
	echo "Usage: accuracy-test.sh <pwntcha binary> <pwntcha share>"
	exit
fi

numTests=0
for file in *.jpeg
do 
	$1 -s $2 $file >> results.txt
	let numTests=$numTests+1
done

diff control.txt results.txt | grep ">" > errors.txt

i=0
while read line
do
	let i=$i+1
done <errors.txt

rm results.txt >> /dev/null
rm errors.txt >> /dev/null

let accuracy=$numTests-$i
echo "Total accuracy: $accuracy/$numTests"


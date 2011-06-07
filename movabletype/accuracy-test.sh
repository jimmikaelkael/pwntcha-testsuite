#!/bin/bash

#for ((i=0; i<25; i++))
#do
#	wget http://www.yorkblog.com/mt/mt-comments.cgi/captcha/10/12Phows0Ts9Ym2Vsy80eq4GFf6MuKtZ8ThiFj64R
#	istr=`printf "%.3d" $i`
#	mv 12Phows0Ts9Ym2Vsy80eq4GFf6MuKtZ8ThiFj64R _templates/movabletype_$istr.png
#done

if (($# < 2))
then
	echo "Usage: accuracy-test.sh <pwntcha binary> <pwntcha share>"
	exit
fi

numTests=0
for file in *.png
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


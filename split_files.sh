#!/bin/bash
# https://stackoverflow.com/questions/29116212/split-a-folder-into-multiple-subfolders-in-terminal-bash-script
#! Rotate images 90 degrees counterclockwise
#!for szFile in ~/Downloads/IndoorDatasetJPG/*.jpg;
#!do    
#!	convert "$szFile" -rotate 270 ~/Downloads/IndoorDatasetJPG1/"$(basename "$szFile")";
#!done

# i is the iterator

dir_size=12
dir_name="IndoorDatasetJPG3"
n=$((`find . -maxdepth 1 -type f | wc -l`/$dir_size+1))
i_train=(0 2 3 5 6 8 9 11)
i_test=(1 4 7 10)

# First split the files into classes based on location (12 photos)
for i in `seq 1 $n`;
do
	mkdir -p ~/Downloads/"$dir_name"/"$i";
	chmod 777 ~/Downloads/"$dir_name"/"$i";
	find . -maxdepth 1 -type f | sort | head "-$dir_size" | xargs -i mv "{}" "$i";
	
	# Next split files into train and test
	cd ~/Downloads/"$dir_name"/"$i";
	mkdir -p ~/Downloads/"$dir_name"/"$i"/train;
	chmod 777 ~/Downloads/"$dir_name"/"$i"/train;
	mkdir -p ~/Downloads/"$dir_name"/"$i"/tests;
	chmod 777 ~/Downloads/"$dir_name"/"$i"/tests;
	iter=0;
 	for a in *.jpg;
	do
		if [[ " ${i_train[*]} " =~ " ${iter} " ]];
		then
			mv "$a" ~/Downloads/"$dir_name"/"$i"/train;
		else
			mv "$a" ~/Downloads/"$dir_name"/"$i"/tests;
		fi
		((iter++))
	done
	cd ~/Downloads/"$dir_name";
done


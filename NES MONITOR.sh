#!/bin/bash

while [ 1 ];
do
    count=`curl -s "http://www.urbanoutfitters.com/urban/catalog/search.jsp?q=Nintendo#/" | grep -c "NES Classic"`

    if [ "$count" != "0" ]
    then
       echo "
***************************************
*****URBAN OUTFITTERS HAS THE NES!*****
***************************************
" ;
        osascript -e 'display notification "THE NES IS UP" with title "NES MONITOR.SH"';
        open "http://www.urbanoutfitters.com/urban/catalog/search.jsp?q=Nintendo#/"
       exit 0
    else
	echo "Keep waiting"
    fi
    sleep 30
done

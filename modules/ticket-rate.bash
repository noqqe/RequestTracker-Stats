#!/bin/bash

date_count=01
while [ $date_count -le $(date +%m) ]; do

    mysql $stats_sqlopts -e "use \"$stats_database\" ; \
    SELECT COUNT(DISTINCT EffectiveID) AS Tickets \
    FROM Tickets \
    WHERE Created LIKE \"$(date +%Y)-$date_count%\" " | awk "{print \"$date_count:\"\$1}" | grep -v Tickets | $statistical_path

    ((date_count++))

    if [ $date_count -le 9 ]; then
        date_count=0$date_count
    fi

done 

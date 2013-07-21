#!/bin/bash
# ticket-rate: count tickets for each month
# Copyright: (C) 2011 Florian Baumann <flo@noqqe.de>
# License: GPL-3 <http://www.gnu.org/licenses/gpl-3.0.txt>
# Date: Tuesday 2011-04-12

date_count=1
while [ $date_count -le $(date +"%-m") ]; do

    if [ $date_count -le 9 ]; then
        count=0$date_count
    else
   count=$date_count
    fi

    mysql $stats_sqlopts -e "use $stats_database ; \
    SELECT COUNT(DISTINCT EffectiveID) AS Tickets \
    FROM Tickets \
    WHERE Created LIKE \"$(date +%Y)-$count%\" " | awk "{print \"$date_count:\"\$1}" | grep -v Tickets 

    ((date_count++))

done | $statistical_path

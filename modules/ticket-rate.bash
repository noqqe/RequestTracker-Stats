#!/bin/bash
# ticket-rate: count tickets for each month
# Copyright: (C) 2011 Florian Baumann <flo@noqqe.de>
# License: GPL-3 <http://www.gnu.org/licenses/gpl-3.0.txt>
# Date: Tuesday 2011-04-12

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

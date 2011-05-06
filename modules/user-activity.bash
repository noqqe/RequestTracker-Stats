#!/bin/bash
# user-activity: list a single activity chart for each user with tickets per month 
# Copyright: (C) 2011 Florian Baumann <flo@noqqe.de>
# License: GPL-3 <http://www.gnu.org/licenses/gpl-3.0.txt>
# Date: Tuesday 2011-04-12
echo
for user in $(mysql $stats_sqlopts -e "use $stats_database; SELECT DISTINCT Owner FROM Tickets WHERE Owner <> 6;" | grep -v ^Owner); do

    if [ $(mysql $stats_sqlopts  -e "use $stats_database; SELECT COUNT(DISTINCT EffectiveID) AS Tickets FROM Tickets WHERE Tickets.Owner=$user AND Status=\"resolved\" AND LastUpdated LIKE \"$(date +%Y)%\" GROUP BY Tickets.Owner;" | grep -v ^Tickets | wc -l) -ge 1 ]; then  

        date_count=01
     
        echo "$(mysql $stats_sqlopts -e "USE $stats_database; SELECT Name from Users WHERE id=$user" | grep -v ^Name ) "
        #echo "---------------------------------------------------"
    
        while [ $date_count -le $(date +%m) ]; do
            mysql $stats_sqlopts -e "use $stats_database; \
            SELECT COUNT(DISTINCT EffectiveID) AS Tickets FROM Tickets, Users \
            WHERE Tickets.Owner=Users.id \
            AND Status=\"resolved\" \
            AND Tickets.LastUpdated LIKE \"$(date +%Y)-$date_count%\" \
            AND Tickets.Owner=\"$user\" \
            GROUP BY Tickets.Owner;" | grep -v ^Tickets | awk "{print \"$date_count:\"\$1}" 

            ((date_count++))

            if [ $date_count -le 9 ]; then
                date_count=0$date_count
            fi 
        done | $statistical_path

        echo
    fi 
done 

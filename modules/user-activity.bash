#!/bin/bash

for user in $(mysql --user="$stats_dbuser" --password="$stats_dbpassword" --batch -e "use $stats_database; SELECT DISTINCT Owner FROM Tickets WHERE Owner <> 6;" | grep -v ^Owner); do

    if [ $(mysql --user="$stats_dbuser" --password="$stats_dbpassword" --batch -e "use $stats_database; SELECT COUNT(DISTINCT EffectiveID) AS Tickets FROM Tickets WHERE Tickets.Owner=$user AND Status=\"resolved\" AND LastUpdated LIKE \"$(date +%Y)%\" GROUP BY Tickets.Owner;" | grep -v ^Tickets | wc -l) -ge 1 ]; then  

    date_count=01
     
    echo "$(mysql --user="$stats_dbuser" --password="$stats_dbpassword" --batch -e "USE $stats_database; SELECT Name from Users WHERE id=$user" | grep -v ^Name ) "
    echo "---------------------------------------------------"
    
    while [ $date_count -le $(date +%m) ]; do
    mysql --user="$stats_dbuser" --password="$stats_dbpassword" --batch -e "use $stats_database; \
    SELECT COUNT(DISTINCT EffectiveID) AS Tickets FROM Tickets, Users \
    WHERE Tickets.Owner=Users.id \
    AND Status=\"resolved\" \
    AND Tickets.LastUpdated LIKE \"$(date +%Y)-$date_count%\" \
    AND Tickets.Owner=\"$user\" \
    GROUP BY Tickets.Owner;" | grep -v ^Tickets | awk "{print \"$date_count:\"\$1}" |$statistical_path

    ((date_count++))

    if [ $date_count -le 9 ]; then
        date_count=0$date_count
    fi 
    
    done
    
    echo
    
    fi 

done 

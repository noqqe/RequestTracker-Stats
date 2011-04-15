#!/bin/bash
mysql --user="$stats_dbuser" --password="$stats_dbpassword" --batch -e \
        "use \"$stats_database\" ;\
        SELECT COUNT(DISTINCT Tickets.EffectiveID) AS Tickets, Queues.Name \
        FROM Queues, Tickets \
        WHERE Tickets.Queue=Queues.id \
        AND Tickets.LastUpdated LIKE \"$(date +%Y-%m)%\" \
        GROUP BY Tickets.Queue \
        ORDER BY Tickets DESC; " | awk {'print $2":"$1'} | grep -v -e ^Name | $statistical_path

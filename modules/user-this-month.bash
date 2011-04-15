#!/bin/bash
mysql $stats_sqlopts -e "use \"$stats_database\" ; \
        SELECT COUNT(DISTINCT Tickets.EffectiveID) AS Tickets, Users.Name \
        FROM Tickets, Users \
        WHERE Tickets.Owner=Users.id \
        AND Tickets.LastUpdated LIKE \"$(date +%Y-%m)%\" \
        AND Status=\"resolved\" \
        AND Tickets.Owner <> 6 \
        AND Tickets.Queue <> 7 \
        GROUP BY Tickets.Owner \
        ORDER BY Tickets DESC;" | awk {'print $2":"$1'} | grep -v -e ^Name | $statistical_path

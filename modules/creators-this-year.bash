#!/bin/bash
mysql $stats_sqlopts -e \
        "use \"$stats_database\" ;\
        SELECT COUNT(DISTINCT EffectiveID) AS Tickets, Users.EmailAddress \
        FROM Tickets, Users \
        WHERE Users.id=Tickets.Creator \
        AND Tickets.LastUpdated LIKE \"$(date +%Y)%\" \
        GROUP BY Tickets.Creator \
        ORDER BY Tickets DESC \
        LIMIT 25; " | awk {'print $2":"$1'} | grep -v -e ^Email | $statistical_path

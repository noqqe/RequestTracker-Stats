#!/bin/bash
mysql $stats_sqlopts -e \
        "use \"$stats_database\" ;\
        SELECT Tickets.Status, COUNT(DISTINCT Tickets.EffectiveID) AS Tickets \
        FROM Tickets \
        WHERE LastUpdated LIKE \"$(date +%Y-%m)%\" \
        GROUP BY Status \
        ORDER BY Tickets DESC;" | awk {'print $1":"$2'} | grep -v -e ^Status | $statistical_path

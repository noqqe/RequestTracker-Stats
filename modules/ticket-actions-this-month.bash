#!/bin/bash
# ticket-status: list and count all ticket status'  
# Copyright: (C) 2011 Florian Baumann <flo@noqqe.de>
# License: GPL-3 <http://www.gnu.org/licenses/gpl-3.0.txt>
# Date: Tuesday 2011-04-12
mysql $stats_sqlopts -e \
        "use \"$stats_database\" ;\
        SELECT Tickets.Status, COUNT(DISTINCT Tickets.EffectiveID) AS Tickets \
        FROM Tickets \
        WHERE LastUpdated LIKE \"$(date +%Y-%m)%\" \
        GROUP BY Status \
        ORDER BY Tickets DESC;" | awk {'print $1":"$2'} | grep -v -e ^Status | $statistical_path

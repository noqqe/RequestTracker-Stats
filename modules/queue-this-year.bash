#!/bin/bash
# queue: list most active queues  
# Copyright: (C) 2011 Florian Baumann <flo@noqqe.de>
# License: GPL-3 <http://www.gnu.org/licenses/gpl-3.0.txt>
# Date: Tuesday 2011-04-12
mysql $stats_sqlopts -e \
        "use \"$stats_database\" ;\
        SELECT COUNT(DISTINCT Tickets.EffectiveID) AS Tickets, Queues.Name \
        FROM Queues, Tickets \
        WHERE Tickets.Queue=Queues.id \
        AND Tickets.LastUpdated LIKE \"$(date +%Y)%\" \
        GROUP BY Tickets.Queue \
        ORDER BY Tickets DESC; " | awk {'print $2":"$1'} | grep -v -e ^Name | $statistical_path

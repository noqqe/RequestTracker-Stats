#!/bin/bash
# users: count all tickets for each user and get the one who solved the most 
# Copyright: (C) 2011 Florian Baumann <flo@noqqe.de>
# License: GPL-3 <http://www.gnu.org/licenses/gpl-3.0.txt>
# Date: Tuesday 2011-04-12
mysql $stats_sqlopts -e "use \"$stats_database\" ; \
        SELECT COUNT(DISTINCT Tickets.EffectiveID) AS Tickets, Users.Name \
        FROM Tickets, Users \
        WHERE Tickets.Owner=Users.id \
        AND Tickets.LastUpdated LIKE \"$(date --date="last month" +%Y-%m)%\" \
        AND Status=\"resolved\" \
        AND Tickets.Owner <> 6 \
        AND Tickets.Queue <> 7 \
        GROUP BY Tickets.Owner \
        ORDER BY Tickets DESC;" | awk {'print $2":"$1'} | grep -v -e ^Name | $statistical_path

#!/bin/bash
# creators-this-year: Creates a detailed list of emailaddresses which created
#  the most tickets this year
# Copyright: (C) 2011 Florian Baumann <flo@noqqe.de>
# License: GPL-3 <http://www.gnu.org/licenses/gpl-3.0.txt>
# Date: Tuesday 2011-04-12

mysql $stats_sqlopts -e \
        "use \"$stats_database\" ;\
        SELECT COUNT(DISTINCT EffectiveID) AS Tickets, Users.EmailAddress \
        FROM Tickets, Users \
        WHERE Users.id=Tickets.Creator \
        AND Tickets.LastUpdated LIKE \"$(date +%Y)%\" \
        GROUP BY Tickets.Creator \
        ORDER BY Tickets DESC \
        LIMIT 25; " | awk {'print $2":"$1'} | grep -v -e ^Email | $statistical_path

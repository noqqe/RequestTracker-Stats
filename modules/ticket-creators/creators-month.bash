#!/bin/bash
# creators-this-month: Creates a detailed list of emailaddresses which created
#  the most tickets this month
# Copyright: (C) 2011 Florian Baumann <flo@noqqe.de>
# License: GPL-3 <http://www.gnu.org/licenses/gpl-3.0.txt>
# Date: Tuesday 2011-04-12

# Example 
# Most active creators for this month (April)
# ---------------------------------------------------
# Christel@company.com       |############ (13)
# Sydelle@company.com        |########### (12)
# Birgitta@company.com       |######### (10)
# Ainsley@company.com        |######## (9)
# Halette@company.com        |##### (6)
# Martguerita@comp           |##### (6)
# Tracy@company.com          |#### (5)
# care@qsc.de@comp           |#### (5)
# waja@company.com           |### (4)
# Christyna@company.com      |## (3)
# Ethel@company.com          |## (3)
# Patricia@company.com       |## (3)
# Justine@company.com        |## (3)
# Nicoline@company.com       |## (3)
# Leyla@company.com          |## (3)
# Lenee@company.com          |## (3)
# Peria@company.com          |## (3)
# Murial@company.com         |# (2)
# Idalina@company.com        |# (2)
# x.wisselm@fax.de           |# (2)
# Fawne@company.com          |# (2)
# Vivyan@company.com         |# (2)
# Rycca@company.com          |# (2)
# Glynis@company.com         |# (2)
# Babara@company.com         |# (2)


mysql $stats_sqlopts -e \
        "use \"$stats_database\" ;\
        SELECT COUNT(DISTINCT EffectiveID) AS Tickets, Users.EmailAddress \
        FROM Tickets, Users \
        WHERE Users.id=Tickets.Creator \
        AND Tickets.LastUpdated LIKE \"$(date +%Y-%m)%\" \
        GROUP BY Tickets.Creator \
        ORDER BY Tickets DESC \
        LIMIT 25; " | awk {'print $2":"$1'} | grep -v -e ^Email | grep -v -e "^\s"| $statistical_path

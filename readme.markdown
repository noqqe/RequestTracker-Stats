# RequestTracker-Stats
RequestTracker-Stats is a simple and easy way to analyze the data in your ticket system. I got to confess that it's kind of a competition thing to squash tickets at work :P At least this was my intention for writing up this. :P 

Basically its just written in Bash and a byte of MySQL magic to generate this statistically information and showing up on your local terminal. 

### Usage
Creating your local copy:

    $ cd /usr/local/bin
    $ git clone git@github.com:noqqe/requesttracker-stats

Configure your database connection

    $ vi conf/rt-stats.conf

    # Global database informations
    stats_dbhost="localhost"
    stats_dbport="3306"
    stats_database="rtdb"
    # Database user and password 
    stats_dbuser="statistic"
    stats_dbpassword="passw0rd"

Start using rt-stats :P 

    $ rt-stats

### Send it periodically to your team

It's a bit of fun sending this as Email to your team from time to time. I created a short cron job which is doing that once a week. 

    #!/bin/bash
    statstmp=$(mktemp)
    /usr/local/bin/requesttracker-stats/rt-stats > $statstmp
    mail -s "RequestTracker-Stats for $(date +%B) $(date +%Y)" mail@address.com < $statstmp
    rm $statstmp

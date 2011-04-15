# RequestTracker-Stats
RequestTracker-Stats is a simple and easy way to analyze the data in your ticket
system (RequestTracker v3.8 from BestPractice). I got to confess that it's kind of a competition thing to squash tickets at work :P At least this was my intention for writing up this. :P 

See http://bestpractical.com/rt/ for Details.

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

### Examples

This is just one of all examples. Showing up the resolved tickets by users this
month. See modules/ for all statistic data.

    Resolved ticket statistic for this month (April)
    ---------------------------------------------------
    sebasto   |##################### (22)
    jawa      |##################### (22)
    ronie     |############ (13)
    noqqe     |######### (10)
    akuweber  |######## (9)
    mfwedler  |####### (8)
    vrte      |# (2)
    fbaumann  |# (2)
    akolt     | (1)

### Send it periodically to your team

It's a bit of fun sending this as Email to your team from time to time. I created a short cron job which is doing that once a week. 

    #!/bin/bash
    statstmp=$(mktemp)
    /usr/local/bin/requesttracker-stats/rt-stats > $statstmp
    mail -s "RequestTracker-Stats for $(date +%B) $(date +%Y)" mail@address.com < $statstmp
    rm $statstmp


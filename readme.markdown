# RequestTracker-Stats
RequestTracker-Stats is a simple and easy way to analyze the data in your ticket
system (RequestTracker v3.8 from BestPractical). I got to confess that it's kind of a competition thing to squash tickets at work :P At least this was my intention for writing up this. :P 

See [http://bestpractical.com/rt/](http://bestpractical.com/rt/) for Details.

Basically it's just written in Bash and a byte of MySQL magic to generate this statistically information and showing up on your local terminal. 

### Usage
Creating your local copy:

    $ cd /usr/local/bin
    $ git clone git@github.com:noqqe/requesttracker-stats requesttracker-stats
    $ cd requesttracker-stats
    $ git submodule init
    $ git submodule update

Configure your database connection

    $ vi conf/rt-stats.conf

    # Global database informations
    stats_dbhost="localhost"
    stats_dbport="3306"
    stats_database="rtdb"
    # Database user and password 
    stats_dbuser="statistic"
    stats_dbpassword="passw0rd"

Start using RequestTracker-Stats. At first you can just hit execute and watch,
which informations are showing up. 

    $ ./rt-stats

Later, if you will use this seriously you can start disabling modules in
rt-stats file if there are not necessary for you. Simply by commenting out the `source` command. If you would write
new modules (what would be a great thing for me ;)) you could take a look at the
module files. If you are ready, than feel free to mail me and/or send a pull
request on github.

### Examples

This is just one of all examples. Showing up the resolved tickets by users this
month. See [https://gist.github.com/948075](https://gist.github.com/948075) for more details.

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
    cd /usr/local/bin/requesttracker-stats/
    ./rt-stats > $statstmp
    mail -s "RequestTracker-Stats for $(date +%B) $(date +%Y)" mail@address.com < $statstmp
    rm $statstmp


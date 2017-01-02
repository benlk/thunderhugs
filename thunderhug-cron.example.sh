#
# Run `crontab -e` to set the cron job for this bot:
# every 30 minutes, from 8 a.m. to 10 p.m., every day
# */30 8-21 * * * /full/path/to/thunderhug-cron.example.sh
#
./fetch.bash -x LAT -y LONG -a TWITTER_ACCOUNT | parse -m MAINTAINER_TWITTER | tweet TWITTER_ACCOUNT

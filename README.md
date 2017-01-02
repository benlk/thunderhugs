# Thunderhugs twitter bot

This bot aims to:

- Scrape NWS for thunderstorm and severe weather warnings
- turn the scraped output into something that can be tweeted
- add a comforting message
- tweet it

Implementation ideas:

- cron job: `fetch LAT LONG TWITTER_ACCOUNT | parse | tweet TWITTER_ACCOUNT` using an established tweet cli command, drawing from ENV vars
- This is designed to not use environment variables, so that any one person can run multiple instances of the bot.

# Setup

	mkvirtualenv thunderhugs
	pip install

-----------

### Notes about jenni's nws.py

> <yano> just replace the jenni.say / jenni.reply with "print" statements or write to a file
> <yano> and then grab the GPS coords for the zip code
> <yano> and hard code that into it
> <yano> and BAM

### fetch

This could probably just be a curl command

See https://forecast-v3.weather.gov/documentation?redirect=legacy

fetch.sh $1 $2 $3
	$1 is the latitude
	$2 is the longitude
	$3 is the twitter account used for this bot; it's used in the useragent string

### parse

This needs to account for:

- 200  success
- any error message
	- the message piped to 'tweet' should highlight the maintainer on Twitter
		- maintainer twitter account should be an env var or a config variable, because no way nohow am I getting hundreds of bots @ing me.


-----

### Dependencies

For Thunderhugs to run successfully, you need to have the following packages or programs installed:

- getopts
- curl
- https://github.com/sferik/t

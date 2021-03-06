# Thunderhugs twitter bot

This bot aims to:

- Query NWS for thunderstorm and severe weather warnings
- turn the output into something that can be tweeted
- add a comforting message
- tweet it

Implementation ideas:

- cron job: `./fetch.bash -x LAT -y LONG -a TWITTER_ACCOUNT | parse | tweet TWITTER_ACCOUNT` using an established tweet cli command
- This is designed to not use environment variables, so that any one person can run multiple instances of the bot.

## Setup

Create a Twitter account for your bot. `thunderhug` plus the ZIP code it's covering will fit in the necessary length.

Follow the setup instructions for https://github.com/sferik/t to allow your bot to tweet.

Do tktk research to get the query parameters for your location.

Make a copy of `thunderhug-cron.example.sh` named `thunderhug-cron.12345.sh` where `12345` is your zip code or other identifying location information. Follow the instructions in that file to set up the cron job to tweet.

### Dependencies

For Thunderhugs to run successfully, you need to have the following packages or programs installed:

- getopts
- curl
- https://github.com/sferik/t (required for the tweeting)

## Documentation

### fetch

This could probably just be a curl command

See https://forecast-v3.weather.gov/documentation?redirect=legacy

fetch.sh arguments can be found by running `./fetch.sh -?`

### parse

This needs to account for:

- 200  success
- any error message
	- the message piped to 'tweet' should highlight the maintainer on Twitter
		- maintainer twitter account should be an env var or a config variable, because no way nohow am I getting hundreds of bots @ing me.



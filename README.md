# Thunderhugs twitter bot

This bot aims to:

- Scrape NWS for thunderstorm and severe weather warnings
- turn the scraped output into something that can be tweeted
- add a comforting message
- tweet it

Implementation ideas:

- cron job: `fetch | parse | tweet` using an established tweet cli command, drawing from ENV vars

-----------

### Notes about jenni's nws.py

> <yano> just replace the jenni.say / jenni.reply with "print" statements or write to a file
> <yano> and then grab the GPS coords for the zip code
> <yano> and hard code that into it
> <yano> and BAM

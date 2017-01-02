
## Documenting the undocumented variables:

https://forecast-v3.weather.gov/documentation?redirect=legacy#apiTab

{wfo} is (I think) a Weather Forecast Office. A list of locations is at https://api.weather.gov/products/locations; you can confirm that a location is an office by checking https://api.weather.gov/offices/{officeID} using the location's id.

{x} is presumed to be a longitude, but they might be something different

{y} is presumed to be a latitude, but they might be something different

{stationID} is is the station callsign from https://api.weather.gov/stations

{recordId} is the timestamp; to get a list of recent timestamps for a given {stationId}, hit /stations/{stationId}/observations

{point} is a ???. You can get latlong of a point from a zip code by putting the zip code in place of `{zip}` in http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php?listZipCodeList={zip} - an example data returned is `39.9889,-82.9874` but NWS rounds that down to `39.99,-82.99`

{productId} is a particular product, usually a UID. To find the UID of a product, hit https://api.weather.gov/products/types to get the type of product you're looking for, then /products/types/{typeId} to get a list of active products of that type. The {productID} is the "id" value; the URL for that product is the "@id" value.

{locationID} is similar to {wfo} in that it is a location ID. A list of locations is at https://api.weather.gov/products/locations .

{officeId} is a Weather Forecast Office. A list of locations is at https://api.weather.gov/products/locations; you can confirm that a location is an office by checking https://api.weather.gov/offices/{officeID} using the location's id.

{type} is the type of a zone, possibly. To get the {type}, find your zone in https://api.weather.gov/zones . Valid types are:  
	```
	$ wget https://api.weather.gov/zones
	$ grep "type" zones | grep -v "@" | sort -u 
	       "type": "coastal",
	       "type": "county",
	       "type": "fire",
	       "type": "offshore",
	       "type": "public",
	```

{zoneID} is the ID of a zone. Zone IDs can be found by looking at https://api.weather.gov/zones


## Product types relevant to this bot:

From https://api.weather.gov/products/types

- SVR Severe Thunderstorm Warning
- WOU Tornado/Severe Thunderstorm Watch
- WWP Severe Thunderstorm / Tornado Watch Probabilities

Don't need to parse the Hazardous Weather Outlooks because those are heads-up the actual products are what we want.

## Finding your location:

https://api.weather.gov/products/locations

The station id is a two- or three-character code

## Finding zones in your location:

Find your location here: https://api.weather.gov/zones

The one that you want is a URL with the two-letter state/territory abbreviation and a `Z`: `http://api.weather.gov/zones/forecast/OHZ055`

That URL is the forecast zone that you're looking for.


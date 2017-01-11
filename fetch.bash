#!/bin/bash

# Initialize variables
url='https://api-v1.weather.gov'
#url='https://api.weather.gov'
query='/points/'
lat=''
long=''
verbose=''
account='no twitter account set on command line'
location=''


## check arguments
function check_arguments {
	verbose_log "long: "$long
	verbose_log "lat: "$lat
	verbose_log "location: "$location
	# $lat should be a latitude
	# $long should be a longitude
	# $location should be a string
	# if any of these are unset, show_help
	if [ -z "$location" ]
	then
		echo "You need to set a location with -l <location>"
		echo "Try running this command with -h to get some help"
		exit 1
	fi

}

function check_dependencies {
	hash curl 2>/dev/null || {
		echo "You need to install curl for thunderhugs to work."
		echo "See https://github.com/benlk/thunderhugs/ for more information"
		exit 1
	}
	hash getopts 2>/dev/null || {
		echo "You need to install getopts for thunderhugs to work."
		echo "See https://github.com/benlk/thunderhugs/ for more information"
		exit 1
	}
}

function show_help {
	cat << EOF
Thunderhugs fetch.bash version 0.0.1
Usage:
	fetch.bash [-h]
	fetch.bash -a <account> -location <latitude> [-v] [-u <URL>]

This script queries the National Weather Service API for information based
on the latitude and longitude given on the command line

Arguments:
	-h
	-?
		Display this help

	-x
		Set the longitude
	
	-y
		Set the latitude

	-v
		Set verbosity
	
	-a
		Set the twitter account you're using Thunderhugs for.
		This is used in the useragent string when we query the NWS API.

	-u
		Set this to change the location of the NWS API.
		By default, this is $url

	-l
		Set this to a NWS location, which is usually an office ID.
		A list of locations ought to be at http://api.weather.gov/locations but it is not
		Office IDs look like ILN, a list of offices is at https://api.weather.gov/offices

EOF
}

function fetch {
	verbose_log "Running verbosely"
	curl \
		-A "Thunderhugs version 0.0.1,""$account" \
		$verbose \
		$url'/products/types/SVR/locations/'$location''
	curl \
		-A "Thunderhugs version 0.0.1,""$account" \
		$verbose \
		$url'/products/types/WOU/locations/'$location''
	curl \
		-A "Thunderhugs version 0.0.1,""$account" \
		$verbose \
		$url'/products/types/WWP/locations/'$location''
}

function verbose_log {
	if [ ! -z "$verbose" ]
	then
		echo $1
	fi
}

#
# The actual execution part of this script
#

check_dependencies

# Parse options
# see also http://aplawrence.com/Unix/getopts.html
OPTIND=1
while getopts "h?va:x:y:u:l:" opt; do
	case "$opt" in
		h|\?)
			show_help
			exit 0
			;;
		x)
			# longitude
			long=$OPTARG
			verbose_log "long: "$OPTARG
			;;
		y)
			#latitude
			lat=$OPTARG
			verbose_log "lat: "$OPTARG
			;;
		v)
			verbose=' --verbose'
			verbose_log "verbose: "$verbose
			;;
		a)
			# twitter account
			account=" twitter account "$OPTARG
			verbose_log "account: "$OPTARG
			;;
		u)
			# NWS API Location
			url=$OPTARG
			verbose_log "url: "$url
			;;
		l)
			# location code
			location=$OPTARG
			verbose_log "location: "$location
			;;
	esac
done
shift $((OPTIND-1))


check_arguments
fetch

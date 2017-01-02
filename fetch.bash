#!/bin/bash

# Initialize variables
url='https://api-v1.weather.gov'
#url='https://api.weather.gov'
query='/points/'
lat=''
long=''
verbose=''
account='no twitter account set on command line'



## check arguments
function check_arguments {
	echo 'tried to check arguments'
	url=$1
	query=$2
	lat=$3
	long=$4
	verbose=$5
	account=$6

	# $lat should be a latitude
	# $long should be a longitude
	# if either of these are unset, show_help
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
	fetch.bash -a <account> -x <longitude> -y <latitude> [-v] [-u <URL>]

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

EOF
}

function fetch {
	url=$1
	query=$2
	lat=$3
	long=$4
	verbose=$5
	account=$6

	curl \
		-A "Thunderhugs version 0.0.1,""$account" \
		$verbose \
		$url'/gridpoints/ILN/'$long','$lat
}

#
# The actual execution part of this script
#

check_dependencies

# Parse options
# see also http://aplawrence.com/Unix/getopts.html
OPTIND=1
while getopts "h?va:x:y:u:" opt; do
	case "$opt" in
		h|\?)
			show_help
			exit 0
			;;
		x)
			# longitude
			long=$OPTARG
			echo "long: "$OPTARG
			;;
		y)
			#latitude
			lat=$OPTARG
			echo "lat: "$OPTARG
			;;
		v)
			verbose=' --verbose'
			echo "verbose: "$verbose
			;;
		a)
			# twitter account
			account=" twitter account "$OPTARG
			echo "account: "$OPTARG
			;;
		u)
			# NWS API Location
			url=$OPTARG
			echo "url: "$url
			;;
	esac
done
shift $((OPTIND-1))


check_arguments $url $query "$lat" "$long" $verbose "$account"
fetch $url $query "$lat" "$long" $verbose "$account"

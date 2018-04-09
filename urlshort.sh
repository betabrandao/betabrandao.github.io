#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#
# Program: urlshort.sh
# Author:  Roberta Nunes
# Description: script to create an shortner url on rebrandly service.
#
# Usage: ./urlshort.sh [options] <url>
#
# Options:
#   -h, --help        output instructions
#   -c, --create      create url, if no values, random short url has created 
#   -q, --qrcode      create url and create qrcode image file     
#
# Alias: alias ushort="bash ~/path/to/script/urlshort.sh"
#
# Example:
#   ./urlshort.sh -c urlshortname http://example.of./url-to-shortness/to?you=site
#
# Important Notes:
#   - This script was created to generate urls to my blog.
#   - Require curl, Rebrandly.com API Key and custom domain.
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------
REBR_APIKEY=""
DOMAIN="l.betab.io"

# ------------------------------------------------------------------------------
# | CORE - NO EDIT THIS                                                        |
# ------------------------------------------------------------------------------
URL_ENV="$(echo ${@:2:$(($#-1))})"

# ------------------------------------------------------------------------------
# | INITIALIZE PROGRAM                                                         |
# ------------------------------------------------------------------------------

#Sub Main
main() {

    # Show help
    if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
        urlshort_help ${1}
        exit
    fi

    # Create url
    if [[ "${1}" == "-c" || "${1}" == "--createurl" ]]; then
        urlshort_get $*
        exit
    fi

    # Create url and qrcode
    if [[ "${1}" == "-q" || "${1}" == "--qrcode" ]]; then
        urlshort_get_qr $*
        exit
    fi

}

# Create url

urlshort_get() {

API="https://api.rebrandly.com/v1/links"
TYPE="Content-Type: application/json"
APIKEY="apikey:${REBR_APIKEY}"

CURL_RETURN="$(echo ${API} -H ${TYPE} -H ${APIKEY}  -d '{"destination": "${URL_ENV}","domain":{"fullName":"${DOMAIN}"}}')"

echo $CURL_RETURN

}

# Initialize
main $*


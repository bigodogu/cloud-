#!/bin/bash

#########################################
# Author: Abhishek
# Version: v1
#
# Script Name: GitHub REST API Helper
#
# Description:
#   This script communicates with GitHub's REST API using curl.
#   It supports paginated and non-paginated responses and displays
#   the full API result in the console.
#
# Usage:
#   ./script.sh <GITHUB_TOKEN> <REST_API_ENDPOINT>
#
# Example:
#   ./script.sh ghp_xxx /repos/org/repo/issues
#
# Arguments:
#   GITHUB_TOKEN         - Your personal GitHub token with required access.
#   REST_API_ENDPOINT    - REST API path (e.g., /repos/org/repo/issues)
#
# Output:
#   Consolidated API response printed to stdout.
#########################################

# Check for minimum required arguments
if [ ${#@} -lt 2 ]; then
    echo "Usage: $0 [your GitHub token] [REST API endpoint]"
    exit 1
fi

GITHUB_TOKEN=$1
GITHUB_API_REST=$2

# Define GitHub API accept header for v3
GITHUB_API_HEADER_ACCEPT="Accept: application/vnd.github.v3+json"

# Create a temporary file to store output
SCRIPT_NAME=$(basename "$0")
TMPFILE=$(mktemp /tmp/${SCRIPT_NAME}.XXXXXX) || exit 1

# Function to make the actual API call
# Arguments:
#   $1 - Full API URL to hit
# Appends the response to the TMPFILE
function rest_call {
    curl -s "$1" \
         -H "${GITHUB_API_HEADER_ACCEPT}" \
         -H "Authorization: token ${GITHUB_TOKEN}" >> "$TMPFILE"
}

# Detect if the API response is paginated
# If so, extract the last page number from the 'Link' header
last_page=$(curl -s -I "https://api.github.com${GITHUB_API_REST}" \
    -H "${GITHUB_API_HEADER_ACCEPT}" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    | grep '^Link:' \
    | sed -e 's/^Link:.*page=//g' -e 's/>.*$//g')

# Perform API calls
if [ -z "$last_page" ]; then
    # Non-paginated response, single API call
    rest_call "https://api.github.com${GITHUB_API_REST}"
else
    # Paginated response, iterate through all pages
    for p in $(seq 1 "$last_page"); do
        rest_call "https://api.github.com${GITHUB_API_REST}?page=$p"
    done
fi

# Print the collected output
cat "$TMPFILE"

#!/bin/bash
################################
# Author: Abhishek
# Version: v1
#
#
#
# This script will help users to communicate and retrieve information from GitHub
# Usage:
#   Please provide your github token and rest api to the script as input
#
#
################################

if [ ${#@} -lt 2 ]; then
    echo "usage: $0 [your github token] [REST expression]"
    exit 1;
fi

GITHUB_TOKEN=$1
GITHUB_API_REST=$2

GITHUB_API_HEADER_ACCEPT="Accept: application/vnd.github.v3+json"

temp=`basename $0`
TMPFILE=`mktemp /tmp/${temp}.XXXXXXX` || exit 1


function rest_call {
    curl -s $1 -H "${GITHUB_API_HEADER_ACCEPT}" -H "Authorization: token $GITHUB_TOKEN" >> $TMPFILE
}

# single page result-s (no pagination), have no Link: section, the grep result is empty
last_page=`curl -s -I "https://api.github.com${GITHUB_API_REST}" -H "${GITHUB_API_HEADER_ACCEPT}" -H "Authorization: token $GITHUB_TOKEN" | grep '^Link:' | sed -e 's/^Link:.*page=//g' -e 's/>.*$//g'`

# does this result use pagination?
if [ -z "$last_page" ]; then
    # no - this result has only one page
    rest_call "https://api.github.com${GITHUB_API_REST}"
else

    # yes - this result is on multiple pages
    for p in `seq 1 $last_page`; do
        rest_call "https://api.github.com${GITHUB_API_REST}?page=$p"
    done
fi

cat $TMPFILE

# Function to create a pull request
function create_pull_request {
    local repo="$1"      # Format: owner/repo
    local title="$2"
    local head="$3"
    local base="$4"
    local body="$5"
    
    curl -s -X POST "https://api.github.com/repos/${repo}/pulls" \
        -H "${GITHUB_API_HEADER_ACCEPT}" \
        -H "Authorization: token $GITHUB_TOKEN" \
        -d "{\"title\": \"$title\", \"head\": \"$head\", \"base\": \"$base\", \"body\": \"$body\"}"
}

# Usage example for creating a pull request:
# create_pull_request "owner/repo" "PR Title" "feature-branch" "main" "Description of the PR"

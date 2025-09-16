#!/bin/bash
################################
# Author: Abuzar Khan
# Version: v1.1
# Updated with error handling
################################

# Exit on any error
set -e

# Error handling function
function handle_error() {
    echo "Error occurred in script at line: ${1}"
    echo "Error code: ${2}"
    # Cleanup temporary file
    [ -f "${TMPFILE}" ] && rm -f "${TMPFILE}"
    exit ${2}
}

# Set error trap
trap 'handle_error ${LINENO} $?' ERR

# Validate input arguments
if [ ${#@} -lt 2 ]; then
    echo "Error: Insufficient arguments"
    echo "Usage: $0 [your github token] [REST expression]"
    exit 1
fi

# Validate GitHub token format
if [[ ! $1 =~ ^gh[ps]_[a-zA-Z0-9]{36}$ ]]; then
    echo "Error: Invalid GitHub token format"
    exit 1
fi

GITHUB_TOKEN=$1
GITHUB_API_REST=$2

GITHUB_API_HEADER_ACCEPT="Accept: application/vnd.github.v3+json"

# Validate temporary file creation
temp=$(basename $0)
TMPFILE=$(mktemp /tmp/${temp}.XXXXXX) || {
    echo "Error: Failed to create temporary file"
    exit 1
}

# Enhanced REST call function with error handling
function rest_call {
    local response
    local http_code
    
    response=$(curl -s -w "%{http_code}" $1 \
               -H "${GITHUB_API_HEADER_ACCEPT}" \
               -H "Authorization: token $GITHUB_TOKEN}")
    
    http_code=${response: -3}
    body=${response::-3}
    
    case $http_code in
        200) 
            echo "$body" >> $TMPFILE
            ;;
        401)
            echo "Error: Unauthorized. Please check your GitHub token"
            rm -f "${TMPFILE}"
            exit 1
            ;;
        403)
            echo "Error: API rate limit exceeded or resource forbidden"
            rm -f "${TMPFILE}"
            exit 1
            ;;
        404)
            echo "Error: Resource not found"
            rm -f "${TMPFILE}"
            exit 1
            ;;
        *)
            echo "Error: API request failed with status $http_code"
            rm -f "${TMPFILE}"
            exit 1
            ;;
    esac
}

# Check API rate limit before making requests
rate_limit_response=$(curl -s -H "${GITHUB_API_HEADER_ACCEPT}" \
                     -H "Authorization: token $GITHUB_TOKEN" \
                     "https://api.github.com/rate_limit")
remaining=$(echo "$rate_limit_response" | grep -o '"remaining":[0-9]*' | cut -d':' -f2)

if [ "$remaining" -lt 10 ]; then
    echo "Warning: Only $remaining API calls remaining"
fi

# Get pagination information with error handling
last_page=$(curl -s -I "https://api.github.com${GITHUB_API_REST}" \
            -H "${GITHUB_API_HEADER_ACCEPT}" \
            -H "Authorization: token $GITHUB_TOKEN" \
            | grep '^Link:' | sed -e 's/^Link:.*page=//g' -e 's/>.*$//g')

# Handle pagination
if [ -z "$last_page" ]; then
    rest_call "https://api.github.com${GITHUB_API_REST}"
else
    for p in $(seq 1 $last_page); do
        rest_call "https://api.github.com${GITHUB_API_REST}?page=$p"
    done
fi

# Output results and cleanup
if [ -f "${TMPFILE}" ]; then
    cat "${TMPFILE}"
    rm -f "${TMPFILE}"
else
    echo "Error: No data retrieved"
    exit 1
fi

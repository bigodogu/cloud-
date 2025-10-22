#!/bin/bash
################################
# Author: Abhishek
# Version: v2
#
# #updated by Adithya sekhar
# Date:22/10/25:
#
#
#
# This script will help users to communicate and retrieve information from GitHub
# Usage:
#   Please provide your github token and rest api to the script as input
#
#eg of api call   as a normal curl :  curl -s "https://api.github.com/rate_limit"  -H "${GITHUB_API_HEADER_ACCEPT}" -H "Authorization: token $GITHUB_TOKEN"
#/rate_limit is an GitHub REST Expressions 
#|||rly other exp are as followes
# User-related
#REST Expression	Description
#/user	Get your authenticated user info
#/users/{username}	Get public info for a specific user
#/user/emails	List your verified email addresses
#/user/followers	Get your followers
#/users/{username}/followers	Get followers of another user
#/users/{username}/following	Get people that user follows


# Repositories
#REST Expression	Description
#/user/repos	List your repos
#/users/{username}/repos	List public repos of a user
#/orgs/{org}/repos	List repos in an organization
#/repositories	List all public repositories
#/repos/{owner}/{repo}	Get details of a specific repo
#/repos/{owner}/{repo}/branches	List branches
#/repos/{owner}/{repo}/contributors	List contributors
#/repos/{owner}/{repo}/languages	List languages used
#/repos/{owner}/{repo}/topics	Get repository topics
#/repos/{owner}/{repo}/tags	List tags



# Commits, branches & contents
#REST Expression	Description
#/repos/{owner}/{repo}/commits	List commits
#/repos/{owner}/{repo}/commits/{sha}	Get details of a commit
#/repos/{owner}/{repo}/branches	List branches
#/repos/{owner}/{repo}/contents/{path}	Get file or directory contents
#/repos/{owner}/{repo}/git/trees/{sha}	List files in a tree
#/repos/{owner}/{repo}/git/blobs/{sha}	Get raw blob content

#Issues & Pull Requests
#REST Expression	Description
#/issues	List all issues assigned to you
#/repos/{owner}/{repo}/issues	List issues in a repo
#/repos/{owner}/{repo}/issues/{number}	Get a specific issue
#/repos/{owner}/{repo}/pulls	List pull requests
#/repos/{owner}/{repo}/pulls/{number}	Get specific PR details
#/repos/{owner}/{repo}/pulls/{number}/files	List changed files in a PR

#Releases & Tags
#REST Expression	Description
#/repos/{owner}/{repo}/releases	List releases
#/repos/{owner}/{repo}/releases/latest	Get the latest release
#/repos/{owner}/{repo}/releases/{id}	Get a specific release
#/repos/{owner}/{repo}/tags	List tags

#Actions & Workflows (CI/CD)
#REST Expression	Description
#/repos/{owner}/{repo}/actions/workflows	List workflows
#/repos/{owner}/{repo}/actions/workflows/{id}/runs	List runs of a workflow
#/repos/{owner}/{repo}/actions/runs/{id}	Get workflow run details
#/repos/{owner}/{repo}/actions/artifacts	List workflow artifacts



#Organizations & Teams
#REST Expression	Description
#/user/orgs	List orgs the user belongs to
#/orgs/{org}	Get organization info
#/orgs/{org}/members	List organization members
#/orgs/{org}/teams	List teams in an organization
#/orgs/{org}/repos	List organization repositories


#Statistics
#REST Expression	Description
#/repos/{owner}/{repo}/stats/contributors	Contributors graph data
#/repos/{owner}/{repo}/stats/commit_activity	Weekly commit activity
#/repos/{owner}/{repo}/stats/code_frequency	Code additions/deletions per week
#/repos/{owner}/{repo}/stats/participation	Commits per week (owner vs others)

#Authentication & Rate Limits
#REST Expression	Description
#/rate_limit	Check your API rate limit usage
#/user	Confirms your token authentication
################################

if [ ${#@} -lt 2 ]; then
    echo "usage: $0 [your github token] [REST expression]"
    exit 1;
fi

GITHUB_TOKEN=$1
GITHUB_API_REST=$2

GITHUB_API_HEADER_ACCEPT="Accept: application/vnd.github.v3+json"

temp=`basename $0`
TMPFILE=`mktemp /tmp/${temp}.XXXXXX` || exit 1


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

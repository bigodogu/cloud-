#!/usr/bin/env bash
tstamp="$(date + '%d-%B-%y %I:%M%p')"
echo "$tstamp"
git pull && git add --all && git commit -m "$* ${tstamp}" && git push

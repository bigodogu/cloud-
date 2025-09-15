#!/bin/bash
echo "enter ip address"
read SERVER
ping -c 3 $SERVER > /dev/null 2>&1
if [$? -ne 0];then
echo "$SERVER is not healthy"
exit 1
else
echo "$SERVER is HEalthy!!!"
fi
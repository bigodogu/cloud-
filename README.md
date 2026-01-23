# Shell
# Check if an ERROR exists in a log file

#!/bin/bash

LOG_FILE="/var/log/app.log"

if grep -i "error" "$LOG_FILE" > /dev/null; then
    echo "❌ ERROR found in log file!"
else
    echo "✅ No errors found."
fi


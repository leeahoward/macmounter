#!/usr/bin/env bash

service=macmounter
account=$service.$1

password="$(osascript -e 'Tell application "System Events" to display dialog "Enter password for account" default answer ""' -e 'text returned of result' 2>/dev/null)"
if [ $? -ne 0 ]; then
    # The user pressed Cancel
    osascript -e 'Tell application "System Events" to display alert "You must enter a password; cancelling..." as warning'>>/dev/null
    exit 1 # exit with an error status
elif [ -z "$password" ]; then
    # The user left the password blank
    osascript -e 'Tell application "System Events" to display alert "You must enter a password; cancelling..." as warning'>>/dev/null
    exit 1 # exit with an error status
fi
#echo "account: $account"
#echo "service: $service"
#echo "Got pwd: $password"

security add-generic-password -a ${account} -s ${service} -w ${password}

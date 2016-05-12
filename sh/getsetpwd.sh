#!/usr/bin/env bash

getNewPassword () {

	password="$(osascript -e 'Tell application "System Events" to display dialog "Enter password for account" default answer ""' -e 'text returned of result' 2>/dev/null)"
	if [ $? -ne 0 ]; then
	    # The user pressed Cancel
	    osascript -e 'Tell application "System Events" to display alert "You must enter a password; cancelling..." as warning'>>/dev/null
	    password=""
	elif [ -z "$password" ]; then
	    # The user left the password blank
	    osascript -e 'Tell application "System Events" to display alert "You must enter a password; cancelling..." as warning'>>/dev/null
	    password=""
	fi

	eval "$1='$password'"
}



service=macmounter
account=$service $1


PASSWD=$(security find-generic-password -w -a $account -s $service)

if [[ -z $PASSWD ]]
then
    echo -n Account: $account

    password=''
   	getNewPassword password $account

    security add-generic-password -a "${account}" -s "${service}" -w "${password}"
fi

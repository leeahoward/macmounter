#!/usr/bin/env bash

# pound defines
USER=$1
HOST=$2
REMOTE_FOLDER=$3
LOCAL_FOLDER=$4

# Get password from keychain.
# Here we look for a password for account 'samba_mount'
PWD=$(/Users/leehoward/projects/macmounter/sh/getpwd.sh $USER@$HOST$REMOTE_FOLDER)
if [[ -z $PWD ]]
then
    # No password set. Interactively obtain password.
    # This script should prompt for the password if one doesn't exist 
    # Here we set the password for the account 
    /Users/leehoward/projects/macmounter/sh/setpwd.sh $USER@$HOST$REMOTE_FOLDER
fi

# Get password from keychain.
# Here we, again, look for a password for account 'samba_mount'
PWD=$(/Users/leehoward/projects/macmounter/sh/getpwd.sh $USER@$HOST$REMOTE_FOLDER)

echo User:$USER
echo Host:$HOST
echo Remote:$REMOTE_FOLDER
echo Local:$LOCAL_FOLDER
# echo Password:$PWD

# Finish big
# echo //$USER:$PWD@$HOST$REMOTE_FOLDER
/sbin/mount -t smbfs "//$USER:$PWD@$HOST$REMOTE_FOLDER" $LOCAL_FOLDER
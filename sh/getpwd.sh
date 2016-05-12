#!/usr/bin/env bash

service=macmounter
account=$service.$1

PASSWD=$(security find-generic-password -w -a $account -s $service)

# for mount_smbfs, spaces in passwords need to be escaped as %20
printf "%s" `echo ${PASSWD// /%20}`
#!/usr/bin/env bash

service=macmounter
account=$service.$1

PASSWD=$(security find-generic-password -w -a $account -s $service)
printf "$PASSWD"
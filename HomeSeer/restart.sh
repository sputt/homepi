#!/bin/bash

# check is a process is running, mono should be the HomeSeer process
check_process() {
# echo "$ts:  checking $1"
 [ "$1" = "" ] && return 0
 [ `pgrep -n $1` ] && return 1 || return 0
}

# wait for the mono process to exit, HomeSeer will then be shut down
while [ 1 ]; do
 check_process "mono"
 if [ $? == 0 ]; then
  break
 fi
 sleep 2
done

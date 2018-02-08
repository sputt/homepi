#!/bin/bash
NAME='HomeSeer'            # Server handle for the screen session
DIR='/app/HomeSeer'
USER='root'                # Start HomeSeer as root. You may use a non privileged user
                           # Note: if homeseer is running as non-root user
                           # remove 'sudo' command in file 'go' in HomeSeer folder
                           # and change setting gWebSvrPort to value > 1024 in settings.ini
RETVAL=0

service_start() {
    if [ -f /var/run/$NAME.pid ]; then
        if [ "$(ps -p `cat /var/run/$NAME.pid` | wc -l)" -gt 1 ]; then
            echo -e "$NAME is already running (pidfile exists)."
            return 1
        else
            rm -f /var/run/$NAME.pid
        fi
    fi
    [ -f $DIR/go ] && cd $DIR && su -c "/usr/bin/screen -S $NAME -d -m ./go" $USER
    sleep 5
    ps -ef | egrep "[S]CREEN.+${NAME}" | awk '{ print $2 }' > /var/run/$NAME.pid
    [ -s /var/run/$NAME.pid ] && echo "$NAME started."
}

service_stop() {
    if [ -f /var/run/$NAME.pid ]; then
        if [ $(ps -ef | egrep -c "[S]CREEN.+$NAME") -ge 1 ]; then
            #invoke shutdown command to homeseer...
            for char in $(printf "\\r s h u t d o w n \\r") ; do
                su -c "/usr/bin/screen -p 0 -S $NAME -X stuff $char" $USER
                sleep 0.1
            done
            sleep 15
        fi
        if [ "$(ps -p `cat /var/run/$NAME.pid` | wc -l)" -gt 1 ]; then
            echo -e "$NAME did not stop gacefully. Killing it"
            [ -s /var/run/$NAME.pid ] && kill `cat /var/run/$NAME.pid`
        fi
        rm -f /var/run/$NAME.pid
    else
        echo -e "$NAME is not running."
    fi
}

case "$1" in
'start')
    service_start
;;
'stop')
    service_stop
;;
'restart')
    service_stop
    sleep 5
    service_start
;;
*)
    echo "Usage $0 start|stop|restart"
esac
# --------------------------------------------------------

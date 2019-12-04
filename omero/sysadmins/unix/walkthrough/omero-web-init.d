#!/bin/bash
#
# /etc/init.d/omero
# Subsystem file for "omero" server
#
### BEGIN INIT INFO
# Provides:             omero-web
# Required-Start:       $local_fs $remote_fs $network $time omero postgresql
# Required-Stop:        $local_fs $remote_fs $network $time omero postgresql
# Default-Start:        2 3 4 5
# Default-Stop:         0 1 6
# Short-Description:    OMERO.web
### END INIT INFO
#
### Redhat
# chkconfig: - 98 02
# description: Init script for OMERO.web
###

RETVAL=0
prog=omero-web

# Read configuration variable file if it is present
[ -r /etc/default/$prog ] && . /etc/default/$prog
# also read the omero config
[ -r /etc/default/omero ] && . /etc/default/omero

OMERO_SERVER=${OMERO_SERVER:-/home/omero/OMERO.server}
OMERO_USER=${OMERO_USER:-omero}
SETTINGS=/home/omero/settings.env

start() {	
	echo -n $"Starting $prog:"
	su - ${OMERO_USER} -c ". ${SETTINGS} omero web start" &> /dev/null && echo -n ' OMERO.web'
	RETVAL=$?
	[ "$RETVAL" = 0 ]
        echo
}

stop() {
	echo -n $"Stopping $prog:"
	su - ${OMERO_USER} -c ". ${SETTINGS} omero web stop" &> /dev/null && echo -n ' OMERO.web'
	RETVAL=$?
	[ "$RETVAL" = 0 ]
        echo
}

restart() {
	echo -n $"Restarting $prog:"
	su - ${OMERO_USER} -c ". ${SETTINGS} omero web restart" &> /dev/null && echo -n ' OMERO.web'
	RETVAL=$?
	[ "$RETVAL" = 0 ]
        echo
}

status() {
	echo -n $"Status $prog:"
	su - ${OMERO_USER} -c ". ${SETTINGS} omero web status"
	RETVAL=$?
}

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	restart)
		restart
		;;
	status)
		status
		;;
	*)	
		echo $"Usage: $0 {start|stop|restart|status}"
		RETVAL=1
esac
exit $RETVAL

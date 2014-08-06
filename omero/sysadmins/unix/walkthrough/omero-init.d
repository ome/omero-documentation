#!/bin/bash
#
# /etc/init.d/omero
# Subsystem file for "omero" server
#
### BEGIN INIT INFO
# Provides:             omero
# Required-Start:       $local_fs $remote_fs $network $time postgresql
# Required-Stop:        $local_fs $remote_fs $network $time postgresql
# Default-Start:        2 3 4 5
# Default-Stop:         0 1 6
# Short-Description:    OMERO.server
### END INIT INFO
#
### Redhat
# chkconfig: - 98 02
# description: Init script for OMERO.server
###

RETVAL=0
prog="omero"

# Read configuration variable file if it is present
[ -r /etc/default/$prog ] && . /etc/default/$prog

OMERO_HOME=${OMERO_HOME:-"/home/omero/OMERO.server"}
OMERO_USER=${OMERO_USER:-"omero"}

start() {	
	echo -n $"Starting $prog:"
	su - ${OMERO_USER} -c "${OMERO_HOME}/bin/omero admin start" &> /dev/null && echo -n ' OMERO.server'
	RETVAL=$?
	[ "$RETVAL" = 0 ]
	echo
}

stop() {
	echo -n $"Stopping $prog:"
	su - ${OMERO_USER} -c "${OMERO_HOME}/bin/omero admin stop" &> /dev/null && echo -n ' OMERO.server'
	RETVAL=$?
	[ "$RETVAL" = 0 ]
	echo
}

status() {
	echo -n $"Status $prog:"
	su - ${OMERO_USER} -c "${OMERO_HOME}/bin/omero admin status" && echo -n ' OMERO.server running'
	RETVAL=$?
	echo
}

diagnostics() {
	echo -n $"Diagnostics $prog:"
	su - ${OMERO_USER} -c "${OMERO_HOME}/bin/omero admin diagnostics"
	RETVAL=$?
	echo
}

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	restart)
		stop
		start
		;;
	status)
		status
		;;
	diagnostics)
		diagnostics
		;;
	*)	
		echo $"Usage: $0 {start|stop|restart|status|diagnostics}"
		RETVAL=1
esac
exit $RETVAL

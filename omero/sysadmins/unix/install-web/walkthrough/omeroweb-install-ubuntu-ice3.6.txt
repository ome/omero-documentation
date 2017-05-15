OMERO.web walkthrough installation Ubuntu 16.04 and IcePy 3.6
=============================================================


For convenience in this walkthrough the main OMERO.web configuration options have been defined as environment variables. When following this walkthrough you can either use your own values, or alternatively source the following file::
    
    OMERO_USER=omero
    WEBPORT=80
    WEBSERVER_NAME=localhost



Create local user omero, homedir :file:`/home/omero` (run as root)::
    
    if [ -z "$(getent passwd omero)" ]; then
    
        useradd -m omero
    
    fi
    
    chmod a+X /home/omero

Install ZeroC IcePy 3.6. IcePy is managed by PyPI and will be installed as a part of OMERO.web requirements (run as root)::
    
    apt-get -y install db5.3-util
    apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev

Install other dependencies (run as root)::
    
    apt-get update
    apt-get -y install \
        python-pip
    
    
    apt-get -y install \
        python-pillow \
        python-numpy
    
    
    # install the latest version
    pip install --upgrade pip
    pip install --upgrade virtualenv


Install VirtualEnv - optional (run as root)::
    
    virtualenv /home/omero/omerowebvenv --system-site-packages

Install OMERO.web (run as omero)::
    
    cd /home/omero
    curl -o OMERO.py.zip -L https://downloads.openmicroscopy.org/latest/omero5.3/py.zip
    unzip -q OMERO.py*
    
    zip=$(ls OMERO.py*.zip)
    rm -f $zip
    ln -s OMERO.py-* OMERO.py

Install in the virtualenv created previously (run as root)::
    
    /home/omero/omerowebvenv/bin/pip install --upgrade -r /home/omero/OMERO.py/share/web/requirements-py27.txt

Configure OMERO.web and generate nginx template (run as omero)::
    
    source /home/omero/omerowebvenv/bin/activate
    # By default no value is set for WEBPREFIX but for example it can be set to /omero
    if [[ $WEBPREFIX = *[!\ ]* ]]; then
        /home/omero/OMERO.py/bin/omero config set omero.web.prefix "${WEBPREFIX}"
        /home/omero/OMERO.py/bin/omero config set omero.web.static_url "${WEBPREFIX}/static/"
    fi
    
    /home/omero/OMERO.py/bin/omero config set omero.web.application_server wsgi-tcp
    /home/omero/OMERO.py/bin/omero web config nginx --http "${WEBPORT}" --servername "${WEBSERVER_NAME}" > /home/omero/nginx.conf.tmp
    
    cat /home/omero/nginx.conf.tmp

Install NGINX (run as root)::
    
    #start-install
    apt-get update
    apt-get -y install nginx
    
    #end-install
    sed -i.bak -re 's/( default_server.*)/; #\1/' /etc/nginx/nginx.conf
    rm /etc/nginx/sites-enabled/default
    cp /home/omero/nginx.conf.tmp /etc/nginx/conf.d/omeroweb.conf
    
    service nginx start


Daemon (run as root)::
    
    Create a file omero-web-init.d. See example file below.
    cp omero-web-init.d /etc/init.d/omero-web
    chmod a+x /etc/init.d/omero-web
    
    update-rc.d -f omero-web remove
    update-rc.d -f omero-web defaults 98 02
    

**omero-web-init.d** example::
    
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
    
    
    OMERO_PY=${OMERO_PY:-/home/omero/OMERO.py}
    OMERO_USER=${OMERO_USER:-omero}
    OMERO=${OMERO_PY}/bin/omero
    VENVDIR=${VENVDIR:-/home/omero/omerowebvenv}
    
    start() {
        echo -n $"Starting $prog:"
        su - ${OMERO_USER} -c "source $VENVDIR/bin/activate; ${OMERO} web start" &> /dev/null && echo -n ' OMERO.web'
        sleep 5
        ls $OMERO_PY/var/log
        RETVAL=$?
        [ "$RETVAL" = 0 ]
            echo
    }
    
    stop() {
        echo -n $"Stopping $prog:"
        su - ${OMERO_USER} -c "source $VENVDIR/bin/activate; ${OMERO} web stop" &> /dev/null && echo -n ' OMERO.web'
        RETVAL=$?
        [ "$RETVAL" = 0 ]
            echo
    }
    
    status() {
        echo -n $"Status $prog:"
        su - ${OMERO_USER} -c "source $VENVDIR/bin/activate; ${OMERO} web status"
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
            stop
            start
            ;;
        status)
            status
            ;;
        *)
            echo $"Usage: $0 {start|stop|restart|status}"
            RETVAL=1
    esac
    exit $RETVAL

Start up services (run as root)::
    
    
    cron
    service nginx start
    service omero-web start

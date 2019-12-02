.. walkthroughs are generated using ansible, see 
.. https://github.com/ome/omeroweb-install

OMERO.web installation separately from OMERO.server on Ubuntu 16.04 and IcePy 3.6
=================================================================================

Please first read :doc:`../../server-ubuntu1604-ice36`.


This is an example walkthrough for installing OMERO.web decoupled from the OMERO.server in a **virtual environment** using a dedicated system user. Installing OMERO.web in a virtual environment is the preferred way. For convenience in this walkthrough, we will use the **omero system user** and define the main OMERO.web configuration options as environment variables.


**The following steps are run as root.**

If required, first create a local system user omero and create the homedir too :file:`/home/omero`::

    useradd -m omero

    chmod a+X /home/omero



Installing prerequisites
------------------------

**The following steps are run as root.**


Install dependencies. The number of dependencies to install depends on the way you plan to install OMERO.web. If you wish to install it in a virtual environment with ``--system-site-packages`` *off*, a few more dependencies will be required (**option 2**)::

    # dependencies common to both options
    apt-get update

    apt-get -y install unzip

    apt-get -y install python3
    apt-get -y install python3-venv

    # to be installed if recommended/suggested is false
    apt-get -y install nginx

    # To install OMERO.web using option 2
    # require to install Pillow
    apt-get -y install libtiff5-dev libjpeg8-dev zlib1g-dev
    apt-get -y install libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev



Creating a virtual environment
------------------------------

**The following steps are run as root.**

Create the virtual environment. This is the preferred way to install OMERO.web::

    # option 1: in a virtual environment with --system-site-packages on
    python3 -mvenv /opt/omero/web/ --system-site-packages

    # option 2: in a virtual environment with --system-site-packages off
    python3 -mvenv /opt/omero/web/



Install ZeroC IcePy 3.6::

    # option 1 and option 2
    /opt/omero/web//bin/pip install --upgrade https://github.com/ome/zeroc-ice-py-ubuntu1604/releases/download/0.2.0/zeroc_ice-3.6.5-cp35-cp35m-linux_x86_64.whl


Install OMERO.web::

    /opt/omero/web//bin/pip install "omero-web>=5.6.dev5"

Installing OMERO.web apps
-------------------------

**The following steps are run as root.**

A number of apps are available to add functionality to OMERO.web, such as `OMERO.figure <https://www.openmicroscopy.org/omero/figure/>`_ and `OMERO.iviewer <https://www.openmicroscopy.org/omero/iviewer/>`_. See the main website for a `list of released apps <https://www.openmicroscopy.org/omero/apps/>`_. These apps are optional and can be installed, as the **root user**, via :program:`pip` to your OMERO.web virtual environment and configure as the **omero system user**, at any time.



Configuring OMERO.web
---------------------

**The following steps are run as the omero system user.**

For convenience the main OMERO.web configuration options have been defined as environment variables. You can either use your own values, or alternatively use the following ones::

    export OMERODIR=/home/omero/omero
    export WEBPORT=80
    export WEBSERVER_NAME=localhost


Configure OMERO.web and create the NGINX OMERO configuration file::

    omero config set omero.web.application_server wsgi-tcp
    omero web config nginx --http "${WEBPORT}" --servername "${WEBSERVER_NAME}" > /home/omero/nginx.conf.tmp

For more customization, please read :ref:`customizing_your_omero_web_installation`.


Configuring Gunicorn
--------------------

**The following steps are run as the omero system user.**

Additional settings can be configured by changing the following properties:

    - :property:`omero.web.application_server.max_requests` to 500

    - :property:`omero.web.wsgi_workers` to (2 x NUM_CORES) + 1

      .. note::
          **Do not** scale the number of workers to the number of clients
          you expect to have. OMERO.web should only need 4-12 worker
          processes to handle many requests per second.

    - :property:`omero.web.wsgi_args` Additional arguments. For more details
      check `Gunicorn Documentation <https://docs.gunicorn.org/en/stable/settings.html>`_.



Configuring NGINX
-----------------

**The following steps are run as root.**

Copy the generated configuration file into the NGINX configuration directory, disable the default configuration and start NGINX::

    sed -i.bak -re 's/( default_server.*)/; #\1/' /etc/nginx/nginx.conf
    rm /etc/nginx/sites-enabled/default
    cp /home/omero/nginx.conf.tmp /etc/nginx/conf.d/omeroweb.conf

    service nginx start


Running OMERO.web
-----------------

**The following steps are run as root.**

Install `WhiteNoise <http://whitenoise.evans.io/>`_::


    /opt/omero/web//bin/pip install --upgrade 'whitenoise<4'

**The following steps are run as the omero system user.**

Configure WhiteNoise and start OMERO.web manually to test the installation::

    omero config append -- omero.web.middleware '{"index": 0, "class": "whitenoise.middleware.WhiteNoiseMiddleware"}'

    omero web start

    # Test installation e.g. curl -sL localhost:4080

    omero web stop


Automatically running OMERO.web
-------------------------------


**The following steps are run as root.**

Should you wish to run OMERO.web automatically, a `init.d` file could be created. See below an example file `omero-web-init.d`::

    #!/bin/bash
    #
    # /etc/init.d/omero-web
    # Subsystem file for "omero" web
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
    # description: init file for OMERO.web
    ###

    RETVAL=0
    prog=omero-web

    # Read configuration variable file if it is present
    [ -r /etc/default/$prog ] && . /etc/default/$prog

    OMERO_USER=${OMERO_USER:-omero}
    OMERO=/opt/omero/web//bin/omero
    OMERODIR=/home/omero/omero
    VENVDIR=${VENVDIR:-/opt/omero/web/}

    start() {
        echo -n $"Starting $prog:"
        su - ${OMERO_USER} -c ". ${VENVDIR}/bin/activate;OMERODIR=${OMERODIR} ${OMERO} web start" &> /dev/null && echo -n ' OMERO.web'
        sleep 5
        RETVAL=$?
        [ "$RETVAL" = 0 ]
            echo
    }

    stop() {
        echo -n $"Stopping $prog:"
        su - ${OMERO_USER} -c ". ${VENVDIR}/bin/activate;OMERODIR=${OMERODIR} ${OMERO} web stop" &> /dev/null && echo -n ' OMERO.web'
        RETVAL=$?
        [ "$RETVAL" = 0 ]
            echo
    }

    status() {
        echo -n $"Status $prog:"
        su - ${OMERO_USER} -c ". ${VENVDIR}/bin/activate;OMERODIR=${OMERODIR} ${OMERO} web status"
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

Copy the `init.d` file, then configure the service::

    cp omero-web-init.d /etc/init.d/omero-web
    chmod a+x /etc/init.d/omero-web

    update-rc.d -f omero-web remove
    update-rc.d -f omero-web defaults 98 02



Start up services::


    cron
    service nginx start
    service omero-web restart


Maintenance
-----------

**The following steps are run as the omero system user.**

Please read :ref:`omero_web_maintenance`.



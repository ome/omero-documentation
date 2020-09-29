.. walkthroughs are generated using ansible, see 
.. https://github.com/ome/omeroweb-install

OMERO.web installation on Debian 9 and IcePy 3.6
================================================

Please first read :doc:`../../server-debian9-ice36`.


This is an example walkthrough for installing OMERO.web in a **virtual environment** using a dedicated system user. Installing OMERO.web in a virtual environment is the preferred way. For convenience in this walkthrough, we will use the **omero-web system user** and define the main OMERO.web configuration options as environment variables. Since 5.6, a new :envvar:`OMERODIR` variable is used, you should first unset :envvar:`OMERO_HOME` (if set) before beginning the installation process. By default, Python 3.5 is installed.


**The following steps are run as root.**

If required, first create a local system user omero-web and create directory::

    useradd -m omero-web

    mkdir -p /opt/omero/web/omero-web/etc/grid
    chown -R omero-web /opt/omero/web/omero-web



Installing prerequisites
------------------------

**The following steps are run as root.**


Install dependencies::

    apt-get update

    apt-get -y install unzip
     
    apt-get -y install python3
    apt-get -y install python3-venv

    apt-get -y install nginx


*Optional*: if you wish to use the Redis cache, install Redis::

    apt-get -y install redis-server

    service redis-server start


Creating a virtual environment
------------------------------

**The following steps are run as root.**

Create the virtual environment. This is the recommended way to install OMERO.web::

    python3 -mvenv /opt/omero/web/venv3




Install ZeroC IcePy 3.6::

    /opt/omero/web/venv3/bin/pip install --upgrade https://github.com/ome/zeroc-ice-py-debian9/releases/download/0.2.0/zeroc_ice-3.6.5-cp35-cp35m-linux_x86_64.whl


Install OMERO.web::

    /opt/omero/web/venv3/bin/pip install "omero-web>=5.6.1"

Installing OMERO.web apps
-------------------------


A number of apps are available to add functionality to OMERO.web, such as `OMERO.figure <https://www.openmicroscopy.org/omero/figure/>`_ and `OMERO.iviewer <https://www.openmicroscopy.org/omero/iviewer/>`_. See the main website for a `list of released apps <https://www.openmicroscopy.org/omero/apps/>`_. These apps are optional and can be installed, as the **root user**, via :program:`pip` to your OMERO.web virtual environment and configured as the **omero-web system user**, at any time.



Configuring OMERO.web
---------------------

**The following steps are run as the omero-web system user.**

For convenience the main OMERO.web configuration options have been defined as environment variables. You can either use your own values, or alternatively use the following ones::

    export WEBSESSION=True
    export OMERODIR=/opt/omero/web/omero-web


Configure OMERO.web and create the NGINX OMERO configuration file to be included in a system-wide NGINX configuration by redirecting the output of the command ``omero web config nginx`` below into a file. If an attempt is made to access OMERO.web whilst it is not running, the generated NGINX configuration file will automatically display a maintenance page::

    export PATH=/opt/omero/web/venv3/bin:$PATH


    omero web config nginx --http "${WEBPORT}" --servername "${WEBSERVER_NAME}" > /opt/omero/web/omero-web/nginx.conf.tmp

OMERO.web offers a number of configuration options. The configuration changes **will not be applied** until Gunicorn is restarted using ``omero web restart``. The Gunicorn workers are managed **separately** from other OMERO processes. You can check their status or stop them using ``omero web status`` or ``omero web stop``.

    -  Session engine:

      -  OMERO.web offers alternative session backends to automatically delete stale data using the cache session store backend, see :djangodoc:`Django cached session documentation <topics/http/sessions/#using-cached-sessions>` for more details.

      - `Redis <https://redis.io/>`_ requires `django-redis <https://github.com/jazzband/django-redis/>`_ in order to be used with OMERO.web. We assume that Redis has already been installed. To configure the cache, run::

          omero config set omero.web.caches '{"default": {"BACKEND": "django_redis.cache.
          RedisCache", "LOCATION": "redis://127.0.0.1:6379/0"}}'

      -  After installing all the cache prerequisites set the following::

          omero config set omero.web.session_engine django.contrib.sessions.backends.cache


    - Use a prefix:

      By default OMERO.web expects to be run from the root URL of the webserver.
      This can be changed by setting :property:`omero.web.prefix` and
      :property:`omero.web.static_url`. For example, to make OMERO.web appear at
      `http://example.org/omero/`::

          omero config set omero.web.prefix '/omero'
          omero config set omero.web.static_url '/omero/static/'

      and regenerate your webserver configuration.

    All configuration options can be found on various sections of
    :ref:`web_index` developers documentation. For the full list, refer to
    :ref:`web_configuration` properties.

    The most popular configuration options include:

    -  Debug mode, see :property:`omero.web.debug`.

    -  Customizing OMERO clients e.g. to add your own logo to the login page
       (:property:`omero.web.login_logo`) or use an index page as an alternative
       landing page for users (:property:`omero.web.index_template`). See
       :doc:`/sysadmins/customization` for further information.

    -  Enabling a public user see :doc:`/sysadmins/public`.


Configuring Gunicorn
--------------------

**The following steps are run as the omero-web system user.**

Additional settings can be configured by changing the properties below. Before changing the properties, run ``export PATH=/opt/omero/web/venv3/bin:$PATH``:

    - :property:`omero.web.wsgi_workers` to (2 x NUM_CORES) + 1

      .. note::
          **Do not** scale the number of workers to the number of clients
          you expect to have. OMERO.web should only need 4-12 worker
          processes to handle many requests per second.

    - :property:`omero.web.wsgi_args` Additional arguments. For more details
      check `Gunicorn Documentation <https://docs.gunicorn.org/en/stable/settings.html>`_. For example to enable **debugging**, run the following command::

          omero config set omero.web.wsgi_args -- "--log-level=DEBUG --error-logfile=/opt/omero/web/omero-web/var/log/error.log"



Setting up CORS
---------------


**The following steps are run as root.**

Cross Origin Resource Sharing allows web applications hosted at other origins to access resources from your OMERO.web installation. This can be achieved using the `django-cors-headers <https://github.com/adamchainz/django-cors-headers>`_ app with additional configuration of OMERO.web. See the `django-cors-headers <https://github.com/adamchainz/django-cors-headers>`_ page for more details on the settings::


    /opt/omero/web/venv3/bin/pip install 'django-cors-headers<3.3'

**The following steps are run as the omero-web system user.**

Configure CORS. An ``index`` is used to specify the ordering of middleware classes. It is important to add the ``CorsMiddleware`` as the first class and ``CorsPostCsrfMiddleware`` as the last. You can specify allowed origins in a whitelist, or allow all, for example::

    omero config append omero.web.middleware '{"index": 0.5, "class": "corsheaders.middleware.CorsMiddleware"}'
    omero config append omero.web.middleware '{"index": 10, "class": "corsheaders.middleware.CorsPostCsrfMiddleware"}'
    omero config set omero.web.cors_origin_whitelist '["https://hostname.example.com"]'
    # or to allow all
    omero config set omero.web.cors_origin_allow_all True

Configuring NGINX
-----------------

**The following steps are run as root.**

Copy the generated configuration file into the NGINX configuration directory, disable the default configuration and start NGINX::

    sed -i.bak -re 's/( default_server.*)/; #\1/' /etc/nginx/nginx.conf
    mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.disabled
    if [ -f /etc/nginx/sites-enabled/default ]; then
        rm /etc/nginx/sites-enabled/default
    fi
    cp /opt/omero/web/omero-web/nginx.conf.tmp /etc/nginx/conf.d/omeroweb.conf

    service nginx start


For production servers you may need to add additional directives to the configuration file, for example to enable `HTTPS <https://nginx.org/en/docs/http/configuring_https_servers.html>`_. As an alternative to manually modifying the generated file you can generate a minimal configuration and include this in your own manually created NGINX file, such as :file:`/etc/nginx/conf.d/omero-web.conf`:

    ::

        omero web config nginx-location > /opt/omero/web/omero-web/omero-web-location.include


This requires more initial work but in the future you can automatically regenerate your OMERO.web configuration and your additional configuration settings will still apply.

    .. note::
        If you need help configuring your firewall rules, see the
        :doc:`/sysadmins/server-security` page.



Running OMERO.web
-----------------

**The following steps are run as root.**

Install `WhiteNoise <http://whitenoise.evans.io/>`_::

    /opt/omero/web/venv3/bin/pip install --upgrade whitenoise

*Optional*: Install `Django Redis <https://github.com/niwinz/django-redis/>`_::

    /opt/omero/web/venv3/bin/pip install 'django-redis<4.9'

**The following steps are run as the omero-web system user.**

*Optional*: Configure the cache::

    omero config set omero.web.caches '{"default": {"BACKEND": "django_redis.cache.RedisCache","LOCATION": "redis://127.0.0.1:6379/0"}}'
    omero config set omero.web.session_engine 'django.contrib.sessions.backends.cache'

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
    # chkconfig: - 98 02
    # description: init file for OMERO.web
    ###

    RETVAL=0
    prog=omero-web

    # Read configuration variable file if it is present
    [ -r /etc/default/$prog ] && . /etc/default/$prog

    OMERO_USER=${OMERO_USER:-omero-web}
    OMERO=/opt/omero/web/venv3/bin/omero
    OMERODIR=/opt/omero/web/omero-web
    VENVDIR=${VENVDIR:-/opt/omero/web/venv3}

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

    service redis-server start


    service nginx start
    service omero-web restart


Maintaining OMERO.web
---------------------

**The following steps are run as the omero-web system user.**

You can manage the sessions using the following configuration options and commands:

    -  Session cookies :property:`omero.web.session_expire_at_browser_close`:

       -  A boolean that determines whether to expire the session when the user
          closes their browser.
          See :djangodoc:`Django Browser-length sessions vs. persistent
          sessions documentation <topics/http/sessions/#browser-length-vs-persistent-sessions>`
          for more details. The default value is ``True``::

              omero config set omero.web.session_expire_at_browser_close "True"

       -  The age of session cookies, in seconds. The default value is ``86400``::

              omero config set omero.web.session_cookie_age 86400

    - Clear session:

      Each session for a logged-in user in OMERO.web is kept in the session 
      store. Stale sessions can cause the store to grow with time. OMERO.web 
      uses by default the OS file system as the session store backend and 
      does not automatically purge stale sessions, see
      :djangodoc:`Django file-based session documentation <topics/http/sessions/#using-file-based-sessions>` for more details. It is therefore the responsibility of the OMERO 
      administrator to purge the session cache using the provided management command::
          
          omero web clearsessions

      It is recommended to call this command on a regular basis, for example 
      as a :download:`daily cron job <../../omero-web-cron>`, see
      :djangodoc:`Django clearing the session store documentation <topics/http/sessions/#clearing-the-session-store>` for more information.



Troubleshooting
---------------

**The following steps are run as the omero-web system user.**

In order to identify why OMERO.web is not available run ``omero web status``. Then consult NGINX :file:`error.log` and :file:`/opt/omero/web/omero-web/var/log/OMEROweb.log`.


Configuring Gunicorn advanced options
-------------------------------------

OMERO.web deployment can be configured with sync and async workers. **Sync workers** are faster and recommended for a data repository with :ref:`download_restrictions`. If you wish to offer users the ability to download data then you have to use **async workers**. OMERO.web is able to handle multiple clients on a single worker thread switching context as necessary while streaming binary data from OMERO.server. Depending on the traffic and scale of the repository you should configure connections and speed limits on your server to avoid blocking resources. We recommend you run benchmark and performance tests. It is also possible to apply :ref:`download_restrictions` and offer alternative access to binary data.

    .. note::
        Handling streaming request/responses requires proxy buffering
        to be turned off. For more details refer to
        `Gunicorn deployment <https://docs.gunicorn.org/en/stable/deploy.html>`_
        and
        `NGINX configuration <https://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_buffering>`_.

    .. note::
        :property:`omero.web.application_server.max_requests` should be set to 0


    See
    `Gunicorn design <https://docs.gunicorn.org/en/stable/design.html>`_ for more details.



Experimental: Sync workers
~~~~~~~~~~~~~~~~~~~~~~~~~~

**The following steps are run as root.**

Install :pypi:`futures`::

    /opt/omero/web/venv3/bin/pip install futures

**The following steps are run as the omero-web system user.**

To find out more about the number of worker threads for handling requests, see `Gunicorn threads <https://docs.gunicorn.org/en/stable/settings.html#threads>`_. Additional settings can be configured by changing the following properties::

        omero config set omero.web.wsgi_worker_class
        omero config set omero.web.wsgi_threads $(2-4 x NUM_CORES)



Experimental: Async workers
~~~~~~~~~~~~~~~~~~~~~~~~~~~

**The following steps are run as root.**

Install `Gevent >= 0.13 <http://www.gevent.org/>`_::

    /opt/omero/web/venv3/bin/pip install 'gevent>=0.13'



**The following steps are run as the omero-web system user.**

To find out more about the maximum number of simultaneous clients, see `Gunicorn worker-connections <https://docs.gunicorn.org/en/stable/settings.html#worker-connections>`_. Additional settings can be configured by changing the following properties::

        omero config set omero.web.wsgi_worker_class gevent
        omero config set omero.web.wsgi_worker_connections 1000
        omero config set omero.web.application_server.max_requests 0




.. walkthroughs are generated using ansible, see 
.. https://github.com/ome/omeroweb-install

OMERO.web installation on CentOS 7 and IcePy 3.6
================================================

Please first read :doc:`../../server-centos7-ice36`.


This is an example walkthrough for installing OMERO.web in a **virtual environment** using a dedicated system user. Installing OMERO.web in a virtual environment is the preferred way. For convenience in this walkthrough, we will use the **omero-web system user** and define the main OMERO.web configuration options as environment variables. Since 5.6, a new :envvar:`OMERODIR` variable is used, you should first unset :envvar:`OMERO_HOME` (if set) before beginning the installation process.


**The following steps are run as root.**

If required, first create a local system user omero-web and create directory::

    useradd -m omero-web

    mkdir -p /opt/omero/web/omero-web/etc/grid
    chown -R omero-web /opt/omero/web/omero-web



Installing prerequisites
------------------------

**The following steps are run as root.**


Install dependencies::

    yum -y install epel-release

    yum -y install unzip

    yum -y install python3

    yum -y install nginx


Creating a virtual environment
------------------------------

**The following steps are run as root.**

Create the virtual environment. This is the recommended way to install OMERO.web::

    python3 -mvenv /opt/omero/web/venv3



Install ZeroC IcePy 3.6::

    /opt/omero/web/venv3/bin/pip install --upgrade https://github.com/ome/zeroc-ice-py-centos7/releases/download/0.2.1/zeroc_ice-3.6.5-cp36-cp36m-linux_x86_64.whl


Install OMERO.web::

    /opt/omero/web/venv3/bin/pip install "omero-web>=5.6.3"

Installing OMERO.web apps
-------------------------


A number of apps are available to add functionality to OMERO.web, such as `OMERO.figure <https://www.openmicroscopy.org/omero/figure/>`_ and `OMERO.iviewer <https://www.openmicroscopy.org/omero/iviewer/>`_. See the main website for a `list of released apps <https://www.openmicroscopy.org/omero/apps/>`_. These apps are optional and can be installed, as the **root user**, via :program:`pip` to your OMERO.web virtual environment and configured as the **omero-web system user**, at any time.



Configuring OMERO.web
---------------------

**The following steps are run as the omero-web system user.**

For convenience the main OMERO.web configuration options have been defined as environment variables. You can either use your own values, or alternatively use the following ones::

    export OMERODIR=/opt/omero/web/omero-web
    export WEBPORT=80
    export WEBSERVER_NAME=localhost


Configure OMERO.web and create the NGINX OMERO configuration file::

    export PATH=/opt/omero/web/venv3/bin:$PATH


    omero config set omero.web.application_server wsgi-tcp
    omero web config nginx --http "${WEBPORT}" --servername "${WEBSERVER_NAME}" > /opt/omero/web/omero-web/nginx.conf.tmp

OMERO.web offers a number of configuration options.
    The configuration changes **will not be applied** until
    Gunicorn is restarted using ``omero web restart``.

    -  Session engine:

      -  OMERO.web offers alternative session backends to automatically delete stale data using the cache session store backend, see :djangodoc:`Django cached session documentation <topics/http/sessions/#using-cached-sessions>` for more details.

      - `Redis <https://redis.io/>`_ requires `django-redis <https://github.com/jazzband/django-redis/>`_ in order to be used with OMERO.web. We assume that Redis has already been installed. Follow the step-by-step deployment guides from :doc:`../web-deployment`. To configure the cache, run::

          $ omero config set omero.web.caches '{"default": {"BACKEND": "django_redis.cache.
          RedisCache", "LOCATION": "redis://127.0.0.1:6379/0"}}'

      -  After installing all the cache prerequisites set the following::

          $ omero config set omero.web.session_engine django.contrib.sessions.backends.cache


    - Use a prefix:

      By default OMERO.web expects to be run from the root URL of the webserver.
      This can be changed by setting :property:`omero.web.prefix` and
      :property:`omero.web.static_url`. For example, to make OMERO.web appear at
      `http://example.org/omero/`::

          $ omero config set omero.web.prefix '/omero'
          $ omero config set omero.web.static_url '/omero/static/'

      and regenerate your webserver configuration.

    - Use a different host:

      The front-end webserver e.g. NGINX can be set up to run on a different
      host from OMERO.web. You will need to set
      :property:`omero.web.application_server.host` to ensure OMERO.web is
      accessible on an external IP.

    All configuration options can be found on various sections of
    :ref:`web_index` developers documentation. For the full list, refer to
    :ref:`web_configuration` properties or::

        $ omero web -h

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
      check `Gunicorn Documentation <https://docs.gunicorn.org/en/stable/settings.html>`_.



Setting up CORS
---------------


**The following steps are run as root.**

Cross Origin Resource Sharing allows web applications hosted at other origins to access resources from your OMERO.web installation. This can be achieved using the `django-cors-headers <https://github.com/adamchainz/django-cors-headers>`_ app with additional configuration of OMERO.web. See the `django-cors-headers <https://github.com/adamchainz/django-cors-headers>`_ page for more details on the settings::


    /opt/omero/web/venv3/bin/pip install 'django-cors-headers<3.3'

**The following steps are run as the omero-web system user.**

Configure CORS. An ``index`` is used to specify the ordering of middleware classes. It is important to add the ``CorsMiddleware`` as the first class and ``CorsPostCsrfMiddleware`` as the last. You can specify allowed origins in a whitelist, or allow all, for example::

    omero config append omero.web.middleware '{"index": 0.5, "class": "corsheaders.middleware.CorsMiddleware"}'
    omero config append omero.web.middleware '{"index": 10, "class": "corsheaders.middleware.CorsPostCsrfMiddleware"}'
    omero config set omero.web.cors_origin_whitelist '["hostname.example.com"]'
    # or to allow all
    omero config set omero.web.cors_origin_allow_all True

Configuring NGINX
-----------------

**The following steps are run as root.**

Copy the generated configuration file into the NGINX configuration directory, disable the default configuration and start NGINX::

    sed -i.bak -re 's/( default_server.*)/; #\1/' /etc/nginx/nginx.conf
    if [ -f /etc/nginx/conf.d/default.conf ]; then
        mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
    fi
    cp /opt/omero/web/omero-web/nginx.conf.tmp /etc/nginx/conf.d/omeroweb.conf

    systemctl enable nginx

    systemctl start nginx


Running OMERO.web
-----------------

**The following steps are run as root.**

Install `WhiteNoise <http://whitenoise.evans.io/>`_::

    /opt/omero/web/venv3/bin/pip install --upgrade 'whitenoise<4'


**The following steps are run as the omero-web system user.**


Configure WhiteNoise and start OMERO.web manually to test the installation::

    omero config append -- omero.web.middleware '{"index": 0, "class": "whitenoise.middleware.WhiteNoiseMiddleware"}'

    omero web start

    # Test installation e.g. curl -sL localhost:4080

    omero web stop

Automatically running OMERO.web
-------------------------------


**The following steps are run as root.**

Should you wish to run OMERO.web automatically, a `systemd.service` file could be created. See below an example file `omero-web-systemd.service`::

    [Unit]
    Description=OMERO.web
    # Not mandatory, NGINX may be running on a different server
    Requires=nginx.service
    After=network.service

    [Service]
    User=omero-web
    Type=forking
    PIDFile=/opt/omero/web/omero-web/var/django.pid
    Restart=no
    RestartSec=10
    Environment="PATH=/opt/omero/web/venv3/bin:/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin""
    Environment="OMERODIR=/opt/omero/web/omero-web"
    ExecStart=/opt/omero/web/venv3/bin/omero web start
    ExecStop=/opt/omero/web/venv3/bin/omero web stop

    [Install]
    WantedBy=multi-user.target

Copy the `systemd.service` file, then enable and start the service::

    cp omero-web-systemd.service /etc/systemd/system/omero-web.service

    systemctl daemon-reload

    systemctl enable omero-web.service

    systemctl stop omero-web.service

    systemctl start omero-web.service



Maintaining OMERO.web
---------------------

**The following steps are run as the omero-web system user.**

If an attempt is made to access OMERO.web whilst it is not running, the generated NGINX configuration file will automatically display a maintenance page.

    -  Session cookies :property:`omero.web.session_expire_at_browser_close`:

       -  A boolean that determines whether to expire the session when the user
          closes their browser.
          See :djangodoc:`Django Browser-length sessions vs. persistent
          sessions documentation <topics/http/sessions/#browser-length-vs-persistent-sessions>`
          for more details. The default value is ``True``::

              $ omero config set omero.web.session_expire_at_browser_close "True"

       -  The age of session cookies, in seconds. The default value is ``86400``::

              $ omero config set omero.web.session_cookie_age 86400

    - Clear session:

      Each session for a logged-in user in OMERO.web is kept in the session 
      store. Stale sessions can cause the store to grow with time. OMERO.web 
      uses by default the OS file system as the session store backend and 
      does not automatically purge stale sessions, see
      :djangodoc:`Django file-based session documentation <topics/http/sessions/#using-file-based-sessions>` for more details. It is therefore the responsibility of the OMERO 
      administrator to purge the session cache using the provided management command::
          
          $ omero web clearsessions

      It is recommended to call this command on a regular basis, for example 
      as a :download:`daily cron job <../../omero-web-cron>`, see
      :djangodoc:`Django clearing the session store documentation <topics/http/sessions/#clearing-the-session-store>` for more information.



Customizing your OMERO.web installation
---------------------------------------

**The following steps are run as the omero-web system user.**

OMERO.web offers a number of configuration options.
    The configuration changes **will not be applied** until
    Gunicorn is restarted using ``omero web restart``.

    -  Session engine:

      -  OMERO.web offers alternative session backends to automatically delete stale data using the cache session store backend, see :djangodoc:`Django cached session documentation <topics/http/sessions/#using-cached-sessions>` for more details.

      - `Redis <https://redis.io/>`_ requires `django-redis <https://github.com/jazzband/django-redis/>`_ in order to be used with OMERO.web. We assume that Redis has already been installed. Follow the step-by-step deployment guides from :doc:`../web-deployment`. To configure the cache, run::

          $ omero config set omero.web.caches '{"default": {"BACKEND": "django_redis.cache.
          RedisCache", "LOCATION": "redis://127.0.0.1:6379/0"}}'

      -  After installing all the cache prerequisites set the following::

          $ omero config set omero.web.session_engine django.contrib.sessions.backends.cache


    - Use a prefix:

      By default OMERO.web expects to be run from the root URL of the webserver.
      This can be changed by setting :property:`omero.web.prefix` and
      :property:`omero.web.static_url`. For example, to make OMERO.web appear at
      `http://example.org/omero/`::

          $ omero config set omero.web.prefix '/omero'
          $ omero config set omero.web.static_url '/omero/static/'

      and regenerate your webserver configuration.

    - Use a different host:

      The front-end webserver e.g. NGINX can be set up to run on a different
      host from OMERO.web. You will need to set
      :property:`omero.web.application_server.host` to ensure OMERO.web is
      accessible on an external IP.

    All configuration options can be found on various sections of
    :ref:`web_index` developers documentation. For the full list, refer to
    :ref:`web_configuration` properties or::

        $ omero web -h

    The most popular configuration options include:

    -  Debug mode, see :property:`omero.web.debug`.

    -  Customizing OMERO clients e.g. to add your own logo to the login page
       (:property:`omero.web.login_logo`) or use an index page as an alternative
       landing page for users (:property:`omero.web.index_template`). See
       :doc:`/sysadmins/customization` for further information.

    -  Enabling a public user see :doc:`/sysadmins/public`.


SELinux
-------

**The following steps are run as root.**

If you are running a system with `SELinux enabled <https://wiki.centos.org/HowTos/SELinux>`_ and are unable to access OMERO.web you may need to adjust the security policy::

    if [ $(getenforce) != Disabled ]; then

        yum -y install policycoreutils-python
        setsebool -P httpd_read_user_content 1
        setsebool -P httpd_enable_homedirs 1
        semanage port -a -t http_port_t -p tcp 4080

    fi

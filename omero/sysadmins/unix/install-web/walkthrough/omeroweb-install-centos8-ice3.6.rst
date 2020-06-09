.. walkthroughs are generated using ansible, see 
.. https://github.com/ome/omeroweb-install

OMERO.web installation on CentOS 8 and IcePy 3.6
================================================

Please first read :doc:`../../server-centos8-ice36`.


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

    /opt/omero/web/venv3/bin/pip install --upgrade https://github.com/ome/zeroc-ice-centos8/releases/download/0.0.1/zeroc_ice-3.6.5-cp36-cp36m-linux_x86_64.whl



Install OMERO.web::

    /opt/omero/web/venv3/bin/pip install "omero-web>=5.6.1"

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


Copy the `systemd.service` file, then enable and start the service::

    cp omero-web-systemd.service /etc/systemd/system/omero-web.service

    systemctl daemon-reload

    systemctl enable omero-web.service

    systemctl stop omero-web.service

    systemctl start omero-web.service



Maintenance
-----------


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


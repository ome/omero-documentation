.. walkthroughs are generated using ansible, see 
.. https://github.com/ome/omeroweb-install

OMERO.web installation separately from OMERO.server on CentOS 7 and IcePy 3.6
=============================================================================

Please first read :doc:`../../server-centos7-ice36`.


This is an example walkthrough for installing OMERO.web decoupled from the OMERO.server in a **virtual environment** using OMERO.py and a dedicated system user. Installing OMERO.web in a virtual environment is the preferred way. For convenience in this walkthrough, we will use the **omero system user** and define the main OMERO.web configuration options as environment variables.

**The following steps are run as root.**

If required, first create a local system user omero and create the homedir too :file:`/home/omero`::
    
    useradd -m omero
    
    chmod a+X /home/omero



Installing prerequisites
------------------------

**The following steps are run as root.**


Install dependencies. The number of dependencies to install depends on the way you plan to install OMERO.web. If you wish to install it in a virtual environment created with ``--system-site-packages`` *on* (**option 1**), you will need to install ``python-pillow`` and ``numpy``. If you wish to install it in a virtual environment with ``--system-site-packages`` *off*, a few more dependencies will be required (**option 2**)::
    
    # dependencies common to both options
    yum -y install epel-release
    
    yum -y install unzip
    
    yum -y install python-{pip,jinja2}
    
    yum -y install nginx
    
    # install the latest version
    pip install --upgrade pip
    pip install --upgrade virtualenv
    
    # To install OMERO.web using option 1
    yum -y install python-pillow numpy
    
    # To install OMERO.web using option 2
    yum -y install python-devel libjpeg-devel libtiff libtiff-devel zlib-devel
    


Creating a virtual environment
------------------------------

**The following steps are run as the omero system user.**

Create the virtual environment. This is the preferred way to install OMERO.web::
    
    # option 1: in a virtual environment with --system-site-packages on
    virtualenv /home/omero/omerowebvenv --system-site-packages
    
    # option 2: in a virtual environment with --system-site-packages off
    virtualenv /home/omero/omerowebvenv
    

Installing OMERO.web
--------------------

**The following steps are run as the omero system user.**

Install OMERO.web using OMERO.py::
    
    cd /home/omero
    curl -o OMERO.py.zip -L https://downloads.openmicroscopy.org/latest/omero5/py.zip
    unzip -q OMERO.py*
    
    zip=$(ls OMERO.py*.zip)
    rm -f $zip
    ln -s OMERO.py-* OMERO.py

**The following steps are run as the omero system user.**

Install ZeroC IcePy 3.6::
    
    # option 1 and option 2
    /home/omero/omerowebvenv/bin/pip install --upgrade https://github.com/ome/zeroc-ice-py-centos7/releases/download/0.1.0/zeroc_ice-3.6.4-cp27-cp27mu-linux_x86_64.whl

Install the OMERO.web requirements. Select one of the commands corresponding to the way you have opted to install it::
    
    # option 1: in a virtual environment with --system-site-packages on
    /home/omero/omerowebvenv/bin/pip install --upgrade -r /home/omero/OMERO.py/share/web/requirements-py27.txt
    
    # option 2: in a virtual environment with --system-site-packages off
    /home/omero/omerowebvenv/bin/pip install --upgrade -r /home/omero/OMERO.py/share/web/requirements-py27-all.txt
    
    

Installing OMERO.web apps
-------------------------

**The following steps are run as the omero system user.**

A number of apps are available to add functionality to OMERO.web, such as `OMERO.figure <https://www.openmicroscopy.org/omero/figure/>`_ and `OMERO.iviewer <https://www.openmicroscopy.org/omero/iviewer/>`_. See the main website for a `list of released apps <https://www.openmicroscopy.org/omero/apps/>`_. These apps are optional and can be installed via :program:`pip` to your OMERO.web virtual environment at any time.


Configuring OMERO.web
---------------------

**The following steps are run as the omero system user.**

For convenience the main OMERO.web configuration options have been defined as environment variables. You can either use your own values, or alternatively use the following ones::
    
    export WEBPORT=80
    export WEBSERVER_NAME=localhost

Configure OMERO.web and create the NGINX OMERO configuration file::
    
    . /home/omero/omerowebvenv/bin/activate
    
    /home/omero/OMERO.py/bin/omero config set omero.web.application_server wsgi-tcp
    /home/omero/OMERO.py/bin/omero web config nginx --http "${WEBPORT}" --servername "${WEBSERVER_NAME}" > /home/omero/nginx.conf.tmp

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
    if [ -f /etc/nginx/conf.d/default.conf ]; then
        mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
    fi
    cp /home/omero/nginx.conf.tmp /etc/nginx/conf.d/omeroweb.conf
    
    systemctl enable nginx
    
    systemctl start nginx

Running OMERO.web
-----------------

**The following steps are run as the omero system user.**

Install `WhiteNoise <http://whitenoise.evans.io/>`_::
    
    . /home/omero/omerowebvenv/bin/activate
    
    pip install --upgrade 'whitenoise<4'

Configure WhiteNoise and start OMERO.web manually to test the installation::
    
    . /home/omero/omerowebvenv/bin/activate
    
    /home/omero/OMERO.py/bin/omero config append -- omero.web.middleware '{"index": 0, "class": "whitenoise.middleware.WhiteNoiseMiddleware"}'
    
    /home/omero/OMERO.py/bin/omero web start
    
    # Test installation e.g. curl -sL localhost:4080
    
    /home/omero/OMERO.py/bin/omero web stop


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
    User=omero
    Type=forking
    PIDFile=/home/omero/OMERO.py/var/django.pid
    Restart=no
    RestartSec=10
    Environment="PATH=/home/omero/omerowebvenv/bin:/bin:/usr/bin"
    ExecStart=/home/omero/omerowebvenv/bin/python /home/omero/OMERO.py/bin/omero web start
    ExecStop=/home/omero/omerowebvenv/bin/python /home/omero/OMERO.py/bin/omero web stop
    
    [Install]
    WantedBy=multi-user.target

Copy the `systemd.service` file, then enable and start the service::
    
    cp omero-web-systemd.service /etc/systemd/system/omero-web.service
    
    systemctl daemon-reload
    
    systemctl enable omero-web.service
    
    systemctl stop omero-web.service
    
    systemctl start omero-web.service


Maintenance
-----------

**The following steps are run as the omero system user.**

Please read :ref:`omero_web_maintenance`.

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


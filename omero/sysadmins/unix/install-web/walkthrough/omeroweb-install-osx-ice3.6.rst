.. walkthroughs are generated using ansible, see 
.. https://github.com/ome/omeroweb-install

OMERO.web installation on Mac OS X and IcePy 3.6
================================================

Please first read :doc:`../../server-install-homebrew`.


This is an example walkthrough for installing OMERO.web decoupled from the OMERO.server in a **virtual environment** using OMERO.py and a dedicated system user. Installing OMERO.web in a virtual environment is the preferred way. For convenience in this walkthrough, we will use the ** system user** and define the main OMERO.web configuration options as environment variables.

**The following steps are run as root.**


Install Homebrew in /usr/local::
    
    xcode-select --install
    
    
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    
    brew update
    brew doctor

Installing prerequisites
------------------------


Install dependencies::
    
    brew install python 
    brew install nginx
    pip install --upgrade virtualenv


Creating virtual environment
----------------------------


Create the virtual environment. This is the preferred way to install OMERO.web::
    
    # option 1: in a virtual environment with --system-site-packages on
    virtualenv ~/omerowebvenv --system-site-packages
    
    # option 2: in a virtual environment with --system-site-packages off
    virtualenv ~/omerowebvenv
    

Installing OMERO.web
--------------------


Install OMERO.web using OMERO.py::
    
    cd ~
    curl -o OMERO.py.zip -L https://downloads.openmicroscopy.org/latest/omero5/py.zip
    unzip -q OMERO.py*
    
    zip=$(ls OMERO.py*.zip)
    rm -f $zip
    ln -s OMERO.py-* OMERO.py

Install dependencies::
    
    brew install python 
    brew install nginx
    pip install --upgrade virtualenv



Install the OMERO.web requirements. Select one of the commands corresponding to the way you have opted to install it::
    
    # option 1: in a virtual environment with --system-site-packages on
    ~/omerowebvenv/bin/pip install --upgrade -r ~/OMERO.py/share/web/requirements-py27.txt
    
    # option 2: in a virtual environment with --system-site-packages off
    ~/omerowebvenv/bin/pip install --upgrade -r ~/OMERO.py/share/web/requirements-py27-all.txt
    
    

Installing OMERO.web apps
-------------------------


A number of apps are available to add functionality to OMERO.web, such as `OMERO.figure <https://www.openmicroscopy.org/omero/figure/>`_ and `OMERO.iviewer <https://www.openmicroscopy.org/omero/iviewer/>`_. See the main website for a `list of released apps <https://www.openmicroscopy.org/omero/apps/>`_. These apps are optional and can be installed via :program:`pip` to your OMERO.web virtual environment at any time.


Configuring OMERO.web
---------------------


For convenience the main OMERO.web configuration options have been defined as environment variables. You can either use your own values, or alternatively use the following ones::
    
    export WEBPORT=80
    export WEBSERVER_NAME=localhost

Configure OMERO.web and create the NGINX OMERO configuration file::
    
    . ~/omerowebvenv/bin/activate
    
    ~/OMERO.py/bin/omero config set omero.web.application_server wsgi-tcp
    ~/OMERO.py/bin/omero web config nginx --http "${WEBPORT}" --servername "${WEBSERVER_NAME}" > ~/nginx.conf.tmp

For more customization, please read :ref:`customizing_your_omero_web_installation`.

Configuring Gunicorn
--------------------


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


Copy the generated configuration file into the NGINX configuration directory::
    
    cp ~/nginx.conf.tmp /usr/local/etc/nginx/servers/omeroweb-nginx.conf
    
    # Restart webserver
    brew services restart nginx

Standalone OMERO.web
--------------------


Install `WhiteNoise <http://whitenoise.evans.io/>`_::
    
    . ~/omerowebvenv/bin/activate
    
    pip install --upgrade 'whitenoise<4'

Configure WhiteNoise and start OMERO.web manually to test the installation::
    
    . ~/omerowebvenv/bin/activate
    
    ~/OMERO.py/bin/omero config append -- omero.web.middleware '{"index": 0, "class": "whitenoise.middleware.WhiteNoiseMiddleware"}'
    
    ~/OMERO.py/bin/omero web start
    
    # Test installation e.g. curl -sL localhost:4080
    
    ~/OMERO.py/bin/omero web stop


Running OMERO.web
-----------------



Start up services::
    
    source ~/omerowebvenv/bin/activate
    
    # Start OMERO.web
    ~/OMERO.py/bin/omero web start

Maintenance
-----------


Please read :ref:`omero_web_maintenance`.


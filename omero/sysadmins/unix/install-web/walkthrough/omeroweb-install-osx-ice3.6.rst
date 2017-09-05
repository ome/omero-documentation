OMERO.web installation on Mac OS X and IcePy 3.6
================================================

Please first read :doc:`../../server-install-homebrew`.


This is an example walkthrough for installing OMERO.web decoupled from the OMERO.server in a **virtual environment** using OMERO.py and a dedicated system user. Installing OMERO.web in a virtual environment is the preferred way. For convenience in this walkthrough the main OMERO.web configuration options have been defined as environment variables. When following this walkthrough you can either use your own values, or alternatively use the following ones::
    
    OMERO_USER=
    WEBPORT=80
    WEBSERVER_NAME=localhost

Install Homebrew in /usr/local::
    
    xcode-select --install
    
    
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    
    brew update
    brew doctor

**The following steps are run as root.**


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
    curl -o OMERO.py.zip -L https://downloads.openmicroscopy.org/latest/omero/py.zip
    unzip -q OMERO.py*
    
    zip=$(ls OMERO.py*.zip)
    rm -f $zip
    ln -s OMERO.py-* OMERO.py

**The following steps are run as root.**

Install the OMERO.web requirements. Select one of the commands corresponding to the way you have opted to install it::
    
    # option 1: in a virtual environment with --system-site-packages on
    ~/omerowebvenv/bin/pip install --upgrade -r ~/OMERO.py/share/web/requirements-py27.txt
    
    # option 2: in a virtual environment with --system-site-packages off
    ~/omerowebvenv/bin/pip install --upgrade -r ~/OMERO.py/share/web/requirements-py27-all.txt
    
    

Configuring OMERO.web
---------------------


Configure OMERO.web and create the NGINX OMERO configuration file::
    
    . ~/omerowebvenv/bin/activate
    
    ~/OMERO.py/bin/omero config set omero.web.application_server wsgi-tcp
    ~/OMERO.py/bin/omero web config nginx --http "${WEBPORT}" --servername "${WEBSERVER_NAME}" > ~/nginx.conf.tmp

For more customization, please read :ref:`customizing_your_omero_web_installation`.

Configuring NGINX
-----------------


Copy the generated configuration file into the NGINX configuration directory::
    
    cp ~/nginx.conf.tmp /usr/local/etc/nginx/servers/omeroweb-nginx.conf
    
    # Restart webserver
    brew services restart nginx

Running OMERO.web
-----------------

To start the OMERO.web client run::
    
    source ~/omerowebvenv/bin/activate
    
    OMERO.py/bin/omero web start



Start up services::
    
    source ~/omerowebvenv/bin/activate
    
    # Start OMERO.web
    ~/OMERO.py/bin/omero web start

Maintenance
-----------


Please read :ref:`omero_web_maintenance`.


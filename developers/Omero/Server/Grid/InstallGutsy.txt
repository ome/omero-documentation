.. _developers/Omero/Server/Grid/InstallGutsy:

Installing OMERO Grid on Ubuntu Gutsy
======================================

OS Installation
---------------

The directions which follow are based on a minimal Gutsy install. This
was performed from the Gutsy iso image found at
` https://help.ubuntu.com/community/Installation/MinimalCD <https://help.ubuntu.com/community/Installation/MinimalCD>`_.
During installation, an OS user ``omero`` was created with the password
``omero``.

This from-the-ground-up testing is special for Gutsy and influences the
instruction seen below. Hopefully, the
` VirtualBox <http://virtualbox.org>`_ image used can be made available
via bittorrent.

Prerequisites
-------------

::

    sudo apt-get install sun-java6-jdk unzip python-zeroc-ice icegrid postgresql

Pre-Installation
----------------

::

    sudo su - postgres -c "createuser omero"
    createuser omero3

    # Configure postgres to accept connections from `omero` user over TCP
    sudo cp pg_hba.conf /etc/postgresql/8.2/main/
    sudo cp postgresql.conf /etc/postgresql/8.2/main/
    sudo /etc/init.d/postgresql restart

The files used here are available under :source:`docs/install/gutsy`.

Starting on boot
----------------

Following :ref:`server/installation#Installation`,
execute the following as root:

::

    #
    # Adds omero-admin as an init script
    #
    sudo ln -s `pwd`/bin/omero /etc/init.d/omero-admin
    sudo update-rc.d omero-admin defaults

    #
    # For this to work, however, it is necessary to modify
    # etc/grid/templates.xml to start as the proper user.
    #
    cp templates.xml etc/grid

    #
    # Start the grid and deploy (only necessary during install)
    #
    sudo /etc/init.d/omero-admin start
    sudo /etc/init.d/omero-admin deploy

    #
    # Stopping
    #
    sudo /etc/init.d/omero-admin stop

.. seealso:: :ref:`server/installation`, :ref:`developers/Omero/Server/Grid/Install`

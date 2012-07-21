.. _rst_install_macports:

Install - Walkthrough on 10.6 using MacPorts.
=============================================

This walkthrough is a list of the commands used to install OMERO on a
clean Mac OS 10.6 SnowLeopard using MacPorts to install Postgres 8.4,
PIL & Matplot for Python 2.6.

Contents

It is not a substitute for the general `install <installation>`_ page
but is here to give a feel for the process.

There is an accompanying video available
`here <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-1/mov/SnowInstall.mov>`_.
This shows the install of OMERO 4.1 onto 10.6 using the version of
MacPorts available at the time.

    **At present Ice 3.4.x is not supported by OMERO. This is now the
    default version installed by MacPorts so these instructions have
    been modified to download pre-built binaries from
    http://glencoesoftware.com. The accompanying video predates Ice
    3.4.x so where there is a difference this page is the correct
    version.**

    ***These instructions are only for 64-bit machines***

    **The version of ice-python26 @3.3.1\_1 has been removed by MacPorts
    so the commands have changed.**

--------------

1: Xcode
~~~~~~~~

On a completely clean machine the first step is to install Xcode from
Apple. This is required by MacPorts. Xcode is usually available as an
optional install on the CD that came with your mac. If not it is
available as a download from `Apple <http://www.apple.com/>`_. A
permanent links is not available as you have to register for the
download.

2: MacPorts
~~~~~~~~~~~

The MacPorts product is avaliable from
`http://www.macports.org/ <http://www.macports.org/>`_ Simply download
the disk image (.dmg), in this case for Snow Leopard and follow the
steps in the installer. The default settings should be fine.

3: Ports for the OMERO pre-requisites
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We need to install several ports (software bundles). If you install all
of these in one port command MacPorts should correctly set up most of
the paths so the preferred command is:

Prefered method
'''''''''''''''

::

    sudo port install postgresql84 postgresql84-server py26-pil py26-matplotlib python_select

This will also install all the pre-requisites for these software bundles
and **will take some time**.

    If you use the individual command listed below you may find MacPorts
    has not got all the paths correct. This may be necessary is you are
    installing on a system which already has some of the packages
    installed.

Less prefered method
''''''''''''''''''''

::

    sudo port install postgresql84
    sudo port install postgresql84-server
    sudo port install python_select
    sudo port install py26-pil
    sudo port install py26-matplotlib

4: Configure Postgres
~~~~~~~~~~~~~~~~~~~~~

We want the postgres server to start when the system restarts so we add
the correct settings to the system launch settings

::

    sudo launchctl load -w /Library/LaunchDaemons/org.macports.postgresql84-server.plist

We create a directory for the postgres databases

::

    sudo mkdir -p /opt/local/var/db/postgresql84/defaultdb

Change its owner to be the postgres user and group

::

    sudo chown postgres:postgres /opt/local/var/db/postgresql84/defaultdb

We then create the initial databases needed by postgres in this location

::

    sudo su postgres -c '/opt/local/lib/postgresql84/bin/initdb -D /opt/local/var/db/postgresql84/defaultdb'

At this point if you **restart** the system the postgres server should
be ready for connections.

5: Configure Python
~~~~~~~~~~~~~~~~~~~

MacPorts will install a new version of python along side the Apple
supplied one that came with your system. You use the ``python_select``
command we installed using MacPorts to choose the one you use:

::

    sudo port select python python26

If you need to revert back to the apple versions you can use:

::

    sudo port select python python26-apple

6. Install Ice 3.3.1 from Glencoe Software, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since the version of Ice in MacPorts has changed to 3.4.x, the easiest
way to install Ice is by downloading the pre-built binaries provided by
Glencoe Software:
`Ice-3.3.1-64.tar.bz2 <http://www.glencoesoftware.com/mac/10.6/Ice-3.3.1-64.tar.bz2>`_
(sha1=eeebd9865869bb513f2a5274a09aa498418bb4db).

These should be unpacked to some directory. In these instructions we'll
use "/opt/Ice-3.3.1-64", but you can place them anywher you'd like as
long as the user running OMERO can access them.

7: Configure PATH and PYTHONPATH
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To configure the paths you need to edit the users ``.profile`` file. You
should add the following lines.

::

    export ICE_HOME=/opt/Ice-3.3.1-64
    export PATH=/opt/local/lib/postgresql84/bin:/opt/local/bin:/opt/local/sbin:$PATH

    # The path to add depends on you OMERO install location.
    export PYTHONPATH=/Users/andrew/Desktop/OMERO/lib/python/:/opt/Ice-3.3.1-64/python:$PYTHONPATH

Optional Configure PYTHONPATH for pre-requisites
''''''''''''''''''''''''''''''''''''''''''''''''

To check if you PYTHONPATH is correct you can try:

::

    % python
    Python 2.6.3 (r263:75183, Oct 15 2009, 19:52:33) 
    [GCC 4.2.1 (Apple Inc. build 5646)] on darwin
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import Ice
    >>> import Image
    >>> import matplotlib
    >>> exit()
    %

    If your python path was not correctly configured by MacPorts you can
    add the individual packages directories to your python path. To find
    where MacPorts has installed a package you can use the location
    command. e.g. for Python Image Library

::

    port location py26-pil

    When you have found the lib folder in this location you can add it
    to the PYTHONPATH in the ``.profile`` file.

::

    export PYTHONPATH=/(your-matplot-lib-location)/python2.6/site-packages/matplotlib/:$PYTHONPATH
    export PYTHONPATH=/(your-PIL-lib-location)/python2.6/site-packages/PIL/:$PYTHONPATH
    export PYTHONPATH=(your-ICE-lib-location)/python2.6/site-packages/:$PYTHONPATH
    # and so on...

We are now following the steps outlined in the general install process.
-----------------------------------------------------------------------

8: Create OMERO databases and folders
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create OMERO databases and directories

::

    sudo -u postgres createuser -P -D -R -S db_user
    sudo -u postgres createdb -O db_user omero_database
    sudo -u postgres createlang plpgsql omero_database
    psql -h localhost -U db_user -l
    sudo mkdir /OMERO
    whoami
    sudo chown -R andrew /OMERO

9: Configure and launch the server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    cd /Users/andrew/Desktop/OMERO
    bin/omero db script
    psql -h localhost -U db_user omero_database < OMERO4.1__0.sql

Starting the server
'''''''''''''''''''

::

    bin/omero admin start

Stopping the server
'''''''''''''''''''

::

    bin/omero admin stop
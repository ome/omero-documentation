Deprecated Page

Contributing to OMERO
=====================

Table of Contents
^^^^^^^^^^^^^^^^^

#. `Getting Started with
   OMERO.server <#GettingStartedwithOMERO.server>`_
#. `Installing From Source: Check out the
   code <#InstallingFromSource:Checkoutthecode>`_

   #. `Gitweb source code view <#Gitwebsourcecodeview>`_
   #. `Requirements <#Requirements>`_
   #. `Setting up your data repository <#Settingupyourdatarepository>`_
   #. `Building <#Building>`_
   #. `Setting up your database <#Settingupyourdatabase>`_
   #. `Checking your deployment <#Checkingyourdeployment>`_
   #. `Setting up users <#Settingupusers>`_
   #. `Running code <#Runningcode>`_

#. `Having Trouble? Want to know more? <#HavingTroubleWanttoknowmore>`_
#. `Guide for the impatient <#Guidefortheimpatient>`_

Getting Started with OMERO.server
---------------------------------

Getting started with OMERO entails having a working
` Ice <http://zeroc.com/ice>`_ installation, an accessible relational
database, and some minor configuration. Once the application has been
deployed, it is possible to use the
`OmeroClientLibrary </ome/wiki/OmeroClientLibrary>`_ or the
OMERO.insight Java client to access the server.

Installing From Source: Check out the code
------------------------------------------

On January 20th 2011, the OME team transitioned to the distributed
version control system Git
(` http://git-scm.com/ <http://git-scm.com/>`_). Access to the legacy
Subversion repositories will remain for some time, but will not be
updated with new source code. OMERO.clients and OMERO.server are now
located in the same Git repository with all Subversion history is
preserved.

::

    git clone git://git.openmicroscopy.org/ome.git

Gitweb source code view
~~~~~~~~~~~~~~~~~~~~~~~

    ` http://git.openmicroscopy.org/ <http://git.openmicroscopy.org/>`_

Requirements
~~~~~~~~~~~~

-  Install a Java 5 or 6 Development Kit (JDK), available from ` Java SE
   Downloads <http://java.sun.com/javase/downloads/index.jsp>`_ or
   perhaps your package manager of choiced. Java is required for both
   the OMERO server and client code. Set the ``JAVA_HOME`` environment
   variable to your JDK installation.
-  Install Python 2.4 or higher, available from
   ` http://python.org <http://python.org>`_ or your package manager of
   choice. Python is required only for the server installations.
-  Install Ice 3.3.x, available from
   ` http://zeroc.com/ <http://zeroc.com/>`_. The following executables
   should all be on your PATH: ``icegridnode``, ``icegridadmin``,
   ``slice2java``, ``slice2cpp``, ``slice2py``.
-  Install PostgreSQL, available from
   ` http://postgresql.org <http://postgresql.org>`_. Version 8.4 or
   later is required. Your database installation will need to be
   available over TCP and have an accessible, empty database.

**Note:** Much of what follows can be cut-n-pasted into bash.

Setting up your data repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before starting the server, it is also necessary to create the data
repository directories. The location of the repository is specified by
the ``omero.data.dir`` property in your configuration. See
`OmeroCli </ome/wiki/OmeroCli>`_ for more information on configuration.

::

    # You will also need to make sure that the directory exists
    mkdir -p /OMERO

**Note:** If at any time you remove *either* the database *or* the data
repository, you should also remove the other. In this way, a fresh
system can be created.

Building
~~~~~~~~

::

    svn co http://svn.openmicroscopy.org.uk/svn/omero/trunk omero
    # a.k.a. OMERO_HOME
    # or check out a stable milestone
    # svn co http://svn.openmicroscopy.org.uk/svn/omero/tags/omero-4.0.0 omero

    cd omero

    # The build.py script is just a very thin wrapper
    # around a call to "java omero" our ant build.
    # We have been experiencing issues with memory
    # limits on 64bit systems, though, and build.py
    # takes care of these.

    ./build.py

**If you are interested in building `OmeroCpp </ome/wiki/OmeroCpp>`_,
please see the section on under
`OmeroBuild#scons </ome/wiki/OmeroBuild#scons>`_**

Setting up your database
~~~~~~~~~~~~~~~~~~~~~~~~

An initialized OMERO database is necessary for the server to start (see
below). The name (here: ``omero``) is unimportant, but must match the
name chosen during setup (also below).

::

    # Create the postgres database
    dropdb omero
    createdb omero
    createlang plpgsql omero

    # Go into the distribution directory
    # you built during ./build.py and
    # create the db script
    bin/omero db script

    # Now initialize the db
    psql omero < OMERO4__0.sql

Checking your deployment
~~~~~~~~~~~~~~~~~~~~~~~~

::

    # Start OMERO
    bin/omero admin start

Setting up users
~~~~~~~~~~~~~~~~

Before you can run any code against the server, you'll have to have at
least one non-root user, who is in the "user" group. Though not fully
functional, the best way to achieve this is via the webadmin client. See
OmeroWeb for more information or browse to:
` http://localhost:8000/webadmin <http://localhost:8000/webadmin>`_

Running code
~~~~~~~~~~~~

Once you've done all that you can run the examples provided with the
source code:

::

    cd ..   # Back to the top-level directory
    cd examples
    python ../scons/scons.py run=1

**These are examples are explained in detail on the
`OmeroClients </ome/wiki/OmeroClients>`_ page.**

It is helpful to setup the projects in
` Eclipse <http://www.eclipse.org>`_ to run tests. For information on
doing that, see `OmeroDevelopment </ome/wiki/OmeroDevelopment>`_. And
for more information on writing code against the server, see
`OmeroClientLibrary </ome/wiki/OmeroClientLibrary>`_.

Having Trouble? Want to know more?
----------------------------------

Take a look at the
`OmeroDevelopmentFaq </ome/wiki/OmeroDevelopmentFaq>`_ or
` report <http://trac.openmicroscopy.org.uk/omero/query?status=new&status=assigned&status=reopened&group=component&order=priority|tickets>`_
for common problems.

Advanced users may want to look at the
`OmeroBuild </ome/wiki/OmeroBuild>`_ page to understand what is going on
behind the scenes.

Guide for the impatient
-----------------------

If you zoomed all the way to bottom, you probably are in a hurry. Take a
look at:

::

    #!/bin/bash
    set -e
    #
    # Prerequisites
    #
    java -version
    python --version 2>&1 | grep -E "Python 2.(4|5)"
    icegridnode --version 2>&1 | grep 3.3
    glacier2router --version 2>&1 | grep 3.3
    psql -U omero -h localhost -l 1> /dev/null
    #
    # Build
    #
    if test -e QUICKSTART.txt; then
        cd ..
    fi
    test -e build.py
    test -e build.xml
    ./build.py
    cd dist
    #
    # Setup database
    #
    bin/omero db script -f QUICKSTART.sql "" "" mypassword
    createlang plpgsql omero || echo "Database already ready?"
    psql -U omero -h localhost omero < QUICKSTART.sql
    #
    # Start
    #
    bin/omero admin start

or for Windows:

::

    @echo OFF
    REM
    REM QUICKSTART.bat is intended for getting developers
    REM up and running quickly. You will need to have
    REM passwordless login for the "omero" DB user configured
    REM in postgres.
    REM
    REM For more information, see http://trac.openmicroscopy.org.uk/ome/wiki/OmeroContributing
    echo.
    echo -----------------------------------------------------
    echo To prevent needing a restart, this script uses the
    echo current user to run the service. You will need to
    echo enter your NT password below. Careful: your password
    echo will be displayed in cleartext.
    echo -----------------------------------------------------
    echo.
    echo Logging in user for service: %USERDOMAIN%\%USERNAME%
    echo.
    REM Move to the directory above this script's directory
    REM i.e. OMERO_HOME
    cd "%~dp0\.."
    if "x%PASSWORD%" == "x" (SET /P PASSWORD=Password:)
    REM Other defaults
    if "x%ROUTERPREFIX%" == "x" (SET ROUTERPREFIX="")
    if "x%OMERO_DIST_DIR%" == "x" (SET OMERO_DIST_DIR="%cd%\dist")
    if exist %OMERO_DIST_DIR% goto AlreadyBuilt
      echo Building...
      REM As of 5c6fc7313f129 it's no longer possible to pass
      REM dist.dir to build.py
      python -c "import sys, os; print 'dist.dir=%%s' %% os.environ['OMERO_DIST_DIR'].replace('\\','\\\\')" > etc\local.properties
      if errorlevel 1 goto ERROR
      python build.py
      if errorlevel 1 goto ERROR
      goto Ready
    :AlreadyBuilt
      echo Server already built. To rebuild, use "build clean"
      goto Ready
    :Ready
    cd %OMERO_DIST_DIR%
    echo Stopping server...
    python bin\omero admin status && python bin\omero admin stop
    if errorlevel 1 echo "Wasn't running?"
    if "x%OMERO_CONFIG%" == "x" (set OMERO_CONFIG=quickstart)
    echo Using OMERO_CONFIG=%OMERO_CONFIG%
    echo Dropping %OMERO_CONFIG% db
    dropdb -U postgres %OMERO_CONFIG%
    if errorlevel 1 echo Didn't exist?
    echo Creating omero database user
    createuser -S -D -R -U postgres omero
    if errorlevel 1 echo Already exists?
    echo Creating %OMERO_CONFIG% db
    createdb -O omero -U postgres %OMERO_CONFIG%
    if errorlevel 1 goto ERROR
    echo Adding pgsql to db
    createlang -U postgres plpgsql %OMERO_CONFIG%
    if errorlevel 1 echo Already installed?
    echo Creating latest DB script
    python bin\omero db script -f %OMERO_CONFIG%.sql "" "" ome
    if errorlevel 1 goto ERROR
    echo Iniitializing DB
    psql -U omero -f %OMERO_CONFIG%.sql %OMERO_CONFIG% 2>quickstart.err >quickstart.out
    if errorlevel 1 goto ERROR
    echo Setting PYTHONPATH
    call bin\setpythonpath
    if errorlevel 1 goto ERROR
    echo Setting etc\grid directory paths to %CD%
    python lib\python\omero\install\win_set_path.py
    if errorlevel 1 goto ERROR
    echo Setting etc\grid ports prefix to %ROUTERPREFIX%
    python bin\omero admin ports --skipcheck --prefix=%ROUTERPREFIX%
    if errorlevel 1 goto ERROR
    REM Required because of environment-less service
    echo Setting config
    python bin\omero config def %OMERO_CONFIG%
    if errorlevel 1 goto ERROR
    if exist data echo Data directory already exists!
    if not exist data (echo Creating data directory && mkdir data)
    if errorlevel 1 goto ERROR
    echo Configuring and creating data directory
    if "x%OMERO_DATA%" == "x" (SET OMERO_DATA="%CD%\data")
    python bin\omero config set omero.data.dir %OMERO_DATA%
    if errorlevel 1 goto ERROR
    mkdir %OMERO_DATA%
    if errorlevel 1 goto ERROR
    echo Configuring Windows user
    python bin\omero config set omero.windows.user %USERDOMAIN%\%USERNAME%
    if errorlevel 1 goto ERROR
    echo Configuring password
    python bin\omero config set omero.windows.pass "%PASSWORD%"
    if errorlevel 1 goto ERROR
    echo Configuring database user
    python bin\omero config set omero.db.user omero
    if errorlevel 1 goto ERROR
    echo Configuring database name
    python bin\omero config set omero.db.name %OMERO_CONFIG%
    if errorlevel 1 goto ERROR
    if "x%OMERO_MASTER%" == x (goto NoMaster)
        echo Copying master.cfg to %OMERO_MASTER%.cfg
        copy etc\master.cfg etc\%OMERO_MASTER%.cfg
        if errorlevel 1 goto ERROR
    :NoMaster
    echo Starting server
    python bin\omero admin start
    if errorlevel 1 goto ERROR
    cd "%~dp0\.."
    exit /b 0
    :ERROR
      echo Failed %ERRORLEVEL%
      cd "%~dp0\.."
      exit /b %ERRORLEVEL%

**Note: these QUICKSTART files are not intended as general installers.
They are intended for developers working with the source who want to get
something up and running quickly. You should understand what the scripts
are doing, and be able to manually comment out or undo (e.g.
``dropdb quickstart``) some of them, if you want to run this script more
than once. As always, *use at your own risk*.**

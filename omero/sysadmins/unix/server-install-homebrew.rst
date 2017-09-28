OMERO.server installation on OS X with Homebrew
===============================================

.. topic:: Overview

    This walkthrough demonstrates how to install OMERO on a clean Mac
    OS X system (10.9 or later). Dependencies are installed with Homebrew.
    The OMERO.server can be downloaded as a pre-built zip,
    or built from the source code. It is aimed at **developers**
    since typically MacOS X is not suited for serious server deployment.

Prerequisites
-------------

Xcode
^^^^^

Homebrew requires the latest version of Xcode. Install :program:`Xcode` and
the Command Line Tools for Xcode from the App Store. If you have already
installed it, make sure all the latest updates are installed.

Homebrew
^^^^^^^^

.. _`Homebrew wiki`: https://github.com/Homebrew/brew/blob/master/docs/Installation.md

Homebrew will install all packages under :file:`/usr/local`. See also: Installation instructions on the `Homebrew wiki`_.

Install Homebrew using the following command in terminal::

    $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Java
^^^^

Oracle Java may be downloaded from the `Oracle website
<http://www.oracle.com/technetwork/java/javase/downloads/index.html>`_.

After installing JDK 7 or JDK 8, check your installation works by
running::

    $ java -version
    java version "1.8.0_51"
    Java(TM) SE Runtime Environment (build 1.8.0_51-b16)
    Java HotSpot(TM) 64-Bit Server VM (build 25.31-b07, mixed mode)
    
    $ javac -version
    javac 1.8.0_51


OS X Basics
-----------

In order to develop on OMERO, we recommend you ensure you have your Mac setup for
development. The first step to achieving this is to create a :file:`.bash_profile` file in the
root directory of your user folder.

To create a :file:`.bash_profile` from terminal, if one does not already exist::

    $ touch ~/.bash_profile

To open your :file:`.bash_profile` in a text editor, such as the built-in TextEdit app, use::

    $ open -a TextEdit.app ~/.bash_profile

.. note::
   If you want changes to your :file:`.bash_profile` to take effect without restarting
   OS X, run::

   $ source ~/.bash_profile

Requirements
------------

1. Open a command-line terminal and install git if not already present::

    $ brew install git

2. Install PostgreSQL database server::

    $ brew install postgresql

   To ensure PostgreSQL uses UTF-8 encoding, open your bash profile and 
   add the following environment variables::

    export LANG=en_US.UTF-8
    export LANGUAGE=en_US:en

3. OMERO depends on Ice 3.6 and unfortunately does not run with 
   the latest version of Ice at this time (Ice 3.7.3). To obtain 
   Ice 3.6, we need to add a *tap* to Homebrew::

    $ brew tap zeroc-ice/tap
    $ brew install zeroc-ice/tap/ice36

  .. note::
   If you already have a version of Ice that is not 3.6 installed, 
   you can instruct Homebrew to *unlink* it using ```$ brew unlink ice```. 
   You can then instruct Homebrew to link to Ice 3.6 using ```$ brew link ice@36```

4. Install Python provided by Homebrew::

    $ brew install python

   Homebrew installs Python in the following location::

    '/usr/local/opt/python/libexec/bin'

   Follow the instructions from the brew Python install and set your system to use the Homebrew version of Python 
   rather than the Python shipped with OS X. Add the following line to your :file:`.bash_profile`::

    export PATH="/usr/local/opt/python/libexec/bin:$PATH"

5. Check that Python is working and is version 2.7.x::

    $ which python
    /usr/local/opt/python/libexec/bin/python

    $ python --version
    Python 2.7.13

6. For developing with OMERO, or Python in general, we recommend the use of Virtualenv.
   Virtualenv allows development of Python applications without having to
   worry about clashing third-party packages for different Python projects.

   Use pip to get `Virtualenv <https://virtualenv.pypa.io/en/stable/>`__::

    $ pip install virtualenv

   With Virtualenv installed, create a virtual environment::

    $ virtualenv ~/Virtual/omero

   This will create a folder to hold Python libraries in the the directory :file:`~/Virtual/omero/lib`

  .. note:: 
   You can activate the Virtualenv environment that we created using::

    $ source ~/Virtual/omero/bin/activate

   This will switch to using Pip and Python in the Virtualenv directory
   :file:`~/Virtual/omero/bin` and any Pip libraries you install, whilst the Virtualenv is activated, 
   will be installed to :file:`source ~/Virtual/omero/lib`.

  .. note::
   **(Optional)** To make starting a Virtualenv environment easier,
   you can add an `alias` to your :file:`.bash_profile`::

    alias startVmOmero="source ~/Virtual/omero/bin/activate"

   Using the command-line terminal, reload your :file:`.bash_profile`::

    $ source ~/.bash_profile

   Now you can activate the Virtualenv environment using::

    $ startVmOmero

7. Install NGINX::

    $ brew install nginx


OMERO installation
------------------

Pre-built server
^^^^^^^^^^^^^^^^

1. Using the command-line terminal, prepare a place for your OMERO server to 
   be downloaded to.

   Find the current OMERO.server zip from the
   `downloads page <https://downloads.openmicroscopy.org/latest/omero/artifacts/>`_.
   Download and extract the OMERO.server-x.x.x-ice36-bxx.zip.

Locally built server
^^^^^^^^^^^^^^^^^^^^

1. Clone the source code from the project's GitHub account to build locally::

    $ git clone --recursive git://github.com/openmicroscopy/openmicroscopy

2. Navigate terminal into the :file:`openmicroscopy` that was just created by performing
   the previous step::

    $ cd openmicroscopy

3. Execute the build script *(this will take a few minutes, depending on how fast your Mac is)* :: 

    $ ./build.py

  .. seealso::
   :doc:`/developers/installation`
        Developer documentation page on how to check out to source code
   :doc:`/developers/build-system`
        Developer documentation page on how to build the OMERO.server

4. Once the build completes, the OMERO server build output will be located in :file:`openmicroscopy/dist`.


OMERO configuration
-------------------

1. Open your :file:`.bash_profile` in a text editor, 
   such as the built-in TextEdit app::

    $ open -a TextEdit.app ~/.bash_profile

   Add an environment variable :envvar:`OMERO_SERVER` to the :file:`.bash_profile` which points
   to the location of the OMERO executable::

    # Pre-built server...
    export OMERO_SERVER=/path/to/OMERO.server-x.x.x-ice36-bxx
    # ...OR locally built server
    export OMERO_SERVER=/path/to/openmicroscopy/dist

   and add the OMERO executable to the OS X :envvar:`PATH`::

    # Add the OMERO distribution to PATH
    export PATH=$OMERO_SERVER/bin:$PATH

   Using the command-line terminal, reload your :file:`.bash_profile` using::

    $ source ~/.bash_profile

   To ensure OMERO is correctly linked into your OS X :envvar:`PATH`, type the following in terminal and ensure
   you get a similar output::

    $ which omero
    # Pre-built server...
    /path/to/OMERO.server-x.x.x-ice36-bxx/bin/omero
    # ...OR locally built server
    /path/to/openmicroscopy/dist/bin/omero

3. Activate the Virtualenv environment that we created earlier in the "Requirements"
   section::

    $ source ~/Virtual/Omero/bin/activate

4. Install Python dependencies using pip::

    $ pip install -r "${OMERO_SERVER}/share/web/requirements-py27-all.txt"

Database
^^^^^^^^

1. From a fresh command-line terminal, start the database server::

    $ pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start

  .. note::
   **(Optional)** To make life easier, you can add an ```alias``` to your :file:`.bash_profile`
   to start and stop the Postgres service::

    alias startPg='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start'
    alias stopPg='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w stop'

   Reload :file:`.bash_profile` in OS X::

    $ source ~/.bash_profile

2. To use OMERO, we need to first set up PostgreSQL. Open a command-line terminal and run the
   following commands to create a user called *db_user* and a database called *omero_database*::

    $ createuser -w -D -R -S db_user
    $ createdb -E UTF8 -O db_user omero_database

3. Now set the OMERO configuration::

    $ omero config set omero.db.name omero_database
    $ omero config set omero.db.user db_user
    $ omero config set omero.db.pass db_password

4. Create and run script to initialize the OMERO database::

    $ omero db script --password omero -f - | psql -h localhost -U db_user omero_database

Binary Repository
^^^^^^^^^^^^^^^^^

1. Create directory for OMERO to store its data::

    $ mkdir /OMERO
    $ omero config set omero.data.dir /OMERO

OMERO.web
^^^^^^^^^

Basic setup for OMERO using NGINX::

    $ mv /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/nginx.conf.orig
    $ omero web config nginx-development > /usr/local/etc/nginx/nginx.conf
    $ nginx -t
    $ nginx

.. note::
    The internal Django webserver can be used for evaluation and development.
    In this case please follow the instructions under
    :doc:`/developers/Web/Deployment`.

.. _install_homebrew_common_issues:

Startup and shutdown
--------------------

If necessary start PostgreSQL database server::

    $ pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start

Start OMERO::

    $ omero admin start

Start OMERO.web::

    $ omero web start

Now connect to your OMERO.server using OMERO.insight or OMERO.web with the following credentials:

::

    U: root
    P: omero

Stop OMERO.web::

    $ nginx -c $(brew --prefix omero53)/etc/nginx.conf -s stop
    $ omero web stop

Stop OMERO::

    $ omero admin stop


Web configuration and maintenance
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For more configuration options and maintenance advice for OMERO.web see :doc:`install-web`.

Common issues
-------------

Example .bash_profile
^^^^^^^^^^^^^^^^^^^^^^

Open your :file:`.bash_profile` in a text editor, such as the built-in TextEdit app::

    $ open -a TextEdit.app ~/.bash_profile

If you have followed this guide your :file:`.bash_profile` should look similar to the following::

    # UTF-8 and US language settings for Postgres
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US:en

    # OMERO Server distribution directory
    export OMERO_SERVER=/path/to/OMERO.server-x.x.x-ice36-bxx

    # Homebrew Python path
    export BREW_PYTHON=/usr/local/opt/python/libexec/bin

    # Full path
    export PATH=$OMERO_SERVER/bin:BREW_PYTHON:$PATH

    # Start a virtual environment for developing Python
    alias startVmOmero='source ~/Virtual/omero/bin/activate'

General considerations
^^^^^^^^^^^^^^^^^^^^^^

If you run into problems with Homebrew, you can always run::

    $ brew update
    $ brew doctor

Also, please check the Homebrew `Bug Fixing Checklist
<https://github.com/mxcl/homebrew/wiki/Bug-Fixing-Checklist>`_.

Below is a non-exhaustive list of errors/warnings specific to the OMERO
installation. Some if not all of them could possibly be avoided by removing
any previous OMERO installation artifacts from your system.

Database
^^^^^^^^
Check to make sure the database has been created and 'UTF8' encoding is used

::

    $ psql -h localhost -U db_user -l

This command should give similar output to the following::

                            List of databases

       Name         | Owner   | Encoding |  Collation  |    Ctype    | Access privileges
    ----------------+---------+----------+-------------+-------------+-------------------
     omero_database | db_user | UTF8     | en_GB.UTF-8 | en_GB.UTF-8 |
     postgres       | ome     | UTF8     | en_GB.UTF-8 | en_GB.UTF-8 |
     template0      | ome     | UTF8     | en_GB.UTF-8 | en_GB.UTF-8 | =c/ome           +
                    |         |          |             |             | ome=CTc/ome
     template1      | ome     | UTF8     | en_GB.UTF-8 | en_GB.UTF-8 | =c/ome           +
                    |         |          |             |             | ome=CTc/ome
    (4 rows)

Macports/Fink
^^^^^^^^^^^^^

::

    Warning: It appears you have MacPorts or Fink installed.

Follow uninstall instructions from the `Macports guide <http://guide.macports.org/chunked/installing.macports.uninstalling.html>`_.

PostgreSQL
^^^^^^^^^^

If you encounter this error during installation of PostgreSQL::

    Error: You must ``brew link ossp-uuid' before postgresql can be installed

try::

    $ brew cleanup
    $ brew link ossp-uuid

For recent versions of OS X (10.10 and above) some directories may be missing,
preventing PostgreSQL from starting up. In that case, it should be sufficient
to reinitialize a PostgreSQL database cluster as::

    $ rm -rf /usr/local/var/postgres
    $ initdb -E UTF8 /usr/local/var/postgres

.. seealso::
  http://stackoverflow.com/questions/25970132/pg-tblspc-missing-after-installation-of-latest-version-of-os-x-yosemite-or-el

szip
^^^^

If you encounter an MD5 mismatch error similar to this::

    ==> Installing hdf5 dependency: szip
    ==> Downloading http://www.hdfgroup.org/ftp/lib-external/szip/2.1/src/szip-2.1.tar.gz
    Already downloaded: /Library/Caches/Homebrew/szip-2.1.tar.gz
    Error: MD5 mismatch
    Expected: 902f831bcefb69c6b635374424acbead
    Got: 0d6a55bb7787f9ff8b9d608f23ef5be0
    Archive: /Library/Caches/Homebrew/szip-2.1.tar.gz
    (To retry an incomplete download, remove the file above.)

then manually remove the archived version located under
:file:`/Library/Caches/Homebrew`, since the maintainer may have
updated the file.

numexpr (and other Python packages)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you encounter an issue related to numexpr complaining about NumPy
having too low a version number, verify that you have not previously
installed any Python packages using :program:`pip`. In the case where
:program:`pip` has been installed before Homebrew, uninstall it::

    $ sudo pip uninstall pip

and then try running :file:`python_deps.sh` again. That should install
:program:`pip` via Homebrew and put the Python packages in correct
locations.

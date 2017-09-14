OMERO.server installation on OS X with Homebrew
===============================================


.. topic:: Overview

    This walkthrough demonstrates how to install OMERO on a clean Mac
    OS X system (10.9 or later) using Homebrew.  Note that this
    demonstrates how to install OMERO.server *from the source code*
    via Homebrew, in addition to all its prerequisites. It is aimed at **developers**
    since typically MacOS X is not suited for serious server deployment.

These instructions are implemented in a series of `automated scripts
<https://github.com/ome/omero-install/tree/develop/osx>`_ which
install OMERO via Homebrew from a fresh configuration.

Prerequisites
-------------

Xcode
^^^^^

Homebrew requires the latest version of Xcode. Install :program:`Xcode` and
the Command Line Tools for Xcode from the App Store. If you have already
installed it, make sure all the latest updates are installed.

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

OSX Basics
------------

In order to develop on OMERO, we recommend you ensure you have your MAC setup for
developement. This first step to achieving this, is to create a bash_profile file in the
root directory of your user folder.

To create a ~/.bash_profile from terminal, if one does not already exist::

    $ touch ~/.bash_profile

Open your .bash_profile in your favourite text editor, such as the built in TextEdit app::

    $ open -a TextEdit.app ~/.bash_profile

Requirements
------------

.. _`Homebrew wiki`: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Installation.md

All the requirements for OMERO will be installed under :file:`/usr/local`. See also: Installation instructions on the `Homebrew wiki`_.

Install Homebrew using the following command in terminal::

    $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Update Homebrew and run 'brew doctor' to fix potential issues beforehand::

    $ brew update
    $ brew doctor

Install git if not already present::

    $ brew install git

Install PostgreSQL database server::

    $ brew install postgresql



.. _`Homebrew and Python`: https://github.com/Homebrew/brew/blob/master/docs/Homebrew-and-Python.md

You should install OMERO using Python 2.7 provided by
Homebrew since it makes using Homebrew-provided modules
simpler, for example the Ice python bindings needed by OMERO. For a
more thorough description of the Homebrew solution, see the `Homebrew
and Python`_ page. Note that the automated script linked above tests
the OMERO installation using the Homebrew Python.

To install the Python provided by Homebrew::

    $ brew install python

(OPTIONAL) If you haven't already, follow the instructions from the brew python install and 
set the homebrew version of Python to be used rather than the Python version shipped
with OSX::

    export PATH="/usr/local/opt/python/libexec/bin:$PATH"

Check that Python is working and is version 2.7::

    $ which python
    /usr/local/opt/python/libexec/bin/python

    $ python --version
    Python 2.7.13

If everything looks okay, go ahead and use pip to get VirtaulEnv

    $ pip install virtualenv

VirtualEnv, eseentially, allows us to develop python applications
without having to worry about clashing thirdparty package versions.




See the :download:`step01_deps.sh <walkthrough/osx/step01_deps.sh>` script for
the steps described above.

OMERO enviorment variables
------------------

Make sure you have the following lines in your .bash_profile::

    # UTF-8 and US language settings for Postgres
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US:en

    # OMERO Server distribution directory
    export OMERO_SERVER=Omero/Server

    # OMERO python libraries
    export OMERO_PYTHON_LIBS=${OMERO_SERVER}/lib/python

    # OMERO ice configuration
    export OMERO_ICE_CONFIG=${OMERO_SERVER}/etc/ice.config

    # Full path
    export PATH=$OMERO_SERVER/bin:$OMERO_ICE_CONFIG:$PATH




OMERO pre-built installation
------------------

OMERO |release| server
^^^^^^^^^^^^^^^^^^^^^^

Run the following command to download a build of OMERO Server to a folder called '/OMERO'

    $ mkdir -p Omero
    $ curl https://downloads.openmicroscopy.org/omero/5.3.4/artifacts/OMERO.server-5.3.4-ice36-b69.zip > Omero/OMERO.server.zip

Extract the OMERO.server.zip

    $ brew install omero53 --with-nginx --with-cpp
    $ export OMERO_SERVER=Omero/Server
    $ export OMERO_PYTHON_LIBS=Omero/Server/lib/python
    $ export OMERO_ICE_CONFIG=Omero/Server/etc/ice.config

This will install the OMERO server to /usr/local/Cellar/omero, which means you
will find the log files in :file:`/usr/local/Cellar/omero/|release|/var/log`.
The binaries will be linked to :file:`/usr/local/bin`::

    $ which omero
    /usr/local/bin/omero

Install Ice 3.6 extension for Python and OMERO python dependencies::

    $ pip install -r $(brew --prefix omero53)/share/web/requirements-py27-all.txt
    $ cd /usr/local
    $ bash bin/omero_python_deps

Start database server::

    $ pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start


OMERO configuration
------------------



Create database and user::

    $ createuser -w -D -R -S db_user
    $ createdb -E UTF8 -O db_user omero_database
    $ psql -h localhost -U db_user -l

Set database parameters in OMERO::

    $ omero config set omero.db.name omero_database
    $ omero config set omero.db.user db_user
    $ omero config set omero.db.pass db_password

Create and run script to initialize the OMERO database::

    $ export ROOT_PASSWORD=${ROOT_PASSWORD:-omero}
    $ omero db script --password $ROOT_PASSWORD -f - | psql -h localhost -U db_user omero_database

Set up OMERO data directory::

    $ export OMERO_DATA_DIR=${OMERO_DATA_DIR:-~/OMERO.data}
    $ mkdir -p $OMERO_DATA_DIR
    $ omero config set omero.data.dir $OMERO_DATA_DIR

See the OMERO installation script :download:`step02_omero.sh <walkthrough/osx/step02_omero.sh>`

Development server
^^^^^^^^^^^^^^^^^^

If you wish to build OMERO.server from source for development
purposes, using the git repository, first use Homebrew to install the
OMERO dependencies::

    $ brew install --only-dependencies omero

The default version of Ice installed by the OMERO formula is currently
Ice 3.6.

Prepare a place for your OMERO code to live, e.g.::

    $ mkdir -p ~/code/projects
    $ cd ~/code/projects

If you want the development version of OMERO.server, you can clone the source
code from the project's GitHub account to build locally::

    $ git clone --recursive git://github.com/openmicroscopy/openmicroscopy
    $ cd openmicroscopy && ./build.py

.. note::
    If you have a GitHub account and you plan to develop code for OMERO, you
    should make a fork into your own account and then clone this fork to your
    local development machine, e.g.

    ::

        $ git remote add  git://github.com/YOURNAMEHERE/openmicroscopy
        $ cd openmicroscopy && ./build.py

.. seealso::

    :doc:`/developers/installation`
        Developer documentation page on how to check out to source code

    :doc:`/developers/build-system`
        Developer documentation page on how to build the OMERO.server



Then prepend the development :file:`bin` directory to your :envvar:`PATH` to
pick the right executbale::

    $ export PATH=~/code/projects/openmicroscopy/dist/bin:$PATH

and follow the steps for setting up the database and OMERO data directory as mentioned in the previous section.

OMERO.web
^^^^^^^^^

Basic setup for OMERO using NGINX::

    $ export HTTPPORT=${HTTPPORT:-8080}
    $ omero web config nginx-development --http $HTTPPORT > $(brew --prefix omero53)/etc/nginx.conf

See installation script :download:`step03_nginx.sh <walkthrough/osx/step03_nginx.sh>`

For detailed instructions on how to deploy OMERO.web in a production
environment such as NGINX please see :doc:`install-web`.

.. note::
    The internal Django webserver can be used for evaluation and development.
    In this case please follow the instructions under
    :doc:`/developers/Web/Deployment`.

.. _install_homebrew_common_issues:

Startup/Shutdown
^^^^^^^^^^^^^^^^

If necessary start PostgreSQL database server::

    $ pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start

Start OMERO::

    $ omero admin start

Start OMERO.web::

    $ omero web start
    $ nginx -c $(brew --prefix omero53)/etc/nginx.conf

Now connect to your OMERO.server using OMERO.insight or OMERO.web with the following credentials:

::

    U: root
    P: omero

Stop OMERO.web::

    $ nginx -c $(brew --prefix omero53)/etc/nginx.conf -s stop
    $ omero web stop

Stop OMERO::

    $ omero admin stop

See example script for a basic functionality test: :download:`step04_test.sh <walkthrough/osx/step04_test.sh>`

Common issues
-------------

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

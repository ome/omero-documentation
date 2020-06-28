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

Java may be installed using OpenJDK from
`AdoptOpenJDK <https://adoptopenjdk.net/>`_.
See :doc:`../version-requirements` for supported versions.

After installing JDK, check your installation works by
running::

    $ java --version
    openjdk 11.0.5 2019-10-15
    OpenJDK Runtime Environment AdoptOpenJDK (build 11.0.5+10)
    OpenJDK 64-Bit Server VM AdoptOpenJDK (build 11.0.5+10, mixed mode)
    
    $ javac -version
    javac 11.0.5


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

#. Open a command-line terminal and install git if not already present::

    $ brew install git

#. Install PostgreSQL database server::

    $ brew install postgresql

   To ensure PostgreSQL uses UTF-8 encoding, open your bash profile and 
   add the following environment variables::

    export LANG=en_US.UTF-8
    export LANGUAGE=en_US:en

#. Install NGINX::

    $ brew install nginx


#. OMERO depends on Ice 3.6 and unfortunately does not run with 
   the Ice version 3.7 or higher. To obtain 
   Ice 3.6, we need to add a *tap* to Homebrew::

    $ brew tap zeroc-ice/tap
    $ brew install zeroc-ice/tap/ice36

  .. note::
   If you already have a version of Ice that is not 3.6 installed, 
   you can instruct Homebrew to *unlink* it using ```$ brew unlink ice```. 
   You can then instruct Homebrew to link to Ice 3.6 using ```$ brew link ice@36```


Python
------

For developing with OMERO, or Python in general, we recommend the use of Virtualenv.
Virtualenv allows development of Python applications without having to
worry about clashing third-party packages for different Python projects.

We will create 2 virtual environments below, ome for ``omero-py`` and another for
``omero-web`` (which also includes ``omero-py``). This allows more flexibility,
but you can use just the ``omero-web`` virtual environment for everything if you wish.

You can create virtual environments using either ``conda`` (preferred) OR ``venv``.

Using conda (preferred)
^^^^^^^^^^^^^^^^^^^^^^^

#. Install Conda.
   See `miniconda <https://docs.conda.io/en/latest/miniconda.html>`_ for more details.

#. Create virtual environments named ``omeropy`` and ``omeroweb``::

    $ conda create -n omeropy -c ome python=3.6 zeroc-ice36-python omero-py
    $ conda create -n omeroweb -c ome python=3.6 zeroc-ice36-python omero-web

#. Activate the virtual environments::

    $ conda activate omeropy

    # In a different terminal:
    $ conda activate omeroweb

#. You can now use the ``omero`` command. You will also need to ensure you are in 
   the appropriate environment when you install additional modules::

    $ omero -h

    # Additional modules. For example:
    $ pip install omero-metadata

   Now go to the :ref:`ref-omero-installtion` section below.

OR using venv
^^^^^^^^^^^^^

#. install Python provided by Homebrew::

    $ brew install python

   Follow the instructions from the brew Python install and set your system to use the Homebrew version of Python 
   rather than the Python shipped with OS X. Typically::

    $ brew link python

#. Check that Python is working and is version 3.7.x::

    $ which python3
    /usr/local/bin/python3

    $ python3 --version
    Python 3.7.4

#. Create a virtual environments for ``omero-py`` and/or ``omero-web`` using Python 3::

    $ python3 -mvenv ~/Virtual/omeropy
    $ python3 -mvenv ~/Virtual/omeroweb

#. Activate the Virtualenv environment(s) and install modules::

    $ source ~/Virtual/omeropy/bin/activate
    $ pip install "omero-py>=5.6.0"

    # In a different terminal:
    $ source ~/Virtual/omeroweb/bin/activate
    $ pip install "omero-web>=5.6.0"

#. You can now use the ``omero`` command in either virtual environment.
   You will also need to ensure you are in 
   the appropriate environment when you install additional modules::

    $ omero -h

    # Additional modules. For example:
    $ pip install omero-metadata

.. _ref-omero-installtion:

OMERO installation
------------------

Pre-built server
^^^^^^^^^^^^^^^^

#. Using the command-line terminal, prepare a place for your OMERO server to 
   be downloaded to.
#. Find the current OMERO.server zip from the
   `downloads page <https://downloads.openmicroscopy.org/latest/omero/artifacts/>`_.
#. Download and extract the OMERO.server-x.x.x-ice36-bxx.zip.

Locally built server
^^^^^^^^^^^^^^^^^^^^

#. Clone the source code from the project's GitHub account to build locally::

    $ git clone --recursive git://github.com/ome/openmicroscopy

#. Navigate terminal into the :file:`openmicroscopy` that was just created by performing
   the previous step::

    $ cd openmicroscopy

#. Execute the build script *(this will take a few minutes, depending on how fast your Mac is)* :: 

    $ ./build.py

#. Once the build completes, the OMERO server build output will be located in :file:`openmicroscopy/dist`.

.. seealso::
   :doc:`/developers/installation`
        Developer documentation page on how to check out to source code
   :doc:`/developers/build-system`
        Developer documentation page on how to build the OMERO.server

OMERO configuration
-------------------

#. Open your :file:`.bash_profile` in a text editor, 
   such as the built-in TextEdit app::

    $ open -a TextEdit.app ~/.bash_profile

#. Add an environment variable :envvar:`OMERODIR` to the :file:`.bash_profile` which points to the location of the OMERO executable::

    # Pre-built server...
    export OMERODIR=/path/to/OMERO.server-x.x.x-ice36-bxx
    # ...OR locally built server
    export OMERODIR=/path/to/openmicroscopy/dist

#. Using the command-line terminal, reload your :file:`.bash_profile` using::

    $ source ~/.bash_profile


Database
^^^^^^^^

#. From a fresh command-line terminal, start the database server::

    $ pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start

#. To use OMERO, we need to first set up PostgreSQL. Open a command-line terminal and run the
   following commands to create a user called *db_user* and a database called *omero_database*::

    $ createuser -w -D -R -S db_user
    $ createdb -E UTF8 -O db_user omero_database

#. Activate the ``omeropy`` env::

    $ conda activate omeropy
    # OR
    $ source ~/Virtual/omeropy/bin/activate

#. Now set the OMERO configuration::

    $ omero config set omero.db.name omero_database
    $ omero config set omero.db.user db_user
    $ omero config set omero.db.pass db_password

#. Create and run script to initialize the OMERO database::

    $ omero db script --password omero -f - | psql -h localhost -U db_user omero_database


.. note::

  **(Optional)** To make life easier, you can add an ```alias``` to your :file:`.bash_profile` to start and stop the Postgres service::

      alias startPg='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start'
      alias stopPg='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w stop'

      Reload :file:`.bash_profile` in OS X::

      $ source ~/.bash_profile

Binary Repository
^^^^^^^^^^^^^^^^^

#. Create directory for OMERO to store its data::

    $ mkdir /OMERO
    $ omero config set omero.data.dir /OMERO

OMERO.web
^^^^^^^^^

#. Activate the ``omeroweb`` env::

    $ conda activate omeroweb
    # OR
    $ source ~/Virtual/omeroweb/bin/activate

#. Basic setup for OMERO using NGINX::

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

Activate the ``omeropy`` env and start OMERO::

    $ conda activate omeropy
    # OR
    $ source ~/Virtual/omeropy/bin/activate

    $ omero admin start

Activate the ``omeroweb`` env and start OMERO.web::

    $ conda activate omeroweb
    # OR
    $ source ~/Virtual/omeroweb/bin/activate
    $ omero web start

Now connect to your OMERO.server using OMERO.insight or OMERO.web with the following credentials:

::

    U: root
    P: omero

Activate the ``omeroweb`` env as above, and stop OMERO.web::

    $ omero web stop

Activate the ``omeropy`` env as above and stop OMERO::

    $ omero admin stop


Web configuration and maintenance
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For more configuration options and maintenance advice for OMERO.web see :doc:`install-web/web-deployment`.

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
  https://stackoverflow.com/questions/25970132/pg-tblspc-missing-after-installation-of-latest-version-of-os-x-yosemite-or-el

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

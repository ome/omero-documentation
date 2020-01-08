OMERO.server installation
=========================

This section covers the installation of OMERO.server on UNIX and
UNIX-like platforms. This includes all BSD, Linux and Mac OS X
systems. Depending upon which platform you are using, you may find a
more specific walk-through listed below but we recommend you read through this
page first as it explains the entire process rather than just being a series
of commands. The walk-throughs describs how to install the **recommended** versions,
not all the supported versions.
This should be read in conjunction with :doc:`../version-requirements`.

Since 5.6, a new :envvar:`OMERODIR` variable is used, you should first unset :envvar:`OMERO_HOME`
(if set) before beginning the installation process.


**Recommended:**

:doc:`server-centos7-ice36`
  Instructions for installing OMERO.server from scratch on
  CentOS 7 with Ice 3.6 and Python 3.6.

:doc:`server-ubuntu1804-ice36`
  Instructions for installing OMERO.server from scratch on
  Ubuntu 18.04 with Ice 3.6 and Python 3.6.

**Upcoming:**

:doc:`server-ubuntu1604-ice36`
  Instructions for installing OMERO.server from scratch on
  Ubuntu 16.04 with Ice 3.6 and Python 3.5.

:doc:`server-debian9-ice36`
  Instructions for installing OMERO.server from scratch on
  Debian 9 with Ice 3.6 and Python 3.5

**Development:**

:doc:`server-install-homebrew`
  Instructions for installing and building OMERO.server on Mac
  OS X with dependencies installed using Homebrew. It is aimed at **developers**
  since typically MacOS X is not suited for serious server deployment.

.. toctree::
    :maxdepth: 1
    :titlesonly:
    :hidden:

    server-centos7-ice36
    server-ubuntu1604-ice36
    server-ubuntu1804-ice36
    server-debian9-ice36
    server-install-homebrew

Prerequisites
-------------

Installation will require:

- a clean, minimal operating system installation
- a "root" level account for which you know the password

.. note::
    If you are unsure of what it means to have a "root" level account,
    or if you are generally having issues with the various
    users/passwords described in this install guide, please see
    :ref:`troubleshooting-password`.

The installation and configuration of the prerequisite applications
are mostly outside the scope of this document. For Linux
distributions, use of the default package manager is recommended.
For MacOS X, Homebrew is recommended. This guide provides the package
names to install for a number of contemporary systems. However, the
names and versions provided vary between releases. Please do check for
similar packages if the one documented here is not available for your
system as it may be provided under an alternative name. "Debian"
refers to Debian and derivative distributions such as Ubuntu.
"RedHat" refers to RedHat and related distributions such as CentOS,
Fedora and Scientific Linux.

* For Ubuntu you need to enable the **universe** repository. This
  should be enabled by default. If not enabled, it may be enabled by
  editing :file:`/etc/apt/sources.list` directly, in which case the
  entries may already exist but are commented out, or by using
  Synaptic (10.04 and 10.10) or Ubuntu Software Center (11.04
  onwards). Update your package lists to ensure that you get the
  latest packages::

    $ sudo apt-get update

  Install packages by running::

    $ sudo apt-get install package

  where *package* is the package name to install.


.. _server-requirements:


The following subsections cover the details for each package, in the
order recommended for installation.

Java SE Runtime Environment (JRE)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If possible, install one of the following packages:

.. list-table::
    :header-rows: 1
    :align: left

    * - System
      - Package

    * - Debian
      - openjdk-11-jre

    * - Homebrew
      - N/A (install Oracle Java)

    * - RedHat
      - java-11-openjdk

OMERO works with the OpenJDK JRE provided by most systems, or with
Oracle Java. Version |javaversion| or later is required.

Your system may already provide a suitable JRE, in which case no extra steps
are necessary. Linux distributions usually provide OpenJDK, and older MacOS X
versions have Java installed by default. Oracle Java is no longer provided by
BSD or Linux distributions for licensing reasons. If your system does not have
Java available, for example on newer MacOS X versions, or the provided
version is too old, Oracle Java may be downloaded from the `Oracle
website
<https://www.oracle.com/technetwork/java/javase/downloads/index.html>`_.

.. warning:: **Security**

    Installing Oracle Java outside the system's package manager will
    leave your system without regular distribution-supplied security
    updates, and so is not recommended.


To check which version of Java is currently available::

    $ which java
    /usr/bin/java
    $ java -version
    openjdk version "11.0.5" 2019-10-15
    OpenJDK Runtime Environment (build 11.0.5+10-post-Ubuntu-0ubuntu1.118.04)
    OpenJDK 64-Bit Server VM (build 11.0.5+10-post-Ubuntu-0ubuntu1.118.04, mixed mode, sharing)

Python 3
^^^^^^^^

Check you have Python (and check its version) by running:

::

    $ python3 --version
    Python 3.6.4

If possible, install the following packages:

.. list-table::
    :header-rows: 1
    :align: left

    * - System
      - Package

    * - Debian
      - python3

    * - Homebrew
      - python3

    * - RedHat
      - python3

Ice
^^^

The Ice version may vary, depending upon the distribution version you
are using. The Ice versions in currently supported versions of Debian
and `Ubuntu <https://wiki.ubuntu.com/Releases>`_ are shown in the
:ref:`ice-requirements` of the :doc:`/sysadmins/version-requirements` page.

Using version 3.6 of Ice is required. If
your package manager provides Ice packages, using these is recommended
where possible. Distribution-provided packages often have additional
bugfixes which are not present in the upstream releases.

If needed, source and binary packages are available from ZeroC_. The
latest release is available from the :zeroc:`ZeroC website
<download.html>`.

.. note::
    ZeroC_ Ice can always be built from source code for specific
    platforms if a binary package is not available.

.. note::
    With Ice 3.6, the Python bindings are provided separately. If
    your package manager does not provide Ice python packages, run
    ``pip install zeroc-ice`` to install the Ice Python bindings.
    See :zerocdoc:`Using the Python Distribution
    <display/Ice36/Using+the+Python+Distribution>`
    for further details.

OMERO.scripts
^^^^^^^^^^^^^

If you wish to run the "Movie Maker" script, please install :program:`mencoder`.

.. list-table::
    :header-rows: 1
    :align: left

    * - System
      - Package

    * - Debian
      - mencoder

    * - Homebrew
      - mplayer

    * - RedHat
      - mencoder

Installation
------------

Once the above prerequisites have been downloaded, installed and
configured appropriately, the OMERO server itself may be installed.
You may wish to create a user account solely for the purpose of
running the server, and switch to this user for the next steps.

Server directory
^^^^^^^^^^^^^^^^

Firstly, a directory needs to be created to contain the server. In
this case :file:`~/omero` is used as an example::

    $ mkdir -p ~/omero

Next, change into this directory::

    $ cd ~/omero


OMERO.server
^^^^^^^^^^^^

The release :file:`OMERO.server.zip` is available from the
:downloads:`OMERO downloads <>` page. Download the version matching
the version of Ice installed on your system before continuing.

Installing a development version from source is also possible. See the
:ref:`install_from_source` section for further details. This is not
recommended unless you have a specific reason *not* to use a release
version.

Once you have obtained the OMERO.server zip archive matching the version
of Ice installed, unpack it:

.. parsed-literal::

    $ unzip OMERO.server-|release|-ice36-byy.zip

If your system does not provide an :program:`unzip` command by
default, install one of the following:

.. list-table::
    :header-rows: 1
    :align: left

    * - System
      - Package

    * - Debian
      - unzip

    * - Homebrew
      - unzip

    * - RedHat
      - unzip


Optionally, give your OMERO software install a short name to save some
typing later, to reflect what you set :envvar:`OMERO_PREFIX` to in the
:ref:`server_env` section, below:

.. parsed-literal::

    $ ln -s OMERO.server-|release|-ice36-byy OMERO.server

This will also ease installation of newer versions of the server at a
later date, by simply updating the link.

.. _server_env:

Environment variables
---------------------

If using distribution-provided packages such as Debian or RPM
packages, or via the homebrew or macports package manager, it should
not be necessary to set any environment variables. However, if using
third-party packages for any required components, several variables
may require setting in order for them to function correctly.

Please note that the precise details of these environment variables
can change as new versions of software are released.

There are several methods for setting environment variables; which is
most appropriate will depend upon how the OMERO server is started.
Options include:

:file:`/etc/security/pam_env.conf`
  Global environment set at login by PAM
:file:`/etc/profile` or :file:`/etc/profile.d/omero`
  Global Bourne shell defaults (also used by derived shells such as :program:`bash` and :program:`zsh`)
:file:`~/.profile`
  User's Bourne shell defaults (also used by derived shells)
:file:`/etc/bash.bashrc`
  Global :program:`bash` defaults
:file:`~/.bashrc`, :file:`~/.bash_profile` or :file:`~/.bash_login`
  User's :program:`bash` configuration.

If OMERO is started as a service using an init script, a global
setting should be preferred. If being started by hand using a
particular user, a user-specific configuration file may be more
appropriate.

The following environment variables may be configured:

:envvar:`LD_LIBRARY_PATH` (Linux) or :envvar:`DYLD_LIBRARY_PATH` (MacOS X)
  The Ice and PostgreSQL libraries must be on the library search path.
  If using the packages provided by your distribution, this will
  already be the case. If using third-party binary distributions the
  :file:`lib` (or :file:`lib64` if present and using a 64-bit system)
  directory for each will require adding to the library search path.
:envvar:`OMERO_PREFIX`
  This is not strictly required, but may be set for convenience to
  point to the OMERO server installation, and is used in this
  documentation as a shorthand for the installation path.
:envvar:`OMERO_TMPDIR`
  Directory used for temporary files. If the home directory of the
  user running the OMERO server is located on a slow filesystem, such
  as NFS, this may be used to store the temporary files on fast local
  storage.
:envvar:`PATH`
  The search path must include the programs :program:`java`,
  :program:`python`, :program:`icegridnode` and PostgreSQL commands
  such as :program:`psql`. If using the packages provided by your
  distribution, this will already be the case. If using third-party
  binary distributions such as the ZeroC Ice package, Oracle Java, or
  PostgreSQL, the :file:`bin` directory for each must be added to the
  path. The OMERO :file:`bin` directory may also be added to the
  search path (:file:`${OMERO_PREFIX}/bin` if :envvar:`OMERO_PREFIX`
  has been set).
:envvar:`PYTHONPATH`
  The Ice :file:`python` directory must be made available to python.
  If using the Ice packages provided by your distribution, this will
  already be the case. If using the ZeroC ice package, add the
  :file:`python` directory to the python path. For Ice 3.6, this
  should never be required.
:envvar:`OMERODIR`
  The path to the OMERO.server.

After making any needed changes, either source the corresponding file
or log back in for them to take effect. Run ``env`` to check them.


Creating a database
-------------------

On most systems, a "postgres" user will be created which has admin
privileges, while the UNIX ``root`` user itself does *not* have admin
privileges. Therefore it is necessary to either become the
``postgres`` user, or use :program:`sudo` as shown below.

For the purposes of this guide, the following dummy data is used::

    Username: db_user
    Password: db_password
    Database: omero_database

.. warning:: **Security**

    These dummy values are examples only and should **not** be used.
    For a live or public server install these values should be altered
    to reflect your security requirements---i.e. use your own choice
    of username and password instead. These should **not** be the same
    username and/or password as your Linux/Mac root user!

    You should also consider restricting access to your server
    machine, but that is outside the scope of this document.

- Create a non-superuser database user and record the name and
  password used. You will need to configure OMERO to use this username
  and password later on.::

      $ sudo -u postgres createuser -P -D -R -S db_user
      Enter password for new role:       # db_password
      Enter it again:       # db_password

-  Create a database for OMERO to reside in::

      $ sudo -u postgres createdb -E UTF8 -O db_user omero_database

-  Check to make sure the database has been created, you have PostgreSQL
   client authentication correctly set up and the database is owned by
   the **db\_user** user.

   ::

       $ psql -h localhost -U db_user -l
       Password for user db_user: 
               List of databases
          Name         |  Owner   | Encoding  
       ----------------+----------+-----------
        omero_database | db_user  | UTF8
        postgres       | postgres | UTF8
        template0      | postgres | UTF8
        template1      | postgres | UTF8
       (4 rows)

If you have problems, especially with the last step, take a look at
:doc:`server-postgresql` since the authentication mechanism is
probably not properly configured.

Location for the your OMERO binary repository
---------------------------------------------

-  Create a directory for the OMERO binary data
   repository. :file:`/OMERO` is the default location and should be
   used unless you explicitly have a reason not to and know what you
   are doing.

-  This is *not* where you want the OMERO application to be installed,
   it is a *separate* directory which the OMERO.server will use to store
   binary data.

-  You can read more about the :doc:`OMERO binary repository <server-binary-repository>`.

   ::

       $ sudo mkdir /OMERO

-  Change the ownership of the directory. :file:`/OMERO` **must**
   either be owned by the user starting the server (it is currently
   owned by the system root) or that user **must** have permission to
   write to the directory. You can find out your username and edit the
   correct permissions as follows:

   ::

       $ whoami
       omero
       $ sudo chown -R omero /OMERO


Configuration
-------------

-   You can view a parsed version of the configuration properties
    under :doc:`/sysadmins/config` or parse it
    yourself with ``omero config parse``.

-   Change any settings that are necessary using ``omero config``,
    including the name and/or password for the 'db\_user' database
    user you chose above or the database name if it is not
    "omero\_database". (Quotes are only necessary if the value could
    be misinterpreted by the shell. See :forum:`Forum post
    <viewtopic.php?f=5&t=360#p922>`)

    ::

        $ omero config set omero.db.name 'omero_database'
        $ omero config set omero.db.user 'db_user'
        $ omero config set omero.db.pass 'db_password'

    You can also check the values that have been set using::

        $ omero config get

-   If you have chosen a non-standard :doc:`OMERO binary repository
    <server-binary-repository>` location above, be sure to configure
    the :property:`omero.data.dir` property. For example, to use
    :file:`/srv/omero`::

    $ omero config set omero.data.dir /srv/omero

-   Create the OMERO database initialization script. You will need to
    provide a password for the newly created OMERO root user, either by
    using the ``--password`` argument or by entering it when prompted.
    Note that this password is for the root user of the
    **OMERO.server**, and is not related to the root system user or a
    PostgreSQL user role.

    .. parsed-literal::

        $ omero db script --password omero_root_password

    .. literalinclude:: /downloads/cli/db-script-example.txt

   .. warning:: **Security**

      For illustrative purposes, the default password for the OMERO
      root user is shown as ``omero_root_password``. However, you
      should **not** use this default values for your installation,
      but use your own choice of password instead. This should **not**
      be the same password as your Linux/Mac root user or the
      database user!

-   Initialize your database with the script.

    .. parsed-literal::

        $ psql -h localhost -U db_user omero_database < |current_dbver|.sql

    At this point you should see some output from PostgreSQL as it
    installs the schema for new OMERO database.

-   Before starting the OMERO.server, run the OMERO diagnostics script to
    check that all of the settings are correct, e.g.

    ::

        $ omero admin diagnostics

-   You can now start the server using::

         $ omero admin start
         Creating var/master
         Initializing var/log
         Creating var/registry
         No descriptor given. Using etc/grid/default.xml

-   If multiple users have access to the system running OMERO you should
    restrict access to the :file:`OMERO.server/etc` and
    :file:`OMERO.server/var` directories, for example by changing the
    permissions on them::

        $ chmod 700 ~/omero/OMERO.server/etc ~/omero/OMERO.server/var

    You should also consider restricting access to the OMERO data repository.
    The required permissions will depend on whether you are using
    :doc:`/sysadmins/import-scenarios`.

-   Test that you can log in as "root", either with the OMERO.insight
    client or on the command-line::

         $ omero login
         Server: [localhost]
         Username: [root]
         Password:         # omero_root_password

    You will be prompted for an OMERO username and password. Use the
    username and password set when running :command:`omero db script`.

-   If your users are going to be importing many files in one go, for example
    multiple plates, you should make sure you set the maximum number of open
    files to a sensible level (i.e. at least 8K for production systems, 16K
    for bigger machines). See :ref:`ulimit` for more information.

JVM memory settings
-------------------

The OMERO server starts a number of Java services. Memory settings for
these are calculated on a system-by-system basis. An attempt has been
made to have usable settings out of the box, but if you can afford to
provide OMERO with more memory, it will certainly improve your overall
performance. See :ref:`jvm_memory_settings` on how to tune the JVM.

Enabling movie creation from OMERO
----------------------------------

OMERO has a facility to create AVI/MPEG Movies from images. The page
:doc:`/sysadmins/omeromovie` details how to enable it.

Post-installation items
-----------------------

Backup
^^^^^^

One of your first steps after putting your OMERO server into
production should be deciding on when and how you are going to
:doc:`backup your database and binary data
</sysadmins/server-backup-and-restore>`. Please do not omit this step.

Security
^^^^^^^^

It is also now recommended that you read the
:doc:`/sysadmins/server-security` page to get a good idea as to what
you need to do to get OMERO clients speaking to your newly installed
OMERO.server in accordance with your institution or company's security
policy.

Advanced configuration
^^^^^^^^^^^^^^^^^^^^^^

Once you have the base server running, you may want to try enabling
some of the advanced features such as :doc:`/sysadmins/dropbox` or
:doc:`/sysadmins/server-ldap`. If you have **Flex data**, you may
want to watch :snapshot:`the HCS configuration screencast
<movies/omero-4-1/mov/FlexPreview4.1-configuration.mov>`. See
:doc:`/sysadmins/config` on how to get the most out of your server.

Troubleshooting
^^^^^^^^^^^^^^^

My OMERO install doesn't work! What do I do now? Examine the
:doc:`/sysadmins/troubleshooting` page and if all else fails post a
message to our :mailinglist:`ome-users` mailing list discussed on the
:doc:`/users/community-resources` page. Especially the
:ref:`server_fails_to_start` and :ref:`remote_clients_cannot_connect`
sections are a good starting point.

OMERO diagnostics
^^^^^^^^^^^^^^^^^

If you want help with your server installation, please include the
output of the diagnostics command:

.. parsed-literal::

    $ omero admin diagnostics

    ================================================================================
    OMERO Diagnostics |release|
    ================================================================================

    Commands:   java -version                  11.0.5    (/usr/bin/java)
    Commands:   python -V                      3.6.9     (/opt/omero/server/venv3/bin/python)
    Commands:   icegridnode --version          3.6.5     (/usr/bin/icegridnode)
    Commands:   icegridadmin --version         3.6.5     (/usr/bin/icegridadmin)
    Commands:   psql --version                 11.6      (/usr/bin/psql)
    Commands:   openssl version                1.1.111   (/usr/bin/openssl)

    Server:     icegridnode                    running
    Server:     Blitz-0                        active (pid = 30324, enabled)
    Server:     DropBox                        active (pid = 30343, enabled)
    Server:     FileServer                     active (pid = 30345, enabled)
    Server:     Indexer-0                      active (pid = 30348, enabled)
    Server:     MonitorServer                  active (pid = 30351, enabled)
    Server:     OMERO.Glacier2                 active (pid = 30353, enabled)
    Server:     OMERO.IceStorm                 active (pid = 30376, enabled)
    Server:     PixelData-0                    active (pid = 30393, enabled)
    Server:     Processor-0                    active (pid = 30394, enabled)
    Server:     Tables-0                       inactive (disabled)
    Server:     TestDropBox                    inactive (enabled)

    OMERO:      SSL port                       4064
    OMERO:      TCP port                       4063

    Log dir:    /opt/omero/server/OMERO.server/var/log exists

    Log files:  Blitz-0.log                    22.8 KB        errors=0    warnings=9
    Log files:  DropBox.log                    1.3 KB        errors=0    warnings=1
    Log files:  FileServer.log                 114 B
    Log files:  Indexer-0.log                  1.3 KB       errors=0    warnings=5
    Log files:  MonitorServer.log              882 B
    Log files:  PixelData-0.log                1.8 KB        errors=0    warnings=4
    Log files:  Processor-0.log                592 B        errors=0    warnings=1
    Log files:  Tables-0.log                   841 B
    Log files:  TestDropBox.log                n/a
    Log files:  master.err                     34.4 KB        errors=2    warnings=0
    Log files:  master.out                     empty
    Log files:  Total size                     0.06 MB

    Environment:OMERODIR=/opt/omero/server/OMERO.server 
    Environment:OMERO_HOME=(unset)
    Environment:OMERO_NODE=(unset)
    Environment:OMERO_MASTER=(unset)
    Environment:OMERO_TEMPDIR=(unset)
    Environment:PATH=/opt/omero/server/venv3/bin:/usr/local/bin:/usr/bin:/bin
    Environment:ICE_HOME=(unset)
    Environment:LD_LIBRARY_PATH=(unset)
    Environment:DYLD_LIBRARY_PATH=(unset)

    OMERO SSL port:4064                           
    OMERO TCP port:4063  
    OMERO data dir: '/OMERO'        Exists? True    Is writable? True
    OMERO temp dir: '/home/omero-server/tmp'        Exists? True    Is writable? True   (Size: 0)

    JVM settings: Blitz-${index}                -Xmx621m -XX:MaxPermSize=512m -XX:+IgnoreUnrecognizedVMOptions
    JVM settings: Indexer-${index}              -Xmx414m -XX:MaxPermSize=512m -XX:+IgnoreUnrecognizedVMOptions
    JVM settings: PixelData-${index}            -Xmx621m -XX:MaxPermSize=512m -XX:+IgnoreUnrecognizedVMOptions
    JVM settings: Repository-${index}           -Xmx414m -XX:MaxPermSize=512m -XX:+IgnoreUnrecognizedVMOptions


Update notification
^^^^^^^^^^^^^^^^^^^

Your OMERO.server installation will check for updates each time it is
started from the *Open Microscopy Environment* update server. If you
wish to disable this functionality you should do so now as outlined on
the :doc:`/sysadmins/UpgradeCheck` page.

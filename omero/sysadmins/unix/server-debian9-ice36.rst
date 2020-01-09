.. walkthroughs are generated using a bash script, see
.. https://github.com/ome/omero-install

OMERO.server installation on Debian 9
=====================================

This is an example walkthrough for installing OMERO on Debian 9, using
a dedicated local system user, and should be read in conjunction with
:doc:`install-web`. You can use this as a guide
for setting up your own test server. For production use you should also read
the pages listed under :ref:`index-optimizing-server`.
This guide will install Python 3.5.
Since 5.6, a new :envvar:`OMERODIR` variable is used, you should first unset :envvar:`OMERO_HOME` (if set) before beginning the installation process.

This guide describes how to install using the **recommended** versions for
Java, Ice, PostgreSQL.
This should be read in conjunction with :doc:`../version-requirements`.

This guide does not describe how to install OMERO.web.
To deploy OMERO.web, please read
:doc:`install-web/walkthrough/omeroweb-install-debian9-ice3.6`.

These instructions assume your Linux distribution is configured with a UTF-8
locale (this is normally the default).

For convenience in this walkthrough we will use the **omero-server system user** and the main OMERO configuration options have
been defined as environment variables. When following this walkthrough you can
either use your own values, or alternatively create :file:`settings.env` for example under ``/tmp`` e.g. ``/tmp/settings.env`` containing the variables below and source it when required:

.. literalinclude:: walkthrough/settings.env
   :start-after: Substitute

Installing prerequisites
------------------------

**The following steps are run as root.**

Install Java |javaversion|, Ice |iceversion| and PostgreSQL |postgresversion|:

To install Java |javaversion| and other dependencies:

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: #start-step01
    :end-before: #end-step01

To install Ice |iceversion|:

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: #start-recommended-ice
    :end-before: #end-recommended-ice

To make Ice available to all users and activate the virtual environment, set the following in ``/etc/profile``:

.. literalinclude:: walkthrough/omero-ice36.env

and add the virtual environment to ``PATH``:

.. literalinclude:: walkthrough/settings.env
    :start-after: # Location of the virtual environment

As part of the installation of Ice, two new daemons are installed and automatically started.
In order for the OMERO.server to start correctly,
they both should be disabled by running the following command:

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: #start-disable-daemons
    :end-before: #end-disable-daemons

To install PostgreSQL |postgresversion|:

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: # install Postgres
    :end-before: #end-step01

Create a local omero-server system user, and a directory for the OMERO repository:

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: #start-step02
    :end-before: #end-step02

Make the :file:`settings.env` available to the omero-server system user by copying in to the user home directory. The file will need to be sourced each time you switch user. You could add ``. ~/settings.env`` to the omero-server system user ``bash`` profile.

Create a database user and initialize a new database for OMERO:

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: #start-step03
    :end-before: #end-step03


Installing OMERO.server
-----------------------

**The following step is run as root.**

We recommend to create a virtual environment and install the Ice Python binding using ``pip``:

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: #start-step03bis
    :end-before: #end-step03bis

Install ``omero-py``:

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: #start-step04-pre
    :end-before: #start-release-ice36

Download and unzip OMERO.server:

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: #start-release-ice36
    :end-before: #end-release-ice36

Change the ownership of the OMERO.server directory and create a symlink:

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: #end-release-ice36
    :end-before: #end-step04-pre

**The following steps are run as the omero-server system user.** (``su - omero-server``)

The variable ``OMERODIR`` set in :download:`settings.env <walkthrough/settings.env>` above **must** point to the location where OMERO.server is installed.
e.g. ``OMERODIR=/path_to_omero_server/OMERO.server``.

Note that this script requires the same environment variables that were set
earlier in `settings.env`, so you may need to copy and/or source this file as
the omero user.

Configure the server:

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: #end-copy-omeroscript
    :end-before: #end-step04

Patching OMERO.server
---------------------

Weaker ciphers like ADH are disabled by default in OpenSSL 1.1.0,
the version installed on Debian 9.
This means that it is not possible to connect to an OMERO.server
using any OMERO clients e.g. the Java Desktop client,
the OMERO.web client or the CLI.
The parameter ``@SECLEVEL=0``, enabling the weaker ciphers, needs to be
added in two files in order to allow connection.

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: #start-seclevel
    :end-before: #end-seclevel

Running OMERO.server
--------------------

**The following steps are run as the omero-server system user.** (``su - omero-server``)

OMERO should now be set up. To start the server run::

    omero admin start

Should you wish to start OMERO automatically, a `init.d` file could be created.
An example :download:`omero-server.init.d <walkthrough/omero-server-init.d>`
is available.

Copy the ``init.d`` file and configure the service:

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: #start-step06
    :end-before: #end-step06

You can then start up the service by running::

   service omero-server start

Securing OMERO
--------------

**The following steps are run as root.**

If multiple users have access to the machine running OMERO you should restrict
access to OMERO.server's configuration and runtime directories, and optionally
the OMERO data directory:

.. literalinclude:: walkthrough/walkthrough_debian9.sh
    :start-after: #start-step07
    :end-before: #end-step07

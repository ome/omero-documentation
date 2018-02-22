.. walkthroughs are generated using a bash script, see
.. https://github.com/ome/omero-install

OMERO.server installation on Ubuntu 16.04
=========================================

This is an example walkthrough for installing OMERO on Ubuntu, using
a dedicated system user, and should be read in conjunction with
:doc:`install-web`. You can use this as a guide
for setting up your own test server. For production use you should also read
the pages listed under :ref:`index-optimizing-server`.

This guide describes how to install the **recommended** versions, not all
the supported versions.
This should be read in conjunction with :doc:`../version-requirements`.

This guide does not describe how to install OMERO.web.
To deploy OMERO.web **separately** from OMERO.server (recommended), please read
:doc:`install-web/walkthrough/omeroweb-install-ubuntu-ice3.6` or
to deploy with OMERO.server :doc:`install-web/walkthrough/omeroweb-install-with-server-ubuntu-ice3.6`

These instructions assume your Linux distribution is configured with a UTF-8
locale (this is normally the default).

For convenience in this walkthrough the main OMERO configuration options have
been defined as environment variables. When following this walkthrough you can
either use your own values, or alternatively source :download:`settings.env <walkthrough/settings.env>`:

.. literalinclude:: walkthrough/settings.env
   :start-after: Substitute

Installing prerequisites
------------------------

**The following steps are run as root.**

Install Java 1.8, Ice 3.6 and PostgreSQL 9.6:

To install Java 1.8 and other dependencies:

.. literalinclude:: walkthrough/walkthrough_ubuntu1604.sh
    :start-after: #start-step01
    :end-before: #start-web-dependencies

To install dependencies required by OMERO core scripts:

.. literalinclude:: walkthrough/walkthrough_ubuntu1604.sh
    :start-after: #start-web-dependencies
    :end-before: #end-web-dependencies

To install Ice 3.6:

.. literalinclude:: walkthrough/walkthrough_ubuntu1604.sh
    :start-after: #start-recommended-ice
    :end-before: #end-recommended-ice

To install PostgreSQL 9.6:

.. literalinclude:: walkthrough/walkthrough_ubuntu1604.sh
    :start-after: #end-supported-ice
    :end-before: #end-step01

Create an omero system user, and a directory for the OMERO repository:

.. literalinclude:: walkthrough/walkthrough_ubuntu1604.sh
    :start-after: #start-step02
    :end-before: #end-step02

Create a database user and initialize a new database for OMERO. For the commands
below to work, add if required the user you are currently logged in as to the newly
created database:

.. literalinclude:: walkthrough/walkthrough_ubuntu1604.sh
    :start-after: #start-step03
    :end-before: #end-step03


Installing OMERO.server
-----------------------

**The following steps are run as the omero system user.**

Download, unzip and configure OMERO. The rest of this walkthrough assumes the
OMERO.server is installed into the home directory of the omero system user.

Note that this script requires the same environment variables that were set
earlier in `settings.env`, so you may need to copy and/or source this file as
the omero user.

You will need to install the server corresponding to your Ice version.

Install ``server-ice36.zip``:

.. literalinclude:: walkthrough/walkthrough_ubuntu1604.sh
    :start-after: #start-release-ice36
    :end-before: #end-release-ice36

Configure:

.. literalinclude:: walkthrough/walkthrough_ubuntu1604.sh
    :start-after: #end-release-ice36
    :end-before: #end-step04

Running OMERO.server
--------------------

**The following steps are run as the omero system user.**

OMERO should now be set up. To start the server run::

    OMERO.server/bin/omero admin start

In addition :download:`omero-init.d <walkthrough/omero-init.d>`
is available should you wish to start OMERO automatically.

Securing OMERO
--------------

**The following steps are run as root.**

If multiple users have access to the machine running OMERO you should restrict
access to OMERO.server's configuration and runtime directories, and optionally
the OMERO data directory:

.. literalinclude:: walkthrough/walkthrough_ubuntu1604.sh
    :start-after: #start-step07
    :end-before: #end-step07

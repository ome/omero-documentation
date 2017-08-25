OMERO.web deployed with OMERO.server Debian 9 and IcePy 3.6
===========================================================

Please first read :doc:`../../server-debian9-ice36`.

This is an example walkthrough for installing OMERO.web with OMERO.server using NGINX.
For convenience in this walkthrough, we will use the same configuration
options that the ones used for the installation of the OMERO.server.

Installing NGINX
----------------

**The following steps are run as root.**

Install NGINX, copy the NGINX OMERO configuration file into the
NGINX configuration directory, and disable the default configuration:

.. literalinclude:: ../../walkthrough/walkthrough_debian9.sh
    :start-after: #start-nginx
    :end-before: #end-nginx

Running OMERO.web
-----------------

**The following steps are run as the omero system user.**

To start the OMERO.web client run::

    OMERO.server/bin/omero web start

NGINX should already be running so you should be able to log in as the OMERO
root user by going to http://localhost/ in your web browser.

In addition :download:`omero-web-init.d <../../walkthrough/omero-web-init.d>`
is available should you wish to start OMERO.web automatically.


Regular tasks
-------------

**The following steps are run as root.**

The default OMERO.web session handler uses temporary files to store sessions
which should be deleted at regular intervals, for instance by creating a cron
job:

.. literalinclude:: ../../walkthrough/walkthrough_debian9.sh
    :start-after: #start-omeroweb-cron
    :end-before: #end-omeroweb-cron

Copy this script into the appropriate location:

.. literalinclude:: ../../walkthrough/walkthrough_debian9.sh
    :start-after: #start-copy-omeroweb-cron
    :end-before: #end-copy-omeroweb-cron

| :download:`omero-web-cron <../../walkthrough/omero-web-cron>`

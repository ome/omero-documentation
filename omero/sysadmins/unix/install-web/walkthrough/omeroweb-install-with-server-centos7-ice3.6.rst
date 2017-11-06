.. walkthroughs are generated using a bash script, see
.. https://github.com/ome/omero-install

OMERO.web installation with OMERO.server on CentOS 7 and IcePy 3.6
==================================================================

Please first read :doc:`../../server-centos7-ice36`.

This is an example walkthrough for installing OMERO.web with OMERO.server using NGINX.
For convenience in this walkthrough, we will use the same configuration
options that are used for the installation of the OMERO.server and an additional option
specific to the OMERO.web installation. When following this walkthrough you can
either use your own values, or alternatively
source :download:`settings-web.env <../../walkthrough/settings-web.env>`:

.. literalinclude:: ../../walkthrough/settings-web.env
   :start-after: Substitute

Installing prerequisites
------------------------

**The following steps are run as root.**

Install Pillow and Numpy:

.. literalinclude:: ../../walkthrough/walkthrough_centos7.sh
    :start-after: #start-web-dependencies
    :end-before: #end-web-dependencies

Install NGINX:

.. literalinclude:: ../../walkthrough/walkthrough_centos7.sh
    :start-after: #start-nginx-install
    :end-before: #end-nginx-install

Configuring OMERO.web
---------------------

**The following steps are run as the omero system user.**

Install other OMERO.web dependencies using pip:

.. literalinclude:: ../../walkthrough/walkthrough_centos7.sh
    :start-after: #web-requirements-recommended-start
    :end-before: #web-requirements-recommended-end

Configure and create the NGINX OMERO configuration file:

.. literalinclude:: ../../walkthrough/walkthrough_centos7.sh
    :start-after: #start-configure-nginx
    :end-before: #end-configure-nginx

For more customization, please read :ref:`customizing_your_omero_web_installation`.

Configuring NGINX
-----------------

**The following steps are run as root.**

Copy the generated configuration file into the NGINX configuration directory, disable the default configuration and start NGINX:

.. literalinclude:: ../../walkthrough/walkthrough_centos7.sh
    :start-after: #start-nginx-admin
    :end-before: #end-nginx-admin

Running OMERO.web
-----------------

**The following steps are run as the omero system user.**

To start the OMERO.web client run::

    OMERO.server/bin/omero web start

NGINX should already be running so you should be able to log in as the OMERO
root user by going to http://localhost/ in your web browser.

In addition :download:`omero-web-systemd.service <../../walkthrough/omero-web-systemd.service>` is available should you wish to start OMERO.web automatically.

Regular tasks
-------------

**The following steps are run as root.**

The default OMERO.web session handler uses temporary files to store sessions
which should be deleted at regular intervals, for instance by creating a cron
job:

.. literalinclude:: ../../walkthrough/walkthrough_centos7.sh
    :start-after: #start-omeroweb-cron
    :end-before: #end-omeroweb-cron

Copy this script into the appropriate location:

.. literalinclude:: ../../walkthrough/walkthrough_centos7.sh
    :start-after: #start-copy-omeroweb-cron
    :end-before: #end-copy-omeroweb-cron

| :download:`omero-web-cron <../../walkthrough/omero-web-cron>`


Maintenance
-----------

**The steps are run as the omero system user.**

Please read :ref:`omero_web_maintenance`.

SELinux
-------

**The following steps are run as root.**

If you are running a system with
`SELinux enabled <http://wiki.centos.org/HowTos/SELinux>`_
and are unable to access OMERO.web you may need to adjust the security policy:

.. literalinclude:: ../../walkthrough/walkthrough_centos7.sh
    :start-after: #start-selinux
    :end-before: #end-selinux

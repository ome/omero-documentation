.. walkthroughs are generated using a bash script, see
.. https://github.com/ome/omero-install

OMERO.server installation on CentOS 6 with Python 2.7
=====================================================

This is an example walkthrough for installing OMERO on CentOS 6 with Python 2.7, using
a dedicated system user, and should be read in conjunction with
:doc:`server-installation` and :doc:`install-web`. You can use this as a guide
for setting up your own test server. For production use you should also read
the pages listed under :ref:`index-optimizing-server`. 


Running OMERO on CentOS 6 has a number of special requirements which
deviate from the standard installation instructions. The instructions
below will set up Python 2.7 and Ice 3.6 on CentOS 6.
We tested the installation with Python 2.7 from `IUS <https://ius.io/>`_
and used a `virtual environment <https://virtualenv.readthedocs.org/en/latest/>`_
to install the various dependencies required to install an OMERO.server.
It is also possible to use SCL Python (for example 
:download:`walkthrough_centos6_py27.sh <walkthrough/walkthrough_centos6_py27.sh>`)
but such solution could have potential side effects.

This guide describes how to install the **recommended** versions, not all
the supported versions.
This should be read in conjunction with :doc:`../version-requirements`.

.. warning::

   CentOS 6 is deprecated, CentOS 7 is preferable for new installations;
   see :doc:`server-centos7-ice36`.

Setting up
----------

Python 2.7
^^^^^^^^^^

CentOS 6 provides Python 2.6. However, OMERO.web requires Python 2.7
in order to use `Django 1.8`_. While Django 1.6 may be used with Python
2.6, this version of Django no longer has security support.  In
consequence, it is necessary to upgrade to Python 2.7 in order to
obtain Django security updates, which are required for a production
deployment.

Ice 3.6
^^^^^^^
 
With Ice 3.6, the Python bindings are provided separately.
This allows to install the RPM packages provided by ZeroC for CentOS 6.
Then run ``pip install zeroc-ice`` to install the Ice Python bindings if
your package manager does not provide the Ice python packages.
See :zerocdoc:`Using the Python Distribution
<display/Ice36/Using+the+Python+Distribution>`
for further details.

Installing prerequisites
------------------------

**The following steps are run as root.**

Install Java 1.8, Ice 3.6 and PostgreSQL 9.6:

To install Java 1.8 and other dependencies:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-step01
    :end-before: # install Ice

To install Ice 3.6:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-recommended-ice
    :end-before: #end-recommended-ice

To install PostgreSQL 9.6:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #end-supported-ice
    :end-before: #end-step01

The remaining dependencies will be installed in a virtual environment:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-step01.1
    :end-before: #end-step01.1

See :download:`requirements_centos6_py27_ius.txt
<walkthrough/requirements_centos6_py27_ius.txt>`

Create an omero system user, and a directory for the OMERO repository:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-step02
    :end-before: #start-configuration-env

Create a database user and initialize a new database for OMERO:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-step03
    :end-before: #end-step03


The following settings will need adding to your OMERO startup script
or to the omero user's environment (for example in a shell startup
script). Add the absolute path to the :file:`bin` directory of 
the virtual environment :file:`/home/omero/omeroenv` to the ``PATH``
variable:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-configuration-env-ice36
    :end-before: #end-configuration-env-ice36

These settings will enable Python 2.7, and set the necessary
environment variables for Ice 3.6 to work.

Installing NGINX
----------------

**The following steps are run as the omero system user.**

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-nginx-install
    :end-before: #end-nginx-install

Install OMERO.server
--------------------

**The following steps are run as the omero system user.**

Download, unzip and configure OMERO. The rest of this walkthrough assumes the
OMERO.server is installed into the home directory of the omero system user.

Note that this script requires the same environment variables that were set
earlier in `settings.env`, so you may need to copy and/or source this file as
the omero user.

You will need to install the server corresponding to your Ice version.

Install ``server-ice36.zip``:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-release-ice36
    :end-before: #end-release-ice36

Configure:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #end-release-ice36
    :end-before: #end-step04

Configuring OMERO.web
---------------------

**The following steps are run as the omero system user.**

When following this section you can
either use your own values, or alternatively
source :download:`settings-web.env <walkthrough/settings-web.env>`:

.. literalinclude:: walkthrough/settings-web.env
   :start-after: Substitute

Install other OMERO.web dependencies using pip:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #web-requirements-recommended-start
    :end-before: #web-requirements-recommended-end

Configure and create the NGINX OMERO configuration file:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-configure-nginx
    :end-before: #end-configure-nginx

For more customization, please read :ref:`customizing_your_omero_web_installation`.

Configuring NGINX
-----------------

**The following steps are run as root.**

Copy the generated configuration file into the NGINX configuration directory, disable the default configuration and start NGINX:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-nginx-admin
    :end-before: #end-nginx-admin

Running OMERO.server
--------------------

**The following steps are run as the omero system user.**

OMERO should now be set up. To start the server run::

    OMERO.server/bin/omero admin start

Please read the SELinux_ section below.

In addition :download:`omero-systemd.service <walkthrough/omero-systemd.service>`
is available should you wish to start OMERO automatically.

Running OMERO.web
-----------------

**The following steps are run as the omero system user.**

To start the OMERO.web client run::

    OMERO.server/bin/omero web start

NGINX should already be running so you should be able to log in as the OMERO
root user by going to http://localhost/ in your web browser.

In addition :download:`omero-web-systemd.service <walkthrough/omero-web-systemd.service>` is available should you wish to start OMERO.web automatically.

Securing OMERO
--------------

**The following steps are run as root.**

If multiple users have access to the machine running OMERO you should restrict
access to OMERO.server's configuration and runtime directories, and optionally
the OMERO data directory:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-step07
    :end-before: #end-step07


Regular tasks
-------------

**The following steps are run as root.**

The default OMERO.web session handler uses temporary files to store sessions
which should be deleted at regular intervals, for instance by creating a cron
job:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-omeroweb-cron
    :end-before: #end-omeroweb-cron

Copy the following commands into the appropriate location:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-copy-omeroweb-cron
    :end-before: #end-copy-omeroweb-cron

| :download:`omero-web-cron <walkthrough/omero-web-cron>`


SELinux
-------

**The following steps are run as root.**

If you are running a system with SELinux enabled (it is
`enabled by default on CentOS 6 <http://wiki.centos.org/HowTos/SELinux>`_)
and are unable to access OMERO.web you may need to adjust the security policy:

.. literalinclude:: walkthrough/walkthrough_centos6_py27_ius.sh
    :start-after: #start-selinux
    :end-before: #end-selinux

Installing Web apps
-------------------

**The following steps are run as root.**

It is possible to add Web applications to OMERO. If your app required some extra Python packages installed
using ``pip``, those packages should be also installed in the virtual environment. For example,
`OMERO.figure <http://figure.openmicroscopy.org/>`_ requires ``reportlab`` and ``markdown``::

    virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
    source /home/omero/omeroenv/bin/activate
    /home/omero/omeroenv/bin/pip2.7 install reportlab markdown



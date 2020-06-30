OMERO.web installation and maintenance
======================================

OMERO.web is a Python 3 client of the OMERO platform that provides a
web-based UI and JSON API.
This section provides links to detailed step-by-step walkthroughs describing how to install, customize, maintain and run OMERO.web for several systems.
OMERO.web is installed **separately** from the OMERO.server.

OMERO.web can be deployed with:

-  `WSGI <https://wsgi.readthedocs.org>`_ using a WSGI capable web server
   such as
   `NGINX <https://nginx.org/>`_ and `Gunicorn <https://docs.gunicorn.org/>`_
-  the built-in Django lightweight development server. This type of deployment should only be used for **testing** purpose
   only; see the :doc:`/developers/Web/Deployment` page.

If you need help configuring your firewall rules, see
:doc:`/sysadmins/server-security` for more details.

Depending upon which platform you are using, you may find a
more specific walkthrough listed below. The guides use the example of deploying OMERO.web with
`NGINX <https://nginx.org/>`_ and `Gunicorn <https://docs.gunicorn.org/>`_.
OMERO can automatically generate a
configuration file for your webserver. The location of the file will depend
on your system, please refer to your webserver's manual. See in the section `Customizing your OMERO.web installation` in the various walkthroughs for more options.

.. _omero_web_configuration:

Configuration
-------------
You will find in the various guides how to create the NGINX OMERO configuration file
and the configuration steps for the NGINX and Gunicorn.
Advanced Gunicorn setups are also described to enable the download of binary data
and to handle multiple clients on a single worker
thread switching context as necessary while streaming binary data from
OMERO.server. Depending on the traffic and scale of the repository you should
configure connections and speed limits on your server to avoid blocking
resources.

Walkthroughs
------------

**Recommended:**


:doc:`walkthrough/omeroweb-install-centos7-ice3.6`
  Instructions for installing OMERO.web from scratch on CentOS 7 with Ice 3.6.

:doc:`walkthrough/omeroweb-install-centos8-ice3.6`
  Instructions for installing OMERO.web from scratch on CentOS 8 with Ice 3.6.

:doc:`walkthrough/omeroweb-install-debian10-ice3.6`
  Instructions for installing OMERO.web from scratch on Debian 10 with Ice 3.6.

:doc:`walkthrough/omeroweb-install-ubuntu1804-ice3.6`
  Instructions for installing OMERO.web from scratch on Ubuntu 18.04 with Ice 3.6.

:doc:`walkthrough/omeroweb-install-ubuntu2004-ice3.6`
  Instructions for installing OMERO.web from scratch on Ubuntu 20.04 with Ice 3.6.

**Upcoming:**

:doc:`walkthrough/omeroweb-install-ubuntu1604-ice3.6`
  Instructions for installing OMERO.web from scratch on Ubuntu 16.04 with Ice 3.6.

:doc:`walkthrough/omeroweb-install-debian9-ice3.6`
  Instructions for installing OMERO.web from scratch on Debian 9 with Ice 3.6.

.. toctree::
    :maxdepth: 1
    :titlesonly:
    :hidden:

    walkthrough/omeroweb-install-centos7-ice3.6
    walkthrough/omeroweb-install-centos8-ice3.6
    walkthrough/omeroweb-install-ubuntu1604-ice3.6
    walkthrough/omeroweb-install-ubuntu1804-ice3.6
    walkthrough/omeroweb-install-ubuntu2004-ice3.6
    walkthrough/omeroweb-install-debian9-ice3.6
    walkthrough/omeroweb-install-debian10-ice3.6

.. note:: Support for Apache deployment has been dropped in 5.3.0.
    
    If your organization's policies only allow Apache to be used as the external-facing web-server you should configure Apache to proxy connections to an NGINX instance running on your OMERO server i.e. use Apache as a reverse proxy. For more details see
    `Apache mod_proxy documentation <https://httpd.apache.org/docs/current/mod/mod_proxy.html>`_.

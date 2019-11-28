OMERO.web installation
======================

OMERO.web is a Python client of the OMERO platform that provides a
web-based UI and JSON API.
This section provides guidance on how to install and set up OMERO.web on
any of the supported UNIX and UNIX-like platforms. Specific walkthroughs are
provided for several systems, with detailed step-by-step instructions.
OMERO.web can be either installed **separately** from 
the OMERO.server or installed with the OMERO.server.
Deploying separately is **recommended** as they
perform best under different circumstances and require a different set of
dependencies.

OMERO.web can be deployed with:

-  `WSGI <https://wsgi.readthedocs.org>`_ using a WSGI capable web server
   such as
   `NGINX <https://nginx.org/>`_ and `Gunicorn <https://docs.gunicorn.org/>`_
-  the built-in Django lightweight development server (for **testing**
   only; see the :doc:`/developers/Web/Deployment` page)

If you need help configuring your firewall rules, see
:doc:`/sysadmins/server-security` for more details.

If you have installed NGINX, OMERO can automatically generate a
configuration file for your webserver. The location of the file will depend
on your system, please refer to your webserver's manual. See
:ref:`customizing_your_omero_web_installation` for additional
customization options.

Depending upon which platform you are using, you may find a
more specific walkthrough listed below.

**Recommended:**

.. seealso::

    :doc:`walkthrough/omeroweb-install-centos7-ice3.6`
        Instructions for installing **separately** OMERO.web from
        scratch on CentOS 7 with Ice 3.6.

    :doc:`walkthrough/omeroweb-install-ubuntu1804-ice3.6`
        Instructions for installing **separately** OMERO.web from
        scratch on Ubuntu 18.04 with Ice 3.6.

**Supported:**

.. seealso::


    :doc:`walkthrough/omeroweb-install-ubuntu1604-ice3.6`
        Instructions for installing **separately** OMERO.web from
        scratch on Ubuntu 16.04 with Ice 3.6.

    :doc:`walkthrough/omeroweb-install-debian9-ice3.6`
        Instructions for installing **separately** OMERO.web from
        scratch on Debian 9 with Ice 3.6.

    :doc:`walkthrough/omeroweb-install-osx-ice3.6`
        Instructions for installing OMERO.web from scratch on
        on Mac OS X with Homebrew. It is aimed at **developers**
        since typically MacOS X is not suited for serious deployment.


.. toctree::
    :maxdepth: 1
    :titlesonly:
    :hidden:

    walkthrough/omeroweb-install-centos7-ice3.6
    walkthrough/omeroweb-install-ubuntu1604-ice3.6
    walkthrough/omeroweb-install-ubuntu1804-ice3.6
    walkthrough/omeroweb-install-debian9-ice3.6
    walkthrough/omeroweb-install-osx-ice3.6

.. note:: Support for Apache deployment has been dropped in 5.3.0.
    
    If your organization's policies only allow Apache to be used as the external-facing web-server you should configure Apache to proxy connections to an NGINX instance running on your OMERO server i.e. use Apache as a reverse proxy. For more details see
    `Apache mod_proxy documentation <https://httpd.apache.org/docs/current/mod/mod_proxy.html>`_.

This guide uses the example of deploying OMERO.web **separately** from OMERO.server with
`NGINX <https://nginx.org/>`_ and `Gunicorn <https://docs.gunicorn.org/>`_.

.. _omero_web_deployment:

Prerequisites
-------------

-  Python 3

   -  `NumPy <https://www.numpy.org>`_ >=1.9

-  A `WSGI <https://wsgi.readthedocs.org>`_-capable webserver such as
   `NGINX <https://nginx.org/>`_ and `Gunicorn <https://docs.gunicorn.org/>`_


If possible, install the following packages:

.. list-table::
    :header-rows: 1
    :widths: 1,8

    * - System
      - Package

    * - Debian
      - python3 nginx

    * - Homebrew
      - python nginx

    * - RedHat
      - python3 nginx

Installation
------------

From **OMERO 5.6.0** release, the ``omero-web`` library supports Python 3 and
can be installed via :command:`pip`.

We assume the following::

    $ omero_user_home_dir=/home/omero
    $ OMERODIR=${omero_user_home_dir}/omero

We recommend you use a virtual environment::

    $ python3 -m venv py3_venv
    $ source py3_venv/bin/activate
    $ pip install omero-web
    $ OMERODIR=${OMERODIR}

.. _gunicorn_default_configuration:

Gunicorn configuration
----------------------

Additional settings can be configured by changing the following properties:

- :property:`omero.web.application_server.max_requests` to 500

- :property:`omero.web.wsgi_workers` to (2 x NUM_CORES) + 1

  .. note::
      **Do not** scale the number of workers to the number of clients
      you expect to have. OMERO.web should only need 4-12 worker
      processes to handle many requests per second.

- :property:`omero.web.wsgi_args` Additional arguments. For more details
  check `Gunicorn Documentation <https://docs.gunicorn.org/en/stable/settings.html>`_.

NGINX configuration
-------------------

OMERO can automatically generate a
configuration file for your web server. The location of the file
will depend on your system, please refer to your webserver's manual.
See :ref:`customizing_your_omero_web_installation`
for additional customization options.

To create a site configuration file for inclusion in a system-wide NGINX
configuration redirect the output of the following command into a file:

::

    $ omero web config nginx

.. literalinclude:: nginx-omero.conf


For production servers you may need to add additional directives to the
configuration file, for example to enable
`HTTPS <https://nginx.org/en/docs/http/configuring_https_servers.html>`_.
As an alternative to manually modifying the generated file you can generate
a minimal configuration:

::

    $ omero web config nginx-location > {{ omero_user_home_dir }}/omero-web-location.include

.. literalinclude:: omero-web-location.include


and include this in your own manually created NGINX file, such as
:file:`/etc/nginx/conf.d/omero-web.conf`.


This requires more initial work but in the future you can automatically
regenerate your OMERO.web configuration and your additional configuration
settings will still apply.


.. note::
    If you need help configuring your firewall rules, see the
    :doc:`/sysadmins/server-security` page.



Running OMERO.web
-----------------

Start the Gunicorn worker processes listening by default on 127.0.0.1:4080:

::

    $ omero web start
    ... static files copied to '/home/omero/omero/lib/python/omeroweb/static'.
    Starting OMERO.web... [OK]

The Gunicorn workers are managed **separately** from other OMERO.server
processes. You can check their status or stop them using the
following commands:

::

    $ omero web status
    OMERO.web status... [RUNNING] (PID 59217)
    $ omero web stop
    Stopping OMERO.web... [OK]
    Django WSGI workers (PID 59217) killed.

.. _trial_download_limitation:

Download limitations
^^^^^^^^^^^^^^^^^^^^

In order to offer users the ability to download data from OMERO.web you have
to deploy using :ref:`async_workers`.
OMERO.web is able to handle multiple clients on a single worker
thread switching context as necessary while streaming binary data from
OMERO.server. Depending on the traffic and scale of the repository you should
configure connections and speed limits on your server to avoid blocking
resources. We recommend you run benchmark and performance tests.
It is also possible to apply :ref:`download_restrictions` and
offer alternative access to binary data.

.. note::
    Handling streaming request/responses requires proxy buffering
    to be turned off. For more details refer to
    `Gunicorn deployment <https://docs.gunicorn.org/en/stable/deploy.html>`_
    and
    `NGINX configuration <https://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_buffering>`_.

.. note::
    :property:`omero.web.application_server.max_requests` should be set to 0


Benchmark
---------

We run example benchmarks on rendering thumbnails and 512x512 pixels planes
for 100 concurrent users making 5000 requests in total::

    $ ab -n 5000 -c 100 https://server.openmicroscopy.org/omero/webclient/render_thumbnail/1234/
    This is ApacheBench, Version 2.3 <$Revision: 1706008 $>
    Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
    Licensed to The Apache Software Foundation, http://www.apache.org/

    Benchmarking server.openmicroscopy.org (be patient)
    Completed 100 requests
    Completed 200 requests
    Completed 300 requests
    Completed 400 requests
    Completed 500 requests
    Finished 500 requests


    Server Software:        nginx/1.11.10
    Server Hostname:        server.openmicroscopy.org
    Server Port:            80

    Document Path:          /omero/webclient/render_thumbnail/1234/
    Document Length:        4405 bytes

    Concurrency Level:      20
    Time taken for tests:   17.904 seconds
    Complete requests:      500
    Failed requests:        0
    Total transferred:      2271500 bytes
    HTML transferred:       2202500 bytes
    Requests per second:    27.93 [#/sec] (mean)
    Time per request:       716.144 [ms] (mean)
    Time per request:       35.807 [ms] (mean, across all concurrent requests)
    Transfer rate:          123.90 [Kbytes/sec] received

    Connection Times (ms)
                  min  mean[+/-sd] median   max
    Connect:       45   49   4.3     48      83
    Processing:   245  650 113.4    620    1167
    Waiting:      244  649 113.4    620    1167
    Total:        294  699 113.0    670    1214

    Percentage of the requests served within a certain time (ms)
      50%    670
      66%    698
      75%    737
      80%    754
      90%    814
      95%    951
      98%   1070
      99%   1080
     100%   1214 (longest request)


Troubleshooting
---------------

In order to identify why OMERO.web is not available run:

::

    $ omero web status


Then consult NGINX :file:`error.log` and :file:`/home/omero/omero/var/log/OMEROweb.log`

Check :ref:`troubleshooting-omeroweb` for more details.


Debugging
^^^^^^^^^

To run the WSGI server in debug mode, enable
`Gunicorn logging <https://docs.gunicorn.org/en/stable/settings.html#logging>`_
using :property:`omero.web.wsgi_args`:

::

    $ omero config set omero.web.wsgi_args -- "--log-level=DEBUG --error-logfile=/home/omero/omero/var/log/error.log".


.. _gunicorn_advance_configuration:

EXPERIMENTAL: Gunicorn advanced configuration
---------------------------------------------

.. note:: The following configuration options marked as **EXPERIMENTAL** have yet to be extensively tested in a
    production environment, use at your own risk.


OMERO.web deployment can be configured with sync and async workers.
Sync workers are faster and recommended for a data repository with
:ref:`download_restrictions`. If you wish to offer users the ability
to download data then you have to use async workers; read more about
:ref:`trial_download_limitation` above.

See
`Gunicorn design <https://docs.gunicorn.org/en/stable/design.html>`_ for more details.


EXPERIMENTAL: Sync workers
^^^^^^^^^^^^^^^^^^^^^^^^^^

- Install :pypi:`futures` ::

      $ pip install futures

Additional settings can be configured by changing the following properties:

- The number of worker threads for handling requests, see
  `Gunicorn threads <https://docs.gunicorn.org/en/stable/settings.html#threads>`_ ::

      $ omero config set omero.web.wsgi_worker_class
      $ omero config set omero.web.wsgi_threads $(2-4 x NUM_CORES)

.. _async_workers:

EXPERIMENTAL: Async workers
^^^^^^^^^^^^^^^^^^^^^^^^^^^

- Install `Gevent >= 0.13 <http://www.gevent.org/>`_ ::

      $ pip install "gevent>=0.13"

Additional settings can be configured by changing the following properties:

- The maximum number of simultaneous clients, see
  `Gunicorn worker-connections <https://docs.gunicorn.org/en/stable/settings.html#worker-connections>`_ ::

      $ omero config set omero.web.wsgi_worker_class gevent
      $ omero config set omero.web.wsgi_worker_connections 1000
      $ omero config set omero.web.application_server.max_requests 0

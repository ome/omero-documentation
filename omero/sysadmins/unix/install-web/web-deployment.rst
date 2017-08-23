OMERO.web WSGI deployment
=========================

OMERO.web is the web application component of the OMERO platform which
allows for the management, visualization (in a fully multi-dimensional
image viewer) and annotation of images from a web browser. It also
includes the ability to manage users and groups.

This guide uses the example of deploying OMERO.web separately from OMERO.server
with Nginx and gunicorn.

Prerequisites
-------------

-  Python 2.7

   -  :pypi:`virtualenv` (optional) tool to create isolated Python environments

   -  :pypi:`PyPI <>` a package management system used to install and manage
      software packages written in Python. PyPI is already installed if
      you are using Python 2 >=2.7.9

   -  `omego <https://github.com/ome/omego>`_ OME package management system

   -  `ZeroC`_ IcePy 3.6

   -  `Pillow`_ <3.4

   -  `NumPy <http://www.numpy.org>`_ >=1.9 

-  A `WSGI <http://wsgi.readthedocs.org>`_-capable web server such as
   `nginx <http://nginx.org/>`_ and `gunicorn <http://docs.gunicorn.org/>`_,


.. _gunicorn_default_configuration:

Default configuration
---------------------

If you wish to install the dependencies in a virtual environment, you will
first have to create one and activate it. The following step is optional:

::

   $ virtualenv omeroweb
   $ source omeroweb/bin/activate

Install the OMERO.web dependencies using the package management tools:

::

   $ pip install omego
   $ omego download --ice "3.6" py
   $ zip=$(ls OMERO.py*.zip)
   $ zipname=${zip%.zip}
   $ rm -f $zip
   $ mv $(find . -name 'OMERO.py*' -type d) `pwd`/OMERO.py
   $ pip install -r OMERO.py/share/web/requirements-py27-all.txt


.. note:: For more details refer to
      :djangodoc:`how to install Django 1.8 <topics/install/#install-the-django-code>`
      or :djangodoc:`upgrade Django to 1.8 <topics/install/#remove-any-old-versions-of-django>`.

Additional Gunicorn configuration
---------------------------------

Additional settings can be configured by changing the following properties:

- :property:`omero.web.application_server.max_requests` to 500

- :property:`omero.web.wsgi_workers` to (2 x NUM_CORES) + 1

  .. note::
      **Do not** scale the number of workers to the number of clients
      you expect to have. OMERO.web should only need 4-12 worker
      processes to handle many requests per second.

- :property:`omero.web.wsgi_args` Additional arguments. For more details
  check `Gunicorn Documentation <http://docs.gunicorn.org/en/stable/settings.html>`_.

Nginx configuration
-------------------

OMERO can automatically generate a
configuration file for your web server. The location of the file
will depend on your system, please refer to your web server's manual.
See :ref:`customizing_your_omero_web_installation`
for additional customization options.

To create a site configuration file for inclusion in a system-wide nginx
configuration redirect the output of the following command into a file:

::

    $ OMERO.py/bin/omero web config nginx

.. literalinclude:: nginx-omero.conf


For production servers you may need to add additional directives to the
configuration file, for example to enable
`HTTPS <http://nginx.org/en/docs/http/configuring_https_servers.html>`_.
As an alternative to manually modifying the generated file you can generate
a minimal configuration:

::

    $ OMERO.py/bin/omero web config nginx-location > \
          /home/omero/nginx-omero-location.include

.. literalinclude:: nginx-omero-location.include


and include this in your own manually created Nginx file, such as
`/etc/nginx/conf.d/omero-web.conf`:

.. literalinclude:: nginx-location-manual-wrapper.conf


This requires more initial work but in future you can automatically
regenerate your OMERO.web configuration and your additional configuration
settings will still apply.


.. note::
    If you need help configuring your firewall rules, see the
    :doc:`/sysadmins/server-security` page.



Running OMERO.web
-----------------

Start the Gunicorn worker processes listening by default on 127.0.0.1:4080:

::

    $ OMERO.py/bin/omero web start
    ... static files copied to '/home/omero/OMERO.server/lib/python/omeroweb/static'.
    Starting OMERO.web... [OK]

The Gunicorn workers are managed **separately** from other OMERO.server
processes. You can check their status or stop them using the
following commands:

::

    $ OMERO.py/bin/omero web status
    OMERO.web status... [RUNNING] (PID 59217)
    $ OMERO.py/bin/omero web stop
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
    `Gunicorn deployment <http://docs.gunicorn.org/en/stable/deploy.html>`_
    and
    `Nginx configuration <http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_buffering>`_.

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

    $ OMERO.py/bin/omero web status

Then consult nginx :file:`error.log` and :file:`OMERO.server/var/log/OMEROweb.log`

Check :ref:`troubleshooting-omeroweb` for more details.


Debugging
^^^^^^^^^

To run the WSGI server in debug mode, enable
`Gunicorn logging <http://docs.gunicorn.org/en/stable/settings.html#logging>`_
using :property:`omero.web.wsgi_args`:

::

    $ OMERO.py/bin/omero config set omero.web.wsgi_args -- "--log-level=DEBUG --error-logfile=/home/omero/OMERO.server/var/log/error.log".


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
`Gunicorn design <http://docs.gunicorn.org/en/stable/design.html>`_ for more details.


EXPERIMENTAL: Sync workers
^^^^^^^^^^^^^^^^^^^^^^^^^^

- Install `futures <https://pypi.python.org/pypi/futures>`_ ::

      $ pip install futures

Additional settings can be configured by changing the following properties:

- The number of worker threads for handling requests, see
  `Gunicorn threads <http://docs.gunicorn.org/en/stable/settings.html#threads>`_ ::

      $ OMERO.py/bin/omero config set omero.web.wsgi_worker_class
      $ OMERO.py/bin/omero config set omero.web.wsgi_threads $(2-4 x NUM_CORES)

.. _async_workers:

EXPERIMENTAL: Async workers
^^^^^^^^^^^^^^^^^^^^^^^^^^^

- Install `Gevent >= 0.13 <http://www.gevent.org/>`_ ::

      $ pip install "gevent>=0.13"

Additional settings can be configured by changing the following properties:

- The maximum number of simultaneous clients, see
  `Gunicorn worker-connections <http://docs.gunicorn.org/en/stable/settings.html#worker-connections>`_ ::

      $ OMERO.py/bin/omero config set omero.web.wsgi_worker_class gevent
      $ OMERO.py/bin/omero config set omero.web.wsgi_worker_connections 1000
      $ OMERO.py/bin/omero config set omero.web.application_server.max_requests 0


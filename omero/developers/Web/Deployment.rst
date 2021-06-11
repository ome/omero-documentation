OMERO.web installation for developers
=====================================

Getting set up
--------------

You will need to have an OMERO server running that you can connect to. This
could be on your own machine ``localhost`` or you can connect to a
remote OMERO server.

The preferred option for developing OMERO.web apps is to install
``omero-web`` on your machine as described below.

However, it is also possible to use
`omero-web-docker <https://github.com/ome/omero-web-docker/>`_
to run OMERO.web in a Docker container.
If you are using this option, you can go directly to the
:doc:`/developers/Web/CreateApp` page which describes this process.

Installing OMERO.web
--------------------

From OMERO 5.6.0 release, the ``omero-web`` library supports Python 3 and
can be installed via :command:`pip`. We need to specify a location :envvar:`OMERODIR`
to create log files and a :file:`config.xml` file. This can be any existing
directory. We recommend you use a virtual environment:

.. parsed-literal::

    $ python3 -m venv py3_venv
    $ source py3_venv/bin/activate

    # Somewhere to create config and log files
    $ export OMERODIR=$(pwd)

    $ pip install 'omero-web>=\ |version_web|'

    Successfully installed Django-1.11.26 Pillow-6.2.1 django-pipeline-1.6.14
    future-0.18.2 gunicorn-20.0.0 omero-marshal-0.6.3 omero-py-5.6.dev5
    omero-web-5.6.dev5 pytz-2019.3 zeroc-ice-3.6.5

Using the lightweight development server
----------------------------------------

All that is required to use the Django lightweight development server
is to set the :property:`omero.web.application_server` configuration option,
and turn :property:`omero.web.debug` on.
If you want to connect to a remote OMERO server, add that as shown.
Then start up the development server to run in the foreground:

::

    $ omero config set omero.web.application_server development
    $ omero config set omero.web.debug True
    $ omero config append omero.web.server_list `["server.address", 4064, "name"]`
    $ omero web start
    INFO:__main__:Application Starting...
    INFO:root:Processing custom settings for module omeroweb.settings
    ...
    Validating models...

    0 errors found
    Django version 1.11, using settings 'omeroweb.settings'
    Starting development server at http://127.0.0.1:4080/
    Quit the server with CONTROL-C.

You should now be able to open http://localhost:4080 in your browser,
choose the OMERO server and login.

Using WSGI
----------

For convenience you may wish to run a web server under your local user account
instead of using a system server for testing. Install NGINX and Gunicorn
(See :doc:`/sysadmins/unix/install-web/web-deployment`) but generate a configuration file
using the following commands:

::

    $ omero config set omero.web.application_server 'wsgi-tcp'
    $ omero web config nginx-development > nginx-development.conf

Start NGINX and the Gunicorn worker processes running one thread
listening on 127.0.0.1:4080 that will autoreload on source change:

::

    $ nginx -c $PWD/nginx-development.conf
    $ omero config set omero.web.application_server.max_requests 1
    $ omero config set omero.web.wsgi_args -- "--reload"
    $ omero web start

Next: Get started by :doc:`/developers/Web/CreateApp`....

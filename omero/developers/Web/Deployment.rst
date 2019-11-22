OMERO.web installation for developers
=====================================

Getting set up
--------------

You will need to have an OMERO server running that you can connect to. This
could be on your own machine or you can connect to an
external OMERO server.

Using Docker
------------

If you are not working on the OMERO.web code itself, you can use
`omero-web-docker <https://github.com/ome/omero-web-docker/>`_
to run OMERO.web. This allows you to develop your own OMERO.web
app without needing to install OMERO.web on your development machine.

If you are using this option, you can go directly to the
:doc:`/developers/Web/CreateApp` page which describes this process.

Installing OMERO.web
--------------------

From OMERO 5.6.0 release, the ``omero-web`` library supports Python 3 and
can be installed via ``pip``. We recommend you use a virtual environment:

    $ python3 -m venv py3_venv
    $ source py3_venv/bin/activate

    $ pip install "omero-web==v5.6.dev5"

    Successfully installed Django-1.11.26 Pillow-6.2.1 django-pipeline-1.6.14
    future-0.18.2 gunicorn-20.0.0 omero-marshal-0.6.3 omero-py-5.6.dev5
    omero-web-5.6.dev5 pytz-2019.3 zeroc-ice-3.6.5

Using the lightweight development server
----------------------------------------

All that is required to use the Django lightweight development server
is to set the :property:`omero.web.application_server` configuration option,
turn :property:`omero.web.debug` on.
We also configure a remote server to connect to, and then
start the server up.

::

    $ omero config set omero.web.application_server development
    $ omero config set omero.web.debug True
    $ omero config append omero.web.server_list `["server.address", 4064, "name"]
    $ omero web start
    INFO:__main__:Application Starting...
    INFO:root:Processing custom settings for module omeroweb.settings
    ...
    Validating models...

    0 errors found
    Django version 1.8, using settings 'omeroweb.settings'
    Starting development server at http://127.0.0.1:4080/
    Quit the server with CONTROL-C.

Using WSGI
----------

For convenience you may wish to run a web server under your local user account
instead of using a system server for testing. Install NGINX and Gunicorn
(See :doc:`/sysadmins/unix/install-web`) but generate a configuration file
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

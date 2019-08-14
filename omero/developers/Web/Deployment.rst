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

You will need to follow the install instructions for OMERO.web,
either as a standalone install, or as part of the OMERO.server install.

If you want to connect to a remote server, you can add the server to the
:property:`omero.web.server_list` and choose that server when you log in.
You should enable :property:`omero.web.debug` and start a lightweight
development Web server on your local machine.

.. note:: Since OMERO 5.2, the OMERO.web framework no longer bundles
    a copy of the Django package, instead manual installation of
    the Django dependency is required. It is highly recommended to use
    `Django 1.8`_ (LTS) which requires Python 2.7. For more information
    see :ref:`python-requirements` on the
    :doc:`/sysadmins/version-requirements` page.

Using the lightweight development server
----------------------------------------

All that is required to use the Django lightweight development server
is to set the :property:`omero.web.application_server` configuration option,
turn :property:`omero.web.debug` on and start the server up:

::

    $ bin/omero config set omero.web.application_server development
    $ bin/omero config set omero.web.debug True
    $ bin/omero web start
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

    $ bin/omero config set omero.web.application_server 'wsgi-tcp'
    $ bin/omero web config nginx-development > nginx-development.conf

Start NGINX and the Gunicorn worker processes running one thread
listening on 127.0.0.1:4080 that will autoreload on source change:

::

    $ nginx -c $PWD/nginx-development.conf
    $ bin/omero config set omero.web.application_server.max_requests 1
    $ bin/omero config set omero.web.wsgi_args -- "--reload"
    $ bin/omero web start

Next: Get started by :doc:`/developers/Web/CreateApp`....

Creating an app
===============

The Django web site has a very good :djangodoc:`tutorial <intro/tutorial01/>`
to get you familiar with the Django framework. The more you know about
Django, the easier you will find it working with the OmeroWeb framework.

All official OMERO applications can be installed from PyPI_.

Getting set up
--------------

In order to deploy OMERO.web in a development or testing environment,
you can use Docker as described below or
follow the install instructions under :doc:`Deployment`.

If you want to make changes to the OMERO.web code itself, go to
:doc:`/developers/Web/EditingOmeroWeb`.

Clone the examples repository
-----------------------------

To get started quickly, we are going to use the
`omero-web-apps-examples <https://github.com/ome/omero-web-apps-examples>`_
repository which contains two sample OMERO.web apps.
Clone the repo to a location of your choice:

::

    $ git clone git@github.com:ome/omero-web-apps-examples.git

We will run the simplest example app from the repo. This is called
``minimal_webapp``.

Run your app with locally-installed OMERO.web
---------------------------------------------

If you have installed ``omero-web`` locally in a virtual environment
as described in :doc:`Deployment`, you can simply install
the minimal-webapp example via pip:

::

    $ cd omero-web-apps-examples/minimal-webapp
    $ pip install -e .

This installs the source code directly, allowing you to work on
the installed code.

You also need to add your app to the :property:`omero.web.apps` setting:

.. note::

    Here we use single quotes around double quotes.

::

    $ omero config append omero.web.apps '"minimal_webapp"'

Now you can restart your omero-web server and go to
`http://localhost:4080/minimal_webapp/ <http://localhost:4080/minimal_webapp/>`_
in your browser.
You should be redirected to the login screen and then back to the ``minimal_webapp``
page which will display your Name and list your Projects.

Run your app with OMERO.web in a Docker container
-------------------------------------------------

The following walk-through uses `omero-web-docker <https://github.com/ome/omero-web-docker/>`_
to run the app. Here we add ``minimal_webapp`` to the installed apps and map the
app directory to the ``site-packages`` directory in the Docker instance so that
python can import our ``minimal_webapp`` module.

::

    # You need to be in the project directory for this to work.
    # cd omero-web-apps-examples/

    # The OMERO server we want to connect to.
    $ host=demo.openmicroscopy.org

    # Path to the python module for the app.
    $ appdir=$(pwd)/minimal-webapp/minimal_webapp

    # Location within Docker instance we want to link the app, so it can be imported.
    $ docker_appdir=/opt/omero/web/venv/lib/python2.7/site-packages/minimal_webapp

    # This example config file installs "minimal_webapp". See the file for more details.
    $ config=$(pwd)/config.omero

    # Location within Docker instance we want to mount the config.
    $ docker_config=/opt/omero/web/config/config.omero

    # Run docker container.
    $ docker run -it --rm -e OMEROHOST=$host -p 4080:4080 -v $appdir:$docker_appdir -v $config:$docker_config openmicroscopy/omero-web-standalone

This will run Docker in the foreground, showing the output in your terminal and allowing you to
kill the container with Ctrl-C. You should see the following lines in the output, indicating
that OMERO.web is starting and the static files from your app are being included.

::

    ...
    Copying '/opt/omero/web/venv/lib/python2.7/site-packages/minimal_webapp/static/minimal_webapp/app.css'
    Copying '/opt/omero/web/venv/lib/python2.7/site-packages/minimal_webapp/static/minimal_webapp/app.js'
    ...
    Starting OMERO.web...

Now go to `http://localhost:4080/minimal_webapp/ <http://localhost:4080/minimal_webapp/>`_
in your browser.
You should be redirected to the login screen and then back to the ``minimal_webapp``
page which will display your Name and list your Projects.

Exploring the app
-----------------

The `minimal_webapp code <https://github.com/ome/omero-web-apps-examples/tree/master/minimal-webapp>`_
is well documented to explain how the app is working.
Briefly, the app supports a single URL defined in
``minimal_webapp/urls.py`` which maps to the ``index`` function
within ``minimal_webapp/views.py``. This uses the connection to
OMERO, ``conn`` to load the current user's name and passes this
to the ``index.html`` template to render the page.

This page also includes the static ``app.js`` and ``app.css`` files.
JavaScript is used to load Projects from the :doc:`/developers/json-api` and
display them on the page.

Create an app from the template example
---------------------------------------

If you want to create your own app, you can use the example
as a template.

Go to the template repository
`omero-web-apps-examples <https://github.com/will-moore/omero-web-apps-examples>`_.
Click 'Use this template' as `described here
<https://help.github.com/en/articles/creating-a-repository-from-a-template>`_
and choose a name for your new repo, for example ``my_app``.

Go to the directory where you want your app to live and clone it.
Then run as above with Docker or locally-installed OMERO.web, making sure
that your app can be imported as before.

::

    $ git clone https://github.com/<username>/my_app
    $ cd my_app

    # Then run as above...


App settings
------------

You can add settings to your app that allow configuration via the command line
in the same way as for the base OMERO.web. The list of ``CUSTOM_SETTINGS_MAPPINGS`` in
`settings.py <https://github.com/ome/omero-web/blob/master/omeroweb/settings.py>`_
is a good source for examples of the different data types and parsers you can use.

For example, if you want to create a user-defined setting appname.foo,
that contains a dictionary of key-value pairs, you can add to
``CUSTOM_SETTINGS_MAPPINGS`` in ``appname/settings.py``::

    import json
    CUSTOM_SETTINGS_MAPPINGS = {
        "omero.web.appname.foo": ["FOO", '{"key": "val"}', json.loads]
    }

From somewhere else in your app, you can then access the settings::

    from appname import settings

    print(settings.FOO)

Users can then configure this on the command line as follows::

    $ omero config set omero.web.appname.foo '{"userkey": "userval"}'


Linking from Webclient
----------------------

If you want to add links to your app from the webclient, a number of options are
described on :doc:`/developers/Web/LinkingFromWebclient`.


Releasing your app
------------------

The :doc:`/developers/Web/ReleaseApp` page has some useful steps to
take when you are preparing to release your app.

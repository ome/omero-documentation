Creating an app
===============

The Django web site has a very good :djangodoc:`tutorial <intro/tutorial01/>`
to get you familiar with the Django framework. The more you know about
Django, the easier you will find it working with the OmeroWeb framework.

All official OMERO applications can be installed from PyPI_.

Getting set up
--------------

In order to deploy OMERO.web in a development or testing environment,
you can use Docker as described below (recommended) or 
follow the install instructions under :doc:`Deployment`.

If you want to make changes to the OMERO.web code itself, go to
:doc:`/developers/Web/EditingOmeroWeb`.

Create an app from the template example
---------------------------------------

To get started quickly, we are going to create an app from a template repository
that contains several example OMERO.web apps.

Go to the template repository
`omero-web-apps-examples <https://github.com/will-moore/omero-web-apps-examples>`_.
Click 'Use this template' as `described here
<https://help.github.com/en/articles/creating-a-repository-from-a-template>`_
and choose a name for your new repo, for example ``omero-demo-webapps``.

Go to the directory where you want your app to live and clone it:

::

    $ cd /path/to/dir/
    $ git clone https://github.com/<username>/omero-demo-webapps

Run your app with OMERO.web in a Docker container
-------------------------------------------------

We will run the simplest example app from the repo. This is called
``minimal_webapp``.

You can now use `omero-web-docker <https://github.com/ome/omero-web-docker/>`_
to run the app. Here we add ``minimal_webapp`` to the installed apps and map the
directory to the ``site-packages`` directory in the Docker instance so that our
``minimal_webapp`` module can be imported.
We also choose the OMERO server we want to connect to.
You need to edit the ``demo.openmicroscopy.org`` and ``/path/to/dir/`` in the
following commands:

::

    $ host=demo.openmicroscopy.org
    $ docker run -it -e OMEROHOST=$host -p 4080:4080 -e CONFIG_omero_web_apps='["minimal_webapp"]' -v /path/to/dir/omero-demo-webapps/minimal-webapp/minimal_webapp:/opt/omero/web/venv/lib/python2.7/site-packages/minimal_webapp openmicroscopy/omero-web-standalone

This will run Docker in the foreground, showing the output in your terminal and allowing you to
kill the container with Ctrl-C. You should see the following lines in the output, indicating
that OMERO.web is starting and the static files from your app are being included.

::

    ...
    Starting OMERO.web
    Copying '/opt/omero/web/venv/lib/python2.7/site-packages/minimal_webapp/static/minimal_webapp/app.css'
    Copying '/opt/omero/web/venv/lib/python2.7/site-packages/minimal_webapp/static/minimal_webapp/app.js'
    ...

Now go to `http://localhost:4080/minimal_webapp/ <http://localhost:4080/minimal_webapp/>`_
in your browser.
You should be redirected to the login screen and then back to the ``minimal_webapp``
page which will display your Name and list your Projects.

Run your app with locally-installed OMERO.web
---------------------------------------------

If you have installed OMERO.web locally in a virtual environment
(instead of using Docker), you can add a
`path configuration file <https://docs.python.org/2/install/index.html#modifying-python-s-search-path>`_
to the ``site-packages`` directory to allow the
``minimal_webapp`` module to be imported.

You need to specify the directory that *contains* ``minimal_webapp``
(in this case it is the parent ``minimal-webapp`` directory) to
be added to the ``sys.path``.

::

    # Find where your python is (run this within your venv)
    $ which python
    /absolute-path/to-your/Virtual/<env_name>/bin/python

    # Create a path configuration file .pth in site-packages
    $ echo /path/to/dir/omero-demo-webapps/minimal-webapp >> /absolute-path/to-your/Virtual/<env_name>/lib/python2.7/site-packages/minimal_webapp.pth

You also need to add your app to the :property:`omero.web.apps` setting:

.. note::

    Here we use single quotes around double quotes.

::

    $ bin/omero config append omero.web.apps '"<appname>"'


Exploring your app
------------------

The ``minimal_wepp app`` code is well documented to explain
how the app is working.
Briefly, the app supports a single URL defined in
``minimal_webapp/urls.py`` which maps to the ``index`` fuction
within ``minimal_webapp/views.py``. This uses the connection to
OMERO, ``conn`` to load the current user's name and passes this
to the ``index.html`` template to render the page.

This page also includes the static ``app.js`` and ``app.css`` files.
JavaScript is used to load Projects from the JSON API and
display them on the page.

App settings
------------

You can add settings to your app that allow configuration via the command line
in the same way as for the base OMERO.web.
The list of ``CUSTOM_SETTINGS_MAPPINGS`` in
:sourcedir:`components/tools/OmeroWeb/omeroweb/settings.py` is a good
source for examples of the different data types and parsers you can use.

For example, if you want to create a user-defined setting organization-appname.foo,
that contains a dictionary of key-value pairs, you can add to
``CUSTOM_SETTINGS_MAPPINGS`` in ``organization-appname/settings.py``::

    import json
    CUSTOM_SETTINGS_MAPPINGS = {
        "omero.web.organization-appname.foo": ["FOO", '{"key": "val"}', json.loads]
    }

From somewhere else in your app, you can then access the settings::

    from organization-appname import settings

    print settings.FOO

Users can then configure this on the command line as follows::

    $ bin/omero config set omero.web.organization-appname.foo '{"userkey": "userval"}'

Linking from Webclient
----------------------

If you want to add links to your app from the webclient, a number of options are
described on :doc:`/developers/Web/LinkingFromWebclient`.


Releasing your app
------------------

The :doc:`/developers/Web/ReleaseApp` page has some useful steps to
take when you are preparing to release your app.

Creating an app
===============

The Django web site has a very good :djangodoc:`tutorial <intro/tutorial01/>`
to get you familiar with the Django framework. The more you know about
Django, the easier you will find it working with the OmeroWeb framework.
One major feature of Django that we do not use in OmeroWeb is the Django
database mapping, since all data comes from the OMERO server and is
saved back there.

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

Go to `https://github.com/will-moore/omero-web-apps-examples <https://github.com/will-moore/omero-web-apps-examples>`_.
Click 'Use this template' as `described here
<https://help.github.com/en/articles/creating-a-repository-from-a-template>`_
and choose a name for your new app, for example ``omero-demo-webapp``.

Go to the directory where you want your app to live and clone it:

::

    $ cd /path/to/dir/
    $ git clone https://github.com/will-moore/omero-demo-webapp

You can now use `omero-web-docker <https://github.com/ome/omero-web-docker/>`_
to run the app. Here we add ``minimal_webapp`` to the installed apps and map the
directory to the ``site-packages`` directory in the Docker instance so that our
app is on the :envvar:`PYTHONPATH`, described in more detail below.
We also choose the OMERO server we want to connect to.
You need to edit the ``demo.openmicroscopy.org`` and ``/path/to/dir/`` in the
following command:

::

    $ docker run -it -e OMEROHOST=demo.openmicroscopy.org -p 4080:4080 -e CONFIG_omero_web_apps='["minimal_webapp"]' -v /path/to/dir/omero-demo-webapp/minimal-webapp/minimal_webapp:/opt/omero/web/venv/lib/python2.7/site-packages/minimal_webapp openmicroscopy/omero-web-standalone

This will run Docker interactively in the terminal.
Now go to `http://localhost:4080/minimal_webapp/ <http://localhost:4080/minimal_webapp/>`_
in your browser.
You should be redirected to the login screen and then back to the ``minimal_webapp``
page which will display your Name and list your Projects.

Adding your app to your PYTHONPATH
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Your Django app is the directory that contains the ``urls.py`` and ``views.py``. In the
example above, this is the ``minimal_webapp`` directory.
This needs to be *within* a directory that is on your :envvar:`PYTHONPATH` or
`python search path <https://docs.python.org/2/install/index.html#modifying-python-s-search-path>`_.

In the Docker example above, we mount the ``minimal_webapp`` directory within the
``site-packages`` of the Docker image.

If you have installed OMERO.web locally in a virtual environment, you can add a
path configuration file to the ``site-packages`` directory.
This must specify the folder that *contains* ``minimal_webapp``
(in this case it is the parent ``minimal-webapp`` directory) to
be added to the ``sys.path``.

::

    # Find where your python is
    $ which python
    /absolute-path/to-your/Virtual/omero/bin/python

    # Create a path configuration file .pth in site-packages
    $ echo /path/to/dir/omero-demo-webapp/minimal-webapp >> /absolute-path/to-your/Virtual/omero/lib/python2.7/site-packages/minimal_webapp.pth

Add your app to OMERO.web
^^^^^^^^^^^^^^^^^^^^^^^^^

:property:`omero.web.apps` adds your custom application to the ``INSTALLED_APPS``,
so that URLs are registered etc.

.. note::

    Here we use single quotes around double quotes, since we are
    passing a double-quoted string as a json object.

::

    $ bin/omero config append omero.web.apps '"<appname>"'

Make your app installable from PyPI
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is not required but it is recommended to make your app
installable from PyPI. If you opt to do so, a few files need to be added:

- ``setup.py`` - a set-up file used to configure various aspects of the app and also used as a command line interface for packaging the app

- ``setup.cfg`` - a configuration file that contains option defaults for ``setup.py`` commands

- ``MANIFEST.in`` - a file needed in certain cases to package files not automatically included

See `Packaging and Distributing Projects <https://packaging.python.org/guides/distributing-packages-using-setuptools/>`_ for more details.

Configuring your app name and label
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

New in OMERO 5.3.0, we support the option of configuring your OMERO.web app with a
name and label.
See Django `Configuring Applications <https://docs.djangoproject.com/en/1.8/ref/applications/#configuring-applications>`_.
This allows the URL to an app to be different from its name.
For example, OMERO.figure app is named ``omero_figure`` but the url is simply ``/figure/``
as configured by `__init__.py <https://github.com/ome/omero-figure/blob/master/omero_figure/__init__.py>`_
and `apps.py <https://github.com/ome/omero-figure/blob/master/omero_figure/apps.py>`_.


-  **views.py**
   Here we are using the ``@login_required`` decorator to
   retrieve a connection to OMERO from the session key in the HTTP
   request (or provide a login page and redirect here). ``conn`` is passed
   to the method arguments.

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

Creating an app
===============

The Django web site has a very good :djangodoc:`tutorial <intro/tutorial01/>`
to get you familiar with the Django framework. The more you know about
Django, the easier you will find it working with the OmeroWeb framework.

All official OMERO applications can be installed from PyPI_.

Getting set up
--------------

In order to deploy OMERO.web in a development or testing environment,
please start by following the install instructions under :doc:`Deployment` to
create a python environment with `omero-py` and `omero-web` installed.

If you want to make changes to the OMERO.web code itself, go to
:doc:`/developers/Web/EditingOmeroWeb`.

Create an app using cookiecutter
--------------------------------

Follow the instructions in `cookiecutter-omero-webapp <https://github.com/ome/cookiecutter-omero-webapp>`_
to install `cookiecutter`, create your app and run it within your `omero-web` python environment.

Exploring the app
-----------------

The working of the newly created app is well-documented within the code itself.

Briefly, the app supports a single URL defined in ``urls.py`` which maps to the ``index`` function
within ``views.py``. This uses the connection to OMERO, ``conn`` to load the current user's name and
passes this to the ``index.html`` template to render the page.

Here we are using the OMERO
`python API <https://omero.readthedocs.io/en/latest/developers/Python.html>`_ to load data
and render it into ``html`` using Django templates.

An alternative option is to use JavaScript
to load data in the form of `JSON` and to generate ``html`` dynamically in the browser.

The sample ``index.html`` page also includes the static ``app.js`` and ``app.css`` files
to demonstrate this approach.
JavaScript is used to load the current user's `Projects`` from the :doc:`/developers/json-api` and
display them on the page.

You may find that the :doc:`/developers/json-api` or :doc:`/developers/Web/WebGateway` provide some
of the data you wish to load. If you wish to provide your own custom JSON api, you can add URL end-points to
your own app and load the data you need in ``views.py`` then format it to JSON and return it as a JSON response.

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

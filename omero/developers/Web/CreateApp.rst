Creating an app
===============

The Django web site has a very good :djangodoc:`tutorial <intro/tutorial01/>`
to get you familiar with the Django framework. The more you know about
Django, the easier you will find it working with the OmeroWeb framework.
One major feature of Django that we do not use in OmeroWeb is the Django
database mapping, since all data comes from the OMERO server and is
saved back there. You will notice that the models.py files in each app
are empty.

All official OMERO applications can be installed from PyPI_.

Getting set up
--------------

In order to deploy OMERO.web in a development or testing environment,
you can use Docker as described below (recommended) or 
follow the instructions under :doc:`Deployment`.

If you want to make changes to the OMERO.web code itself, go to
:doc:`/developers/Web/EditingOmeroWeb`.

Use the app template
--------------------

Go to `https://github.com/will-moore/omero-web-apps-examples <https://github.com/will-moore/omero-web-apps-examples>`_.
Click 'Use this template' as `described here
<https://help.github.com/en/articles/creating-a-repository-from-a-template>`_.

Choose a name for your new app, for example ``omero-demo-webapp``.
Go to the directory where you want your app to live and clone it:

::

    $ cd /path/to/dir/
    $ git clone https://github.com/will-moore/omero-demo-webapp

You can now use `omero-web-docker <https://github.com/ome/omero-web-docker/>`_
to run this. Here we add ``minimal_webapp`` to the installed apps and map the
directory to the ``site-packages`` directory in the Docker instance.
We also choose the OMERO server we want to connect to.
You need to edit the ``demo.openmicroscopy.org`` and ``/path/to/dir/`` in the
following command:

::

    $ docker run -it -e OMEROHOST=demo.openmicroscopy.org -p 4080:4080 -e CONFIG_omero_web_apps='["minimal_webapp"]' -v /path/to/dir/omero-demo-webapp/minimal-webapp/minimal_webapp:/opt/omero/web/venv/lib/python2.7/site-packages/minimal_webapp openmicroscopy/omero-web-standalone

This will run Docker interactively in the terminal.
Now go to `http://localhost:4080/minimal_webapp/ <http://localhost:4080/minimal_webapp/>`_.
You should be redirected to the login screen and then back to the ``minimal_webapp``
page which will display your Name and list your Projects.

Creating an app
---------------

You can place your app anywhere on your :envvar:`PYTHONPATH`,
as long as it can be imported by OMERO.web.

We suggest you use `GitHub <https://github.com/>`_ (as we do) since it is much easier for us to
help you with any problems you have if we can see your code. The steps below
describe how to create a stand-alone git repository for your app, similar to
`omero-webtest <https://github.com/openmicroscopy/omero-webtest>`_.
If you do not want to use GitHub, simply ignore the steps related to GitHub.

The steps below describe how to set up a new app. You should choose an
appropriate name for your app and use it in place of <organization-appname>:


Add your app to your PYTHONPATH
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Your app needs to be within a directory that is on your :envvar:`PYTHONPATH`.
We usually create a new container for a new app, and add it to the
:envvar:`PYTHONPATH`.
::

    $ mkdir organization-appname
    $ cd organization-appname
    $ export PYTHONPATH=$PYTHONPATH:/path/to/organization-appname


OR you could simply choose an existing location:

::

    $ cd /somewhere/on/your/pythonpath/


Create and check out a new GitHub repository OR manually create a new directory
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  Login to your GitHub account homepage e.g.
   `<https://github.com/>`_\<your-name>/) and click
   "New repository"

-  Enter the name of your repository e.g. ``<organization-appname>``,
   add a ``README.rst`` file (using the ``.rst`` extension allows it to be rendered correctly on PyPI).
   Its contents should cover the goal of the app and the configuration instructions.

-  Check out your new repository into a new directory::

       $ git clone git@github.com:<your-name>/<organization-appname>.git

-  OR: If you have not used git to create your app directory above, then::

        $ mkdir <organization-app>

-  In either case, you should now have a directory called ``organization-appname`` within
   a directory that is on your :envvar:`PYTHONPATH`.

Make your app installable from PyPI
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is not required but it is recommended to make your app
installable from PyPI. If you opt to do so, a few files need to be added:

- ``setup.py`` - a set-up file used to configure various aspects of the app and also used as a command line interface for packaging the app

- ``setup.cfg`` - a configuration file that contains option defaults for ``setup.py`` commands

- ``MANIFEST.in`` - a file needed in certain cases to package files not automatically included

See `Packaging and Distributing Projects <https://packaging.python.org/guides/distributing-packages-using-setuptools/>`_ for more details.

Add the essential files to your app
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  Create a directory ``<organization_appname>`` e.g. ``omero_webtest`` (note the underscore) to add the essential files to
   
-  Create an empty file ``<organization_appname>/__init__.py`` (double underscores)

-  Create :file:`<organization_appname>/urls.py`::

       from django.conf.urls import url, patterns
       from . import views

       urlpatterns = patterns('django.views.generic.simple',

            # index 'home page' of the appname e.g. webtest
            url(r'^$', views.index, name='<appname>_index'),

        )

-  Create :file:`<organization_appname>/views.py`::

        from django.http import HttpResponse

        def index(request):
            """
            Just a place-holder while we get started
            """
            return HttpResponse("Welcome to your app home-page!")

-  Create :file:`<organization_appname>/apps.py`::

        from django.apps import AppConfig

        class AppNameAppConfig(AppConfig):
            name = "organization_appname"
            label = "appname"

For more details on how to write views, forms, using templates, etc. check the
:djangodoc:`Django documentation <intro/tutorial03/#write-your-first-view>`.


Add your app to OMERO.web
^^^^^^^^^^^^^^^^^^^^^^^^^

:property:`omero.web.apps` adds your custom application to the ``INSTALLED_APPS``,
so that URLs are registered etc.

.. note::

    Here we use single quotes around double quotes, since we are
    passing a double-quoted string as a json object.

::

    $ bin/omero config append omero.web.apps '"<organization_appname>"'

Now you can view the home-page we created above. Now restart OMERO.web as normal
for the config settings to take effect.

Go to `http://localhost:4080/ <http://localhost:4080/>`_\<appname>/
OR `http://localhost:8000/ <http://localhost:8000/>`_\<appname>/
and you should see 'Welcome'.

Configuring your app name and label
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

New in OMERO 5.3.0, we support the option of configuring your OMERO.web app with a
name and label.
See Django `Configuring Applications <https://docs.djangoproject.com/en/1.8/ref/applications/#configuring-applications>`_.
This allows the URL to an app to be different from its name.
For example, OMERO.figure app is named ``omero_figure`` but the url is simply ``/figure/``
as configured by `__init__.py <https://github.com/ome/omero-figure/blob/master/omero_figure/__init__.py>`_
and `apps.py <https://github.com/ome/omero-figure/blob/master/omero_figure/apps.py>`_.

Commit your code and push to GitHub
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    $ git status (see new files, plus .pyc files)
    $ echo "*.pyc" > .gitignore         # ignore .pyc files
    $ echo ".gitignore" >> .gitignore   # ALSO ignore .gitignore

    $ git add ./
    $ git commit -m "Initial commit of bare-bones OMERO.web app"
    $ git push origin master

Connect to OMERO: an example
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We have got our new app working, but it is not connecting to OMERO yet.
Let us create a simple "stack preview" for an Image with multiple
Z-sections. We are going to display the image name and 5 planes evenly
spaced across the Z-stack. You should be able to add the appropriate
code to :file:`urls.py`, :file:`views.py` that you created above, and add a template
under /omeroweb/<organization-appname>/<organization_appname>/templates/<appname>/ 


The following example can be found in the
`OMERO.webtest <https://github.com/openmicroscopy/omero-webtest/>`_ repository.

-  **urls.py**::

       url(r'^stack_preview/(?P<image_id>[0-9]+)/$', views.stack_preview, 
            name="<appname>_stack_preview"),

-  **views.py**
   Here we are using the ``@login_required`` decorator to
   retrieve a connection to OMERO from the session key in the HTTP
   request (or provide a login page and redirect here). ``conn`` is passed
   to the method arguments. A couple of new imports must be added at
   the top of your page.::

       from omeroweb.webclient.decorators import login_required
       from django.shortcuts import render


       @login_required()
       def stack_preview(request, image_id, conn=None, **kwargs):
            """ Shows a subset of Z-planes for an image """
            image = conn.getObject("Image", image_id)
            image_name = image.getName()
            size_z = image.getSizeZ()
            z_indexes = [0, int(size_z*0.25), int(size_z*0.5),
                 int(size_z*0.75), size_z-1]
            return render(request, 'webtest/stack_preview.html',
                  {'imageId': image_id, 'image_name': image_name,
                   'z_indexes': z_indexes})

-  **<organization-appname>/<organization_appname>/templates/<appname>/stack\_preview.html**::

       <html>
       <head>
            <title>Stack Preview</title>
       </head>
       <body>
            <h1>{{ image_name }}</h1>

            {% for z in z_indexes %}
                <img src="{% url 'webgateway.views.render_image' imageId z 0 %}"
                    style="max-width: 200px; max-height:200px"/>
            {% endfor %}
       </body>
       </html>


Viewing the page at http://localhost:4080/<appname>/stack_preview/<image-id>/
should give you the image name and 5 planes from the Z stack. You will notice
that we are using the ``webgateway`` to handle the image rendering using a URL
auto-generated by Django - see :doc:`/developers/Web/WebGateway`.

Resources for writing your own code
-----------------------------------

The `OMERO.webtest <https://github.com/openmicroscopy/omero-webtest/>`_ app
has a number of examples. Once installed, you can go to the webtest
homepage e.g. `<http://localhost:4080/webtest>`_ and you will
see an introduction to some of them. This page tries to find random
images and datasets from your OMERO server to use in the webtest examples.


.. _jquery_and_jquery_ui:

Using jQuery and jQuery UI from OMERO.web
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

OMERO.web uses the `jQuery <https://jquery.com/>`_ and `jQuery UI <https://jqueryui.com/>`_ 
javascript libraries extensively.
If you need these libraries, you can include the OMERO.web versions of
these libraries in your own pages. The alternative is to provide a specific
version of jQuery or jQuery UI in your own app if, for example, you think
that a version change may cause problems in your code.
If you need to make use of these resources in your own pages, you can
add the following statements to the ``<head>`` of your page templates::

    <!-- jQuery -->
    {% include "webgateway/base/includes/script_src_jquery.html" %}

    <!-- jQuery UI - includes js and css -->
    {% include "webgateway/base/includes/jquery-ui.html" %}


Extending templates
^^^^^^^^^^^^^^^^^^^

We provide several HTML templates in
webgateway/templates/webgateway/base. This is a nice way of giving users
the feeling that they have not left the webclient, if you are providing
additional functionality for webclient users. You may choose not to use
this if you are building a 'stand-alone' web application. In either
case, it is good practice to create your own templates with common
components (links, logout, etc.), so you can make changes to all your
pages at once. See :doc:`/developers/Web/WritingTemplates` for more info.

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

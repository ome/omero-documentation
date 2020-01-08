Release an app
==============

When you are ready to share your app with others, you can improve
the install process by making your app installable via ``pip``.
You may also wish to configure the app label to make the app URL
more user-friendly.

Make your app installable from PyPI
-----------------------------------

This is not required but it is recommended to make your app
installable from PyPI. If you opt to do so, a few files need to be added:

- ``setup.py`` - a set-up file used to configure various aspects of the app and also used as a command line interface for packaging the app

- ``setup.cfg`` - a configuration file that contains option defaults for ``setup.py`` commands

- ``MANIFEST.in`` - a file needed in certain cases to package files not automatically included

See `Packaging and Distributing Projects <https://packaging.python.org/guides/distributing-packages-using-setuptools/>`_ for more details.

Configuring your app name and label
-----------------------------------

We support the option of configuring your OMERO.web app with a name and label.
See :djangodoc:`Configuring Applications <ref/applications/#configuring-applications>`.

This allows the URL to an app to be different from its name.
For example, OMERO.figure app is named ``omero_figure`` but the url is simply ``/figure/``
as configured by `__init__.py <https://github.com/ome/omero-figure/blob/master/omero_figure/__init__.py>`_
and `apps.py <https://github.com/ome/omero-figure/blob/master/omero_figure/apps.py>`_.

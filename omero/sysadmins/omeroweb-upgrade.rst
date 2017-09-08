OMERO.web upgrade
====================

The OME team is committed to providing frequent, project-wide upgrades both
with bug fixes and new functionality. We try to make the schedule for these
releases as public as possible. You may want to take a look at the `Trello
boards <https://trello.com/b/4EXb35xQ/getting-started>`_ for exactly what will
go into a release.

See the full details of OMERO |release| features in the :doc:`/users/history`.

This guide aims to be as definitive as possible so please do not be put off by
the level of detail; upgrading should be a straightforward process.

Upgrade check list
------------------

.. contents::
    :local:
    :depth: 1

Check prerequisities
^^^^^^^^^^^^^^^^^^^^

Before starting the upgrade, please ensure that you have reviewed and
satisfied all the :doc:`system requirements <system-requirements>` with
:doc:`correct versions <version-requirements>` for installation.

Configuration
^^^^^^^^^^^^^

Since OMERO 5.3, OMERO.web can be deployed **separately** from OMERO.server.
This is the recommended installation set-up as they
perform best under different circumstances and require a different set of
dependencies. Please check :ref:`omero_web_deployment` for the latest advice
on how to deploy OMERO.web.

If you generated configuration stanzas using :program:`omero web config` which
enables OMERO.web via NGINX, they will include **hard-coded links** to
your previous version of OMERO. Therefore, you should regenerate your config
files when upgrading, remembering to merge in any of your own modifications if
necessary. You should carry out this step even for minor version upgrades as
there may be fixes which require it.

.. note:: Since OMERO 5.2, the OMERO.web framework no longer bundles
    a copy of the Django package, instead manual installation of
    the Django dependency is required. It is highly recommended to use
    `Django 1.8`_ (LTS) which requires Python 2.7. For more information
    see :ref:`python-requirements` on the
    :doc:`/sysadmins/version-requirements` page.
    
    Also note that support for Apache deployment has been dropped in 5.3.0.

Dependencies
^^^^^^^^^^^^

While upgrading the server you should keep OMERO.web dependencies
up to date to ensure that security updates are applied::

    $ pip install --upgrade -r share/web/requirements-py27-all.txt

.. warning:: Missing this step can result in OMERO.web failing to start after
    upgrading.

Plugin updates
^^^^^^^^^^^^^^

OMERO.web plugins are very closely integrated into the webclient. For this
reason, it is possible that an update of OMERO will cause issues with an older
version of a plugin. It is best when updating the server to also install any
available plugin updates according to their own documentation.

Since 5.3, all official OMERO.web plugins can be installed from :pypi:`Python Package Index <>`.
You should remove all previously installed plugins and install the latest
versions using `pip <https://pip.pypa.io/en/stable/>`_.

Also introduced in 5.3, the ``Open with`` configuration allows users to open
data in other web applications e.g. open images in a custom viewer or open images
in a new figure with OMERO.figure.
After installing OMERO.figure (or any other app), run the following command
to add it to the ``Open with`` options, so that the app is available from the context
menu on the webclient tree::

    $ bin/omero config append omero.web.open_with '["omero_figure", "new_figure",
      {"supported_objects":["images"], "target": "_blank", "label": "OMERO.figure"}]'

Updating 'Open with' config
^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you have configured :property:`omero.web.open_with` prior to OMERO 5.3.3 and
also set the default viewer with :property:`omero.web.viewer.view`, for example
as described for `OMERO.iviewer <https://pypi.python.org/pypi/omero-iviewer>`_
then you will find that ``Open with > Image Viewer`` also opens the OMERO.iviewer
instead of the ``webgateway`` viewer.

To fix this, you need to update the ``Image Viewer`` option within
your :property:`omero.web.open_with` config.

The best way to do this without changing the ordering of the options is to
``get`` the complete current config, edit the ``Image Viewer`` option, replacing
``"webindex"`` with ``"webgateway"`` and then ``set`` this as the updated config::

    $ bin/omero config get omero.web.open_with
    [["Image viewer", "webindex", {"supported_objects": ["image"], "script_url": "we....

    # Replace "webindex" with "webgateway" and paste everything back to set, within single quotes

    $ bin/omero config set omero.web.open_with '[["Image viewer", "webgateway", {"supported_objects": ["image"], "scr....'

Troubleshooting
^^^^^^^^^^^^^^^

If you encounter errors during an OMERO.web upgrade, etc., you
should retain as much log information as possible and notify the OMERO.server
team via the mailing lists available on the :community:`support <>`
page.


Update your OMERO.web server configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

FastCGI support was removed in OMERO 5.2 and OMERO.web can be deployed
using WSGI (see :ref:`omero_web_deployment` for more details).
If you have already deployed OMERO.web using WSGI you should regenerate your
config files, remembering to merge in any of your own modifications if
necessary. **Due to changes in OMERO.web,
you should carry out this step even for minor version upgrades as there may be
fixes which require it.**

If necessary ensure you have set up a regular task to clear out any stale
OMERO.web session files as described in :ref:`omero_web_maintenance`.

Migrating from Apache to NGINX
""""""""""""""""""""""""""""""

Support for Apache and mod_wsgi deployment was deprecated
in OMERO 5.2.6 and dropped in 5.3.0.
It is recommended to use
:doc:`/sysadmins/unix/install-web/web-deployment`.

.. seealso::

    :ref:`troubleshooting-omeroweb-migrate-to-nginx`

Restart OMERO.web
^^^^^^^^^^^^^^^^^

-  If anything goes wrong, please send the output of
   :program:`omero web diagnostics` to
   ome-users@lists.openmicroscopy.org.uk.

-  Start OMERO.web with the following command:

   ::

       $ bin/omero web restart

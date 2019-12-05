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

Upgrade checklist
-----------------

.. contents::
    :local:
    :depth: 1

Check prerequisites
^^^^^^^^^^^^^^^^^^^

Before starting the upgrade, please ensure that you have reviewed and
satisfied all the :doc:`system requirements <system-requirements>` with
:doc:`correct versions <version-requirements>` for installation.

Configuration
^^^^^^^^^^^^^

This documentation assumes that OMERO.web is deployed **separately** from OMERO.server.
This is the recommended installation set-up as they
perform best under different circumstances and require a different set of
dependencies. Please check :ref:`omero_web_deployment` for the latest advice
on how to deploy OMERO.web.

If you are migrating from a shared installation to separate installations, you will
need to export and re-import the configuration from your previous installation.

::

    OLD_INSTALLATION/bin/omero config get --show-password > properties.backup
    NEW_INSTALLATION/bin/omero config load properties.backup

If you generated configuration stanzas using :program:`omero web config` which
enables OMERO.web via NGINX, you should regenerate your config files,
remembering to merge in any of your own modifications if necessary. You should
carry out this step even for minor version upgrades as there may be fixes which
require it.

::


    NEW_INSTALLATION/bin/omero web config nginx > new.confg

More examples can be found under :ref:`omero_web_nginx_configuration`.

Dependencies
^^^^^^^^^^^^

While upgrading the server you should keep OMERO.web dependencies
up to date to ensure that security updates are applied:


.. parsed-literal::


      $ pip install --upgrade 'omero-web>=\ |version_web|'


Plugin updates
^^^^^^^^^^^^^^

OMERO.web plugins are very closely integrated into the webclient. For this
reason, it is possible that an update of OMERO will cause issues with an older
version of a plugin. It is best when updating the server to also install any
available plugin updates according to their own documentation.

All official OMERO.web plugins can be installed from PyPI_.
You should remove all previously installed plugins and install the latest
versions using pip.

Restart OMERO.web
^^^^^^^^^^^^^^^^^

Finally, restart OMERO.web with the following command:

   ::

       $ bin/omero web restart

Troubleshooting
^^^^^^^^^^^^^^^

If you encounter errors during an OMERO.web upgrade, etc., you
should retain as much log information as possible, including
the output of :program:`omero web diagnostics` to the OMERO
team via the mailing lists available on the :community:`support <>`
page.

Maintenance & Scaling
^^^^^^^^^^^^^^^^^^^^^

If you have not already done so, there are a number of additional
steps that can be performed on your OMERO.web installation to improve
its functioning. For example, you may need to set up a regular task
to clear out any stale OMERO.web session files. More information can
be found under :ref:`omero_web_maintenance`.

Additionally, it is recommended to use a WSGI-capable server such as NGINX.
Information can be found under :doc:`unix/install-web/web-deployment`.

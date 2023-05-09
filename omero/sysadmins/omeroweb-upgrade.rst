OMERO.web upgrade
====================

The OME team is committed to providing frequent, project-wide upgrades with
security fixes, bug fixes and new functionality. We try to make the schedule for
these releases as public as possible. You may want to take a look at the `Trello
boards <https://trello.com/b/4EXb35xQ/getting-started>`_ for exactly what will
go into a release. See also :doc:`server-upgrade`.

See the full details of OMERO |version_openmicroscopy| features in the :doc:`/users/history`.

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

Upgrade
^^^^^^^

Make sure you have activated the correct virtual environment then
upgrade OMERO.web via pip:

.. parsed-literal::

      $ pip install --upgrade 'omero-web>=\ |version_web|'

If the ```omero-web``` upgrade *requires* an upgrade to ```omero-py``` (e.g.
for new features), this will happen automatically above.
However, even when an ```omero-py``` upgrade is not required, there may be some
benefits to upgrading:

.. parsed-literal::

      $ pip install --upgrade 'omero-py>=\ |version_py|'


Configuration
^^^^^^^^^^^^^

We now recommend that ``omero-web`` is installed in a separate python
virtual environment.

If you are migrating to a new virtual environment, where :envvar:`$OMERODIR`
does not refer to a server with an existing config, you will
need to export and re-import the configuration from your previous installation.

::

    OLD_INSTALLATION/bin/omero config get --show-password > properties.backup

    # omero-web virtual env
    omero config load properties.backup

If you generated configuration stanzas using :program:`omero web config` which
enables OMERO.web via NGINX, you should regenerate your config files,
remembering to merge in any of your own modifications if necessary. You should
carry out this step even for minor version upgrades as there may be fixes which
require it.

::

    omero web config nginx > new.confg

More examples can be found under :ref:`omero_web_configuration`.

Plugin updates
^^^^^^^^^^^^^^

OMERO.web plugins are very closely integrated into the webclient. For this
reason, it is possible that an update of OMERO will cause issues with an older
version of a plugin. It is best when updating the server to also install any
available plugin updates according to their own documentation.

All official OMERO.web plugins can be installed from PyPI_.
You should remove all previously installed plugins and install the latest
versions using pip.

.. _clearing_session_store:

Clear the sessions store (optional)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

During an upgrade, it might be necessary to clear the sessions store
before restarting OMERO.web. This is the case when either OMERO.web or
Django introduced backwards incompatible changes in the way sessions are
stored or if the session serialization format has been modified via
:property:`omero.web.session_serializer`.

.. warning::

   Clearing the sessions store will terminate all OMERO.web sessions and log
   out all users.

The process for clearing the store depends on the storage backend configured
via :property:`omero.web.session_engine`:

- if :property:`omero.web.session_engine` is either unset or set to
  `omeroweb.filesessionstore` or `django.contrib.sessions.backends.file`,
  OMERO.web will use file-based sessions. The session files are stored under a
  temporary folder determined by the output of `tempfile.gettempdir()`,
  usually `/tmp` and prefixed either by the value of
  :property:`omero.web.session_cookie_name` if the property is set or by
  `sessionid` if the property is unset.
  For a default configuration, the following command will
  typically delete all file sessions::

      $ rm /tmp/sessionid*

- if :property:`omero.web.session_engine` is set to
  `django.contrib.sessions.backends.cache`, OMERO.web uses cached sessions
  with a cache backend configured via :property:`omero.web.caches`. For a
  Redis cache backend, sessions are stored using keys prefixed with
  `django.contrib.sessions.cache` and can be cleared using :program:`redis-cli`.
  In a default configuration, the following command will delete all the
  keys associated with OMERO.web sessions::

      $ redis-cli keys '*django.contrib.sessions.cache*'  | xargs redis-cli del

Restart OMERO.web
^^^^^^^^^^^^^^^^^

Finally, restart OMERO.web with the following command::

   $ omero web restart

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
be found in the various walkthroughs available from :doc:`unix/install-web/web-deployment`.

Additionally, it is recommended to use a WSGI-capable server such as NGINX.
Information can be found under :doc:`unix/install-web/web-deployment`.

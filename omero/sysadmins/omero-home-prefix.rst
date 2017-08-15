Setting the OMERO_HOME environment variable
===========================================

.. warning::
    :envvar:`OMERO_HOME` should be considered strictly *internal* to OMERO
    and be reserved for development or "power usage".


Rationale
---------

:envvar:`OMERO_HOME` defines the root deployment directory to be used by
OMERO command line tools.

Setting it allows to switch between different versions of applications
or libraries during development.


.. note::
    Despite a familiar-sounding name, :envvar:`OMERO_HOME` does **not**
    denote the server installation directory.


Caveats
-------

As a "power switch", :envvar:`OMERO_HOME` will override the directory layout
as detected by the `bin/omero` family of utilities.

This could cause hard-to-detect problems at runtime.
Environments hosting multiple OMERO versions would be particularly prone to
such side effects, as illustrated below.

::

   # Installation directory layout:
   # /opt
   #   +-- OMERO.server-version-4.4.10
   #   +-- OMERO.server-version-5.0.0

   # OMERO-4 was first installed, and is conveniently referenced through OMERO_HOME
   $ echo $OMERO_HOME
   > /opt/OMERO.server-version-4.4.10

   # Update the configuration for OMERO-4
   $ /opt/OMERO.server-version-4.4.10/bin/omero config set omero.db.name 'omero_4_database'
   $ /opt/OMERO.server-version-4.4.10/bin/omero config get omero.db.name
   > omero_4_database

   # Update the configuration for OMERO-5
   $ /opt/OMERO.server-version-5.0.0/bin/omero config set omero.db.name 'omero_5_database'
   $ /opt/OMERO.server-version-5.0.0/bin/omero config get omero.db.name
   > omero_5_database

   # Double check the OMERO-4 configuration...
   # Using OMERO_HOME has taken precedence over the current directory
   # The OMERO-4 server instance has been mistakenly updated to point at
   # a version 5 database schema.
   # Furthermore, the issue might go unnoticed until the next OMERO-4 restart.
   $ /opt/OMERO.server-version-4.4.10/bin/omero config get omero.db.name
   > omero_5_database


Recommendations
---------------

- If you are using an environment variable to define the server installation root,
  choose a different name, as represented by :envvar:`OMERO_PREFIX` in this documentation.

- If you are nevertheless using :envvar:`OMERO_HOME` in your **local** environment,
  it is worth checking for potentially lingering global definitions (eg. `.bashrc`,
  `.profile`, `/etc/profile.d`).


.. seealso:: :doc:`/sysadmins/unix/server-installation`

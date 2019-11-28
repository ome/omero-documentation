OMERO.server upgrade
====================

The OME team is committed to providing frequent, project-wide upgrades both
with bug fixes and new functionality. We try to make the schedule for these
releases as public as possible. You may want to take a look at the `Trello
boards <https://trello.com/b/4EXb35xQ/getting-started>`_ for exactly what will
go into a release.

See the full details of OMERO |release| features in the :doc:`/users/history`.

This guide aims to be as definitive as possible so please do not be put off by
the level of detail; upgrading should be a straightforward process.

.. warning::

    If you are upgrading from a version *prior to* OMERO
    |previousversion| then you *must* also study the upgrade
    instructions for those prior versions because they may describe
    important steps that these instructions assume to already have been
    done by OMERO |previousversion| users. Before proceeding with these
    instructions you may first need to read the `instructions
    <https://docs.openmicroscopy.org/latest/omero5.3/sysadmins/server-upgrade.html>`_
    for upgrading *to* OMERO |previousversion| because some extra steps
    may be required beyond simply running the SQL upgrade scripts
    described below.
    
    If you are upgrading from 5.2 on **Windows** and need to migrate to Linux,
    there is a guide in the `OMERO 5.3 documentation <https://docs.openmicroscopy.org/latest/omero5.3/sysadmins/windows-migration.html>`_.

Upgrade checklist
-----------------

.. contents::
    :local:
    :depth: 1

Check prerequisities
^^^^^^^^^^^^^^^^^^^^

Before starting the upgrade, please ensure that you have reviewed and
satisfied all the :doc:`system requirements <system-requirements>` with
:doc:`correct versions <version-requirements>` for installation. In
particular, ensure that you are running a suitable version of PostgreSQL
to enable successful upgrading of the database, otherwise the upgrade
script aborts with a message saying that your database server version is
less than the OMERO prerequisite.

Corrupted pyramids
^^^^^^^^^^^^^^^^^^

A bug introduced in OMERO 5.2.0 meant that corrupted pyramids were generated
for large TIFF files with little endian encoding. This bug was fixed in
OMERO 5.4.4 and corrupted pyramids need to be deleted to allow new ones to be
generated::

   omero admin removepyramids --endian=little

We recommend you run the command with :command:`--dry-run` first to list the pyramids
that will be deleted. If there are a large number of pyramids, you may need to
run the command more than once since you cannot remove more than 500 pyramids in one call.
For large installations, to avoid any timeout issue it is recommended to run the
command with ``--wait=xxx`` where ``xxx`` is for example ``5000`` seconds.
You can also specify a cut-off date (e.g. the
date you upgraded to 5.2) so the command has fewer files to process; use
``-h`` for details of the additional arguments possible.

Attempting to remove pyramids imported before OMERO 5.0 (pre-FS) will result in messages
like ``Failed to remove for image 20: pyramid-requires-fileset`` being printed out.
You can safely ignore those messages. The pyramids are not corrupted.

File limits
^^^^^^^^^^^

You may wish to review the open file limits. Please consult the
:ref:`limitations-openfiles` section for further details.

Password usage
^^^^^^^^^^^^^^

The passwords and logins used here are examples. Please consult the
:ref:`troubleshooting-password` section for explanation. In particular, be
sure to replace the values of **db_user** and **omero_database** with the
actual database user and database name for your installation.

Memoization files invalidation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

All cached Bio-Formats memoization files created at import time will be
invalidated by the server upgrade. This means the very first loading of each
image after upgrade will be slower. After re-initialization, a new memoization
file will be automatically generated and OMERO will be able to load images in
a performant manner again.

These files are stored under :file:`BioFormatsCache` in the OMERO data
directory, e.g. :file:`/OMERO/BioFormatsCache`. You may see error messages in
your log files when an old memoization file is found; to avoid these messages
delete everything under this directory before starting the upgraded server.

Troubleshooting
^^^^^^^^^^^^^^^

If you encounter errors during an OMERO upgrade, database upgrade, etc., you
should retain as much log information as possible and notify the OMERO.server
team via the mailing lists available on the :community:`support <>`
page.

Upgrade check
^^^^^^^^^^^^^

All OMERO products check themselves with the OmeroRegistry for update
notifications on startup. If you wish to disable this functionality you should
do so now as outlined on the :doc:`UpgradeCheck` page.

Upgrade steps
-------------

For all users, the basic workflow for upgrading your OMERO.server is listed
below. Please refer to each section for additional details.

.. contents::
    :local:
    :depth: 1

Check ahead for upgrade issues
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There is a ``precheck`` SQL script provided that performs various database
checks to verify readiness for upgrade. The precheck script works even
with the OMERO server running so it may be used before downtime for the
actual upgrade is scheduled. Issues that the script reports will need to
be resolved before the upgrade may proceed. The precheck script will
**not** make any changes to the database: it merely performs various
precautionary checks also done by the actual upgrade script.

.. parsed-literal::

    $ cd OMERO.server
    $ psql -h localhost -U **db_user** **omero_database** < sql/psql/|current_dbver|/|previous_dbver|-precheck.sql
    Password for user **db_user**:
    ...
    ...
                               status
    ---------------------------------------------------------------------
                                                                        +
                                                                        +
                                                                        +
    YOUR DATABASE IS READY FOR UPGRADE TO VERSION |current_dbver|       +
                                                                        +
                                                                        +

    (1 row)


.. warning::

   The :file:`sql/psql/OMERO5.4__0/OMERO5.3__1-precheck.sql` script
   referenced by the above :program:`psql` command assumes a planned
   upgrade from OMERO 5.3.4. If you are instead currently running OMERO
   5.3.3 or an earlier 5.3.x version then you perform the precheck by
   using the above command with
   :file:`sql/psql/OMERO5.4__0/OMERO5.3__0-precheck.sql`. That script
   verifies that the database contains no trace of
   :secvuln:`2017-SV5-filename-2` having been exploited; this
   vulnerability was fixed in OMERO 5.3.4.

.. _back-up-the-db:

Perform a database backup
^^^^^^^^^^^^^^^^^^^^^^^^^

The first thing to do before **any** upgrade activity is to backup your
database.

.. parsed-literal::

    $ pg_dump -h localhost -U **db_user** -Fc -f before_upgrade.db.dump **omero_database**


Copy new binaries
^^^^^^^^^^^^^^^^^

Before copying the new binaries, stop the existing server::

    $ cd OMERO.server
    $ bin/omero web stop
    $ bin/omero admin stop

Your OMERO configuration is stored using :file:`config.xml` in the
:file:`etc/grid` directory under your OMERO.server directory. Assuming you
have not made any file changes within your OMERO.server distribution
directory, you are safe to follow the following upgrade procedure:

.. parsed-literal::

    $ cd ..
    $ mv OMERO.server OMERO.server-old
    $ unzip OMERO.server-|release|-ice3x-byy.zip
    $ ln -s OMERO.server-|release|-ice3x-byy OMERO.server
    $ cp OMERO.server-old/etc/grid/config.xml OMERO.server/etc/grid

.. note::
    ``ice3x`` and ``byy`` **need to be replaced** by the appropriate Ice
    version and build number of OMERO.server.

.. _upgradedb:

Upgrade your database
^^^^^^^^^^^^^^^^^^^^^

.. only:: point_release

    .. warning::
        This section only concerns users upgrading from a 5.3 or
        earlier server. If upgrading from a 5.4 or 5.5 server, you do not need
        to upgrade the database.

Ensure Unicode character encoding
"""""""""""""""""""""""""""""""""

OMERO requires a Unicode-encoded database; without it, the upgrade
script aborts with a message warning how the ``OMERO database character
encoding must be UTF8``. From :command:`psql`::

  # SELECT datname, pg_encoding_to_char(encoding) FROM pg_database;
    datname   | pg_encoding_to_char
  ------------+---------------------
   template1  | UTF8
   template0  | UTF8
   postgres   | UTF8
   omero      | UTF8
  (4 rows)

Alternatively, simply run :command:`psql -l` and check the output. If
your OMERO database is not Unicode-encoded with ``UTF8`` then it must be
re-encoded.

If you have the :command:`pg_upgradecluster` command available then its
``--locale`` option can effect the change in encoding. Otherwise,
create a Unicode-encoded dump of your database: dump it :ref:`as before
<back-up-the-db>` but to a different dump file and with an additional
``-E UTF8`` option. Then, create a Unicode-encoded database for
OMERO and restore that dump into it with :command:`pg_restore`,
similarly to :ref:`effecting a rollback <restore-the-db>`. If required
to achieve this, the ``-E UTF8`` option is accepted by both
:command:`initdb` and :command:`createdb`.

Run the upgrade script
""""""""""""""""""""""

You **must** use the same username and password you have defined during
:doc:`unix/server-installation`. For a large production system you
should plan for the fact that the upgrade script may take several hours
to run.

.. parsed-literal::

    $ cd OMERO.server
    $ psql -h localhost -U **db_user** **omero_database** < sql/psql/|current_dbver|/|previous_dbver|.sql
    Password for user **db_user**:
    ...
    ...
                               status
    ---------------------------------------------------------------------
                                                                        +
                                                                        +
                                                                        +
    YOU HAVE SUCCESSFULLY UPGRADED YOUR DATABASE TO VERSION |current_dbver| +
                                                                        +
                                                                        +

    (1 row)


If you are upgrading from a server earlier than 5.3, then
you must run the earlier upgrade scripts in sequence before the one
above. There is no need to download and run the server from an
intermediate major release but you must still study the upgrade
instructions for earlier versions in case there are additional steps.
For example, any optional SQL scripts that affect the database probably
run only on the specific version before the next upgrade script.

.. note::

   If you perform the database upgrade using *SQL shell*, make sure you are
   connected to the database using **db_user** before running the script. See
   :forum:`this forum thread <viewtopic.php?f=5&t=7778>` for more information.

.. warning::

   The :file:`sql/psql/OMERO5.4__0/OMERO5.3__1.sql` script referenced by
   the above :program:`psql` command assumes upgrade from OMERO 5.3.4.
   If you are instead currently running OMERO 5.3.3 or an earlier 5.3.x
   version then you upgrade the database directly to OMERO 5.4.0 by
   using the above command with
   :file:`sql/psql/OMERO5.4__0/OMERO5.3__0.sql`.

Remove the guest user password (optional)
"""""""""""""""""""""""""""""""""""""""""

If a password was set on the `guest` user to work around
:secvuln:`2017-SV4-guest-user` then you will need to remove it to restore the
forgotten password reset functionality in OMERO.web:

.. parsed-literal::

    $ psql -h localhost -U **db_user** **omero_database** < sql/psql/|current_dbver|/allow-guest-user-without-password.sql

This can be done at any time during the OMERO 5.4 series and is optional if
you do not deploy OMERO.web.

.. note::

    The above script assumes that the `guest` user has an ID of 1 as is
    typical. Otherwise the script will do nothing until it is adjusted.
    Please feel free to contact us for assistance with that if required.

Optimize an upgraded database (optional)
""""""""""""""""""""""""""""""""""""""""

After you have run the upgrade script, you may want to optimize your
database which can both save disk space and speed up access times.

.. parsed-literal::

    $ psql -h localhost -U **db_user** **omero_database** -c 'VACUUM FULL VERBOSE ANALYZE;'

Merge script changes
^^^^^^^^^^^^^^^^^^^^

If any new official scripts have been added under ``lib/scripts`` or if
you have modified any of the existing ones, then you will need to backup
your modifications. Doing this, however, is not as simple as copying the
directory over since the core developers will have also improved these
scripts. In order to facilitate saving your work, we have turned the
scripts into a Git submodule which can be found at
`<https://github.com/ome/scripts>`_.

For further information on managing your scripts, refer to
:doc:`installing-scripts`. If you require help, please contact the OME
developers.

Update your environment variables and memory settings
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Environment variables
"""""""""""""""""""""

If you changed the directory name where the |release| server code
resides, make sure to update any system environment variables. Before
restarting the server, make sure your :envvar:`PATH` and
:envvar:`PYTHONPATH` system environment variables are pointing to the
new locations.

JVM memory settings
"""""""""""""""""""

Your memory settings should be copied along with :file:`etc/grid/config.xml`,
but you can check the current settings by running :program:`omero admin jvmcfg`.
See :ref:`jvm_memory_settings` for more information.

Restart your server
^^^^^^^^^^^^^^^^^^^

-  Following a successful database upgrade, you can start the server.

   .. parsed-literal::

       $ cd OMERO.server
       $ bin/omero admin start

-  If anything goes wrong, please send the output of
   :program:`omero admin diagnostics` to
   ome-users@lists.openmicroscopy.org.uk.

.. _restore-the-db:

Restore a database backup
^^^^^^^^^^^^^^^^^^^^^^^^^

If the upgraded database or the new server version do not work for you,
or you otherwise need to rollback to a previous database backup, you may
want to restore a database backup. To do so, create a new database,

.. parsed-literal::

    $ createdb -h localhost -U postgres -E UTF8 -O **db_user** omero_from_backup

restore the previous archive into this new database,

::

    $ pg_restore -Fc -d omero_from_backup before_upgrade.db.dump

and configure your server to use it.

::

    $ bin/omero config set omero.db.name omero_from_backup


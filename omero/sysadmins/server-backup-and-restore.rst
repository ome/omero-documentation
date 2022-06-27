.. _server_backup:

OMERO.server backup and restore
===============================

Cleaning up your binary repository
----------------------------------

As detailed in :ref:`DeleteBinaryData`, it is possible that some files may be
left behind when a delete action is performed. This was mostly an issue on
Windows, which is no longer supported for OMERO server, but is still possible
on Posix systems. If you think files have been left behind e.g. after a
hard-reboot, a script to clean these up is included in the OMERO.server
distribution ``lib/python/omero/util/cleanse.py``, which can be used so::

    $ omero admin cleanse /OMERO

Note that only items not listed in the relational database (i.e. previously
failed deletes) and empty directories will be cleaned up by this script.

.. note::

    If you are cleaning a large repository and the process runs for a long
    time but does not appear to succeed, you may find that running
    ``$ omero sessions keepalive`` in one shell and then running the
    cleanse command from another shell allows the process to finish without
    timing out.

Managing OMERO.server log files
-------------------------------

Your OMERO.server will produce log files that are rotated when they
reach 512MB. These directories will look like::

    omero_dist $ ls var/log
    Blitz-0.log     FileServer.log      MonitorServer.log   Processor-0.log     master.out
    DropBox.log     Indexer-0.log       OMEROweb.log        master.err

Any files with a ``.1``, ``.2``, ``.3`` etc. suffix may be compressed or
deleted.

OMERO.server log file location
------------------------------

The log file directory may also be relocated to different storage by
modifying the ``etc/grid/default.xml`` file::

    ...
    <variable name="OMERO_LOGS"    value="var/log/"/>
    ...

Backing up OMERO
----------------

Understanding backup sources
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

OMERO.server has three main backup sources:

1.  PostgreSQL database (assumed to be ``omero_database``)
2.  OMERO.server
    :doc:`binary data store <unix/server-binary-repository>`
    (assumed to be :file:`/OMERO`)
3.  OMERO.server configuration

.. warning:: You must back up *(1)* and *(2)* frequently.

Frequent backups taken while the server is still running are usually
sufficient but you should be aware that they may not be consistent
snapshots. The **safest** course of action is to perform
backups during server downtime when possible, especially if you think you
may need the backup.

You need to back up *(3)* only before you make changes. You can copy it into 
``/OMERO/backup`` to ensure it is kept safe::

    $ omero config get > /OMERO/backup/omero.config

Other backup sources
""""""""""""""""""""

If you have edited :file:`etc/grid/(win)default.xml` directly for any
reason then you will also need to copy that file to somewhere safe, such
as :file:`/OMERO/backup`.

The :file:`lib/scripts` directory should also be backed up, but restoring it
may pose issues if any of your users have added their own "official
scripts". A :omero_subs_github_repo_root:`GitHub repository <scripts>` provides help for merging
your scripts directories.

.. _backup-and-restore_postgresql:

Backing up your PostgreSQL database
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Database backups can be achieved using the PostgreSQL ``pg_dump``
command. Here is an example backup script that can be placed in
:file:`/etc/cron.daily` to perform daily database backups::

    #!/bin/bash

    DATE=`date '+%Y-%m-%d_%H:%M:%S-%Z'`
    OUTPUT_DIRECTORY=/OMERO/backup/database
    DATABASE="omero_database"
    DATABASE_ADMIN="postgres"

    mkdir -p $OUTPUT_DIRECTORY
    chown -R $DATABASE_ADMIN $OUTPUT_DIRECTORY
    su $DATABASE_ADMIN -c "pg_dump -Fc -f $OUTPUT_DIRECTORY/$DATABASE.$DATE.pg_dump $DATABASE"

Other database backup configurations are outside the scope of this
document but can be researched on the `PostgreSQL website <https://www.postgresql.org/docs/10/backup.html>`_
*(Chapter 25. Backup and Restore)*.

.. note:: Frequent backups of your PostgreSQL database are crucial; you do not
    want to be in the position of trying to restore your server without one.

.. note:: Consider OMERO database dumps to be sensitive and be
    accordingly cautious in allowing access to them. For example, the
    ``session.uuid`` column contains UUIDs with which OMERO clients can
    attach to existing sessions.

Backing up your binary data store
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To simplify backup locations we have, in this document, located all
database and configuration backups under ``/OMERO``, your :doc:`binary data
store <unix/server-binary-repository>`. The entire contents of ``/OMERO`` should be
backed up frequently as this will, especially if this document's
conventions are followed, contain all the relevant data to restore your
OMERO.server installation in the unlikely event of a system failure,
botched upgrade or user malice.

File system backup is often a very personal and controversial topic
amongst systems administrators and as such the OMERO project does not
make any explicit recommendations about backup software. In the interest
of providing a working example we will use open source ``rdiff-backup``
project and like :ref:`backup-and-restore_postgresql` above, provide a
backup script which can be placed in ``/etc/cron.daily`` to perform
daily ``/OMERO`` backups::

    #!sh
    #!/bin/bash

    FROM=/OMERO
    TO=/mnt/backup_server

    rdiff-backup $FROM $TO

``rdiff-backup`` can also be used to backup ``/OMERO`` to a remote
machine::

    #!sh
    #!/bin/bash

    FROM=/OMERO
    TO=backup_server.example.com::/backup/omero

    rdiff-backup $FROM $TO

More advanced ``rdiff-backup`` configurations are beyond the scope of
this document. If you want to know more you are encouraged to read the
documentation available on the ``rdiff-backup`` `website <https://www.nongnu.org/rdiff-backup/docs.html>`_.

Restoring OMERO
---------------

There are three main steps to OMERO.server restoration in the event of a
system failure:

1. OMERO.server ``etc`` configuration
2. PostgreSQL database (assumed to be ``omero``)
3. OMERO.server binary data store (assumed to be ``/OMERO``)

.. note::
    It is important that restoration steps are done in this order
    unless you are absolutely sure what you are doing.

Restoring your configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Once you have retrieved an OMERO.server package from the
:downloads:`downloads <>` page that **matches** the version you
originally had installed, all that is required is to restore your backup
preferences by running::

    $ omero config load /OMERO/backup/omero.config

You should then follow the *Reconfiguration* steps of
:doc:`install <unix/server-installation>`.

Restoring your PostgreSQL database
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you have had a PostgreSQL crash and database users are missing from
your configuration, you should follow the first two (*Create a
non-superuser database user* and *Create a database for OMERO data to
reside in*) steps of :doc:`unix/server-installation`. Once you have ensured
that the database user and empty database exist, you can restore the
:file:`pg_dump` file as follows::

    $ sudo -u postgres pg_restore -Fc -d omero_database omero.2010-06-05_16:27:29-GMT.pg_dump

Restoring your OMERO.server binary data store
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

All that remains once you have restored your Java preferences and
PostgreSQL database is to restore your ``/OMERO`` :doc:`binary data
store <unix/server-binary-repository>` backup.


.. seealso::

    `List of backup software <https://en.wikipedia.org/wiki/List_of_backup_software>`_
        Wikipedia page listing the backup softwares.
    
    `PostgreSQL 10 Interactive Manual <https://www.postgresql.org/docs/10/backup.html>`_
        Chapter 25: Backup and Restore

    `rdiff-backup documentation <https://www.nongnu.org/rdiff-backup/docs.html>`_
        Online documentation of rdiff-backup project


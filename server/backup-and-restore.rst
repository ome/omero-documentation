.. _rst_backup-and-restore:

Maintenance tasks for OMERO
===========================

Cleaning up your binary repository
----------------------------------

The OMERO.server does not remove files from disk until a cleanup task
has been run. A script to do this is included in the OMERO.server
distribution ``lib/python/omero/util/cleanse.py`` which can be used so:

::

    $ bin/omero admin cleanse /OMERO

This can be performed daily using cron with a script such as:

::

    #!sh
    #!/bin/bash

    USERNAME="root"
    PASSWORD="root_password"
    BINARY_REPOSITORY="/OMERO"
    OMERO_HOME=/home/omero/OMERO-CURRENT
    $OMERO_HOME/bin/omero -s localhost -u $USERNAME -w $PASSWORD admin cleanse $BINARY_REPOSITORY

Managing OMERO.server log files
-------------------------------

Your OMERO.server will produce log files that are rotated when they
reach 512MB. These directories will look like:

::

    omero_dist $ ls var/log
    Blitz-0.log     FileServer.log      MonitorServer.log   Processor-0.log     master.out
    DropBox.log     Indexer-0.log       OMEROweb.log        master.err

Any files with a ``.1,``.2\ ``,``.3\`, etc. suffix may be compressed or
deleted.

OMERO.server log file location
------------------------------

The log file directory may also be relocated to different storage by
modifying the \`etc/grid/default.xml file:

::

    ...
    <variable name="OMERO_LOGS"    value="var/log/"/>
    ...

Backing Up OMERO
----------------

Understanding backup sources
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OMERO.server has three main backup sources:

1. PostgreSQL database (assumed to be ``omero``)
2. OMERO.server :ref:`binary data store <rst_binary-repository>` (assumed to be
   ``/OMERO``)
3. OMERO.server configuration

    **NOTE:** Since 4.2.0, the lib/scripts directory should also be
    backed up, but restoring it may pose issues. See [Software
    Limitations] (troubleshooting#section-18)

*(1)* and *(2)* should be backed up regularly and *(3)* really only
needs backing up before you make changes. You can ensure it is kept safe
copying it into ``/OMERO/backup``:

::

    $ bin/omero config get > /OMERO/backup/omero.config

Note: If you have edited ``etc/grid/(win)default.xml`` directly for any
reason then you will also need to copy that file to somewhere safe, such
as ``/OMERO/backup``.

.. _backup-and-restore_postgresql:

Backing up your PostgreSQL database
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Database backups can be achieved using the PostgreSQL ``pg_dump``
command. Here is an example backup script that can be placed in
``/etc/cron.daily`` to perform daily database backups:

::

    #!sh
    #!/bin/bash

    DATE=`date '+%Y-%m-%d_%H:%M:%S-%Z'`
    OUTPUT_DIRECTORY=/OMERO/backup/database
    DATABASE="omero_database"
    DATABASE_ADMIN="postgres"

    mkdir -p $OUTPUT_DIRECTORY
    chown -R $DATABASE_ADMIN $OUTPUT_DIRECTORY
    su $DATABASE_ADMIN -c "pg_dump -Fc -f $OUTPUT_DIRECTORY/$DATABASE.$DATE.pg_dump"

Other database backup configurations are outside the scope of this
document but can be researched on the `PostgreSQL website <http://www.postgresql.org/docs/9.1/interactive/backup.html>`_
*(Chapter 24. Backup and Restore)*.

Backing up your binary data store
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To simplify backup locations we have, in this document, located all
database and configuration backups under ``/OMERO``, your :ref:`binary data
store <rst_binary-repository>`. The entire contents of ``/OMERO`` should be
backed up regularly as this will, especially if this document's
conventions are followed, contain all the relevant data to restore your
OMERO.server installation in the unlikely event of a system failure,
botched upgrade or user malice.

File system backup is often a very personal and controversial topic
amongst systems administrators and as such the OMERO project does not
make any explicit recommendations about backup software. In the interest
of providing a working example we will use open source ``rdiff-backup``
project and like :ref:`backup-and-restore_postgresql` above, provide a
backup script which can be placed in ``/etc/cron.daily`` to perform
daily ``/OMERO`` backups:

::

    #!sh
    #!/bin/bash

    FROM=/OMERO
    TO=/mnt/backup_server

    rdiff-backup $FROM $TO

``rdiff-backup`` can also be used to backup ``/OMERO`` to a remote
machine:

::

    #!sh
    #!/bin/bash

    FROM=/OMERO
    TO=backup_server.example.com::/backup/omero

    rdiff-backup $FROM $TO

More advanced ``rdiff-backup`` configurations are beyond the scope of
this document. If you want to know more you are encouraged to read the
documentation available on the ``rdiff-backup`` `website <http://www.nongnu.org/rdiff-backup/docs.html>`_.

Restoring OMERO
---------------

There are three main steps to OMERO.server restoration in the event of a
system failure:

1. OMERO.server ``etc`` configuration
2. PostgreSQL database (assumed to be ``omero``)
3. OMERO.server binary data store (assumed to be ``/OMERO``)

**NOTE:** It is important that restoration steps are done in this order
unless you are absolutely sure what you are doing.

Restoring your configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Once you have retrieved an OMERO.server package from the
`download <../downloads>`_ page that **matches** the version you
originally had installed, all that is required is to restore your backup
preferences by running:

::

    $ bin/omero config load /OMERO/backup/omero.config

You should then follow the *Reconfiguration* steps of
:ref:`install <rst_installation>`.

Restoring your PostgreSQL database
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you have had a PostgreSQL crash and database users are missing from
your configuration, you should follow the first two (*Create a
non-superuser database user* and *Create a database for OMERO data to
reside in*) steps of :ref:`install <rst_installation>`. Once you have ensured
that the database user and empty database exist, you can restore the
``pg_dump`` file as follows:

::

    $ sudo -u postgres pg_restore -Fc -d omero_database omero.2010-06-05_16:27:29-GMT.pg_dump

Restoring your OMERO.server binary data store
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All that remains once you have restored your Java preferences and
PostgreSQL database is to restore your ``/OMERO`` :ref:`binary data
store <rst_binary-repository>` backup.


.. seealso::

	`List of backup software <http://en.wikipedia.org/wiki/List_of_backup_software>`_
		Wikipedia page listing the backup softwares.
	
	`PostgreSQL 9.1 Interactive Manual <http://www.postgresql.org/docs/9.1/interactive/backup.html>`_
 		Chapter 24: Backup and Restore

	`rdiff-backup documentation <http://www.nongnu.org/rdiff-backup/docs.html>`_
		Online documentation of rdiff-backup project


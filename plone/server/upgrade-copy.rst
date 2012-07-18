Upgrade copy
============

This page describes the upgrade process for the latest version of the
OMERO.server

Contents

General instructions
--------------------

-  The OME team is committed to providing frequent, project-wide
   upgrades both with bug fixes and new functionality. We try to make
   the schedule for these releases as public as possible. You may want
   to take a look at the
   `server <http://trac.openmicroscopy.org.uk/omero/roadmap>`_ and
   `client <http://trac.openmicroscopy.org.uk/shoola/roadmap>`_ roadmaps
   for exactly what will go into a release. We always inform our
   `mailing lists </site/community>`_ of the development status.

-  Finally, all the products check themselves with the
   `OMERO.registry <http://trac.openmicroscopy.org.uk/omero/wiki/OmeroRegistry>`_
   for update notifications on startup. If you wish to disable this
   functionality you should do so now as outlined on the
   `UpgradeCheck <http://trac.openmicroscopy.org.uk/omero/wiki/UpgradeCheck>`_
   page.

-  If you encounter errors during an OMERO upgrade, database upgrade,
   etc. you should retain as much log information as possible and notify
   the OMERO.server team via the mailing lists available on the
   `community </site/community>`_ page.

-  More experienced users may wish to examine the
   `DbUpgrade <http://trac.openmicroscopy.org.uk/omero/wiki/DbUpgrade>`_
   page for technical information about OMERO.server database upgrades
   and how to troubleshoot errors themselves.

-  For all users, the basic worflow for upgrading your OMERO.server from
   4.3.x to 4.4.0 is listed below. Please refer to each section for
   additional details.

   #. `Perform a database backup <#section-2>`_
   #. `Copy binaries <#section-3>`_
   #. `Update your database <#section-4>`_
   #. `(Optional) Optimize an upgraded database <#section-5>`_
   #. `Merge script changes <#section-6>`_
   #. `Restart your database <#section-7>`_
   #. `(Optional - if something goes wrong) Restore a database
      backup <#section-8>`_

Upgrade from 4.3.x server to 4.4.0 server
=========================================

Perform a database backup
-------------------------

The first thing to do before **any** upgrade activity is to backup your
database.

::

    # pg_dump -h <database_host> -U <database_username> -Fc -f <dump_filename> <db_name>
    $ pg_dump -h localhost -U db_user -Fc -f before_upgrade.db.dump omero_database

Copy new binaries
-----------------

Before copying the new binaries, stop the existing server

::

    $ cd ~/omero_dist
    $ bin/omero web stop
    $ bin/omero admin stop

Your OMERO 4.3 configuration is stored using ``config.xml`` in the
``etc/grid`` directory under your OMERO.server directory. Assuming you
have not made any file changes within your OMERO.server distribution
directory, you are safe to follow the following upgrade procedure:

::

    $ cd ..
    $ mv omero_dist omero_dist_old
    $ unzip OMERO.server-4.4.0-ice3x-b3033.zip
    $ cp omero_dist_old/etc/grid/config.xml OMERO.server-4.4.0-ice3x-b3033/etc/grid

where ice3x need to replaced by the adequate Ice version of
OMERO.server.

**Ensuring your OMERO.web media directories point to the right location
when using FastCGI**

When upgrading, if you have kept the extracted OMERO.server directory
you will need to keep the media directories in sync with the correct
version of OMERO.web. Your options are :

-  either to replace the entire stanza that you pasted into your Apache
   or nginx configuration by re-running
   ``bin/omero web config <webserver>``
-  or by just modifying the ``/appmedia`` and ``/media`` alias
   locations.

**Changes to OMERO.web URLs**

In order to ease deployment and avoid errors for IIS (Windows production
deployment) and Apache (notably CentOS/RHEL 5 and 6) OMERO.web now
defaults to being "mounted on ``omero``". The new OMERO.web web server
stanzas have redirects in them with the notable exception of IIS.
Depending on your web server configuration you may need to visit your
OMERO.web instance at
`http://your\_host/omero/ <http://localhost/omero/>`_.

Update your database
--------------------

You **must** use the same username and password you have defined during
`installation <installation>`_. The 4.4 upgrade script should execute
very quickly.

::

    $ psql -h localhost -U db_user omero_database < sql/psql/OMERO4.4__0/OMERO4.3__0.sql
    Password for user db_user:
    ...
    ...

Optimize an upgraded database (optional)
----------------------------------------

After you have run the upgrade script, you may want to optimize your
database which can both save disk space and speed up access times.

::

    # psql -h <database_host> -U <database_username> <database_name> -c "REINDEX DATABASE <database_name> FORCE;"
    $ psql -h localhost -U db_user omero_database -c "REINDEX DATABASE omero_database FORCE;"

    # psql -h <database_host> -U <database_username> <database_name> -c "VACUUM FULL VERBOSE ANALYZE;"
    $ psql -h localhost -U db_user omero_database -c "VACUUM FULL VERBOSE ANALYZE;"

Merge script changes (New!)
---------------------------

If any new official scripts have been added under lib/scripts or if
you've modified any of the existing ones, then you will need to save
your modifications. Doing this, however, is not as simple as copying the
directory over since the core developers will have also improved these
scripts. In order to facilitate saving your work, we've turned the
scripts into a git submodule which can be found at
`http://github.com/ome/scripts <http://github.com/ome/scripts>`_

maybe add details here or at least reference to FAQ

If you would like help merging the two repositories, please contact the
OME developers.

Restart your database
---------------------

-  Following a successful db upgrade, you can start the 4.4 server.

   ::

       $ cd ~/OMERO.server-4.4.0-ice33-b3033/
       $ bin/omero admin start

-  If anything goes wrong, please send the output of bin/omero admin
   diagnostics to ome-users@lists.openmicroscopy.org.uk.

-  Restart OMERO.web with the following command:

   ::

       $ cd ~/OMERO.server-4.4.0-ice33-b3033
       $ bin/omero web start

Restore a database backup
-------------------------

If the upgraded database or the new server version do not work for you,
or you otherwise need to rollback to a previous database backup, you may
want to restore a database backup. To do so, create a new database,

::

    $ createdb -h localhost -U postgres -O db_user omero_from_backup

restore the previous archive into this new database,

::

    $ pg_restore -Fc -d omero_from_backup before_upgrade.db.dump

and configure your server to use it.

::

    $ bin/omero config omero.db.name omero_from_backup

Previous upgrades
=================

Upgrades for previous versions of the OMERO server can be found on our
`Legacy upgrade <legacy-upgrade>`_ page.
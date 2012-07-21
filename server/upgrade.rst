.. _rst_upgrade:

Upgrade
=======

Contents

The OME team is committed to providing frequent, project-wide upgrades
both with bug fixes and new functionality. We try to make the schedule
for these releases as public as possible. You may want to take a look at
the <http://trac.openmicroscopy.org.uk/ome/roadmap>_
for exactly what will go into a release. We always inform our `mailing
lists </site/community>`_ of the development status. Finally, all the
products check themselves with the
:wiki:`OmeroRegistry`
for update notifications on startup. If you wish to disable this
functionality you should do so now as outlined on the :wiki:`UpgradeCheck`
page.

If you encounter errors during a OMERO upgrade, database upgrade, etc.
you should retain as much log information as possible and notify the
OMERO.server team via the mailing lists available on the
`community </site/community>`_ page. More experienced users may wish to
examine the :wiki:`DbUpgrade` page for technical information about OMERO.server database upgrades and
how to troubleshoot errors themselves.

General HOWTOs
--------------

Performing a database backup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The first thing to do before **any** upgrade activity is to backup your
database.

::

    # pg_dump -h <database_host> -U <database_username> -Fc -f <dump_filename> <db_name>
    $ pg_dump -h localhost -U db_user -Fc -f before_upgrade.db.dump omero_database

Optimizing an upgraded database (optional)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After you have run the upgrade script related to your version (see
below), you may want to optimize your database which can both save disk
space and speed up access times.

::

    # psql -h <database_host> -U <database_username> <database_name> -c "REINDEX DATABASE <database_name> FORCE;"
    $ psql -h localhost -U db_user omero_database -c "REINDEX DATABASE omero_database FORCE;"

    # psql -h <database_host> -U <database_username> <database_name> -c "VACUUM FULL VERBOSE ANALYZE;"
    $ psql -h localhost -U db_user omero_database -c "VACUUM FULL VERBOSE ANALYZE;"

Restoring a database backup if something goes wrong
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If the upgraded database or the new server version do not work for you,
or you otherwise need to rollback to a previous database backup, it's
best to create a new database and configure your server to use it:

::

    $ createdb -h localhost -U postgres -O db_user omero_from_backup
    $ pg_restore -Fc -d omero_from_backup beforE_upgrade.db.dump
    $ bin/omero config omero.db.name omero_from_backup

Ensuring your OMERO.web media directories point to the right location when using FastCGI
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When upgrading, if you have kept the extracted OMERO.server directory
you will need to keep the media directories in sync with the correct
version of OMERO.web. Your options are either to replace the entire
stanza that you pasted into your Apache or nginx configuration by
re-running ``bin/omero web config <webserver>`` or by just modifying the
``/appmedia`` and ``/media`` alias locations.

Per version upgrade instructions
--------------------------------

4.3.x to 4.4.0
~~~~~~~~~~~~~~

    **Note:** You should *always* backup your database before performing
    an upgrade as outlined above.

Your OMERO 4.3 configuration is stored using ``config.xml`` in the
``etc/grid`` directory under your OMERO.server directory. If you have
not made any file changes within your OMERO.server distribution
directory you are safe to follow the following upgrade procedure:

::

    $ cd ~/omero_dist
    $ bin/omero web stop
    $ bin/omero admin stop
    $ cd ..
    $ mv omero_dist omero_dist_old
    $ unzip OMERO.server-4.4.0-ice33-b3033.zip
    $ cp omero_dist_old/etc/grid/config.xml OMERO.server-4.4.0-ice33-b3033/etc/grid

Changes to OMERO.web URLs
^^^^^^^^^^^^^^^^^^^^^^^^^

In order to ease deployment and avoid errors for IIS (Windows production
deployment) and Apache (notably CentOS/RHEL 5 and 6) OMERO.web now
defaults to being "mounted on ``omero``. The new OMERO.web web server
stanzas have redirects in them with the notable exception of IIS.
Depending on your web server configuration you may need to visit your
OMERO.web instance at
`http://your\_host/omero/ <http://localhost/omero/>`_.

Update your database
^^^^^^^^^^^^^^^^^^^^

You **must** use the same username and password you have defined during
`installation <installation>`_. The 4.4 upgrade script should execute
very quickly. Please ensure you have performed a database backup as
outlined under "First steps".

::

    $ psql -h localhost -U omero omero < sql/psql/OMERO4.4__0/OMERO4.3__0.sql
    Password for user omero:
    ...
    ...

Following a successful db upgrade, you can start the 4.4 server.

::

    $ cd ~/OMERO.server-4.4.0-ice33-b3033/
    $ bin/omero admin start

-  If anything goes wrong, please send the output of bin/omero admin
   diagnostics to ome-users@lists.openmicroscopy.org.uk.

-  Restart OMERO.web with the following command:

   ::

       $ cd ~/OMERO.server-4.4.0-ice33-b3033
       $ bin/omero web start

Merge script changes (New!)
^^^^^^^^^^^^^^^^^^^^^^^^^^^

If any new official scripts have been added under lib/scripts or if
you've modified any of the existing ones, then you will need to save
your modifications. Doing this, however, is not as simple as copying the
directory over since the core developers will have also improved these
scripts. In order to facilitate saving your work, we've turned the
scripts into a git submodule which can be found at
`http://github.com/ome/scripts <http://github.com/ome/scripts>`_

If you would like help merging the two repositories, please contact the
OME developers.

4.3.x to 4.3.4
~~~~~~~~~~~~~~

    **Note:** You should *always* backup your database before performing
    an upgrade as outlined under the steps for upgrading from 3.2.x to
    4.0.0 (found at the bottom of this page).

-  Stop your old server, and replace it with the new binaries:

   ::

       $ cd ~/omero_dist
       $ bin/omero web stop
       $ bin/omero admin stop
       $ cd ..
       $ mv omero_dist omero_dist_old
       $ tar jxvf omero-Beta4.3.4.tar.bz2

-  Your server configuration is stored in "config.xml" under "etc/grid".
   If you would prefer not to reconfigure your server, copy that file
   over:

   ::

       $ cd ~/omero_dist
       $ mv ../omero_dist_old/etc/grid/config.xml etc/grid

-  If you have modified any of the other etc/grid files like default.xml
   or template.xml you will need to make those modifications in the new
   files. A typical example is an increased memory setting for the Blitz
   process in etc/grid/templates.xml.

-  Now, you should be ready to start the OMERO server:

   ::

       $ cd ~/omero_dist
       $ bin/omero admin start

-  If anything goes wrong, please send the output of bin/omero admin
   diagnostics to ome-users@lists.openmicroscopy.org.uk.

-  Restart OMERO.web by the following command:

   ::

       $ cd ~/omero_dist
       $ bin/omero web syncmedia
       $ bin/omero web start

4.3.x to 4.3.3
~~~~~~~~~~~~~~

    **Note:** You should *always* backup your database before performing
    an upgrade as outlined under the steps for upgrading from 3.2.x to
    4.0.0 (found at the bottom of this page).

    **LDAP users Read This: Password Provider Change** In this minor
    release, the LDAP plugin changed. You can manually choose the
    previous version of the plugin for backwards compatibility. See the
    section `*Legacy Password Providers* <install-ldap>`_

-  Stop your old server, and replace it with the new binaries:

   ::

       $ cd ~/omero_dist
       $ bin/omero web stop
       $ bin/omero admin stop
       $ cd ..
       $ mv omero_dist omero_dist_old
       $ tar jxvf omero-Beta4.3.3.tar.bz2

-  Your server configuration is stored in "config.xml" under "etc/grid".
   If you would prefer not to reconfigure your server, copy that file
   over:

   ::

       $ cd ~/omero_dist
       $ mv ../omero_dist_old/etc/grid/config.xml etc/grid

-  If you have modified any of the other etc/grid files like default.xml
   or template.xml you will need to make those modifications in the new
   files. A typical example is an increased memory setting for the Blitz
   process in etc/grid/templates.xml.

-  Now, you should be ready to start the OMERO server:

   ::

       $ cd ~/omero_dist
       $ bin/omero admin start

-  If anything goes wrong, please send the output of bin/omero admin
   diagnostics to ome-users@lists.openmicroscopy.org.uk.

-  Restart OMERO.web by the following command:

   ::

       $ cd ~/omero_dist
       $ bin/omero web syncmedia
       $ bin/omero web start

4.3.x to 4.3.2
~~~~~~~~~~~~~~

    **Note:** You should *always* backup your database before performing
    an upgrade as outlined under the steps for upgrading from 3.2.x to
    4.0.0 (found at the bottom of this page).

    **LDAP users Read This: Password Provider Change** In this minor
    release, the LDAP plugin changed. You can manually choose the
    previous version of the plugin for backwards compatibility. See the
    section `*Legacy Password Providers* <install-ldap>`_

-  Stop your old server, and replace it with the new binaries:

   ::

       $ cd ~/omero_dist
       $ bin/omero web stop
       $ bin/omero admin stop
       $ cd ..
       $ mv omero_dist omero_dist_old
       $ tar jxvf omero-Beta4.3.2.tar.bz2

-  Your server configuration is stored in "config.xml" under "etc/grid".
   If you would prefer not to reconfigure your server, copy that file
   over:

   ::

       $ cd ~/omero_dist
       $ mv ../omero_dist_old/etc/grid/config.xml etc/grid

-  If you have modified any of the other etc/grid files like default.xml
   or template.xml you will need to make those modifications in the new
   files. A typical example is an increased memory setting for the Blitz
   process in etc/grid/templates.xml.

-  Now, you should be ready to start the OMERO server:

   ::

       $ cd ~/omero_dist
       $ bin/omero admin start

-  If anything goes wrong, please send the output of bin/omero admin
   diagnostics to ome-users@lists.openmicroscopy.org.uk.

-  Restart OMERO.web by the following command:

   ::

       $ cd ~/omero_dist
       $ bin/omero web syncmedia
       $ bin/omero web start

4.3.x to 4.3.1
~~~~~~~~~~~~~~

    **Note:** You should *always* backup your database before performing
    an upgrade as outlined under the steps for upgrading from 3.2.x to
    4.0.0 (found at the bottom of this page).

-  Stop your old server, and replace it with the new binaries:

   ::

       $ cd ~/omero_dist
       $ bin/omero web stop
       $ bin/omero admin stop
       $ cd ..
       $ mv omero_dist omero_dist_old
       $ tar jxvf omero-Beta4.3.1.tar.bz2

-  Your server configuration is stored in "config.xml" under "etc/grid".
   If you would prefer not to reconfigure your server, copy that file
   over:

   ::

       $ cd ~/omero_dist
       $ mv ../omero_dist_old/etc/grid/config.xml etc/grid

-  If you have modified any of the other etc/grid files like default.xml
   or template.xml you will need to make those modifications in the new
   files. A typical example is an increased memory setting for the Blitz
   process in etc/grid/templates.xml.

-  Now, you should be ready to start the OMERO server:

   ::

       $ cd ~/omero_dist
       $ bin/omero admin start

-  If anything goes wrong, please send the output of bin/omero admin
   diagnostics to ome-users@lists.openmicroscopy.org.uk.

-  Restart OMERO.web with the following command:

   ::

       $ cd ~/omero_dist
       $ bin/omero web syncmedia
       $ bin/omero web start

4.2.x to 4.3.0
~~~~~~~~~~~~~~

    **Note:** You should *always* backup your database before performing
    an upgrade as outlined under the steps for upgrading from 3.2.x to
    4.0.0 (found at the bottom of this page).

From OMERO Beta 4.2.0, configuration is stored using ``config.xml`` in
the ``etc/grid`` directory under your OMERO.server directory. If you
have not made any file changes within your OMERO.server distribution
directory you are safe to follow the following upgrade procedure:

::

    $ cd ~/omero_dist
    $ bin/omero web stop
    $ bin/omero admin stop
    $ cd ..
    $ mv omero_dist omero_dist_old
    $ tar jxvf omero-Beta4.3.0.tar.bz2
    $ cp omero_dist_old/etc/grid/config.xml omero_dist/etc/grid

Update your database
^^^^^^^^^^^^^^^^^^^^

You **must** use the same username and password you have defined during
`installation <installation>`_. Once begun, the upgrade can take
*significant* time on large databases (up to 1 or 2 hours), please be
patient and ensure you have performed a database backup as outlined
under "First steps".

::

    $ psql -h localhost -U omero omero < sql/psql/OMERO4.3__0/OMERO4.2__0.sql
    Password for user omero:
    ...
    ...

    **Warning:**: Unlike previous database upgrades, the move to
    ``OMERO4.3__0`` may require manual intervention. If you encounter
    errors such as:

::

    ALTER TABLE
    Time: 9.105 ms
    ERROR:  check constraint "logicalchannel_check" is violated by some row
    ERROR:  current transaction is aborted, commands ignored until end of transaction block
    ERROR:  current transaction is aborted, commands ignored until end of transaction block

You have some metadata that will need to be fixed by running:

::

    $ psql -h localhost -U omero omero < sql/psql/OMERO4.3__0/omero-4.2-data-fix.sql
    Password for user omero:
    ...
    ...

Following a successful db upgrade, you can start the 4.3 server.

::

    $ cd ~/omero_dist/
    $ bin/omero admin start

-  If anything goes wrong, please send the output of bin/omero admin
   diagnostics to ome-users@lists.openmicroscopy.org.uk.

-  Restart OMERO.web with the following command:

   ::

       $ cd ~/omero_dist
       $ bin/omero web syncmedia
       $ bin/omero web start

4.2.x patch releases
~~~~~~~~~~~~~~~~~~~~

    **Note:** You should *always* backup your database before performing
    an upgrade as outlined under the steps for upgrading from 3.2.x to
    4.0.0 (found at the bottom of this page).

-  Stop your old server, and replace it with the new binaries:

   ::

       $ cd ~/omero_dist
       $ bin/omero web stop
       $ bin/omero admin stop
       $ cd ..
       $ mv omero_dist omero_dist_old
       $ tar jxvf omero-Beta4.2.1.tar.bz2

-  Your server configuration is stored in "config.xml" under "etc/grid".
   If you would prefer not to reconfigure your server, copy that file
   over:

   ::

       $ cd ~/omero_dist
       $ mv ../omero_dist_old/etc/grid/config.xml etc/grid

-  If you have modified any of the other etc/grid files like default.xml
   or template.xml you will need to make those modifications in the new
   files. A typical example is an increased memory setting for the Blitz
   process in etc/grid/templates.xml.

-  Now, you should be ready to start the OMERO server:

   ::

       $ cd ~/omero_dist
       $ bin/omero admin start

-  If anything goes wrong, please send the output of bin/omero admin
   diagnostics to ome-users@lists.openmicroscopy.org.uk.

-  Configuration for ***OMERO.web*** changed significantly in 4.2.1 to
   ease many of the deployment issues on both Unix and Windows
   platforms. Therefore, it is not necessarily, or possible to copy your
   web settings.py, but rather you should see the `"Web on
   Production" <install_web>`_ page for more information on setting up
   your web server. This can safely be done after the OMERO server is
   running.

       If you have already upgraded to 4.2.1 you should only restart
       OMERO.web by the following command:

   ::

       $ cd ~/omero_dist
       $ bin/omero web syncmedia
       $ bin/omero web start

4.1.x to 4.2.1+
~~~~~~~~~~~~~~~

    **Note:** You should *always* backup your database before performing
    an upgrade as outlined under the steps for upgrading from 3.2.x to
    4.0.0 (found at the bottom of this page).

From OMERO Beta 4.0.0, configuration is stored using Java properties so
no configuration file copies need happen. If you have not made any file
changes within your OMERO.server distribution directory you are safe to
follow the following upgrade procedure:

::

    $ cd ~/omero_dist
    $ bin/omero admin stop
    $ cd ..
    $ mv omero_dist omero_dist_old
    $ tar jxvf omero-Beta4.2.0.tar.bz2
    $ cd omero_dist

Update your database
^^^^^^^^^^^^^^^^^^^^

You **must** use the same username and password you have defined during
`installation <installation>`_. Once begun, the upgrade can take
*significant* time on large databases (up to 2 or 3 hours), please be
patient and ensure you have performed a database backup as outlined
under "First steps".

    **Warning:**: Unlike previous database upgrades, the move to
    ``OMERO4.2__0`` may require manual intervention. After some initial
    processing, a report is run which checks for possible permission
    issues. `More Info Here <db-upgrade-41-to-42>`_. If it finds any, an
    error message will be printed:

::

    ERROR ON omero_41_check:
    Your database has data which is incompatible with 4.2 and will need to be manually updated
    Contact ome-users@lists.openmicroscopy.org.uk for help adjusting your data.

If this happens, please send the full report to the OME team for
assistance correcting the warnings. The steps to run the script are
slightly different from previous upgrades as well. It is necessary to be
in the same directory as omero-4.1-permissions-report.sql, and adding
more flags to the command line will help detect errors sooner:

::

    $ cd ~/omero_dist/sql/psql/OMERO4.2__0                      
    $ psql -v ON_ERROR_STOP=1 --pset pager=off -h localhost -U omero -f OMERO4.1__0.sql  omero 
    Password for user omero:
    ...
    ...

To mail the output of the command to the team, you may want to pipe the
output to a file:

::

    $ psql ... -f OMERO4.1__0.sql omero > upgrade.log

Following a successful db upgrade, you can start the 4.2 server.

::

    $ cd ~/omero_dist/
    $ bin/omero admin start

OMERO.web upgrade
^^^^^^^^^^^^^^^^^

Configuration for ***OMERO.web*** changed significantly in 4.2.1 to ease
many of the deployment issues on both Unix and Windows platforms.
Therefore, it is not necessarily, or possible to copy your web
settings.py, but rather you should see the `"Web on
Production" <install_web>`_ page for more information on setting up your
web server. This can safely be done after the OMERO server is running.

Additional (Optional) Services
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In addition to a database upgrade you may also want to consider if any
of the additional services and optional installs would be of use to you.

-  **Python Imaging Library** (for OMERO.web and Figure Export
   functionality only) Packages should be available for your
   distribution from `here <http://www.pythonware.com/products/pil/>`__

-  **Matplot Lib** (for OMERO.web only) Packages should be available for
   your distribution from `here <http://matplotlib.sourceforge.net/>`__

-  **NumPy Lib** (for scripting services) This package may already have
   been installed as a dependency of Matplot Lib, above, but if not you
   will need to install it to use scripting services. NumPy is available
   from `here <http://numpy.scipy.org/>`__

-  **OMERO.tables** can be installed by following the :wiki:`OmeroTables`
   install guide.

-  **Security** By default, OMERO clients only need to connect to two
   TCP ports for communication with your OMERO.server: 4063 (unsecured)
   and 4064 (ssl). For more details please see `here <security>`__.

4.0.x to 4.1.x
~~~~~~~~~~~~~~

    **Note:** You should *always* backup your database before performing
    an upgrade as outlined under the steps for upgrading from 3.2.x to
    4.0.0 (found at the bottom of this page).

From OMERO Beta 4.0.0, configuration is stored using Java properties so
no configuration file copies need happen. If you have not made any file
changes within your OMERO.server distribution directory you are safe to
follow the following upgrade procedure:

::

    $ cd ~/omero_dist
    $ bin/omero admin stop
    $ cd ..
    $ mv omero_dist omero_dist_old
    $ tar jxvf omero-Beta4.1.0.tar.bz2
    $ cd omero_dist
    $ bin/omero admin start

-  4.1.0 to 4.1.1 or newer:

   If you have configured OMERO.web for a production environment, you
   should copy the configuration files from your old distribution
   directory:

   ::

       $ cp ~/omero_dist_old/lib/python/omeroweb/settings.py ~/omero_dist/lib/python/omeroweb

-  4.0.x to 4.1.0:

   If you wish to configure OMERO.web you should follow the instruction
   on `Install page <./installation#section-6>`_.

    **Note:** It is **not recommended** to use any older settings.py
    files with the 4.1.x.

You should also change any environment variables or directory references
that may point to the wrong location.

Update your database
^^^^^^^^^^^^^^^^^^^^

You **must** use the same username and password you have defined during
`installation <installation>`_. Once begun, the upgrade can take
*significant* time on large databases (up to 2 or 3 hours), please be
patient and ensure you have performed a database backup as outlined
under "First steps".

::

    $ cd ~/omero-Beta4.1.0
    $ psql -h localhost -U omero omero < sql/psql/OMERO4.1__0/OMERO4__0.sql
    Password for user omero:
    ...
    ...

4.0.x patch releases
~~~~~~~~~~~~~~~~~~~~

    **Note:** You should *always* backup your database before performing
    an upgrade as outlined under the steps for upgrading from 3.2.x to
    4.0.0 (found at the bottom of this page).

From OMERO Beta 4.0.0, configuration is stored using Java properties so
no configuration file copies need happen. If you have not made any file
changes within your OMERO.server distribution directory you are safe to
follow the following upgrade procedure:

::

    $ cd ~/omero_dist
    $ bin/omero admin stop
    $ cd ..
    $ mv omero_dist omero_dist_old
    $ tar jxvf omero-Beta4.0.3.tar.bz2
    $ cd omero_dist
    $ bin/omero admin start

If you have configured OMERO.web for a production environment, you
should copy the configuration files from your old distribution
directory:

::

    $ cp ~/omero_dist_old/lib/python/omeroweb/settings.py \
         ~/omero_dist/lib/python/omeroweb

You should also change any environment variables or directory references
that may point to the wrong location.

3.2.x to 4.0.0
~~~~~~~~~~~~~~

** If your server is anything other than a Beta 3.2 series, you will
first need to follow all required upgrades on the :wiki:`OmeroUpgrade`
before proceeding with these instructions. **

Unlike previous upgrades, migrating from the 3.2.x series to 4.0.0 is
essentially a full re-install but re-using your existing database and
data files. Nevertheless, all the instructions under
`install <installation>`_ should be followed before beginning with these
instructions. In fact, starting with a bare database may be advisable to
test out your installation. Also, be sure to put aside a **significant**
amount of time for upgrading larger databases.

**Steps:**

#. Perform a database backup
#. Update your database from ``OMERO3A__11`` to ``OMERO4__0``
#. Configure the Beta4.0.0 server to use your existing database and data
   files.

Step 1: Database backup
^^^^^^^^^^^^^^^^^^^^^^^

::

    # pg_dump -h <database_host> -U <database_username> -Fc -f <dump_filename> <db_name>
    $ pg_dump -h localhost -U omero -Fc -f before_upgrade.db.dump omero3

Step 2: Update your database
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You **must** use the same username and password you have defined during
`installation <installation>`_. Once begun, the upgrade can take
*significant* time on large databases (up to 2 or 3 hours), please be
patient and ensure you have performed a database backup as above.

::

    $ cd ~/omero-Beta4.0.0
    $ psql -h localhost -U omero omero3 < sql/psql/OMERO4__0/OMERO3A__11.sql
    Password for user omero:
    ...
    ...

Step 3: Configuring server
^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    $ cd ~/omero-Beta4.0.0
    $ bin/omero config set omero.data.dir /OMERO
    $ bin/omero config set omero.db.name omero3

If the ``omero.db.user`` and ``omero.db.pass`` for the ``omero3``
database are different then those for the database you created during
`installation <installation>`_, then those should be configured as well.
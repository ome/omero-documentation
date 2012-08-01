Deprecated Page

3.2 ONLY. The latest version of page is available at
 `http://www.openmicroscopy.org/site/documents/data-management/omero4/server/upgrade <http://www.openmicroscopy.org/site/documents/data-management/omero4/server/upgrade>`_
===========================================================================================================================================================================

OMERO.server Upgrade Instructions
=================================

Table of Contents
^^^^^^^^^^^^^^^^^

#. `Beta3.1.x to Beta3.2.x <#Beta3.1.xtoBeta3.2.x>`_
#. `Beta3.0 *OR* Beta3.0.1 to Beta3.1 <#Beta3.0ORBeta3.0.1toBeta3.1>`_
#. `3.0-Beta2.3 to Beta3.0 <#a3.0-Beta2.3toBeta3.0>`_
#. `3.0-Beta2.2 to 3.0-Beta2.3 <#a3.0-Beta2.2to3.0-Beta2.3>`_
#. `3.0-Beta2 to 3.0-Beta2.2 <#a3.0-Beta2to3.0-Beta2.2>`_
#. `Update Notification <#UpdateNotification>`_
#. `Troubleshooting <#Troubleshooting>`_

Beta3.1.x to Beta3.2.x
----------------------

Upgrading from any of the Beta3.1 releases to any of the Beta3.2
releases does *not* require a database upgrade. Therefore, like the
other upgrades, you begin with step 1:

#. **Copy the ``etc/local.properties`` file** from your existing
   ``omero-Beta3.1`` installation directory to your new
   ``omero-Beta3.2`` installation directory and re-deploy the
   *OMERO.server* EAR. This is similar to performing a *Reconfiguration*
   in the `OmeroInstall </ome/wiki/OmeroInstall>`_ documentation.

   ::

       $ cp ~/omero-Beta3.1/omero/etc/local.properties ~/omero-Beta3.2/omero/etc/local.properties
       $ cd ~/omero-Beta3.2/omero
       $ export JBOSS_HOME=~/omero-Beta3.2/jboss-4.2.3.GA
       $ java omero deploy

#. Done.

You have now successfully updated and can restart your *OMERO.server*
instance as follows:

::

    $ export JBOSS_HOME=~/omero-Beta3.2/jboss-4.2.3.GA
    $ $JBOSS_HOME/bin/run.sh

    (To start OMERO.server in the background:
    ``$JBOSS_HOME/bin/run.sh > /dev/null 2>&1``)

Beta3.0 *OR* Beta3.0.1 to Beta3.1
---------------------------------

Upgrading from `milestone:3.0-Beta3 </ome/milestone/3.0-Beta3>`_ (which
includes the patch release 3.0-Beta3.0.1) to
`milestone:3.0-Beta3.1 </ome/milestone/3.0-Beta3.1>`_ requires a fairly
straight-forward DB upgrade:

#. **Copy the ``etc/local.properties`` file** from your existing
   ``omero-Beta3.0`` or ``omero-Beta3.0.1`` installation directory to
   your new ``omero-Beta3.1`` installation directory and re-deploy the
   *OMERO.server* EAR. This is similar to performing a *Reconfiguration*
   in the `OmeroInstall </ome/wiki/OmeroInstall>`_ documentation.

   ::

       $ cp ~/omero-Beta3.0/omero/etc/local.properties ~/omero-Beta3.1/omero/etc/local.properties
       $ cd ~/omero-Beta3.1/omero
       $ export JBOSS_HOME=~/omero-Beta3.1/jboss-4.2.3.GA
       $ java omero deploy

#. **Perform a database backup**

   ::

       pg_dump -h <database_host> -U <db_username> -Fc -f <dump_filename> <db_name>

       ex. pg_dump -h localhost -U omero -Fc -f before_upgrade.db.dump omero3

#. **Add the ``PL/pgSQL`` language to your database:**

   ::

       $ sudo -u postgres createlang plpgsql omero3

   Depending on whether you upgraded from a previous version or created
   a new ``Beta3.0`` database, this might print out the following
   warning message which can be safely ignored:

   ::

       createlang: language "plpgsql" is already installed in database "omero3"

#. **Update your database from ``OMERO3__11`` to ``OMERO3A__5``**.

    **NOTE:** You **must** use the same username and password you have
    defined in your ``etc/local.properties`` file in the
    ``hibernate.connection.username`` and
    ``hibernate.connection.password`` properties. This will also be the
    same as the database user you created as outlined in the
    *Pre-Installation* phase of the
    `OmeroInstall </ome/wiki/OmeroInstall>`_ documentation.

    **NOTE:** As with all database upgrades, ensure you have performed a
    database backup as above.

    ::

        $ cd ~/omero-Beta3.1/omero
        $ psql -h localhost -U omero omero3 < sql/psql/OMERO3A__11/OMERO3A__5.sql
        Password for user omero:
        ...
        ...

You have now successfully updated from
`milestone:3.0-Beta3 </ome/milestone/3.0-Beta3>`_ to
`milestone:3.0-Beta3.1 </ome/milestone/3.0-Beta3.1>`_ and can restart
your *OMERO.server* instance as follows:

::

    $ export JBOSS_HOME=~/omero-Beta3.1/jboss-4.2.3.GA
    $ $JBOSS_HOME/bin/run.sh

    (To start OMERO.server in the background:
    ``$JBOSS_HOME/bin/run.sh > /dev/null 2>&1``)

3.0-Beta2.3 to Beta3.0
----------------------

Upgrading from `milestone:3.0-Beta2.3 </ome/milestone/3.0-Beta2.3>`_ to
`milestone:3.0-Beta3 </ome/milestone/3.0-Beta3>`_ is a large upgrade
requiring **significant** time for larger databases:

#. Copy the ``etc/local.properties`` file from your existing
   *3.0-Beta2.3* installation directory to your new *Beta3.0*
   installation directory and re-deploy the *OMERO.server* EAR. This is
   similar to performing a *Reconfiguration* in the
   `OmeroInstall </ome/wiki/OmeroInstall>`_ documentation.

   ::

       $ cp ~/omero-3.0-Beta2.3/omero/etc/local.properties ~/omero-Beta3.0/omero/etc/local.properties
       $ cd ~/omero-Beta3.0/omero
       $ export JBOSS_HOME=~/omero-Beta3.0/jboss-4.2.1.GA
       $ java omero deploy

#. **Perform a database backup**

   ::

       pg_dump -h <database_host> -U <db_username> -Fc -f <dump_filename> <db_name>

       ex. pg_dump -h localhost -U omero -Fc -f before_upgrade.db.dump omero3

#. Add the ``PL/pgSQL`` language to your database:

   ::

       $ sudo -u postgres createlang plpgsql omero3

#. **Update your database from ``OMERO3__5`` to ``OMERO3A__4``**.

    **NOTE:** You **must** use the same username and password you have
    defined in your ``etc/local.properties`` file in the
    ``hibernate.connection.username`` and
    ``hibernate.connection.password`` properties. This will also be the
    same as the database user you created as outlined in the
    *Pre-Installation* phase of the
    `OmeroInstall </ome/wiki/OmeroInstall>`_ documentation.

    **NOTE:** This upgrade can take **significant** time on large
    databases (up to **2 or 3 hours**) please be patient and ensure you
    have performed a database backup as above.

    ::

        $ cd ~/omero-Beta3.0/omero
        $ psql -h localhost -U omero omero3 < sql/psql/OMERO3A__4/OMERO3__5.sql
        Password for user omero:
        ...
        ...

5. **Update your database from ``OMERO3A__4`` to ``OMERO3A__5``**.

   ::

       $ cd ~/omero-Beta3.0/omero
       $ psql -h localhost -U omero omero3 < sql/psql/OMERO3A__5/OMERO3A__4.sql
       Password for user omero:
       ...
       ...

6. **Decide whether or not you wish to preserve *Category Group* and
   *Category* metadata**

As of `milestone:3.0-Beta3 </ome/milestone/3.0-Beta3>`_ OMERO no longer
provides views for *Category Group* or *Category* entities and has
replaced this functionality with
`StructuredAnnotations </ome/wiki/StructuredAnnotations>`_. As a
migration path, you may now wish to make your *Category Group* and
*Category* entities into *Projects* and *Datasets*:

::

    $ cd ~/omero-Beta3.0/omero
    $ psql -h localhost -U omero omero3 < sql/psql/OMERO3A__5/CGCtoPDI.sql
    Password for user omero:
    ...
    ...

After converting to Projects and Datasets, it might be useful to convert
some of them back to
`StructuredAnnotations </ome/wiki/StructuredAnnotations>`_. Follow the
instructions under `ProdatasetTotags </ome/wiki/ProdatasetTotags>`_.

You have now successfully updated from
`milestone:3.0-Beta2.3 </ome/milestone/3.0-Beta2.3>`_ to
`milestone:3.0-Beta3 </ome/milestone/3.0-Beta3>`_ and can restart your
*OMERO.server* instance as follows:

::

    $ export JBOSS_HOME=~/omero-Beta3.0/jboss-4.2.1.GA
    $ $JBOSS_HOME/bin/run.sh

    (To start OMERO.server in the background:
    ``$JBOSS_HOME/bin/run.sh > /dev/null 2>&1``)

3.0-Beta2.2 to 3.0-Beta2.3
--------------------------

Upgrading from `milestone:3.0-Beta2.2 </ome/milestone/3.0-Beta2.2>`_ to
`milestone:3.0-Beta2.3 </ome/milestone/3.0-Beta2.3>`_ is fairly simple
and only really entails the following:

-  Copy the ``etc/local.properties`` file from your existing
   *3.0-Beta2.2* installation directory to your new *3.0-Beta2.3*
   installation directory and re-deploy the *OMERO.server* EAR. This is
   similar to performing a *Reconfiguration* in the
   `OmeroInstall </ome/wiki/OmeroInstall>`_ documentation.

   ::

       $ cp ~/omero-3.0-Beta2.2/omero/etc/local.properties ~/omero-3.0-Beta2.3/omero/etc/local/properties
       $ cd ~/omero-3.0-Beta2.3/omero
       $ export JBOSS_HOME=~/omero-3.0-Beta2.3/jboss-4.2.1.GA
       $ java omero update deploy

-  **Perform a database backup**

   ::

       pg_dump -h <database_host> -U <db_username> -Fc -f <dump_filename> <db_name>

       ex. pg_dump -h localhost -U omero -Fc -f before_upgrade.db.dump omero3

**NOTE:** If you are upgrading from **3.0-Beta2.0** directly to
**3.0-Beta2.3** you should perform the *Update your database...* step
from the **3.0-Beta2.0 to 3.0-Beta2.2** documentation above before
starting your server.

You have now successfully updated from
`milestone:3.0-Beta2.2 </ome/milestone/3.0-Beta2.2>`_ to
`milestone:3.0-Beta2.3 </ome/milestone/3.0-Beta2.3>`_ and can restart
your *OMERO.server* instance as follows:

::

    $ export JBOSS_HOME=~/omero-3.0-Beta2.3/jboss-4.2.1.GA
    $ $JBOSS_HOME/bin/run.sh

    (To start OMERO.server in the background:
    ``$JBOSS_HOME/bin/run.sh > /dev/null 2>&1``)

3.0-Beta2 to 3.0-Beta2.2
------------------------

Upgrading from `milestone:3.0-Beta2 </ome/milestone/3.0-Beta2>`_ to
`milestone:3.0-Beta2.2 </ome/milestone/3.0-Beta2.2>`_ is fairly simple
and only really entails the following:

-  Copy the ``etc/local.properties`` file from your existing *3.0-Beta2*
   installation directory to your new *3.0-Beta2.2* installation
   directory and re-deploy the *OMERO.server* EAR. This is similar to
   performing a *Reconfiguration* in the
   `OmeroInstall </ome/wiki/OmeroInstall>`_ documentation.

   ::

       $ cp ~/omero-3.0-Beta2/omero/etc/local.properties ~/omero-3.0-Beta2.2/omero/etc/local.properties
       $ cd ~/omero-3.0-Beta2.2/omero
       $ export JBOSS_HOME=~/omero-3.0-Beta2.2/jboss-4.2.1.GA
       $ java omero update deploy

-  **Perform a database backup**

   ::

       pg_dump -h <database_host> -U <db_username> -Fc -f <dump_filename> <db_name>

       ex. pg_dump -h localhost -U omero -Fc -f before_upgrade.db.dump omero3

-  **Update your database from ``OMERO3__4`` to ``OMERO3__5``**.

    **NOTE:** You **must** use the same username and password you have
    defined in your ``etc/local.properties`` file in the
    ``hibernate.connection.username`` and
    ``hibernate.connection.password`` properties. This will also be the
    same as the database user you created as outlined in the
    *Pre-Installation* phase of the
    `OmeroInstall </ome/wiki/OmeroInstall>`_ documentation.

    ::

        $ cd ~/omero-3.0-Beta2.2/omero
        $ psql -h localhost -U omero omero3 < sql/psql/OMERO3__4__OMERO3__5.sql
        Password for user omero:
        BEGIN
        INSERT 0 1
        ALTER TABLE
        UPDATE 1
        COMMIT

You have now successfully updated from
`milestone:3.0-Beta2 </ome/milestone/3.0-Beta2>`_ to
`milestone:3.0-Beta2.2 </ome/milestone/3.0-Beta2.2>`_ and can restart
your *OMERO.server* instance as follows:

::

    $ export JBOSS_HOME=~/omero-3.0-Beta2.2/jboss-4.2.1.GA
    $ $JBOSS_HOME/bin/run.sh

    (To start OMERO.server in the background:
    ``$JBOSS_HOME/bin/run.sh > /dev/null 2>&1``)

Update Notification
-------------------

As of `milestone:3.0-Beta2.3 </ome/milestone/3.0-Beta2.3>`_, your
OMERO.server installation will check for updates each time it is started
from the *Open Microscopy Environment* update server. If you wish to
disable this functionality you should do so now as outlined on the
`UpgradeCheck </ome/wiki/UpgradeCheck>`_ page.

Troubleshooting
---------------

If you encounter errors during a OMERO upgrade, database upgrade, etc.
you should retain as much log information as possible and notify the
*OMERO.server* team via the mailing lists available on the
`OmeroCommunity </ome/wiki/OmeroCommunity>`_ page. More experienced
users may wish to examine the `DbUpgrade </ome/wiki/DbUpgrade>`_ page
for technical information about *OMERO.server* database upgrades and how
to troubleshoot errors themselves.

--------------

See also: `OmeroInstall </ome/wiki/OmeroInstall>`_,
`OmeroTroubleshooting </ome/wiki/OmeroTroubleshooting>`_,
`DbUpgrade </ome/wiki/DbUpgrade>`_,
`UpgradeCheck </ome/wiki/UpgradeCheck>`_

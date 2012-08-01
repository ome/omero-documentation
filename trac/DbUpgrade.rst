Deprecated Page

Database Upgrades
=================

When necessary and appropriate, the OMERO team provides database
upgrades which can be applied from the command line. These scripts are
found under `source:ome.git/sql/psql </ome/browser/ome.git/sql/psql>`_
followed by directories named after the current database version, which
can be found in
`source:ome.git/etc/omero.properties </ome/browser/ome.git/etc/omero.properties>`_
.

Upgrade scripts are not provided between all consecutive versions, since
intermediate versions are developer releases, and it is assumed that the
developers work from a fresh database.

All public releases are accompanied by an upgrade script if necessary.

Database version
----------------

The naming scheme is not linear but rather hierarchical to support
branching between various sites. The first part of name, the database
version is a string name like ``OMERO3`` or ``OMERO3A``. The second part
of any name is the patch level and is a simple counting integer.

The versions for a given OMERO release are defined in
OMERO\_HOME/etc/omero.properties:

::

    omero.version=3.0-TRUNK
    omero.dbversion=OMERO3
    omero.dbpatch=5

``omero.version`` describes the software version, and is further
unimportant for database upgrades. ``omero.dbversion`` and
``omero.dbpatch``, however, determine which version of the database the
OMERO server expects to find. During startup, they are tested against
the ``dbpatch`` table.

Dbpatch
-------

If the ``dbpatch`` table is not present, an ``InternalException`` will
be thrown with the following message:

::

    ***************************************************************************************
    Error connecting to database table dbpatch. You may need to bootstrap.
    See https://trac.openmicroscopy.org.uk/omero/wiki/DbUpgrade
    ***************************************************************************************

If all else is configured properly, this most likely is due to the use
of database created before r1547. If this is the case you will need to
use the ``OMERO3__5__bootstrap.sql`` script to create a ``dbpatch``
table in your database.

Otherwise, the latest values for the db version and db patch are
retrieved via:

::

    select currentversion, currentpatch from dbpatch order by id desc limit 1

and compared to the values in omero.properties. If there is a mismatch,
an ``InternalException`` will be thrown with the following message:

::

    ***************************************************************************************
    DB version (OMERO3__0) does not match omero.properties (OMERO3__5). Please apply a db upgrade.
    See https://trac.openmicroscopy.org.uk/omero/wiki/DbUpgrade
    ***************************************************************************************

which requires a db upgrade.

Upgrading
---------

Currently, there is no automatic way to upgrade a database. Rather, the
SQL scripts under OMERO\_HOME/sql/psql can be used to move from one
version to the next. For example, if you are on ``OMERO3__5`` and would
like to get to the ``OMERO3_7``, then you can use

then you can use:

::

    cat OMERO3__5__OMERO3__6.sql OMERO3__6__OMERO3__7.sql | psql DATABASENAME

to upgrade.

Full example
------------

::

    $ psql omero3
    omero3=#  select currentversion||'__'||currentpatch from dbpatch order by id desc limit 1;
     ?column?  
    -----------
     OMERO3__5
    (1 row)

    $ cd $OMERO_HOME
    $ grep omero.db etc/omero.properties 
    omero.dbversion=OMERO3
    omero.dbpatch=5

    $ cd sql/psql
    $ cat OMERO3__5__OMERO3__6.sql OMERO3__6__OMERO3__7.sql | psql omero3

--------------

See also: `OmeroUpgrade </ome/wiki/OmeroUpgrade>`_

.. _rst_db-upgrade-41-to-42:

Database Upgrade: -41-to-42
===========================

Background
----------

In OMERO 4.2, we have exposed the User-Group features of OMERO to
support data sharing between users in the same group. Group permissions
determine the level of data sharing between users in the same group, as
described on the `permissions <permissions>`_ page.

This means that all data objects that are linked in the OMERO database
must be in the same group (can't link between data in different groups).
For example, all Projects, Datasets and Images that are linked must be
in the same group. This rule was not well enforced in OMERO 4.1,
although most users are unlikely to have problems.

The 4.1 clients did not allow users to change between groups, so it is
unlikely that users will have created data in 2 or more groups and
linked that data between groups. This would only be possible if the
server administrator has changed the default group that the user logs in
to.

It is also possible that databases created **before** OMERO 4.0 (March
2009) will have data that is linked between different groups.

Upgrade to 4.2
--------------

The 4.1 to 4.2 upgrade procedure described on the `upgrade <upgrade>`_
page, explains how to attempt the upgrade and what you will see if any
data is found to be linked between different groups.

For example:

::

    $ pwd
    /Users/omero/Desktop/OMERO.server-Beta-4.2.0/sql/psql/OMERO4.2__0
    $ psql -v ON_ERROR_STOP=1 --pset pager=off -h localhost -U omero -f OMERO4.1__0.sql  omero
    ...
    psql:OMERO4.1__0.sql:542: ERROR: 
    ...
    Different groups: Image(id=195, group=2, owner=2, perms=rw----) <--> DatasetImageLink.child(id=210, group=4, owner=2, perms=rw----)
    Different groups: Project(id=1, group=2, owner=2, perms=rw----) <--> ProjectDatasetLink.parent(id=5, group=4, owner=2, perms=rw----)
    Different groups: Project(id=1, group=2, owner=2, perms=rw----) <--> ProjectDatasetLink.parent(id=6, group=4, owner=2, perms=rw----)
    Different groups: Pixels(id=319, group=2, owner=2, perms=rw----) <--> Pixels.relatedTo(id=331, group=4, owner=2, perms=rw----)
    Different groups: ObjectiveSettings(id=132, group=2, owner=2, perms=rw----) <--> Image.objectiveSettings(id=331, group=4, owner=2, perms=rw----)
    Different groups: Instrument(id=143, group=2, owner=2, perms=rw----) <--> Image.instrument(id=331, group=4, owner=2, perms=rw----)
    Different groups: LogicalChannel(id=553, group=2, owner=2, perms=rw----) <--> Channel.logicalChannel(id=838, group=4, owner=2, perms=rw----)
    Different groups: LogicalChannel(id=554, group=2, owner=2, perms=rw----) <--> Channel.logicalChannel(id=839, group=4, owner=2, perms=rw----)
    Different groups: LogicalChannel(id=555, group=2, owner=2, perms=rw----) <--> Channel.logicalChannel(id=840, group=4, owner=2, perms=rw----)

We have considered a number of ways that administrators might want to
resolve these problems and have prepared database scripts accordingly.
For example,
`omero-4.1-move-to-group.sql <http://git.openmicroscopy.org/src/4_2/sql/psql/OMERO4.2__0/omero-4.1-move-to-group.sql>`_
which is in the `sql/psql/OMERO4.2\_\_0
directory <http://git.openmicroscopy.org/src/4_2/sql/psql/OMERO4.2__0/>`_
(read the sql file for usage instructions).

However, we strongly advise that you send us any error messages like the
one above, so that we can discuss how you would like to fix the problem
according to your requirements or permissions policy. We can also check
that you use an upgrade script that will work for your database.
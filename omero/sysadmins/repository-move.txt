Moving the data repository
==========================

It may be necessary to move either the whole OMERO data directory or only the
Managed Repository to a new location on the file system. This should be done
with care following the steps below.

.. warning::
    Before moving OMERO data it is wise to ensure that both the data and the
    database are fully backed up. See :doc:`server-backup-and-restore`.

The current location of the data repositories can be found using the
:omerocmd:`fs repos` command:

::

    $ bin/omero fs repos

     # | Id | UUID                                 | Type    | Path
    ---+----+--------------------------------------+---------+-----------------------------------------
     0 | 1  | 309ea513-a23c-48d1-abd2-9ceed1b3ffa4 | Managed | /Users/omero/var/omero/ManagedRepository
     1 | 2  | ScriptRepo                           | Script  | /Users/omero/dist/lib/scripts
     2 | 3  | 3ec8c878-c776-48a3-b57e-2a11b0c97045 | Public  | /Users/omero/var/omero
    (3 rows)

.. note::
    This command can be slow, :omerocmd:`config get` can also be used to
    determine if :property:`omero.data.dir` or :property:`omero.managed.dir`
    have non-default values.

Moving the OMERO data directory
-------------------------------

If the Managed Repository is within the OMERO data directory and the whole
data directory is to be moved then the following steps should be used:

::

    bin/omero admin stop
    bin/omero config set omero.data.dir NEW
    mv OLD NEW
    bin/omero admin start

.. warning::
    The use of :omerocmd:`config set` is absolutely necessary here. The steps:
    :omerocmd:`admin stop`, ``mv``, :omerocmd:`admin start` without
    :omerocmd:`config set` could lead to an unstable situation.

For example, moving the OMERO data directory from ``/Users/omero/var/omero``
to ``/Volumes/omero``:

::

    $ bin/omero admin stop
    ...
    $ bin/omero config set omero.data.dir /Volumes/omero
    $ mv /Users/omero/var/omero /Volumes/omero
    $ bin/omero admin start
    ...
    $ bin/omero fs repos

     # | Id | UUID                                 | Type    | Path
    ---+----+--------------------------------------+---------+---------------------------------
     0 | 1  | 309ea513-a23c-48d1-abd2-9ceed1b3ffa4 | Managed | /Volumes/omero/ManagedRepository
     1 | 2  | ScriptRepo                           | Script  | /Users/omero/dist/lib/scripts
     2 | 3  | 3ec8c878-c776-48a3-b57e-2a11b0c97045 | Public  | /Volumes/omero
    (3 rows)

Moving the Managed Repository
-----------------------------

If the Managed Repository is in a separate location from the OMERO data
directory or only the Managed Repository is to be moved then the following
steps should be used:

::

    bin/omero admin stop
    bin/omero config set omero.managed.dir NEW
    mv OLD NEW
    bin/omero admin start

.. warning::
    The use of :omerocmd:`config set` is absolutely necessary here. The steps:
    :omerocmd:`admin stop`, ``mv``, :omerocmd:`admin start` without
    :omerocmd:`config set` could lead to an unstable situation.

For example, moving the Managed Repository from ``/Users/omero/var/omero/ManagedRepository``
to ``/Volumes/imports/ManagedRepository``:

::

    $ bin/omero admin stop
    ...
    $ bin/omero config set omero.managed.dir /Volumes/imports/ManagedRepository
    $ mv /Users/omero/var/omero/ManagedRepository /Volumes/imports/ManagedRepository
    $ bin/omero admin start
    ...
    $ bin/omero fs repos

     # | Id | UUID                                 | Type    | Path
    ---+----+--------------------------------------+---------+-----------------------------------
     0 | 1  | 309ea513-a23c-48d1-abd2-9ceed1b3ffa4 | Managed | /Volumes/imports/ManagedRepository
     1 | 2  | ScriptRepo                           | Script  | /Users/omero/dist/lib/scripts
     2 | 3  | 3ec8c878-c776-48a3-b57e-2a11b0c97045 | Public  | /Users/omero/var/omero
    (3 rows)

.. note::
    If :property:`omero.managed.dir` is not set then the location of the
    Managed Repository will be determined by :property:`omero.data.dir` and
    the OMERO directory should only be moved as a whole.

    If the Managed Repository needs to be moved to a location other than that
    set by :property:`omero.data.dir`, to a location outside of the OMERO data
    directory, for example, then :property:`omero.managed.dir` must be set.

    If :property:`omero.managed.dir` is set then the Managed Repository and
    the OMERO data directory should be treated independently and thus be moved
    separately if necessary.

Extending the Managed Repository
--------------------------------

It is possible to leave the Managed Repository in place yet have newly
imported image files stored on a different underlying storage volume.
For example, if your :property:`omero.managed.dir` is set to
:file:`/mnt/omero/ManagedRepository` then, as that volume fills, it
would become better for new imports to be stored elsewhere. An OMERO
administrator may use the :omerocmd:`fs mkdir` subcommand to properly
set up a subdirectory for that new volume in the existing Managed
Repository:
::

    bin/omero fs mkdir volume-B

This is the correct way to create
:file:`/mnt/omero/ManagedRepository/volume-B` ready for new imports.
The new storage volume may then be mounted at that mount point.
Alternatively, if the volume is already mounted elsewhere, such as
:file:`/mnt/omero/large-volume-B/`, then while the OMERO server is shut
down you may create a corresponding symbolic link at
:file:`/mnt/omero/ManagedRepository/volume-B`:

::

    rmdir /mnt/omero/ManagedRepository/volume-B
    ln -s /mnt/omero/large-volume-B /mnt/omero/ManagedRepository/volume-B

In either case the :property:`omero.fs.repo.path` must be updated in the server
configuration. An example of adjusting its usual default value is:
::

    bin/omero config set omero.fs.repo.path 'volume-B/%user%_%userId%//%year%-%month%/%day%/%time%'

After the OMERO server is started then new imports should upload onto
the new storage volume. At a later date further storage volumes may be
added by using this same workflow.

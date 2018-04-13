Clustering
==========

Clustering an OMERO instance consists of starting multiple
:doc:`/developers/server-blitz` servers with each allocating user
sessions based on some criteria. There are at least two reasons you may
want to cluster the OMERO server: availability and throughput.

Availability
------------

Having the ability to have two servers up at the same time implies that
even if you have to restart one of the servers, there should be no
downtime. Currently, |OmeroSessions| are sticky to a cluster node so it
is not possible to shut down a node at any time. However, all new
sessions can be redirected to the server that is to be left turned on.
When all active sessions have completed, the chosen server can be shut
down.

Throughput
----------

The other main reason to have other servers running is to service more
user sessions simultaneously. When dealing with memory-intensive
operations like rendering, each added server can make a positive
difference. This is only a part of the story, since much of the
bottleneck is not the server itself but other shared resources, like the
database or the filesystem. To further extend throughput you will need
to parallelize these.

Installation
------------

If you are using the default |OmeroGrid|
:source:`application descriptor <etc/templates/grid/default.xml>`
then quickly enabling clustering is as simple as executing:

::

     bin/omero config set omero.cluster.redirector configRedirector
     bin/omero node backup start

This starts a second node, named "backup", which contains a second
:doc:`/developers/server-blitz` server, "Blitz-1". By default, this
newly created server will not be used until sessions are manually
redirected to it.

.. seealso:: :doc:`/developers/Server/ScalingOmero`

Read-Only
---------

A read-only server disallows many operations while still permitting
users to log in and retrieve data. Prohibitions for users of read-only
servers include that they may not import data or run scripts. Two
properties control read-only configuration:
:property:`omero.cluster.read_only.db` for the database and
:property:`omero.cluster.read_only.repo` for the binary repository.

Read-only access to the database assumes that ``INSERT`` and ``UPDATE``
commands cannot be used over a JDBC connection. Read-only access to the
binary repository assumes that filesystem changes cannot be made within
any of the standard OMERO directories. In all cases OMERO's
:doc:`../Modules/TempFileManager` expects write access to the volatile
storage location that :envvar:`OMERO_TMPDIR` can be used to configure.

For each of these configuration properties the server assumes read-write
access by default or with a ``false`` setting. Set a property to
``true`` to have the server treat the corresponding resource as being
read-only. Additionally, without a ``true`` setting the server may log a
warning and regard a resource as being in read-only mode if it discovers
that it does not have write access. The currently effective values are
provided by the :javadoc:`configuration service
<slice2html/omero/api/IConfig.html>` as
:property:`omero.cluster.read_only.runtime.db` and
:property:`omero.cluster.read_only.runtime.repo`.

Setting :property:`omero.pixeldata.memoizer.dir.local` to a read-write
directory allows a read-only server to create and use the Bio-Formats
memo files that cache reader state. The server still checks the default
:file:`BioFormatsCache/` directory in the read-only binary repository
for existing memo files that it can copy to this local directory.

::

       $ bin/omero config set omero.cluster.read_only.db true
       $ bin/omero config set omero.cluster.read_only.repo true
       $ bin/omero config set omero.pixeldata.memoizer.dir.local /tmp/BioFormatsCache

.. note::

    If the deprecated configuration property
    :property:`omero.cluster.read_only` is set to ``true`` then the
    server behaves as if all ``omero.cluster.read_only.*`` properties
    were set to ``true`` regardless of any other value that they have.

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
downtime. Currently, |OmeroSessions| are
sticky to a cluster node so it is not possible to shut down a node at any
time. However, all new sessions can be redirected to the server that is to
be left turned on. When all active sessions have completed, the
chosen server can be shut down.

Throughput
----------

The other main reason to have other servers running is to service more
user sessions simultaneously. When dealing with memory-intensive
operations like rendering, each added server can make a positive
difference. This is only a part of the story, since much of the
bottleneck is not the server itself but other shared resources, like the
database or the filesystem. To further extend throughput you
will need to parallelize these.

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

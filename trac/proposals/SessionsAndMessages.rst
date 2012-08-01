Deprecated Page

Session Management and Dynamic Message Registration
===================================================

**Josh Moore, April/2007**

Current situation
-----------------

Via Spring's ``ApplicationContext.publishEvent()``
(`#643 </ome/ticket/643>`_) it is currently possible to send internal
messages within the server.

There are some serious limitations to this:

-  synchronous
-  no dynamic registering of listeners

OMERO.bus
---------

    mule

    if we included better session management, this becomes quite useful.

Sessions
--------

Benefits:

-  Reduced db usage on IO queries (better performance!)

--------------

-  Should review issues related to `#326 </ome/ticket/326>`_ once
   sessions are implemented

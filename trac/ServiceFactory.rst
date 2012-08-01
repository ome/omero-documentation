Deprecated Page

Starting location for access to all `OmeroApi </ome/wiki/OmeroApi>`_
services. When working with JBoss over RMI, the
`ServiceFactory </ome/wiki/ServiceFactory>`_ is a client-side object:

::

       ome.system.ServiceFactory sf = new ome.system.ServiceFactory();
       sf = new ServiceFactory(new ome.system.Login("user","password"));
       sf = new ServiceFactory(new ome.system.Server("localhost"));
       // etc.

As of `milestone:3.0-Beta3 </ome/milestone/3.0-Beta3>`_, the
`ServiceFactory </ome/wiki/ServiceFactory>`_ also interacts with the
`OmeroSessions </ome/wiki/OmeroSessions>`_ API, and transparently
creates a session for you to preserve backwards compatibility.

When working with `OmeroBlitz </ome/wiki/OmeroBlitz>`_, the
`ServiceFactory </ome/wiki/ServiceFactory>`_ is created on the server,
and a proxy is returned to the client.

::

       import omero
       c = omero.client()
       sf = c.createSession("username", "password");

--------------

See also:

-  RMI Implementation :
   `source:ome.git/components/common/src/ome/system/ServiceFactory.java </ome/browser/ome.git/components/common/src/ome/system/ServiceFactory.java>`_
-  Ice Definition :
   `source:ome.git/components/blitz/resources/omero/API.ice </ome/browser/ome.git/components/blitz/resources/omero/API.ice>`_
-  Ice Implementation :
   `source:ome.git/components/blitz/src/ome/services/blitz/impl/ServiceFactoryI.java </ome/browser/ome.git/components/blitz/src/ome/services/blitz/impl/ServiceFactoryI.java>`_

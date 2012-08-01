OmeroContext
============

The entire OMERO application (on a single JVM) resides in a single
ome.system.\ `OmeroContext </ome/wiki/OmeroContext>`_. Each call belongs
additionally to a single org.hibernate.Session (which can span over
multiple calls) and to a single ome.model.meta.Event (which is
restricted to a single task).


The container for all Omero applications is the
`OmeroContext </ome/wiki/OmeroContext>`_
(`source:ome.git/components/common/src/ome/system/OmeroContext.java </ome/browser/ome.git/components/common/src/ome/system/OmeroContext.java>`_).
Based on the ` Spring <http://www.springframework.org>`_ configuration
backing the context, it can be one of : ``client``, ``internal``, or
``managed``. The use of a
`ServiceFactory </ome/wiki/ServiceFactory>`_\ (` code <http://cvs.openmicroscopy.org.uk/svn/omero/trunk/components/client/src/ome/client/ServiceFactory.javasource>`_)
simplifies this usage for the client. See
`OmeroClientLibrary </ome/wiki/OmeroClientLibrary>`_ for more
information.

Hibernate Sessions
------------------

A ``Hibernate Session`` comprises a
` Unit-of-Work <http://www.martinfowler.com/eaaCatalog/unitOfWork.html>`_
which translates for OMERO's `ObjectModel </ome/wiki/ObjectModel>`_ to a
relational database. It keeps references to all DB-backed objects so
that within a single session object-identity stays constant and objects
changes can be persisted.

A session can span multiple calls by being disconnected from the
underlying database transaction and, then, reconnected to a new
transaction on the next call (See
`source:ome.git/components/server/src/ome/tools/hibernate/SessionHandler.java </ome/browser/ome.git/components/server/src/ome/tools/hibernate/SessionHandler.java>`_
for the implementation).

! Event

For more information about Events see
`OmeroEvents </ome/wiki/OmeroEvents>`_.

`|image1| </ome/attachment/wiki/OmeroContext/contexts.png>`_

Attachments
~~~~~~~~~~~

-  `contexts.png </ome/attachment/wiki/OmeroContext/contexts.png>`_
   `|Download| </ome/raw-attachment/wiki/OmeroContext/contexts.png>`_
   (89.4 KB) - added by *jmoore* `4
   years </ome/timeline?from=2008-09-15T16%3A35%3A39%2B01%3A00&precision=second>`_
   ago.

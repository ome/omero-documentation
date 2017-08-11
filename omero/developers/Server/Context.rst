OmeroContext
============

The entire OMERO application (on a single JVM) resides in a single
ome.system.OmeroContext. Each call belongs
additionally to a single org.hibernate.Session (which can span over
multiple calls) and to a single ome.model.meta.Event (which is
restricted to a single task).


The container for all OMERO applications is the
:doc:`/developers/Server/Context`
(:source:`components/common/src/ome/system/OmeroContext.java`).
Based on the Spring_ configuration backing the context, it can be one of
``client``, ``internal``, or ``managed``. The use of a ServiceFactory
simplifies this usage for the client. 

Hibernate sessions
------------------

A ``Hibernate Session`` comprises a
` Unit-of-Work <http://www.martinfowler.com/eaaCatalog/unitOfWork.html>`_
which translates for OMERO's |OmeroModel| model to a
relational database. It keeps references to all Database-backed objects so
that within a single session, object-identity stays constant and object
changes can be persisted.

A session can span multiple calls by being disconnected from the
underlying database transaction, and then reconnected to a new
transaction on the next call (see
:source:`components/server/src/ome/tools/hibernate/SessionHandler.java`
for the implementation).



For information about Events see :doc:`/developers/Server/Events`.

.. figure:: /images/contexts.png
    :align: center
    :alt: Context Usage

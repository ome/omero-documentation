.. _developers/Omero/Modules/Api:

OMERO Application Programming Interface
=======================================

.. contents::

All interaction with the OMERO server takes place via several API
services available from a `ServiceFactory </ome/wiki/ServiceFactory>`_.
A service factory is obtained from the client connection. E.g. Python:

::

    client = omero.client("localhost")
    session = client.createSession("username", "password")   # this is the service factory
    adminService = session.getAdminService()                 # now we can get/create services

-  The :javadoc:` Service factory API <slice2html/omero/api/ServiceFactory.html#ServiceFactory>`
   has methods for creating Stateless and Stateful services (see below).

   -  Stateless services are obtained using "get..." methods E.g.
      getQueryService()
   -  Stateful services are obtained using "create..." methods E.g.
      createRenderingEngine()

-  Services will provide access to omero.model.objects. You will then
   need the :javadoc:`API for these objects <slice2html/omero/model.html>`.
   E.g. Dataset, Image, Pixels etc.

Services List
-------------

The :source:`ome.api <components/common/src/ome/api>`
package in the common component defines the central "verbs" of the Omero
system. All external interactions with the system should happen with
these verbs, or services. Each OMERO service belongs to a particular
service level with each level calling only on services from lower
levels.

Service Level 1 (direct DB and hibernate connections)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  AdminService:
   :source:`src <components/common/src/ome/api/IAdmin.java>`,
   :javadoc:`API <slice2html/omero/api/IAdmin.html#IAdmin>`
   for working with Experimenters, Groups and the current Context
   (switching groups etc).
-  ConfigService:
   :source:` src <components/common/src/ome/api/IConfig.java>`,
   :javadoc:`API <slice2html/omero/api/IConfig.html#IConfig>`
   for getting and setting config parameters.
-  ContainerService:
   :javadoc:`API <slice2html/omero/api/IContainer.html>`
   for loading Project, Dataset and Image hierarchies.
-  DeleteService:
   :javadoc:`API <slice2html/omero/api/IDelete.html>`
   for deleting objects asynchronously (delete queue).
-  MetadataService:
   :javadoc:`API <slice2html/omero/api/IMetadata.html>`
   for working with Annotations.
-  PixelsService:
   :javadoc:`API <slice2html/omero/api/IPixels.html>`
   for pixels stats and creating Images with existing or new Pixels.
-  ProjectionService
   :javadoc:`API <slice2html/omero/api/IProjection.html>`
-  QueryService:
   :source:`src <components/common/src/ome/api/IQuery.java>`,
   :javadoc:`API <ome/api/IQuery.html>`
   for custom SQL-like queries.
-  RenderingSettingsService
   :javadoc:`API <slice2html/omero/api/IRenderingSettings.html>`
   for copying, pasting & resetting rendering settings.
-  RepositoryInfo
   :javadoc:`API <slice2html/omero/api/IRepositoryInfo.html>`
   disk space stats.
-  RoiService
   :javadoc:`API <slice2html/omero/api/IRoi.html>`
   working with ROIs.
-  ScriptService
   :javadoc:`API <slice2html/omero/api/IScript.html>`
   for uploading and launching Python scripts.
-  SessionService
   :javadoc:`API <slice2html/omero/api/ISession.html>`
   for creating and working with OMERO sessions.
-  ShareService
   :javadoc:`API <slice2html/omero/api/IShare.html>`
-  TimelineService
   :javadoc:`API <slice2html/omero/api/ITimeline.html>`
   for queries based on time.
-  TypesService
   :javadoc:`API <slice2html/omero/api/ITypes.html>`
   for Enumerations.
-  UpdateService:
   :source:`src <components/common/src/ome/api/IUpdate.java>`,
   :javadoc:`API <ome/api/IUpdate.html>`
   for saving and deleting omero.model objects.

Service Level 2
~~~~~~~~~~~~~~~

-  :source:` IPojos <components/common/src/ome/api/IPojos.java>`
-  :source:` ITypes <components/common/src/ome/api/ITypes.java>`

Stateful/Binary? Services
~~~~~~~~~~~~~~~~~~~~~~~~~

-  RawFileStore:
   :source:`src <components/common/src/ome/api/RawFileStore.java>`,
   :javadoc:`API <ome/api/RawFileStore.html>`
-  RawPixelsStore:
   :source:` src <components/common/src/ome/api/RawPixelsStore.java>`,
   :javadoc:` API <ome/api/RawPixelsStore.html>`
-  RenderingEngine:
   :source:` src <components/common/src/omeis/providers/re/RenderingEngine.java>`,
   :javadoc:` API <slice2html/omero/api/RenderingEngine.html#RenderingEngine>`
   (see `RenderingEngine </ome/wiki/RenderingEngine>`_ for more)
-  ThumbnailStore:
   :source:` src <components/common/src/ome/api/Thumbnail.store>`,
   :javadoc:` API <ome/api/ThumbnailStore.html>`
-  :source:` IScale <components/common/src/ome/api/IScale.java>`

A complete list of service APIs can be found :javadoc:` here <slice2html/omero/api.html>`
and some examples of `API use in
Python </ome/wiki/PythonClientCodeExamples>`_ are provided. Java or C++
code can use the same API in a very similar manner.

Discussion
----------

Reads and Writes
~~~~~~~~~~~~~~~~

IQuery and IUpdate are the basic building blocks for the rest of the
(non-binary) API. IQuery is based on QuerySources? and QueryParemeters?
which are explained under ((Omero Queries\|Queries)). The goal of this
design is to make wildly separate definitions of queries (templates,
db-stored , Java code, C# code, ...) runnable on the server.

IUpdate takes any graph composed of
:source:`IObject <components/common/src/ome/model/IObject.java>`
objects and checks them for dirtiness. All changes to the graph are
stored in the database if the user calling IUpdate has the proper
permissions, otherwise an exception is thrown.

Dirty checks follow the Three Commandments:

#. Any IObject-valued field with unloaded set to true is treated as a
   place holder (proxy) and is re-loaded from the DB.
#. Any collection-valued field with a null value is re-loaded from the
   DB.
#. Any collection-valued field with the FILTERED flag is assumed to be
   dirty and is loaded from the DB, with the future option of examing
   the filtered collection for any new and updated values and applying
   them to the real collection. (Deletions cannot happen this way since
   it would be unclear if the object was filtered or deleted.)

Administation
~~~~~~~~~~~~~

The :source:`IAdmin <components/common/src/ome/api/IAdmin.java>`
interface defines all the actions necessary to administer the `security
system </ome/wiki/OmeroSecurity>`_ . It is explained further on the
`AdminInterface </ome/wiki/AdminInterface>`_ page.

Pojos
~~~~~

Certain operations, like those deailing with data management and
viewing, happen more frequently than others (like defining microscopes).
Those have been collected in the
:source:`IPojos <components/common/src/ome/api/IPojos.java>`
interface. IPojos simplify a few very common queries, and there is a
related package ("pojos.\*") for working with the returned graphs. The
`Java Client </ome/wiki/OmeroInsight>`_ works almost exclusively with
the IPojos interface for its non-binary needs.

Examples
--------

::

    // Saving a simple change
    Dataset d = iQuery.get( Dataset.class,1L );
    d.setName( "test" );
    iUpdate.saveObject( d );

    // Creating a new object
    Dataset d = new Dataset();
    d.setName( "test" ); // not-null fields must be filled in
    iUpdate.saveObject( d );

    // Retrieving a graph
    Set<Dataset> ds = iQuery.findAllByQuery( "from Dataset d left outer join d.images where d.name = 'test'",null );

Other topics
============

Stateless versus Stateful Services
----------------------------------

A stateless service has no client-noticeable lifecycle and all instances
can be treated equally. A new stateful service, on the other hand, will
be created for each client-side proxy (see the
`ServiceFactory.create\* </ome/wiki/ServiceFactory>`_ methods). Once
obtained, a stateful service proxy can only be used by a single user.
After task completion, the service should be closed (proxy.close()) to
free up server resources.

How to write a service
----------------------

A tutorial is available on to write a service at
wiki/HowToCreateAService. In general, if a properly annotated service is
placed in any JAR of the OMERO EAR file (see
:ref:`developers/Omero/Build` for more) then the service will be
deployed to the server. In the case of
`OmeroBlitz </ome/wiki/OmeroBlitz>`_, the service must be properly
defined under :source:`components/blitz/resources`.

Omero Annotations for Validation
--------------------------------

The server-side implementation of these interfaces makes use of ((JDK5))
((Omero Annotations)) and an ((Omero AOP\|AOP)) interceptor to validate
all method parameters. Calls to pojos.findContainerHierarches are first
caught by a method interceptor, which checks for annotations on the
parameters and, if available, performs the necessary checks. The
interceptor also makes proactive checks. For a range of parameters types
(such as Java Collections) it requires that annotations exist and will
refuse to proceed if not implemented.

An api call of the form:

::

        pojos.findContainerHierarches(Class,Set,Map)

is implemented as

::

         pojos.findContainerHierarchies(@NotNull Class, @NotNull @Validate(Integer.class) Set, Map)

--------------

See also: `OmeroQueries </ome/wiki/OmeroQueries>`_ \| PixelService? \|
`RenderingEngine </ome/wiki/RenderingEngine>`_ \|
`ExceptionHandling </ome/wiki/ExceptionHandling>`_

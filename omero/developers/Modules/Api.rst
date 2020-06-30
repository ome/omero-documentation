OMERO Application Programming Interface
=======================================

All interaction with the OMERO server takes place via several API services
available from a ServiceFactory. A service factory is obtained from the client
connection e.g. Python:

::

    import omero.clients

    client = omero.client("localhost")
    session = client.createSession("username", "password")   # this is the service factory
    adminService = session.getAdminService()                 # now we can get/create services

-  The :slicedoc_blitz:`Service factory API <omero/api/ServiceFactory.html>`
   has methods for creating Stateless and Stateful services, see below.

   -  Stateless services are obtained using "getXXX" methods e.g.
      ``getQueryService()``
   -  Stateful services are obtained using "createXXX" methods e.g.
      ``createRenderingEngine()``

-  Services will provide access to omero.model.objects. You will then
   need the :slicedoc_blitz:`API for these objects <omero/model.html>`,
   e.g. Dataset, Image, Pixels, etc.

-  Some services or their operations may be marked as being deprecated.
   You may use them but do seek :community:`developer support <>` if you
   rely on them and can find no alternative as the deprecation means
   that *you are at risk of our removing them with no further notice*.

Services list
-------------

The :common_sourcedir:`ome.api <src/main/java/ome/api>` package in the common
component defines the central "verbs" of the OMERO system. All external
interactions with the system should happen with these verbs, or services. Each
OMERO service belongs to a particular service level with each level calling
only on services from lower levels.

Service Level 1 (direct database and Hibernate connections)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  AdminService:
   :common_source:`src <src/main/java/ome/api/IAdmin.java>`,
   :slicedoc_blitz:`API <omero/api/IAdmin.html>`
   for working with Experimenters, Groups and the current Context
   (switching groups etc.).
-  ConfigService:
   :common_source:`src <src/main/java/ome/api/IConfig.java>`,
   :slicedoc_blitz:`API <omero/api/IConfig.html>`
   for getting and setting config parameters.
-  ContainerService:
   :slicedoc_blitz:`API <omero/api/IContainer.html>`
   for loading Project, Dataset, Image, Screen, Plate hierarchies.
-  LdapService:
   :common_source:`src <src/main/java/ome/api/ILdap.java>`,
   :slicedoc_blitz:`API <omero/api/ILdap.html>`
   for communicating with LDAP servers.
-  MetadataService:
   :slicedoc_blitz:`API <omero/api/IMetadata.html>`
   for working with Annotation and retrieving acquisition metadata e.g. instrument.
-  PixelsService:
   :slicedoc_blitz:`API <omero/api/IPixels.html>`
   for pixels stats and creating Images with existing or new Pixels.
-  ProjectionService
   :slicedoc_blitz:`API <omero/api/IProjection.html>`
   for performing projections of Pixels sets.
-  QueryService:
   :common_source:`src <src/main/java/ome/api/IQuery.java>`,
   :slicedoc_blitz:`API <omero/api/IQuery.html>`
   for custom SQL-like queries.
-  RenderingSettingsService
   :slicedoc_blitz:`API <omero/api/IRenderingSettings.html>`
   for copying, pasting & resetting rendering settings.
-  RepositoryInfo
   :slicedoc_blitz:`API <omero/api/IRepositoryInfo.html>`
   disk space stats.
-  RoiService
   :slicedoc_blitz:`API <omero/api/IRoi.html>`
   working with ROIs (now deprecated).
-  ScriptService
   :slicedoc_blitz:`API <omero/api/IScript.html>`
   for uploading and launching Python scripts.
-  SessionService
   :slicedoc_blitz:`API <omero/api/ISession.html>`
   for creating and working with OMERO sessions.
-  ShareService
   :slicedoc_blitz:`API <omero/api/IShare.html>` (now deprecated).
-  TimelineService
   :slicedoc_blitz:`API <omero/api/ITimeline.html>`
   for queries based on time.
-  TypesService
   :slicedoc_blitz:`API <omero/api/ITypes.html>`
   for Enumerations.
-  UpdateService:
   :common_source:`src <src/main/java/ome/api/IUpdate.java>`,
   :slicedoc_blitz:`API <omero/api/IUpdate.html>`
   for saving and editing omero.model objects.

Service Level 2
^^^^^^^^^^^^^^^

-  :common_source:`IContainer <src/main/java/ome/api/IContainer.java>`
-  :common_source:`ITypes <src/main/java/ome/api/ITypes.java>`

Stateful/Binary Services
^^^^^^^^^^^^^^^^^^^^^^^^

-  RawFileStore:
   :common_source:`src <src/main/java/ome/api/RawFileStore.java>`,
   :slicedoc_blitz:`API <omero/api/RawFileStore.html>` for reading and writing files
-  RawPixelsStore:
   :common_source:`src <src/main/java/ome/api/RawPixelsStore.java>`,
   :slicedoc_blitz:`API <omero/api/RawPixelsStore.html>` for reading and writing pixels data
-  RenderingEngine:
   :common_source:`src <src/main/java/omeis/providers/re/RenderingEngine.java>`,
   :slicedoc_blitz:`API <omero/api/RenderingEngine.html>` for viewing images,
   see :doc:`/developers/Server/RenderingEngine` for more details
-  ThumbnailStore:
   :common_source:`src <src/main/java/ome/api/ThumbnailStore.java>`,
   :slicedoc_blitz:`API <omero/api/ThumbnailStore.html>` for retrieving thumbnails
-  :common_source:`IScale <src/main/java/ome/api/IScale.java>` for scaling rendered images

A complete list of service APIs can be found
:slicedoc_blitz:`here <omero/api.html>` and some examples of API usage in
Python are provided. Java or C++ code can use the same API in a very similar
manner.

Discussion
----------

Reads and writes
^^^^^^^^^^^^^^^^

IQuery and IUpdate are the basic building blocks for the rest of the
(non-binary) API. IQuery is based on QuerySources and QueryParemeters
which are explained under :doc:`/developers/Server/Queries`. The goal of this
design is to make wildly separate definitions of queries (templates,
db-stored, Java code, C# code, …) runnable on the server.

IUpdate takes any graph composed of
:model_source:`IObject <src/main/java/ome/model/IObject.java>`
objects and checks them for dirtiness. All changes to the graph are
stored in the database if the user calling IUpdate has the proper
permissions, otherwise an exception is thrown.

Dirty checks follow the Three Commandments:

#. Any IObject-valued field with unloaded set to true is treated as a proxy
   and is reloaded from the database.
#. Any collection-valued field with a null value is re-loaded from the
   database.
#. Any collection-valued field with the FILTERED flag is assumed to be
   dirty and is loaded from the database, with the future option of
   examining the filtered collection for any new and updated values and
   applying them to the real collection. Deletions cannot happen
   this way since it would be unclear if the object was filtered or 
   deleted.

Administration
^^^^^^^^^^^^^^

The :common_source:`IAdmin <src/main/java/ome/api/IAdmin.java>` interface
defines all the actions necessary to administer the
:doc:`/sysadmins/server-security`. It is explained further on the
:doc:`/developers/Modules/Api/AdminInterface` page.

Model Object Java
^^^^^^^^^^^^^^^^^

Certain operations, like those dealing with data management and viewing,
happen more frequently than others e.g. defining microscopes. Those have
been collected in the 
:common_source:`IContainer <src/main/java/ome/api/IContainer.java>`
interface. IContainer simplifies a few very common queries, and there is a
related package ``omero.gateway.model.\*`` for working with the returned graphs.
OMERO.insight works almost exclusively with the IContainer interface mostly 
indirectly via the :ref:`javagateway`.

Examples
--------

::

    // Saving a simple change
    Dataset d = iQuery.get(Dataset.class, 1L);
    d.setName("test");
    iUpdate.saveObject(d);

    // Creating a new object
    Dataset d = new Dataset();
    d.setName("test"); // not-null fields must be filled in
    iUpdate.saveObject(d);

    // Retrieving a graph
    Set<Dataset> ds = iQuery.findAllByQuery("from Dataset d left outer join d.images where d.name = 'test'", null);

Stateless versus stateful services
----------------------------------

A stateless service has no client-noticeable lifecycle and all instances can
be treated equally. A new stateful service, on the other hand, will be created
for each client-side proxy, see the ``ServiceFactory.createXXX`` methods. Once
obtained, a stateful service proxy can only be used by a single user. After
task completion, the service should be closed i.e. ``proxy.close()`` to free up
server resources.

How to write a service
----------------------

A tutorial is available at :doc:`/developers/Server/HowToCreateAService`.
See :doc:`/developers/build-system` for more information
on how the annotated service will be deployed.
In the case of :doc:`/developers/server-blitz`, the
service must be properly defined under 
:blitz_sourcedir:`src/main/slice/omero`.

OMERO annotations for validation
--------------------------------

The server-side implementation of these interfaces makes use of `Java annotations <https://docs.oracle.com/javase/tutorial/java/annotations/basics.html>`_
and an :doc:`AOP </developers/Server/Aop>` interceptor to validate all method
parameters. Calls to ``pojos.findContainerHierarchies`` are first caught by a
method interceptor, which checks for annotations on the parameters and, if
available, performs the necessary checks. The interceptor also makes proactive
checks. For a range of parameter types such as Java Collections it requires
that annotations exist and will refuse to proceed if not implemented.

An API call of the form:

::

        pojos.findContainerHierarchies(Class, Set, Map)

is implemented as

::

         pojos.findContainerHierarchies(@NotNull Class, @NotNull @Validate(Integer.class) Set, Map)

.. seealso:: :doc:`/developers/Server/Queries`, :doc:`/developers/Server/RenderingEngine`, :doc:`/developers/Modules/ExceptionHandling`

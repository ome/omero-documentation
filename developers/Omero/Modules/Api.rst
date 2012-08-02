OMERO Application Programming Interface
=======================================

Table of Contents
^^^^^^^^^^^^^^^^^

#. `Services List <#ServicesList>`_

   #. `Service Level 1 (direct DB and hibernate
      connections) <#ServiceLevel1directDBandhibernateconnections>`_
   #. `Service Level 2 <#ServiceLevel2>`_
   #. `Stateful/Binary? Services <#StatefulBinaryServices>`_

#. `Discussion <#Discussion>`_

   #. `Reads and Writes <#ReadsandWrites>`_
   #. `Administation <#Administation>`_
   #. `Pojos <#Pojos>`_

#. `Examples <#Examples>`_
#. `Stateless versus Stateful
   Services <#StatelessversusStatefulServices>`_
#. `How to write a service <#Howtowriteaservice>`_
#. `Omero Annotations for Validation <#OmeroAnnotationsforValidation>`_

All interaction with the OMERO server takes place via several API
services available from a `ServiceFactory </ome/wiki/ServiceFactory>`_.
A service factory is obtained from the client connection. E.g. Python:

::

    client = omero.client("localhost")
    session = client.createSession("username", "password")   # this is the service factory
    adminService = session.getAdminService()                 # now we can get/create services

-  The ` Service factory
   API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/ServiceFactory.html#ServiceFactory>`_
   has methods for creating Stateless and Stateful services (see below).

   -  Stateless services are obtained using "get..." methods E.g.
      getQueryService()
   -  Stateful services are obtained using "create..." methods E.g.
      createRenderingEngine()

-  Services will provide access to omero.model.objects. You will then
   need the ` API for these
   objects <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/model.html>`_.
   E.g. Dataset, Image, Pixels etc.

Services List
-------------

The
` ome.api <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/common/src/ome/api>`_
package in the common component defines the central "verbs" of the Omero
system. All external interactions with the system should happen with
these verbs, or services. Each OMERO service belongs to a particular
service level with each level calling only on services from lower
levels.

Service Level 1 (direct DB and hibernate connections)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  AdminService:
   ` src <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/common/src/ome/api/IAdmin.java>`_,
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IAdmin.html#IAdmin>`_
   for working with Experimenters, Groups and the current Context
   (switching groups etc).
-  ConfigService:
   ` src <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/common/src/ome/api/IConfig.java>`_,
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IConfig.html#IConfig>`_
   for getting and setting config parameters.
-  ContainerService:
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IContainer.html>`_
   for loading Project, Dataset and Image hierarchies.
-  DeleteService:
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IDelete.html>`_
   for deleting objects asynchronously (delete queue).
-  MetadataService:
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IMetadata.html>`_
   for working with Annotations.
-  PixelsService:
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IPixels.html>`_
   for pixels stats and creating Images with existing or new Pixels.
-  ProjectionService
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IProjection.html>`_
-  QueryService:
   ` src <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/common/src/ome/api/IQuery.java>`_,
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/ome/api/IQuery.html>`_
   for custom SQL-like queries.
-  RenderingSettingsService
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IRenderingSettings.html>`_
   for copying, pasting & resetting rendering settings.
-  RepositoryInfo
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IRepositoryInfo.html>`_
   disk space stats.
-  RoiService
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IRoi.html>`_
   working with ROIs.
-  ScriptService
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IScript.html>`_
   for uploading and launching Python scripts.
-  SessionService
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/ISession.html>`_
   for creating and working with OMERO sessions.
-  ShareService
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IShare.html>`_
-  TimelineService
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/ITimeline.html>`_
   for queries based on time.
-  TypesService
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/ITypes.html>`_
   for Enumerations.
-  UpdateService:
   ` src <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/common/src/ome/api/IUpdate.java>`_,
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/ome/api/IUpdate.html>`_
   for saving and deleting omero.model objects.

Service Level 2
~~~~~~~~~~~~~~~

-  ` IPojos <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/common/src/ome/api/IPojos.java>`_
-  ` ITypes <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/common/src/ome/api/ITypes.java>`_

Stateful/Binary? Services
~~~~~~~~~~~~~~~~~~~~~~~~~

-  RawFileStore:
   ` src <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/common/src/ome/api/RawFileStore.java>`_,
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/ome/api/RawFileStore.html>`_
-  RawPixelsStore:
   ` src <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/common/src/ome/api/RawPixelsStore.java>`_,
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/ome/api/RawPixelsStore.html>`_
-  RenderingEngine:
   ` src <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/common/src/omeis/re/providers/RenderingEngine.java>`_,
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/RenderingEngine.html#RenderingEngine>`_
   (see `RenderingEngine </ome/wiki/RenderingEngine>`_ for more)
-  ThumbnailStore:
   ` src <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/common/src/ome/api/Thumbnail.store>`_,
   ` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/ome/api/ThumbnailStore.html>`_
-  ` IScale <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/common/src/ome/api/IScale.java>`_

A complete list of service APIs can be found
` here <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api.html>`_
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
`IObject </ome/browser/ome.git/components/common/src/ome/model/IObject.java>`_
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

The
`IAdmin </ome/browser/ome.git/components/common/src/ome/api/IAdmin.java>`_
interface defines all the actions necessary to administer the `security
system </ome/wiki/OmeroSecurity>`_ . It is explained further on the
`AdminInterface </ome/wiki/AdminInterface>`_ page.

Pojos
~~~~~

Certain operations, like those deailing with data management and
viewing, happen more frequently than others (like defining microscopes).
Those have been collected in the
`IPojos </ome/browser/ome.git/components/common/src/ome/api/IPojos.java>`_
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
`OmeroBuild </ome/wiki/OmeroBuild>`_ for more) then the service will be
deployed to the server. In the case of
`OmeroBlitz </ome/wiki/OmeroBlitz>`_, the service must be properly
defined under
`source:ome.git/components/blitz/resources/ </ome/browser/ome.git/components/blitz/resources>`_.

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

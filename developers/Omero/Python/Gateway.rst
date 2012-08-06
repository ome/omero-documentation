.. _developers/Omero/Python/Gateway:

Blitz Gateway
=============

.. contents::

` MOVIE: introduction to Blitz
Gateway <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-3/mov/BlitzGatewayIntro-4.3.mov>`_

**omero.gateway** (known as the 'Blitz' gateway) is a Python module for
working with the OMERO API and model objects. It facilitates many
aspects of working with the API, such as handling connections, creating
services, loading objects and traversing object graphs.

The Gateway consists of wrapper objects around the OMERO connection and
the various model objects, providing more convenient methods in many
cases, while also permitting access to the underlying omero.model
objects.

Dependancies
~~~~~~~~~~~~

-  OMERO python libs. Included in the server package
   ` download <https://www.openmicroscopy.org/site/documents/data-management/omero4/downloads>`_.
-  Ice 3.3.1
-  Python 2.4 or higher.

Installing
----------

To install the gateway you will need to get the latest release version
of OMERO.server and import the OMERO\_DIR/lib/python to your PYTHONPATH.

::

    $ export PYTHONPATH=$PYTHONPATH:/Users/will/Desktop/OMERO.server-Beta-4.2.2/lib/python/
    $ echo $PYTHONPATH 
    /opt/local/share/ice/python:/home/omero/omero_dist/lib/python/:
    $ python
    Python 2.4.5 (#1, Nov 23 2008, 00:21:06) 
    [GCC 4.0.1 (Apple Computer, Inc. build 5367)] on darwin
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import omero.gateway
    >>> 

Creating a connection
---------------------

The gateway provides methods to access the OMERO.blitz server, many of
the methods are helper methods which provide extra functionality so that
using the OMERO.blitz server does not require understanding of the data
model, or server services.

To create a connection to the server we need:

::

    Python 2.4.5 (#1, Nov 23 2008, 00:21:06) 
    [GCC 4.0.1 (Apple Computer, Inc. build 5367)] on darwin
    Type "help", "copyright", "credits" or "license" for more information.
    >>> from omero.gateway import BlitzGateway
    >>> username = 'user'
    >>> passwd = 'secret'
    >>> host = 'localhost'
    >>> port = 4064
    >>> conn = BlitzGateway(username, passwd, host=host, port=port)
    >>> conn.connect()
    True
    >>> conn.getEventContext()
    object #0 (::omero::sys::EventContext)
    {
        shareId = -1
        sessionId = 3336
        sessionUuid = deb1bcb4-7c9d-449d-97e8-991f1e9f0a67
        userId = 2
        userName = user
        groupId = 4
        groupName = group1
        isAdmin = False
        isReadOnly = True
        eventId = -1
        eventType = Internal
        memberOfGroups = 
        {
            [0] = 1
            [1] = 4
            [2] = 2
        }
        leaderOfGroups = 
        {
            [0] = 4
        }
        umask = <nil>
    }
    >>> 

The Gateway Methods
-------------------

The epydoc-generated documentation of methods provided by OMERO Gateway
is available showing :javadoc:` wrapper classes <epydoc/omero.gateway-module.html>`.

Specifically, the API for the 'conn' connection wrapper created above is
:javadoc:` here <epydoc/omero.gateway._BlitzGateway-class.html>`.

When working with :javadoc:` OMERO model objects <slice2html/omero/model.html>`
(omero.model.Image etc) the Gateway will wrap these objects in classes
such as
:javadoc:` omero.gateway.ImageWrapper <epydoc/omero.gateway._ImageWrapper-class.html>`
to handle object loading and hierarchy traversal. For example:

::

    >>> for p in conn.listProjects():         # Initially we just load Projects
    ...     print p.getName()
    ...     for dataset in p.listChildren():      # lazy-loading of Datasets here
    ...             print "  ", dataset.getName()
    ... 
    TestProject
       Aurora-B
    tiff stacks
       newTimeStack
       test
    siRNAi
       CENP
       live-cell
       survivin

Access to the OMERO API services
--------------------------------

If you need access to API methods that are not provided by the gateway
library, you can get hold of the |OmeroApi|. 

.. note:: 
    These services will always work
    with omero.model objects and not the gateway wrapper objects.

The gateway handles creation and reuse of the API services, so that new
ones are not created unnecessarily. Services can be accessed using the
methods of the underlying :javadoc:` Service
Factory <slice2html/omero/api/ServiceFactory.html#ServiceFactory>`
with the Gateway handling reuse as needed. Stateless services (those
retrieved with get.... methods E.g.
:javadoc:` getQueryService <slice2html/omero/api/ServiceFactory.html#getQueryService>`)
are always reused for each call, E.g. blitzon.getQueryService() whereas
stateful services E.g.
:javadoc:` createRenderingEngine <slice2html/omero/api/ServiceFactory.html#createRenderingEngine>`
may be created each time.

Not all methods of the service factory are currently supported in the
gateway. You can get an idea of the currently supported services by
looking at the source code under the
:javadoc:` \_createProxies <epydoc/omero.gateway-pysrc.html#_BlitzGateway._createProxies>`
method.

Example: ContainerService can load Projects and Datasets in a single
call to server (no lazy loading)

::

    cs = conn.getContainerService()
    projects = cs.loadContainerHierarchy("Project", None, None)
    for p in projects:                # omero.model.ProjectI
        print p.getName().getValue()     # need to 'unwrap' rstring
        for d in p.linkedDatasetList():
            print d.getName().getValue()

Stateful services, reconnection, error handling etc
---------------------------------------------------

The Blitz gateway was designed for use in the |OmeroWeb| framework and it is not expected that
stateful services will be maintained on the client for significant time.
There is various error-handling functionality in the Blitz gateway that
will close existing services and recreate them in order to maintain a
working connection. If this happens then any stateful services that you
have on the client-side will become stale. We will attempt to document
this a little better in due course, but our general advice is to create,
use and close the stateful services in the shortest practicable time.

Overwriting and extending omero.gateway classes
-----------------------------------------------

When working with
:javadoc:` omero.gateway <epydoc/omero.gateway._BlitzGateway-class.html>`
or wrapper classes such as
:javadoc:` omero.gateway.ImageWrapper <epydoc/omero.gateway._ImageWrapper-class.html>`
you might want to add your own functionality or customize an existing
one. NB: Note the call to ``omero.gateway.refreshWrappers()`` to ensure
that your subclasses are returned by calls to getObjects() For example:

::

    class MyBlitzGateway (omero.gateway.BlitzGateway):

        def __init__ (self, *args, **kwargs):
            super(MyBlitzGateway, self).__init__(*args, **kwargs)
            
            ...do something, e.g. add new field...
            self.new_field = 'foo'

        def connect (self, *args, **kwargs):
                    
            rv = super(MyBlitzGateway, self).connect(*args,**kwargs)
            if rv: 
                ...do something, e.g. modify new filed...
                self.new_field = 'bla'
            
            return rv
        
    omero.gateway.BlitzGateway = MyBlitzGateway

    class MyBlitzObjectWrapper (object):
        
        annotation_counter = None

        def countAnnotations (self):
            """
            Count on annotations linked to the object and set the value
            on the custom field 'annotation_counter'.

            @return     Counter
            """
            
            if self.annotation_counter is not None:
                return self.annotation_counter
            else:
                container = self._conn.getContainerService()
                m = container.getCollectionCount(self._obj.__class__.__name__, type(self._obj).ANNOTATIONLINKS, [self._oid], None)
                if m[self._oid] > 0:
                    self.annotation_counter = m[self._oid]
                    return self.annotation_counter
                else:
                    return None

    class ImageWrapper (MyBlitzObjectWrapper, omero.gateway.ImageWrapper):
        """
        omero_model_ImageI class wrapper overwrite omero.gateway.ImageWrapper
        and extends MyBlitzObjectWrapper.
        """
        
        def __prepare__ (self, **kwargs):
            if kwargs.has_key('annotation_counter'):
                self.annotation_counter = kwargs['annotation_counter']

    omero.gateway.ImageWrapper = ImageWrapper

    # IMPORTANT to update the map of wrappers for 'Image' etc. returned by getObjects("Image")
    omero.gateway.refreshWrappers()

This page provides some background information on the OMERO Python
client 'gateway' (omero.gateway module) and describes work to improve
the API, beginning with the OMERO 4.3 release.

The |BlitzGateway| is a Python client-side library that facilitates working 
with the OMERO API, handling connection to the server, loading of data
objects and providing convenience methods to access the data. It was
originally designed as part of the |OmeroWeb| framework, 
to provide connection and data retrieval services to various
web clients. However, we have now decided to encourage it's use for all
access to the OMERO Python API.

Wrapper Objects
---------------

The Gateway consists of a number of wrapper objects:

Connection Wrapper
~~~~~~~~~~~~~~~~~~

The BlitzGateway class (see :javadoc:` API of development code <epydoc/omero.gateway._BlitzGateway-class.html>`)
is a wrapper for the OMERO client and session objects. It provides
various methods for connecting to the OMERO server, querying the status
or context of the current connection and as a starting point for
retrieving data objects from OMERO.

::

    from omero.gateway import *

    conn = BlitzGateway("username", "password", host="localhost", port=4064)
    conn.connect()

    for p in conn.listProjects():
        print p.name

Model Object Wrappers
~~~~~~~~~~~~~~~~~~~~~

OMERO model objects, E.g. omero.model.Project, omero.model.Pixels etc
(see :javadoc:` full list <slice2html/omero/model.html>`)
are code-generated and mapped to the OMERO database schema. They are
language agnostic and their data is in the form of omero.rtypes as
described: :ref:` about model
objects <developers/Omero/GettingStarted/AdvancedClientDevelopment#Objects>`).

::

    import omero
    from omero.model import *
    from omero.rtypes import rstring
    p = omero.model.ProjectI()
    p.name = rstring("My Project")   # attributes are all rtypes
    print p.getName().getValue()     # getValue() to unwrap the rtype
    print p.name.val                 # short-hand 

To facilitate work in Python, particularly in web page templates, these
Python model objects are wrapped in Blitz Object Wrappers. This hides
the use of rtypes.

::

    import omero
    from omero.model import *
    from omero.rtypes import rstring
    p = omero.model.ProjectI()
    p.setName(rstring("Omero Model Project"))   # attributes are all rtypes
    print p.getName().getValue()                # getValue() to unwrap the rtype
    print p.name.val                            # short-hand

    from omero.gateway import *
    project = ProjectWrapper(obj=p)             # wrap the model.object
    project.setName("Project Wrapper")          # Don't need to use rtypes
    print project.getName()
    print project.name

    print project._obj                  # access the wrapped object with ._obj

These wrappers also have a reference to the BlitzGateway connection
wrapper, so they can make calls to the server and load more data when
needed (lazy loading).

E.g.

::

    # connect as above
    for p in conn.listProjects():
        print p.name
        for dataset in p.listChildren():   # lazy loading of datasets, wrapped in DatasetWrapper
            print "Dataset", d.name

Wrapper Coverage
~~~~~~~~~~~~~~~~

The OMERO data model has a large number of objects, not all of which
are used by the |OmeroWeb| framework. For this reason, the Blitz
gateway (which was originally built for |OmeroWeb|) has not yet been
extended to wrap every omero.model object with a specific Blitz Object
Wrapper. The current list of object wrappers can be found in the
omero.gateway module :jenkins:`4.2 API
<view/Beta4.2/job/OMERO-Beta4.2/javadoc/epydoc/omero.gateway-module.html>`,
:javadoc:` development code API <epydoc/omero.gateway-module.html>`_.
As more functionality is provided by the Blitz Gateway, the coverage
of object wrappers will increase accordingly.

Gateway Evolution
-----------------

As mentioned above, the Blitz gateway was originally designed for
|OmeroWeb|, but is now being developed as a
general purpose Python client library. Various changes are in the
pipeline:

Connection Wrapper API
~~~~~~~~~~~~~~~~~~~~~~

A number of methods to query the server from the BlitzGateway connection
wrapper have been consolidated, to remove specific use cases and provide
more general purpose methods.

E.g.

::

    conn.findProject("Project Name")                                # OMERO 4.2
    conn.getObject("Project", attributes={'name':"Project Name"})   # OMERO 4.3

These changes have begun in the 4.3 release. Full details are `available
here </ome/wiki/Api/BlitzGateway>`_.

Blitz Object Wrapper API
~~~~~~~~~~~~~~~~~~~~~~~~

Similar work is needed to improve the API of the model object wrappers.
This work will follow the OMERO 4.3 release. Although it is difficult to
define exactly what will change, in general we are looking to remove
specific use-case methods, E.g. the 4.3 API has both these methods

::

    getAnnotation (self, ns=None)     # less general-purpose - candidate for removal
    listAnnotations(self, ns=None)    # general-purpose, "stable" 

Any changes will be outlined prior to the release (as above) and users
notified via the mailing lists and forum.


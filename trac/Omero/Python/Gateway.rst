A Python interface to OMERO
===========================

.. contents::

` MOVIE: introduction to Blitz
Gateway <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-3/mov/BlitzGatewayIntro-4.3.mov>`_

**omero.gateway** (known as the 'Blitz' gateway) is a Python module for
working with the OMERO API and model objects. It facilitates many
aspects of working with the API, such as handling connections, creating
services, loading objects and traversing object graphs.

This page is a 'quick-start' guide to the Blitz gateway. More info can
be found at `OmeroPy/GatewayInfo </ome/wiki/OmeroPy/GatewayInfo>`_.

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
is available showing ` wrapper
classes <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/epydoc/omero.gateway-module.html>`_.

Specifically, the API for the 'conn' connection wrapper created above is
` here <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/epydoc/omero.gateway._BlitzGateway-class.html>`_.

When working with ` OMERO model
objects <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/model.html>`_
(omero.model.Image etc) the Gateway will wrap these objects in classes
such as
` omero.gateway.ImageWrapper <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/epydoc/omero.gateway._ImageWrapper-class.html>`_
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
library, you can get hold of the `OMERO API
services </ome/wiki/OmeroApi>`_. NB. These services will always work
with omero.model objects and not the gateway wrapper objects.

The gateway handles creation and reuse of the API services, so that new
ones are not created unnecessarily. Services can be accessed using the
methods of the underlying ` Service
Factory <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/ServiceFactory.html#ServiceFactory>`_
with the Gateway handling reuse as needed. Stateless services (those
retrieved with get.... methods E.g.
` getQueryService <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/ServiceFactory.html#getQueryService>`_)
are always reused for each call, E.g. blitzon.getQueryService() whereas
stateful services E.g.
` createRenderingEngine <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/ServiceFactory.html#createRenderingEngine>`_
may be created each time.

Not all methods of the service factory are currently supported in the
gateway. You can get an idea of the currently supported services by
looking at the source code under the
` \_createProxies <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/epydoc/omero.gateway-pysrc.html#_BlitzGateway._createProxies>`_
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

The Blitz gateway was designed for use in the
`OmeroWeb </ome/wiki/OmeroWeb>`_ framework and it is not expected that
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
` omero.gateway <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/epydoc/omero.gateway._BlitzGateway-class.html>`_
or wrapper classes such as
` omero.gateway.ImageWrapper <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/epydoc/omero.gateway._ImageWrapper-class.html>`_
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

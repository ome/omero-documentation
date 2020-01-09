Blitz Gateway documentation
---------------------------

This page provides some background information on the OMERO Python client
'gateway' (omero.gateway module).

The Blitz Gateway is a Python client-side library that facilitates working
with the OMERO API, handling connection to the server, loading of data objects
and providing convenience methods to access the data. It was originally
designed as part of the |OmeroWeb|, to provide connection and data
retrieval services to various web clients. However, we
encourage its use for all access to the OMERO Python API.



Connection wrapper
""""""""""""""""""

The BlitzGateway class (see :pythondoc:`API of development code <omero/omero.gateway.html#omero.gateway._BlitzGateway>`)
is a wrapper for the OMERO client and session objects. It provides
various methods for connecting to the OMERO server, querying the status
or context of the current connection and retrieving data objects from OMERO.

BlitzGateway can be used as a context manager to ensure the underlying client connection is automatically closed.

For examples see :ref:`python-code-samples`.


Model object wrappers
"""""""""""""""""""""

OMERO model objects, e.g. omero.model.Project, omero.model.Pixels etc.
(see :slicedoc_blitz:`full list <omero/model.html>`)
are code-generated and mapped to the OMERO database schema. They are
language agnostic and their data is in the form of omero.rtypes as
described in :ref:`about model objects <AdvancedClientDevelopment#Objects>`.

To facilitate work in Python, particularly in web page templates, these
Python model objects are wrapped in Blitz Object Wrappers. This hides
the use of rtypes.

::

    import omero
    from omero.model import ProjectI
    from omero.rtypes import rstring
    p = ProjectI()
    p.setName(rstring("Omero Model Project"))   # attributes are all rtypes
    print(p.getName().getValue())               # getValue() to unwrap the rtype
    print(p.name.val)                           # short-hand

    from omero.gateway import ProjectWrapper
    project = ProjectWrapper(obj=p)             # wrap the model.object
    project.setName("Project Wrapper")          # Don't need to use rtypes
    print(project.getName())
    print(project.name)

    print(project._obj)                  # access the wrapped object with ._obj

These wrappers also have a reference to the BlitzGateway connection wrapper,
so they can make calls to the server and load more data when needed (lazy
loading).

::

    >>> from omero.gateway import BlitzGateway

    >>> conn = BlitzGateway("username", "password", host="localhost", port=4064)
    >>> conn.connect()

    >>> for p in conn.listProjects():         # Initially we just load Projects
    ...     print(p.getName())
    ...     for dataset in p.listChildren():      # lazy-loading of Datasets here
    ...             print("  ", dataset.getName())
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
    >>> conn.close()


Wrapper coverage
""""""""""""""""

The OMERO data model has a large number of objects, not all of which are used
by the |OmeroWeb|. Therefore, the Blitz gateway (which was
originally built for this framework) has not yet been extended to wrap every
omero.model object with a specific Blitz Object Wrapper. The current list of
object wrappers can be found in the omero.gateway module
:pythondoc:`API <omero/omero.gateway.html>`.
As more functionality is provided by the Blitz Gateway, the coverage of object
wrappers will increase accordingly.

Access to the OMERO API services
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you need access to API methods that are not provided by the gateway
library, you can get hold of the |OmeroApi|.

.. note::
 
    These services will always work with omero.model objects and not the
    gateway wrapper objects.

The gateway handles creation and reuse of the API services, so that new
ones are not created unnecessarily. Services can be accessed using the
methods of the underlying :slicedoc_blitz:`Service
Factory <omero/api/ServiceFactory.html>`
with the Gateway handling reuse as needed. **Stateless** services (those
retrieved with getXXX methods e.g.
:slicedoc_blitz:`getQueryService <omero/api/ServiceFactory.html#getQueryService>`)
are always reused for each call, e.g. conn.getQueryService() whereas
**stateful** services e.g.
:slicedoc_blitz:`createRenderingEngine <omero/api/ServiceFactory.html#createRenderingEngine>`
may be created each time.

Not all methods of the service factory are currently supported in the
gateway. You can get an idea of the currently supported services by
looking at the source code under the
:pythondoc:`\_createProxies <omero/omero.gateway.html#omero.gateway._BlitzGateway._createProxies>`
method.

Example: ContainerService can load Projects and Datasets in a single
call to server (no lazy loading)

::

    cs = conn.getContainerService()
    projects = cs.loadContainerHierarchy("Project", None, None)
    for p in projects:                # omero.model.ProjectI
        print(p.getName().getValue())     # need to 'unwrap' rstring
        for d in p.linkedDatasetList():
            print(d.getName().getValue())

Stateful services, reconnection, error handling etc.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Blitz gateway was designed for use in the |OmeroWeb| and it is
not expected that stateful services will be maintained on the client for
significant time.
There are various error-handling functionalities in the Blitz gateway that
will close existing services and recreate them in order to maintain a
working connection. If this happens then any stateful services that you
have on the client-side will become stale. Our general advice is to create,
use and close the stateful services in the shortest practicable time.

::

    try:
        image = conn.getObject("Image", image_id)
        # Initializes the Rendering engine and sets rendering settings
        image.setActiveChannels([1, 2], [[20, 300], [50, 500]], ['00FF00', 'FF0000'])
        pil_image = image.renderImage(0, 0)
        # Now we close the rendering engine
        image._re.close

    # Can continue to use the connection until done,
    # then close ALL services:
    finally:
        conn.close()

Overwriting and extending omero.gateway classes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When working with
:pythondoc:`omero.gateway <omero/omero.gateway.html>`
or wrapper classes such as
:pythondoc:`omero.gateway.ImageWrapper <omero/omero.gateway.html#omero.gateway.ImageWrapper>`
you might want to add your own functionality or customize an existing
one. N.B. The call to ``omero.gateway.refreshWrappers()`` is important to update the
dictionary of classes used by conn.getObjects(). This will ensure that instances of
your class are returned by conn.getObjects().
::

    class MyBlitzGateway (omero.gateway.BlitzGateway):

        def __init__ (self, *args, **kwargs):
            super(MyBlitzGateway, self).__init__(*args, **kwargs)
            
            ...do something, e.g. add new field...
            self.new_field = 'foo'

        def connect (self, *args, **kwargs):
                    
            rv = super(MyBlitzGateway, self).connect(*args,**kwargs)
            if rv: 
                ...do something, e.g. modify new field...
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

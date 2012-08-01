Python Gateway Info
===================

Table of Contents
^^^^^^^^^^^^^^^^^

#. `Wrapper Objects <#WrapperObjects>`_

   #. `Connection Wrapper <#ConnectionWrapper>`_
   #. `Model Object Wrappers <#ModelObjectWrappers>`_
   #. `Wrapper Coverage <#WrapperCoverage>`_

#. `Gateway Evolution <#GatewayEvolution>`_

   #. `Connection Wrapper API <#ConnectionWrapperAPI>`_
   #. `Blitz Object Wrapper API <#BlitzObjectWrapperAPI>`_

This page provides some background information on the OMERO Python
client 'gateway' (omero.gateway module) and describes work to improve
the API, beginning with the OMERO 4.3 release.

The `OmeroPy/Gateway </ome/wiki/OmeroPy/Gateway>`_, known as the 'Blitz'
gateway, is a Python client-side library that facilitates working with
the OMERO API, handling connection to the server, loading of data
objects and providing convenience methods to access the data. It was
originally designed as part of the `OmeroWeb </ome/wiki/OmeroWeb>`_
framework, to provide connection and data retrieval services to various
web clients. However, we have now decided to encourage it's use for all
access to the OMERO Python API.

Wrapper Objects
---------------

The Gateway consists of a number of wrapper objects:

Connection Wrapper
~~~~~~~~~~~~~~~~~~

The BlitzGateway class (see ` API of development
code <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/epydoc/omero.gateway._BlitzGateway-class.html>`_)
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
(see ` full
list <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/model.html>`_)
are code-generated and mapped to the OMERO database schema. They are
language agnostic and their data is in the form of omero.rtypes as
described: ` about model
objects <http://trac.openmicroscopy.org.uk/ome/wiki/DevelopingOmeroClients#Objects>`_).

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

The OMERO data model has a large number of objects, not all of which are
used by the `OmeroWeb </ome/wiki/OmeroWeb>`_ framework. For this reason,
the Blitz gateway (which was originally built for
`OmeroWeb </ome/wiki/OmeroWeb>`_) has not yet been extended to wrap
every omero.model object with a specific Blitz Object Wrapper. The
current list of object wrappers can be found in the omero.gateway module
` 4.2
API <http://hudson.openmicroscopy.org.uk/view/Beta4.2/job/OMERO-Beta4.2/javadoc/epydoc/omero.gateway-module.html>`_,
` development code
API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/epydoc/omero.gateway-module.html>`_.
As more functionality is provided by the Blitz Gateway, the coverage of
object wrappers will increase accordingly.

Gateway Evolution
-----------------

As mentioned above, the Blitz gateway was originally designed for
`OmeroWeb </ome/wiki/OmeroWeb>`_, but is now being developed as a
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

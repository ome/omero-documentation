Deprecated Page

Writing a Python Client for Beginners
=====================================

Table of Contents
^^^^^^^^^^^^^^^^^

#. `What's this? <#Whatsthis>`_
#. `Getting Started <#GettingStarted>`_

   #. `Python <#Python>`_
   #. `Get OMERO gateway code <#GetOMEROgatewaycode>`_

#. `Working with OMERO Python API <#WorkingwithOMEROPythonAPI>`_

   #. `OMERO API <#OMEROAPI>`_
   #. `Python Gateway <#PythonGateway>`_

What's this?
------------

This page is a guide for beginners looking to write or edit simple
Python scripts that connect to the OMERO server and perform simple
tasks. It should be read in conjunction with the
`OmeroClients </ome/wiki/OmeroClients>`_ page, and the
`OmeroPy/Gateway </ome/wiki/OmeroPy/Gateway>`_ page.

Sample code is given on the
`PythonClientCodeExamples </ome/wiki/PythonClientCodeExamples>`_ page,
to give you an idea of the OMERO API usage.

Getting Started
---------------

Python
~~~~~~

If you need help getting started with Python, have a look at
` http://wiki.python.org/moin/BeginnersGuide <http://wiki.python.org/moin/BeginnersGuide>`_

Get OMERO gateway code
~~~~~~~~~~~~~~~~~~~~~~

This is a library of Python code that will enable your Python scripts to
connect to an OMERO server.

It is included in the server release, in a folder called /lib/python/

You should use the Python code here to connect to a server of the same
version. E.g. if you want to connect to an OMERO 4.1 server, the client
will need the code in /lib/python/ from a 4.1 server release.

Now you need to edit your PYTHONPATH so that this code can be found by
Python scripts. This involves editing your environment variables, which
are either found in a hidden file (for example, the .profile or
.bash\_profile on Mac in your home directory), or elsewhere in your
system configuration (under windows). If you are updating your
PYTHONPATH by hand, be careful to use a text editor that will not format
the text (I suggest using TextWrangler on a Mac, freely available at
` http://www.barebones.com/products/TextWrangler/download.html <http://www.barebones.com/products/TextWrangler/download.html>`_).

As an example of how to update your PYTHONPATH, under Mac with
TextWrangler installed. First, make sure that in TextWrangler you go to
Menu: Text Wrangler > Install Command Line Tools. Then you would do this
in the command line in the user's home directory:

::

    $ pwd
    /Users/will
    $ edit .profile

which will open the file in TextWrangler. You need to add the following
line to the file, making sure that you edit the directory path to point
to the location of the unzipped folder.

::

    export PYTHONPATH=$/Users/will/Desktop/OMERO/lib/python/:$PYTHONPATH

Save the file. You will need to exit the command line and restart it for
this change to take effect. To test you have this working, enter the
Python interactive prompt as above (type python) and then type:
``>>> import omero``. If you get no error message, you are done!

::

    JRS-Macbookpro-19203:~ will$ python
    Python 2.4.6 (#1, Feb  6 2009, 13:58:29) 
    [GCC 4.0.1 (Apple Computer, Inc. build 5363)] on darwin
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import omero
    >>> 

If this hasn't worked, display the PYTHONPATH in the Terminal (when not
in the Python prompt). Simply type `` echo $PYTHONPATH `` and check that
the output contains the /lib/python/ directory.

::

    JRS-Macbookpro-19203:~ will$ echo $PYTHONPATH
    /Users/will/Desktop/OMERO/lib/python/:/opt/local/share/ice/python:

Working with OMERO Python API
-----------------------------

OMERO API
~~~~~~~~~

All client interaction with OMERO is via the ` OMERO
API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero.html>`_.
This includes
` objects <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/model.html>`_
code-generated in Python (and Java) from the OME data model and various
` services <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api.html>`_
for retrieving, editing and saving this data.

A example: Here we connect to the server, get a service (Container
Service, for working with Project, Dataset, Image hierarchies) get
images in a Dataset (ID 201) and print their names.

::

    import omero

    client = omero.client("omero.openmicroscopy.org.uk")
    session = client.createSession("willmoore", "mypassword")
    cs = session.getContainerService()
    imgs = cs.getImages("Dataset", [201], None)
    for i in imgs:
        print i.getName().getValue()

NB. Because we are working with the core model objects, as described on
the `OmeroClients </ome/wiki/OmeroClients>`_ page, i.getName() returns
an rstring object and we call getValue() to get the name string itself.

For more examples, see
`PythonClientCodeExamples </ome/wiki/PythonClientCodeExamples>`_.

Python Gateway
~~~~~~~~~~~~~~

The `omero.gateway </ome/wiki/OmeroPy/Gateway>`_ is a Python library
built on top of the OMERO API to facilitate many aspects of working with
the API, such as handling connections, creating services, loading
objects and traversing object graphs.

It also wraps the core omero.model objects to provide handy methods for
common tasks. We recommend you use the
`gateway </ome/wiki/OmeroPy/Gateway>`_ rather than the core API and
services described above.

An example: Connect to the server, use the ` connection
wrapper <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/epydoc/omero.gateway._BlitzGateway-class.html>`_
to
` listProjects <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/epydoc/omero.gateway._BlitzGateway-class.html#listProjects>`_,
print their names and list their Datasets. For more details see the
`OmeroPy/Gateway </ome/wiki/OmeroPy/Gateway>`_ wiki page.

::

    from omero.gateway import BlitzGateway
    conn = BlitzGateway("will", "mypassword", host="localhost", port=4064)
    conn.connect()
    for p in conn.listProjects():
        print p.getName()
        for dataset in p.listChildren():
            print "  ", dataset.getName()

NB: The omero gateway does not wrap ALL functionality of the OMERO API.
If you want to use parts of the API not covered by the gateway, simply
get the services you need from the connection wrapper and use their
methods as with the core API.

::

    import omero.gateway
    from omero import client_wrapper
    blitzcon = client_wrapper("will", "mypassword", host="localhost", port=4064)
    blitzcon.connect()
    cs = blitzcon.getContainerService()
    qs = blitzcon.getQueryService()      # etc. 

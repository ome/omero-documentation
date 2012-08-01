Deprecated Page

Python Client Code Examples
---------------------------

The Python examples on this page use the plain OMERO API, based on the
` OMERO model
objects <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/model.html>`_
and
` services <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api.html>`_.
For info on using the Python 'Blitz' gateway, which simplifies many
aspects of working with OMERO (recommended), see
`OmeroPy/Gateway </ome/wiki/OmeroPy/Gateway>`_.

Before trying these examples, you should read the
`OmeroClients </ome/wiki/OmeroClients>`_ page, or the `Python client
beginners </ome/wiki/PythonClientBeginners>`_ page. Also see
`OmeroPy </ome/wiki/OmeroPy>`_.

The code below can be run from a client, connecting to the server like
this:

::

    import omero.gateway
    from omero import client_wrapper
    blitzcon = client_wrapper("will", "mypassword", host="localhost", port=4064)
    blitzcon.connect()
    # we now have access to methods of the service factory:
    cs = blitzcon.getContainerService()
    qs = blitzcon.getQueryService()      # etc. 

Alternatively, the code examples on this page can be run as part of the
`OMERO scripting service </ome/wiki/OmeroScripts>`_ (also see the
`scripting guide </ome/wiki/OmeroPy/ScriptingServiceGuide>`_), in which
Python scripts are uploaded to the server and run on the server by the
scripting service. In this case, the client and session objects are
created like this:

::

    client = scripts.client('scriptName.py', 'Description.')
    session = client.getSession()
    cs = session.getContainerService()
    qs = session.getQueryService()      # etc. 

In either case, a "session" is created that can be used to create other
services as shown below, using methods from this
` API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/ServiceFactory.html#ServiceFactory>`_.
For a technical description of the session, see the
`OmeroSessions </ome/wiki/OmeroSessions>`_ page.

Container Service
-----------------

The ` Container
Service <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IContainer.html>`_
API can be used to load hierarchies of Project, Dataset and Images.
Image objects retrieved from the container service also have their
Pixels data loaded from the server.

Loading Projects and Datasets (Images not loaded):

::

    containerService = session.getContainerService()
    projectIds = [301, 402]
    projects = containerService.loadContainerHierarchy("Project", projectIds, None)
    for p in projects:
        print "Project: ", p.getId().getValue(), p.getName().getValue()
        for pdLink in p.copyDatasetLinks():
            dataset = pdLink.child
            print "   Dataset: ", dataset.id.val, dataset.name.val  # short-hand for getName().getValue()

Loading images from a Dataset:

::

    images = containerService.getImages("Dataset", [451], None)
    for i in images:
        print "Image: ", i.name.val
        print "Size X: ", i.getPrimaryPixels().getSizeX().getValue()
        print "Size Y: ", i.getPrimaryPixels().getSizeY().getValue()

NB: To load all images from a "Project", or get images simply using
"Image" ID, simply replace "Dataset" with "Project" or "Image"
respectively.

Rendering Engine
----------------

The
` RenderingEngine <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/RenderingEngine.html#RenderingEngine>`_
API can be used to edit the rendering settings of an image, and retrieve
a rendered image from the server.

The example code below is taken from the
`source:ome.git/components/tools/OmeroPy/scripts/omero/figure\_scripts/Split\_View\_Figure.py </ome/browser/ome.git/components/tools/OmeroPy/scripts/omero/figure_scripts/Split_View_Figure.py>`_
scripting service script. See the script itself for necessary import
statements etc.

::

    # ... session created as described above

    containerService = session.getContainerService()
    image = containerService.getImages("Image", [imageId], None)[0]   # loads image AND pixels 

    # get the primary (only) set of pixels for the image
    pixels = image.getPrimaryPixels()
    pixelsId = pixels.getId().getValue()
    sizeZ = pixels.getSizeZ().getValue()
    sizeC = pixels.getSizeC().getValue()

    # create rendering engine and initialize with pixelsId
    renderingEngine = session.createRenderingEngine()
    renderingEngine.lookupPixels(pixelsId)
    renderingEngine.lookupRenderingDef(pixelsId)
    renderingEngine.load()

    # turn all channels on
    for index in range(sizeC):
        renderingEngine.setActive(index, True)  

    # get a rendered projected image. 
    algorithm = omero.constants.projection.ProjectionType.MAXIMUMINTENSITY
    timepoint = 0
    stepping = 1
    proStart = 0
    proEnd = sizeZ-1
    img = renderingEngine.renderProjectedCompressed(algorithm, timepoint, stepping, proStart, proEnd)

    # use PIL to handle image
    i = Image.open(StringIO.StringIO(img))
    i.show()    # handy display for bug-fixing
    i.save("myImage.jpg")

IQuery
------

The ` IQuery
API <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/IQuery.html#IQuery>`_
allows users to perform low-level queries on the OMERO database, similar
to "SELECT" statements (` more
documentation <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/ome/api/IQuery.html>`_).

This example, taken from code in
`source:ome.git/components/tools/OmeroPy/src/omero/util/figureUtil.py </ome/browser/ome.git/components/tools/OmeroPy/src/omero/util/figureUtil.py>`_
script, gets Images by ID, and their parent Datasets and Projects.

::

    from omero.rtypes import *

    queryService = session.getQueryService()

    imageIds = [1,2,3]

    p = omero.sys.Parameters()
    p.map = {}
    p.map["iids"] = rlist([rlong(iid) for iid in imageIds])

    # select images (by ID), joined to parent Datasets and Projects. 
    query_string = "select i from Image i join fetch i.datasetLinks idl join fetch idl.parent d join fetch d.projectLinks pl join fetch pl.parent where i.id in (:iids)"

    images = queryService.findAllByQuery(query_string, p)
        
    for i in images:    # order of images not same as imageIds
        imageId = i.getId().getValue()
        for link in i.iterateDatasetLinks():
            dataset = link.parent
            dName = dataset.getName().getValue()
            if dataset.sizeOfProjectLinks() == 0:
                print "Dataset: %s is not in a project" % dName
            for dpLink in dataset.iterateProjectLinks():
                project = dpLink.parent
                pName = project.getName().getValue()
                print "Image ID: %d is in Dataset: %s Project: %s" % (imageId, dName, pName)

Another example:

::

    from omero.rtypes import *

    tIndexes = [1,5,10,15]

    p = omero.sys.Parameters()
    p.map = {}
    p.map["tids"] = rlist([rlong(tid) for tid in tIndexes])
    p.map["cids"] = rlist([rlong(cid) for cid in cIndexes])
    p.map["zids"] = rlist([rlong(zid) for zid in zIndexes])
    p.map["pixelsId"] = rlong(pixelsId)

    query = "from PlaneInfo as Info where Info.theT in (:tids) and Info.theZ in (:zids) and Info.theC in (:cids) and pixels.id=:pixelsId"

    infoList = queryService.findAllByQuery(query,p)

    # results may not be ordered by tIndex. Put in a map instead
    timeMap = {}
    for info in infoList:
        tIndex = info.theT.getValue()
        time = info.deltaT.getValue() 
        timeMap[tIndex] = time  

RawPixelsStore
--------------

This interface allows access to the pixel values of images. Often the
raw data will need converting into an array of the correct data type, as
provided by this code in
`source:ome.git/components/tools/OmeroPy/src/omero/util/script\_utils.py </ome/browser/ome.git/components/tools/OmeroPy/src/omero/util/script_utils.py>`_.
This method returns a numpy 2D array of the pixel data for the required
plane.

::

    def downloadPlane(rawPixelStore, pixels, z, c, t):
        rawPlane = rawPixelStore.getPlane(z, c, t);
        sizeX = pixels.getSizeX().getValue();
        sizeY = pixels.getSizeY().getValue();
        pixelType = pixels.getPixelsType().getValue().getValue();
        convertType ='>'+str(sizeX*sizeY)+pixelstypetopython.toPython(pixelType);
        convertedPlane = unpack(convertType, rawPlane);
        numpyType = pixelstypetopython.toNumpy(pixelType)
        remappedPlane = numpy.array(convertedPlane, numpyType);
        remappedPlane.resize(sizeX, sizeY);
        return remappedPlane;

This method is used, for example, by a
`source:ome.git/components/tools/OmeroPy/scripts/examples/frapFigure.py </ome/browser/ome.git/components/tools/OmeroPy/scripts/examples/frapFigure.py>`_
(not released) which plots the average pixel intensity in an ellipse ROI
over time, and
`source:ome.git/components/tools/OmeroPy/scripts/omero/util\_scripts/Images\_From\_ROIs.py </ome/browser/ome.git/components/tools/OmeroPy/scripts/omero/util_scripts/Images_From_ROIs.py>`_
script, which creates new images from rectangle ROIs on another image.

::

    import omero.util.script_utils as scriptUtil
    from omero.rtypes import *

    p = omero.sys.Parameters()
    p.map = {}
    p.map["pixelsId"] = rlong(pixelsId)

    # get pixels with pixelsType
    query_string = "select p from Pixels p join fetch p.image i join fetch p.pixelsType pt where i.id=:pixelsId"
    pixels = queryService.findByQuery(query_string, p)
    theX = pixels.getSizeX().getValue()
    theY = pixels.getSizeY().getValue()

    # get the plane
    theZ, theC, theT = (0,0,0)
    pixelsId = pixels.getId().getValue()
    bypassOriginalFile = True
    rawPixelStore.setPixelsId(pixelsId, bypassOriginalFile)
    plane2D = scriptUtil.downloadPlane(rawPixelStore, pixels, theZ, theC, theT)

RawFileStore
------------

The
` RawFileStore <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/slice2html/omero/api/RawFileStore.html#RawFileStore>`_
can be used to upload an OriginalFile to the server, for example to
annotate an image, as implemented in the attachFileToParent() method of
the
`source:ome.git/components/tools/OmeroPy/src/omero/util/script\_utils.py </ome/browser/ome.git/components/tools/OmeroPy/src/omero/util/script_utils.py>`_.
Usage example:

::

    import import omero.util.script_utils as scriptUtil

    # ... session created as described above

    imageId = 101
    filepath = "Desktop/image.png"
    mimetype = "image/png"  

    # create the services we need
    queryService = session.getQueryService()
    updateService = session.getUpdateService()
    rawFileStore = session.createRawFileStore()

    parent = queryService.get("Image", imageId)    # only loads image, not pixels etc

    # uploads the file to the server, attaching it to the 'parent' Project/Dataset as an OriginalFile annotation
    scriptUtil.uploadAndAttachFile(queryService, updateService, rawFileStore, parent, filepath, format, description)

This code is used in the
`source:ome.git/components/tools/OmeroPy/scripts/omero/figure\_scripts/Thumbnail\_Figure.py </ome/browser/ome.git/components/tools/OmeroPy/scripts/omero/figure_scripts/Thumbnail_Figure.py>`_
scripting service script.

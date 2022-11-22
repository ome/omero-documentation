OMERO Python language bindings
==============================

To access the OMERO.server Python API, you need to install the Python client
libraries.

From OMERO 5.6.0 release, the client library ``omero-py`` supports Python 3 and
is now available on PyPI_ and Conda_. The ``omero-py`` API documentation is available at https://omero-py.readthedocs.io/.
We recommend you use a Python virtual environment to install the client library. You can create one using either ``venv`` or ``conda`` (preferred).
If you opt for Conda_, you will need
to install it first, see `miniconda <https://docs.conda.io/en/latest/miniconda.html>`_ for more details.

To install ``omero-py`` using venv:

.. parsed-literal::

    $ python3 -m venv myenv
    $ . myenv/bin/activate
    $ pip install omero-py==\ |version_py|

To install ``omero-py`` using conda (preferred):

.. parsed-literal::

    conda create -n myenv -c conda-forge python=3.8 omero-py
    conda activate myenv

You can then start using the library in the terminal where the environment has been activated:

.. parsed-literal::

    $ python
    >>> from omero.gateway import BlitzGateway
    >>> conn = BlitzGateway('username', 'password', host='omero.server', port=4064)
    >>> conn.connect()

In addition to the auto-generated Python libraries of the core |OmeroApi|,
``omero-py`` includes a more user-friendly Python module 'BlitzGateway' that
facilitates several aspects of working with the Python API, such as
connection handling, object graph traversal and lazy loading.

Building on the 'BlitzGateway', the Jackson Laboratory has created
a module of convenience functions called `ezomero <https://github.com/TheJacksonLaboratory/ezomero>`_.

This page gives you a large number of code samples to get you
started. Then we describe a bit more about :doc:`PythonBlitzGateway`.

All the code examples below can be found at
:sourcedir:`examples/Training/python`.

.. _python-code-samples:

Code samples
------------

Connect to OMERO
^^^^^^^^^^^^^^^^

-  **Import OMERO and the BlitzGateway**

::

    import omero.clients
    from omero.gateway import BlitzGateway


-  **Create a connection**

::

    conn = BlitzGateway(USERNAME, PASSWORD, host=HOST, port=PORT)
    conn.connect()


-  **Create a secure-only connection**

   By default, once we have logged in, data transfer is not encrypted.
   To ensure all data is transferred securely pass the ``secure`` flag.

::

    conn = BlitzGateway(USERNAME, PASSWORD, host=HOST, port=PORT, secure=True)
    conn.connect()


-  **Create a connection using a context manager**

   The BlitzGateway should be closed after use to free up server resources.
   This can be automatically done by using it as a context manager.
   This also automatically calls ``connect()``.

::

    with BlitzGateway(USERNAME, PASSWORD, host=HOST, port=PORT, secure=True) as conn:
        for p in conn.getObjects('Project'):
            print(p.name)
        ...
    # conn.close() is automatically called


-  **Create a connection using an existing session**

   The BlitzGateway can also be initialized from an existing ``omero.client``
   object.

::

    >>> client = omero.client(HOST, PORT)
    >>> session = client.createSession(USERNAME, PASSWORD)
    >>> conn = BlitzGateway(client_obj=client)

In this example the BlitzGateway and client will not be closed automatically.
If nothing else is using the client object you could use ``with BlitzGateway(client_obj=client) as conn``.


-  **Current session details**

::

    # By default, you will have logged into your 'current' group in OMERO. This
    # can be changed by switching group in the OMERO.insight or OMERO.web clients. 

    user = conn.getUser()
    print("Current user:")
    print("   ID:", user.getId())
    print("   Username:", user.getName())
    print("   Full Name:", user.getFullName())

    # Check if you are an Administrator
    print("   Is Admin:", conn.isAdmin())
    if not conn.isFullAdmin():
        # If 'Restricted Administrator' show privileges
        print(conn.getCurrentAdminPrivileges())

    print("Member of:")
    for g in conn.getGroupsMemberOf():
        print("   ID:", g.getName(), " Name:", g.getId())
    group = conn.getGroupFromContext()
    print("Current group: ", group.getName())

    # List the group owners and other members
    owners, members = group.groupSummary()
    print("   Group owners:")
    for o in owners:
        print("     ID: %s %s Name: %s" % (
            o.getId(), o.getOmeName(), o.getFullName()))
    print("   Group members:")
    for m in members:
        print("     ID: %s %s Name: %s" % (
            m.getId(), m.getOmeName(), m.getFullName()))

    print("Owner of:")
    for g in conn.listOwnedGroups():
        print("   ID: ", g.getName(), " Name:", g.getId())

    # Added in OMERO 5.0
    print("Admins:")
    for exp in conn.getAdministrators():
        print("   ID: %s %s Name: %s" % (
            exp.getId(), exp.getOmeName(), exp.getFullName()))

    # The 'context' of our current session
    ctx = conn.getEventContext()
    # print(ctx)     # for more info 

-  **Close connection**

   If you did not use the context manager close the session to free up server
   resources.

::

    conn.close()


Read data
^^^^^^^^^

::

    def print_obj(obj, indent=0):
        """
        Helper method to display info about OMERO objects.
        Not all objects will have a "name" or owner field.
        """
        print("""%s%s:%s  Name:"%s" (owner=%s)""" % (
            " " * indent,
            obj.OMERO_CLASS,
            obj.getId(),
            obj.getName(),
            obj.getOwnerOmeName()))

-  **List all Projects available to me, and their Datasets and Images**

::

    # Load first 5 Projects, filtering by default group and owner
    my_exp_id = conn.getUser().getId()
    default_group_id = conn.getEventContext().groupId
    for project in conn.getObjects("Project", opts={'owner': my_exp_id,
                                                'group': default_group_id,
                                                'order_by': 'lower(obj.name)',
                                                'limit': 5, 'offset': 0}):
        print_obj(project)
        # We can get Datasets with listChildren, since we have the Project already.
        # Or conn.getObjects("Dataset", opts={'project', id}) if we have Project ID
        for dataset in project.listChildren():
            print_obj(dataset, 2)
            for image in dataset.listChildren():
                print_obj(image, 4)

-  **Get Objects by their ID or attributes**

   The first argument for ``conn.getObjects()`` or ``conn.getObject()`` is the object type.
   This is not case sensitive. Supported types are
   ``project``, ``dataset``, ``image``, ``screen``, ``plate``, ``plateacquisition``, ``acquisition``, ``well``,
   ``roi``, ``shape``, ``experimenter``, ``experimentergroup``, ``originalfile``, ``fileset``, ``annotation``.
   You can find attributes of these objects at :slicedoc_blitz:`OMERO model API <omero/model.html>`.

::

    # Find objects by ID. NB: getObjects() returns a generator, not a list
    projects = conn.getObjects("Project", [1, 2, 3])

    # Get a single object by ID. Can use "Annotation" for all types of annotations by ID
    annotation = conn.getObject("Annotation", 1)

    # Find an Object by attribute. E.g. 'name'
    images = conn.getObjects("Image", attributes={"name": name})

-  **Get different types of Annotations***

   Supported types are: ``tagannotation``, ``longannotation``, ``booleanannotation``, ``fileannotation``,
   ``doubleannotation``, ``termannotation``, ``timestampannotation``, ``mapannotation``

::

    # List All Tags that you have permission to access
    conn.getObjects("TagAnnotation")

    # Find Tags with a known text value
    tags = conn.getObjects("TagAnnotation", attributes={"textValue": text})

-  **Retrieve 'orphaned' objects**

::

    # We can use the 'orphaned' filter to find Datasets, Images
    # or Plates that are not in any parent container
    print("\nList orphaned Datasets: \n", "=" * 50)
    datasets = conn.getObjects("Dataset", opts={'orphaned': True})
    for dataset in datasets:
        print_obj(dataset)

-  **Retrieve objects in a container**

::

    # We can filter Images by their parent Dataset
    # We can also filter Datasets by 'project', Plates by 'screen',
    # Wells by 'plate'
    print("\nImages in Dataset:", datasetId, "\n", "=" * 50)
    for image in conn.getObjects('Image', opts={'dataset': datasetId}):
        print_obj(image)

-  **Retrieve an image by Image ID**

::

    # Pixels and Channels will be loaded automatically as needed
    image = conn.getObject("Image", imageId)
    print(image.getName(), image.getDescription())
    # Retrieve information about an image.
    print(" X:", image.getSizeX())
    print(" Y:", image.getSizeY())
    print(" Z:", image.getSizeZ())
    print(" C:", image.getSizeC())
    print(" T:", image.getSizeT())
    # List Channels (loads the Rendering settings to get channel colors)
    for channel in image.getChannels():
        print('Channel:', channel.getLabel())
        print('Color:', channel.getColor().getRGB())
        print('Lookup table:', channel.getLut())
        print('Is reverse intensity?', channel.isReverseIntensity())

    # render the first timepoint, mid Z section
    z = image.getSizeZ() / 2
    t = 0
    rendered_image = image.renderImage(z, t)
    # rendered_image.show()               # popup (use for debug only)
    # rendered_image.save("test.jpg")     # save in the current folder

-  **Get Pixel Sizes for the above Image**

::

    size_x = image.getPixelSizeX()       # e.g. 0.132
    print(" Pixel Size X:", size_x)
    # Units support, new in OMERO 5.1.0
    size_x_obj = image.getPixelSizeX(units=True)
    print(" Pixel Size X:", size_x_obj.getValue(), "(%s)" % size_x_obj.getSymbol())
    # To get the size with different units, e.g. Angstroms
    size_x_ang = image.getPixelSizeX(units="ANGSTROM")
    print(" Pixel Size X:", size_x_ang.getValue(), "(%s)" % size_x_ang.getSymbol())

-  **Retrieve Screening data**

::

    for screen in conn.getObjects("Screen"):
        print_obj(screen)
        for plate in screen.listChildren():
            print_obj(plate, 2)
            plateId = plate.getId()

-  **Retrieve Wells and Images within a Plate**

::

    plate = conn.getObject("Plate", plateId)
    print("\nNumber of fields:", plate.getNumberOfFields())
    print("\nGrid size:", plate.getGridSize())
    print("\nWells in Plate:", plate.getName())
    for well in plate.listChildren():
        index = well.countWellSample()
        print("  Well: ", well.row, well.column, " Fields:", index)
        for index in range(0, index):
            print("    Image: ", \
                well.getImage(index).getName(),\
                well.getImage(index).getId())

-  **List all annotations on an object. Filter for Tags and get textValue**

::

    for ann in project.listAnnotations():
        print(ann.getId(), ann.OMERO_TYPE)
        print(" added by ", ann.link.getDetails().getOwner().getOmeName())
        if ann.OMERO_TYPE == omero.model.TagAnnotationI:
            print("Tag value:", ann.getTextValue())

-  **Get Links between Objects and Annotations**

::

    # Find Images linked to Annotation(s), unlink Images from these annotations
    # and link them to another Tag Annotation
    annotation_ids = [1, 2, 3]
    tag_id = 4
    for link in conn.getAnnotationLinks('Image', ann_ids=annotation_ids):
        print("Image ID:", link.getParent().id)
        print("Annotation ID:", link.getChild().id)
        # Update the child of the underlying omero.model.ImageAnnotationLinkI
        link._obj.child = omero.model.TagAnnotationI(tag_id, False)
        link.save()

    # Find Annotations linked to Object(s), filter by namespace (optional)
    for link in conn.getAnnotationLinks('Image', parent_ids=image_ids, ns=namespace):
        print("Annotation ID:", link.getChild().id)


Groups and permissions
^^^^^^^^^^^^^^^^^^^^^^

-  **We are logged in to our 'default' group**

::

    group = conn.getGroupFromContext()
    print("Current group: ", group.getName())

-  **Each group has defined Permissions set**

::

    group_perms = group.getDetails().getPermissions()
    perm_string = str(group_perms)
    permission_names = {
        'rw----': 'PRIVATE',
        'rwr---': 'READ-ONLY',
        'rwra--': 'READ-ANNOTATE',
        'rwrw--': 'READ-WRITE'}
    print("Permissions: %s (%s)" % (permission_names[perm_string], perm_string))

-  **By default, any query applies to ALL data that we can access in our
   Current group.**

This will be determined by group permissions e.g. in Read-Only or
Read-Annotate groups, this will include other users' data - see
:doc:`/sysadmins/server-permissions`.

::

    projects = conn.listProjects()      # may include other users' data
    for p in projects:
        print(p.getName(), "Owner: ", p.getDetails().getOwner().getFullName())

::

    # Will return None if Image is not in current group
    image = conn.getObject("Image", imageId)
    print("Image: ", image)

-  **For cross-group querying, use ``-1``**

::

    conn.SERVICE_OPTS.setOmeroGroup('-1')
    image = conn.getObject("Image", imageId)     # Will query across all my groups
    print("Image: ", image)
    if image is not None:
        print("Group: ", image.getDetails().getGroup().getName())
        print(image.getDetails().getGroup().getId())    # access groupId without loading group

-  **To query only a single group (not necessarily your 'current' group)**

::

    group_id = image.getDetails().getGroup().getId()
    # This is how we 'switch group' in webclient
    conn.SERVICE_OPTS.setOmeroGroup(group_id)
    projects = conn.listProjects()
    image = conn.getObject("Image", imageId)
    print("Image: ", image)

- **To set (or change) the owner of an object (Admins only)**

::

    tag_ann = omero.gateway.TagAnnotationWrapper(conn)
    tag_ann.setTextValue("Not owned by me")
    # update details of the wrapped omero.model.AnnotationI _obj
    tag_ann._obj.details.owner = ExperimenterI(userId, False)
    tag_ann.save()

    # If we want to perform multiple tasks it may be more convenient to
    # connect as another user. We can use 'user_conn' exactly as for 'conn'
    user = conn.getObject("Experimenter", userId).getName()
    user_conn = conn.suConn(user)
    # This annotation will be owned by user
    map_ann = omero.gateway.MapAnnotationWrapper(user_conn)
    map_ann.setNs(namespace)
    map_ann.setValue(key_values)
    map_ann.save()
    # Link will be owned by the user
    project.linkAnnotation(map_ann)
    user_conn.close()

Raw data access
^^^^^^^^^^^^^^^

-  **Retrieve a given plane**

::

    # Use the pixelswrapper to retrieve the plane as
    # a 2D numpy array see [https://github.com/scipy/scipy]
    #
    # Numpy array can be used for various analysis routines
    #
    image = conn.getObject("Image", imageId)
    size_z = image.getSizeZ()
    size_c = image.getSizeC()
    size_t = image.getSizeT()
    z, t, c = 0, 0, 0                     # first plane of the image
    pixels = image.getPrimaryPixels()
    plane = pixels.getPlane(z, c, t)      # get a numpy array.
    print("\nPlane at zct: ", z, c, t)
    print(plane)
    print("shape: ", plane.shape)
    print("min:", plane.min(), " max:", plane.max(),\
        "pixel type:", plane.dtype.name)

-  **Retrieve a given stack**

::

    # Get a Z-stack of tiles. Using getTiles or getPlanes (see below) returns
    # a generator of data (not all the data in hand) The RawPixelsStore is
    # only opened once (not closed after each plane) Alternative is to use
    # getPlane() or getTile() multiple times - slightly slower.
    c, t = 0, 0                 # First channel and timepoint
    tile = (50, 50, 10, 10)     # x, y, width, height of tile

    # list of [ (0,0,0,(x,y,w,h)), (1,0,0,(x,y,w,h)), (2,0,0,(x,y,w,h))... ]
    zct_list = [(iz, c, t, tile) for iz in range(size_z)]
    print("\nZ stack of tiles:")
    planes = pixels.getTiles(zct_list)
    for i, p in enumerate(planes):
        print("Tile:", zct_list[i], " min:", p.min(),\
            " max:", p.max(), " sum:", p.sum())

-  **Retrieve a given hypercube**

::

    zct_list = []
    for z in range(size_z / 2, size_z):     # get the top half of the Z-stack
        for c in range(size_c):          # all channels
            for t in range(size_t):      # all time-points
                zct_list.append((z, c, t))
    print("\nHyper stack of planes:")
    planes = pixels.getPlanes(zct_list)
    for i, p in enumerate(planes):
        print("plane zct:", zct_list[i], " min:", p.min(), " max:", p.max())

-  **Retrieve a histogram**

::

    # Get a 256 bin histogram for channel 0 and plane z=0/t=0:
    hist = image.getHistogram([0], 256, False, 0, 0)
    print(hist)


Write data
^^^^^^^^^^

-  **Create a new Dataset**

::

    # Use omero.gateway.DatasetWrapper:
    new_dataset = DatasetWrapper(conn, omero.model.DatasetI())
    new_dataset.setName('Scipy_Gaussian_Filter')
    new_dataset.save()
    print("New dataset, Id:", new_dataset.id)
    # Can get the underlying omero.model.DatasetI with:
    dataset_obj = new_dataset._obj

    # OR create the DatasetI directly:
    dataset_obj = omero.model.DatasetI()
    dataset_obj.setName(rstring("New Dataset"))
    dataset_obj = conn.getUpdateService().saveAndReturnObject(dataset_obj, conn.SERVICE_OPTS)
    dataset_id = dataset_obj.getId().getValue()
    print("New dataset, Id:", dataset_id)

-  **Link to Project**

::

    link = omero.model.ProjectDatasetLinkI()
    # We can use a 'loaded' object, but we might get an Exception
    # link.setChild(dataset_obj)
    # Better to use an 'unloaded' object (loaded = False)
    link.setChild(omero.model.DatasetI(dataset_obj.id.val, False))
    link.setParent(omero.model.ProjectI(projectId, False))
    conn.getUpdateService().saveObject(link)

-  **Annotate Project with a new Tag**

::

    tag_ann = omero.gateway.TagAnnotationWrapper(conn)
    tag_ann.setValue("New Tag")
    tag_ann.setDescription("Add optional description")
    tag_ann.save()
    project = conn.getObject("Project", projectId)
    project.linkAnnotation(tag_ann)

-  **Add a Map Annotation (list of key: value pairs)**

::

    key_value_data = [["Drug Name", "Monastrol"], ["Concentration", "5 mg/ml"]]
    map_ann = omero.gateway.MapAnnotationWrapper(conn)
    # Use 'client' namespace to allow editing in Insight & web
    namespace = omero.constants.metadata.NSCLIENTMAPANNOTATION
    map_ann.setNs(namespace)
    map_ann.setValue(key_value_data)
    map_ann.save()
    project = conn.getObject("Project", projectId)
    # NB: only link a client map annotation to a single object
    project.linkAnnotation(map_ann)

-  **Count the number of annotations on one or many objects**

::

    print(conn.countAnnotations('Project', [projectId]))

-  **List all annotations on an object. Get text from tags**

::

    for ann in project.listAnnotations():
        print(ann.getId(), ann.OMERO_TYPE)
        print(" added by ", ann.link.getDetails().getOwner().getOmeName())
        if ann.OMERO_TYPE == omero.model.TagAnnotationI:
            print("Tag value:", ann.getTextValue())

-  **How to create a file annotation and link to a Dataset**

::

    dataset = conn.getObject("Dataset", dataset_id)
    # Specify a local file e.g. could be result of some analysis
    file_to_upload = "README.txt"   # This file should already exist
    with open(file_to_upload, 'w') as f:
        f.write('annotation test')
    # create the original file and file annotation (uploads the file etc.)
    namespace = "my.custom.demo.namespace"
    print("\nCreating an OriginalFile and FileAnnotation")
    file_ann = conn.createFileAnnfromLocalFile(
        file_to_upload, mimetype="text/plain", ns=namespace, desc=None)
    print("Attaching FileAnnotation to Dataset: ", "File ID:", file_ann.getId(), \
        ",", file_ann.getFile().getName(), "Size:", file_ann.getFile().getSize())
    dataset.linkAnnotation(file_ann)     # link it to dataset.

-  **Download a file annotation linked to a Dataset**

::

    # make a location to download the file. "download" folder.
    path = os.path.join(os.path.dirname(__file__), "download")
    if not os.path.exists(path):
        os.makedirs(path)
    # Go through all the annotations on the Dataset. Download any file annotations
    # we find. Filter by namespace is optional
    print("\nAnnotations on Dataset:", dataset.getName())
    namespace = "my.custom.demo.namespace"
    for ann in dataset.listAnnotations(ns=namespace):
        if isinstance(ann, omero.gateway.FileAnnotationWrapper):
            print("File ID:", ann.getFile().getId(), ann.getFile().getName(), \
                "Size:", ann.getFile().getSize())
            file_path = os.path.join(path, ann.getFile().getName())

            with open(str(file_path), 'wb') as f:
                print("\nDownloading file to", file_path, "...")
                for chunk in ann.getFileInChunks():
                    f.write(chunk)
            print("File downloaded!")

-  **Load all the file annotations with a given namespace**

::

    ns_to_include = [namespace]
    ns_to_exclude = []
    metadataService = conn.getMetadataService()
    annotations = metadataService.loadSpecifiedAnnotations(
        'omero.model.FileAnnotation', ns_to_include, ns_to_exclude, None)
    for ann in annotations:
        print(ann.getId().getValue(), ann.getFile().getName().getValue())

-  **Get first annotation with specified namespace**

::

    ann = dataset.getAnnotation(namespace)
    print("Found Annotation with namespace: ", ann.getNs())


.. _python_omero_tables_code_samples:

OMERO tables
^^^^^^^^^^^^

-  **Create a name for the Original File (should be unique)**

::

    from random import random
    table_name = "TablesDemo:%s" % str(random())
    col1 = omero.grid.LongColumn('Uid', 'testLong', [])
    col2 = omero.grid.StringColumn('MyStringColumnInit', '', 64, [])
    columns = [col1, col2]

-  **Create and initialize a new table.**

::

    resources = conn.c.sf.sharedResources()
    repository_id = resources.repositories().descriptions[0].getId().getValue()
    table = resources.newTable(repository_id, table_name)
    table.initialize(columns)

-  **Add data to the table**

::

    ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    strings = ["one", "two", "three", "four", "five",
               "six", "seven", "eight", "nine", "ten"]
    data1 = omero.grid.LongColumn('Uid', 'test Long', ids)
    data2 = omero.grid.StringColumn('MyStringColumn', '', 64, strings)
    data = [data1, data2]
    table.addData(data)
    orig_file = table.getOriginalFile()
    table.close()           # when we are done, close.

-  **Load the table as an original file**

::

    orig_file_id = orig_file.id.val
    # ...so you can attach this data to an object e.g. Dataset
    file_ann = omero.model.FileAnnotationI()
    # use unloaded OriginalFileI
    file_ann.setFile(omero.model.OriginalFileI(orig_file_id, False))
    file_ann = conn.getUpdateService().saveAndReturnObject(file_ann)
    link = omero.model.DatasetAnnotationLinkI()
    link.setParent(omero.model.DatasetI(datasetId, False))
    link.setChild(omero.model.FileAnnotationI(file_ann.getId().getValue(), False))
    conn.getUpdateService().saveAndReturnObject(link)

-  **Table API**


.. seealso:: :slicedoc_blitz:` OMERO Tables <omero/grid/Table.html>`


::

    open_table = resources.openTable(orig_file)
    print("Table Columns:")
    for col in open_table.getHeaders():
        print("   ", col.name)
    rowCount = open_table.getNumberOfRows()
    print("Row count:", rowCount)

-  **Get data from every column of the specified rows**

::

    row_numbers = [3, 5, 7]
    print("\nGet All Data for rows: ", row_numbers)
    data = open_table.readCoordinates(range(rowCount))
    for col in data.columns:
        print("Data for Column: ", col.name)
        for v in col.values:
            print("   ", v)

-  **Get data from every column of the specified rows with slice**

::

    row_numbers = [3, 5, 7]
    print("\nGet All Data for rows with slice: ", row_numbers)
    data = open_table.slice(range(len(open_table.getHeaders())), row_numbers)
    for col in data.columns:
        print("Data for Column: ", col.name)
        for v in col.values:
            print("   ", v)

-  **Get data from specified columns of specified rows**

::

    col_numbers = [1]
    start = 3
    stop = 7
    print("\nGet Data for cols: ", col_numbers,\
        " and between rows: ", start, "-", stop)
    data = open_table.read(col_numbers, start, stop)
    for col in data.columns:
        print("Data for Column: ", col.name)
        for v in col.values:
            print("   ", v)

-  **Get data from specified columns of specified rows with slice**

::

    col_numbers = [1]
    start = 3
    stop = 7
    print("\nGet Data for cols: ", col_numbers,
          " and between rows: ", start, "-", stop,
          " with slice")
    data = open_table.slice(col_numbers, range(start, stop))
    for col in data.columns:
        print("Data for Column: ", col.name)
        for v in col.values:
            print("   ", v)

-  **Query the table for rows where the 'Uid' is in a particular range**

::

    query_rows = open_table.getWhereList(
        "(Uid > 2) & (Uid <= 8)", variables={}, start=0, stop=rowCount, step=0)
    data = open_table.readCoordinates(query_rows)
    for col in data.columns:
        print("Query Results for Column: ", col.name)
        for v in col.values:
            print("   ", v)
    open_table.close()           # we're done

-  **In future, to get the table back from Original File**

::

    orig_table_file = conn.getObject(
        "OriginalFile", attributes={'name': table_name})    # if name is unique
    saved_table = resources.openTable(orig_table_file._obj)
    print("Opened table with row-count:", saved_table.getNumberOfRows())
    saved_table.close()

ROIs
^^^^

-  **Initialize service**

::

    updateService = conn.getUpdateService()
    from omero.rtypes import rdouble, rint, rstring

-  **Create ROI**

::

    # We are using the core Python API and omero.model objects here, since ROIs
    # are not yet supported in the Python Blitz Gateway.
    #
    # First we load our image and pick some parameters for shapes
    x = 50
    y = 200
    width = 100
    height = 50
    image = conn.getObject("Image", imageId)
    z = image.getSizeZ() / 2
    t = 0

::

    # We have a helper function for creating an ROI and linking it to new shapes
    def create_roi(img, shapes):
        # create an ROI, link it to Image
        roi = omero.model.RoiI()
        # use the omero.model.ImageI that underlies the 'image' wrapper
        roi.setImage(img._obj)
        for shape in shapes:
            roi.addShape(shape)
        # Save the ROI (saves any linked shapes too)
        return updateService.saveAndReturnObject(roi)

::

    # Another helper for generating the color integers for shapes
    # see https://www.openmicroscopy.org/Schemas/Documentation/Generated/OME-2016-06/ome_xsd.html#Color for background
    def rgba_to_int(red, green, blue, alpha=255):
        """ Return the color as an Integer in RGBA encoding """
        return int.from_bytes([red, green, blue, alpha],
                          byteorder='big', signed=True)

::

    # create a rectangle shape (added to ROI below)
    print(("Adding a rectangle at theZ: %s, theT: %s, X: %s, Y: %s, width: %s, " +
        "height: %s") % (z, t, x, y, width, height))
    rect = omero.model.RectangleI()
    rect.x = rdouble(x)
    rect.y = rdouble(y)
    rect.width = rdouble(width)
    rect.height = rdouble(height)
    rect.theZ = rint(z)
    rect.theT = rint(t)
    rect.textValue = rstring("test-Rectangle")
    rect.fillColor = rint(rgba_to_int(255, 255, 255, 255))
    rect.strokeColor = rint(rgba_to_int(255, 255, 0, 255))

::

    # create an Ellipse shape (added to ROI below)
    ellipse = omero.model.EllipseI()
    ellipse.x = rdouble(y)
    ellipse.y = rdouble(x)
    ellipse.radiusX = rdouble(width)
    ellipse.radiusY = rdouble(height)
    ellipse.theZ = rint(z)
    ellipse.theT = rint(t)
    ellipse.textValue = rstring("test-Ellipse")

::

    # Create an ROI containing 2 shapes on same plane
    # NB: OMERO.insight client doesn't support display
    # of multiple shapes on a single plane.
    # Therefore the ellipse is removed later (see below)
    create_roi(image, [rect, ellipse])

::

    # create an ROI with single line shape
    line = omero.model.LineI()
    line.x1 = rdouble(x)
    line.x2 = rdouble(x+width)
    line.y1 = rdouble(y)
    line.y2 = rdouble(y+height)
    line.theZ = rint(z)
    line.theT = rint(t)
    line.textValue = rstring("test-Line")
    create_roi(image, [line])

::

    def create_mask(mask_bytes, bytes_per_pixel=1):
        if bytes_per_pixel == 2:
            divider = 16.0
            format_string = "H"  # Unsigned short
            byte_factor = 0.5
        elif bytes_per_pixel == 1:
            divider = 8.0
            format_string = "B"  # Unsigned char
            byte_factor = 1
        else:
            message = "Format %s not supported"
            raise ValueError(message)
        steps = math.ceil(len(mask_bytes) / divider)
        mask = []
        for i in range(int(steps)):
            binary = mask_bytes[
                i * int(divider):i * int(divider) + int(divider)]
            format = str(int(byte_factor * len(binary))) + format_string
            binary = struct.unpack(format, binary)
            s = ""
            for bit in binary:
                s += str(bit)
            mask.append(int(s, 2))
        return bytearray(mask)

::

    mask_x = 50
    mask_y = 50
    mask_h = 100
    mask_w = 100
    # Create [0, 1] mask
    mask_array = numpy.fromfunction(
        lambda x, y: (x * y) % 2, (mask_w, mask_h))
    # Set correct number of bytes per value
    mask_array = mask_array.astype(numpy.uint8)
    # Convert the mask to bytes
    mask_array = mask_array.tostring()
    # Pack the bytes to a bit mask
    mask_packed = create_mask(mask_array, 1)

    # Define mask's fill color
    from omero.gateway import ColorHolder
    mask_color = ColorHolder()
    mask_color.setRed(255)
    mask_color.setBlue(0)
    mask_color.setGreen(0)
    mask_color.setAlpha(100)

::

    # create an ROI with a single mask
    mask = omero.model.MaskI()
    mask.setTheC(rint(0))
    mask.setTheZ(rint(0))
    mask.setTheT(rint(0))
    mask.setX(rdouble(mask_x))
    mask.setY(rdouble(mask_y))
    mask.setWidth(rdouble(mask_w))
    mask.setHeight(rdouble(mask_h))
    mask.setFillColor(rint(mask_color.getInt()))
    mask.setTextValue(rstring("test-Mask"))
    mask.setBytes(mask_packed)
    create_roi(image, [mask])

::

    # create an ROI with single point shape
    point = omero.model.PointI()
    point.x = rdouble(x)
    point.y = rdouble(y)
    point.theZ = rint(z)
    point.theT = rint(t)
    point.textValue = rstring("test-Point")
    create_roi(image, [point])

::

    # create an ROI with a single polygon, setting colors and lineWidth
    polygon = omero.model.PolygonI()
    polygon.theZ = rint(z)
    polygon.theT = rint(t)
    polygon.fillColor = rint(rgba_to_int(255, 0, 255, 50))
    polygon.strokeColor = rint(rgba_to_int(255, 255, 0))
    polygon.strokeWidth = omero.model.LengthI(10, UnitsLength.PIXEL)
    points = "10,20, 50,150, 200,200, 250,75"
    polygon.points = rstring(points)
    create_roi(image, [polygon])

-  **Retrieve ROIs linked to an Image**

::

    roi_service = conn.getRoiService()
    result = roi_service.findByImage(imageId, None)
    for roi in result.rois:
        print("ROI:  ID:", roi.getId().getValue())
        for s in roi.copyShapes():
            shape = {}
            shape['id'] = s.getId().getValue()
            shape['theT'] = s.getTheT().getValue()
            shape['theZ'] = s.getTheZ().getValue()
            if s.getTextValue():
                shape['textValue'] = s.getTextValue().getValue()
            if type(s) == omero.model.RectangleI:
                shape['type'] = 'Rectangle'
                shape['x'] = s.getX().getValue()
                shape['y'] = s.getY().getValue()
                shape['width'] = s.getWidth().getValue()
                shape['height'] = s.getHeight().getValue()
            elif type(s) == omero.model.EllipseI:
                shape['type'] = 'Ellipse'
                shape['x'] = s.getX().getValue()
                shape['y'] = s.getY().getValue()
                shape['radiusX'] = s.getRadiusX().getValue()
                shape['radiusY'] = s.getRadiusY().getValue()
            elif type(s) == omero.model.PointI:
                shape['type'] = 'Point'
                shape['x'] = s.getX().getValue()
                shape['y'] = s.getY().getValue()
            elif type(s) == omero.model.LineI:
                shape['type'] = 'Line'
                shape['x1'] = s.getX1().getValue()
                shape['x2'] = s.getX2().getValue()
                shape['y1'] = s.getY1().getValue()
                shape['y2'] = s.getY2().getValue()
            elif type(s) == omero.model.MaskI:
                shape['type'] = 'Mask'
                shape['x'] = s.getX().getValue()
                shape['y'] = s.getY().getValue()
                shape['width'] = s.getWidth().getValue()
                shape['height'] = s.getHeight().getValue()
            elif type(s) in (
                    omero.model.LabelI, omero.model.PolygonI):
                print(type(s), " Not supported by this code")
            # Do some processing here, or just print:
            print("   Shape:",)
            for key, value in shape.items():
                print("  ", key, value,)
            print("")

-  **Get Pixel Intensities for ROIs**

::

    result = roi_service.findByImage(imageId, None)
    shape_ids = []
    for roi in result.rois:
        for s in roi.copyShapes():
            shape_ids.append(s.id.val)
    ch_index = 0
    # Z/T will only be used if a shape doesn't have Z/T set
    the_z = 0
    the_t = 0
    stats = roi_service.getShapeStatsRestricted(shape_ids, the_z, the_t, [ch_index])
    for s in stats:
        print("Points", s.pointsCount[ch_index])
        print("Min", s.min[ch_index])
        print("Mean", s.mean[ch_index])
        print("Max", s.max[ch_index])
        print("Sum", s.max[ch_index])
        print("StdDev", s.stdDev[ch_index])

-  **Remove shape from ROI**

::

    result = roi_service.findByImage(imageId, None)
    for roi in result.rois:
        for s in roi.copyShapes():
            # Find and remove the Shape we added above
            if s.getTextValue() and s.getTextValue().getValue() == "test-Ellipse":
                print("Removing Shape from ROI...")
                roi.removeShape(s)
                roi = updateService.saveAndReturnObject(roi)


Delete data
^^^^^^^^^^^

-  **Delete Project**

::

    # You can delete a number of objects of the same type at the same
    # time. In this case 'Project'. Use deleteChildren=True if you are
    # deleting a Project and you want to delete Datasets and Images.
    obj_ids = [project_id]
    delete_children = False
    conn.deleteObjects(
        "Project", obj_ids, deleteAnns=True,
        deleteChildren=delete_children, wait=True)

-  **Retrieve callback and wait until delete completes**

::

    # This is not necessary for the Delete to complete. Can be used
    # if you want to know when delete is finished or if there were any errors
    handle = conn.deleteObjects("Project", [project_id])
    cb = omero.callbacks.CmdCallbackI(conn.c, handle)
    print("Deleting, please wait.")
    while not cb.block(500):
        print(".")
    err = isinstance(cb.getResponse(), omero.cmd.ERR)
    print("Error?", err)
    if err:
        print(cb.getResponse())
    cb.close(True)      # close handle too

- **Delete Annotations on an Object**

::

    i = conn.getObject("Image", image_id)
    to_delete = []
    # Optionally to filter by namespace
    for ann in i.listAnnotations(ns=namespace):
        to_delete.append(ann.id)
    conn.deleteObjects('Annotation', to_delete, wait=True)

- **Remove Annotations from an Object (unlink but don't delete)**

::

    i = conn.getObject("Image", image_id)
    to_delete = []
    for ann in i.listAnnotations():
        to_delete.append(ann.link.id)
    conn.deleteObjects("ImageAnnotationLink", to_delete, wait=True)

Render Images
^^^^^^^^^^^^^

-  **Get thumbnail**

::
    from PIL import Image
    from io import BytesIO
    # Thumbnail is created using the current rendering settings on the image
    image = conn.getObject("Image", imageId)
    img_data = image.getThumbnail()
    rendered_thumb = Image.open(BytesIO(img_data))
    # rendered_thumb.show()           # shows a pop-up
    rendered_thumb.save("thumbnail.jpg")

-  **Get current settings**

::

    print("Channel rendering settings:")
    for ch in image.getChannels():
        # if no name, get emission wavelength or index
        print("Name: ", ch.getLabel())
        print("  Color:", ch.getColor().getHtml())
        print("  Active:", ch.isActive())
        print("  Levels:", ch.getWindowStart(), "-", ch.getWindowEnd())
    print("isGreyscaleRenderingModel:", image.isGreyscaleRenderingModel())
    print("Default Z/T positions:")
    print("    Z = %s, T = %s" % (image.getDefaultZ(), image.getDefaultT()))


-  **Show the saved rendering settings on this image**

::

    print("Rendering Defs on Image:")
    for rdef in image.getAllRenderingDefs():
        img_data = image.getThumbnail(rdefId=rdef['id'])
        print("   ID: %s (owner: %s %s)" % (
            rdef['id'], rdef['owner']['firstName'], rdef['owner']['lastName']))



-  **Render each channel as a separate grayscale image**

::

    image.setGreyscaleRenderingModel()
    size_c = image.getSizeC()
    z = image.getSizeZ() / 2
    t = 0
    for c in range(1, size_c + 1):       # Channel index starts at 1
        channels = [c]                  # Turn on a single channel at a time
        image.setActiveChannels(channels)
        rendered_image = image.renderImage(z, t)
        # renderedImage.show()                        # popup (use for debug only)
        rendered_image.save("channel%s.jpg" % c)     # save in the current folder


-  **Turn 3 channels on, setting their colors**

::

    image.setColorRenderingModel()
    channels = [1, 2, 3]
    color_list = ['F00', None, 'FFFF00']  # do not change color of 2nd channel
    image.setActiveChannels(channels, colors=color_list)
    # max intensity projection 'intmean' for mean-intensity
    image.setProjection('intmax')
    rendered_image = image.renderImage(z, t)  # z and t are ignored for projections
    # renderedImage.show()
    rendered_image.save("all_channels.jpg")
    image.setProjection('normal')               # turn off projection

-  **Turn 2 channels on, setting levels of the first one**

::

    channels = [1, 2]
    range_list = [[100.0, 120.2], [None, None]]
    image.setActiveChannels(channels, windows=range_list)
    # Set default Z and T. These will be used as defaults for further rendering
    image.setDefaultZ(0)
    image.setDefaultT(0)
    # default compression is 0.9
    rendered_image = image.renderImage(z=None, t=None, compression=0.5)
    rendered_image.show()
    rendered_image.save("two_channels.jpg")

-  **Save the current rendering settings & default Z/T**

::

    image.saveDefaults()

-  **Reset to settings at import time, and optionally save**

::

    image.resetDefaults(save=True)

Create Image
^^^^^^^^^^^^

-  **Create an image from scratch**

::

    # This example demonstrates the usage of the convenience method
    # createImageFromNumpySeq() Here we create a multi-dimensional image from a
    # hard-coded array of data.
    from numpy import array, int8
    import omero
    size_x, size_y, size_z, size_c, size_t = 5, 4, 1, 2, 1
    plane1 = array(
        [[0, 1, 2, 3, 4], [5, 6, 7, 8, 9], [0, 1, 2, 3, 4], [5, 6, 7, 8, 9]],
        dtype=int8)
    plane2 = array(
        [[5, 6, 7, 8, 9], [0, 1, 2, 3, 4], [5, 6, 7, 8, 9], [0, 1, 2, 3, 4]],
        dtype=int8)
    planes = [plane1, plane2]

::

    def plane_gen():
        """generator will yield planes"""
        for p in planes:
            yield p

::

    desc = "Image created from a hard-coded arrays"
    i = conn.createImageFromNumpySeq(
        plane_gen(), "numpy image", size_z, size_c, size_t, description=desc,
        dataset=None)
    print('Created new Image:%s Name:"%s"' % (i.getId(), i.getName()))

-  **Set the pixel size using units (added in 5.1.0)**


Lengths are specified by value and a unit enumeration
Here we set the pixel size X and Y to be 9.8 Angstroms


::

    from omero.model.enums import UnitsLength
    # Re-load the image to avoid update conflicts
    i = conn.getObject("Image", i.getId())
    u = omero.model.LengthI(9.8, UnitsLength.ANGSTROM)
    p = i.getPrimaryPixels()._obj
    p.setPhysicalSizeX(u)
    p.setPhysicalSizeY(u)
    conn.getUpdateService().saveObject(p)

-  **Create an Image from an existing image**

::

    # We are going to create a new image by passing the method a 'generator' of 2D
    # planes This will come from an existing image, by taking the average of 2
    # channels.
    zct_list = []
    image = conn.getObject('Image', imageId)
    size_z, size_c, size_t = image.getSizeZ(), image.getSizeC(), image.getSizeT()
    dataset = image.getParent()
    pixels = image.getPrimaryPixels()
    new_size_c = 1

::

    def plane_gen():
        """
        set up a generator of 2D numpy arrays.

        The createImage method below expects planes in the order specified here
        (for z.. for c.. for t..)
        """
        for z in range(size_z):              # all Z sections
            # Illustrative purposes only, since we only have 1 channel
            for c in range(new_size_c):
                for t in range(size_t):      # all time-points
                    channel0 = pixels.getPlane(z, 0, t)
                    channel1 = pixels.getPlane(z, 1, t)
                    # Here we can manipulate the data in many different ways. As
                    # an example we are doing "average"
                    # average of 2 channels
                    new_plane = (channel0 + channel1) / 2
                    print("newPlane for z,t:", z, t, new_plane.dtype, \
                        new_plane.min(), new_plane.max())
                    yield new_plane

::

    desc = ("Image created from Image ID: %s by averaging Channel 1 and Channel 2"
        % imageId)
    i = conn.createImageFromNumpySeq(
        plane_gen(), "new image", size_z, new_size_c, size_t, description=desc,
        dataset=dataset)


Filesets - added in OMERO 5.0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  **Get the 'Fileset' for an Image**

::

    # A Fileset is a collection of the original files imported to
    # create an image or set of images in OMERO.
    image = conn.getObject("Image", imageId)
    fileset = image.getFileset()       # will be None for pre-FS images
    fs_id = fileset.getId()
    # List all images that are in this fileset
    for fs_image in fileset.copyImages():
        print(fs_image.getId(), fs_image.getName())
    # List original imported files
    for orig_file in fileset.listFiles():
        name = orig_file.getName()
        path = orig_file.getPath()
        print(path, name)

-  **Get Original Imported Files directly from the image**

::

    # this will include pre-FS data IF images were archived on import
    print(image.countImportedImageFiles())
    # specifically count Fileset files
    file_count = image.countFilesetFiles()
    # list files
    if file_count > 0:
        for orig_file in image.getImportedImageFiles():
            name = orig_file.getName()
            path = orig_file.getPath()
            print(path, name)

-  **Can get the Fileset using conn.getObject()**

::

    fileset = conn.getObject("Fileset", fs_id)


Python OMERO.scripts
^^^^^^^^^^^^^^^^^^^^

It is relatively straightforward to take the code samples above and
re-use them in OMERO.scripts. This allows the code to be run on the
OMERO server and called from either the OMERO.insight client or
OMERO.web by any users of the server. See :doc:`/developers/scripts/user-guide`.

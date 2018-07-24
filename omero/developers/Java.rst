OMERO Java language bindings
============================

Using the :zerocdoc:`Ice Java language mapping
<display/Ice/Hello+World+Application>` from ZeroC_, OMERO provides access to
your data within an :doc:`/developers/server-blitz` server from Java code.

All the code examples below can be found at
:sourcedir:`examples/Training/java/src/training`.

Writing client apps
-------------------

To make use of the OMERO Java API and interact with
:doc:`/developers/server-blitz` from your code, a client application needs the
Java bindings available on the classpath.

The required :file:`.jar` files can be obtained in a number of ways:

* manually from the `OME artifactory`_. All available artifacts and their POM
  files can be browsed using the
  `Maven repository
  <https://artifacts.openmicroscopy.org/artifactory/maven/>`_.
* using the :file:`OMERO.java` ZIP file downloaded from the
  :downloads:`Java <>` section of the OMERO download page.
  The :file:`libs` directory can then be used on the Java classpath (or
  attached to a project in Eclipse).
* following the example in
  `minimal-omero-client <https://github.com/ome/minimal-omero-client>`_.
  Please make sure you are using the proper branch of the repository, as that
  influences the versions of dependencies defined in the Maven POM file.

Extended classpath
------------------

To access all the functionality available in omero\_client.jar or to use the
importer, you will need more jar files. To see all the current requirements,
take a look at the builds on :jenkins:`jenkins <>`, or alternatively examine
the dependencies in the ivy.xml files (e.g.
:source:`components/insight/ivy.xml`)

.. _javagateway:

Java Gateway
------------

The Java :javadoc:`Gateway <omero/gateway/Gateway.html>` is a
wrapper around the :zerocdoc:`Ice Java language mapping
<display/Ice/Hello+World+Application>` and the :doc:`Modules/Api` which makes
it easier to interact with an OMERO server in Java.

The :javadoc:`Gateway <omero/gateway/Gateway.html>` is the central object
for maintaining the connection to the server, see :ref:`gatewayconnect`

Functionality for interacting with the server is encapsulated into different
:javadoc:`facilities </omero/gateway/facility/package-summary.html>`.
For an example using the :javadoc:`BrowseFacility <omero/gateway/facility/BrowseFacility.html>`
to access Projects, Datasets, etc. see :ref:`gatewaybrowse`.

As the plain Ice objects can be a bit 'bulky' to handle, they are usually wrapped
into Java  :javadoc:`DataObjects <omero/gateway/model/DataObject.html>`.

.. _gatewayconnect:

Connect to OMERO
----------------

-  **Connect to the server**. Remember to close the session.

::

    LoginCredentials cred = new LoginCredentials(userName, password, host, port);

    // Alternative using args array:
    // args = new String[] { "--omero.host=" + hostName, "--omero.port=" + port,
    //                "--omero.user=" + userName, "--omero.pass=" + password };
    // LoginCredentials cred = new LoginCredentials(args);

    // If you want to join an existing session you can use the session ID as 
    // user name and a 'null' password:
    // LoginCredentials cred = new LoginCredentials(sessionID, null, host, port);
    
    //Create a simple Logger object which just writes
    //to System.out or System.err
    Logger simpleLogger = new SimpleLogger();

    Gateway gateway = new Gateway(simpleLogger);
    ExperimenterData user = gateway.connect(cred);

    //for every subsequent call to the server you'll need the
    //SecurityContext for a certain group; in this case create
    //a SecurityContext for the user's default group.
    SecurityContext ctx = new SecurityContext(user.getGroupId());

-  **Close connection**. **IMPORTANT**

::

    gateway.disconnect();

.. _gatewaybrowse:

Read data
---------

The BrowseFacility offers methods for browsing within the data hierarchy.
A list of examples follows, indicating how to load
Project, Dataset, Screen, etc.

-  **Retrieve the projects** owned by the user currently logged in.

If a Project contains Datasets, the Datasets will automatically be
loaded.

::

    BrowseFacility browse = gateway.getFacility(BrowseFacility.class);

    Collection<ProjectData> projects = browse.getProjects(ctx);

    Iterator<ProjectData> i = projects.iterator();
    ProjectData project;
    Set<DatasetData> datasets;
    Iterator<DatasetData> j;
    DatasetData dataset;
    while (i.hasNext()) {
        project = i.next();
        String name = projet.getName();
        long id = project.getId();
        datasets = project.getDatasets();
        j = datasets.iterator();
        while (j.hasNext()) {
            dataset = j.next();
            // Do something here
            // If images loaded.
            // dataset.getImages();
        }
    }

-  **Retrieve the Datasets** owned by the user currently logged in.

::

    BrowseFacility browse = gateway.getFacility(BrowseFacility.class);
    Collection<DatasetData> datasets = browse.getDatasets(ctx);
        
    Iterator<DatasetData> i = datasets.iterator();
    DatasetData dataset;
    Set<ImageData> images;
    Iterator<ImageData> j;
    ImageData image;
    while (i.hasNext()) {
        dataset = i.next();
        images = dataset.getImages();
        j = images.iterator();
        while (j.hasNext()) {
            image = j.next();
            //Do something
        }
    }

-  **Retrieve the Images** contained in a Dataset.

::

    BrowseFacility browse = gateway.getFacility(BrowseFacility.class);
    Collection<ImageData> images = browse.getImagesForDatasets(ctx, Arrays.asList(datasetId));

    Iterator<ImageData> j = images.iterator();
    ImageData image;
    while (j.hasNext()) {
        image = j.next();
        // Do something
    }

-  **Retrieve an Image** if the identifier is known.

::

    BrowseFacility browse = gateway.getFacility(BrowseFacility.class);
    ImageData image = browse.getImage(ctx, imageId);

-  **Access information about the image** for example to draw it.

The model is as follows: Image-Pixels i.e. to access valuable data about
the image you need to use the pixels object. We now only support one set
of pixels per image (it used to be more!).

::

    PixelsData pixels = image.getDefaultPixels();
    int sizeZ = pixels.getSizeZ(); // The number of z-sections.
    int sizeT = pixels.getSizeT(); // The number of timepoints.
    int sizeC = pixels.getSizeC(); // The number of channels.
    int sizeX = pixels.getSizeX(); // The number of pixels along the X-axis.
    int sizeY = pixels.getSizeY(); // The number of pixels along the Y-axis.

-  **Retrieve Screening data** owned by the user currently logged
   in\ **.**

Note that the wells are not loaded.

::

    BrowseFacility browse = gateway.getFacility(BrowseFacility.class);
    Collection<ScreenData> screens = browse.getScreens(ctx);

    Iterator<ScreenData> i = screens.iterator();
    ScreenData screen;
    Set<PlateData> plates;
    Iterator<PlateData> j;
    PlateData plate;
    while (i.hasNext()) {
        screen = i.next();
        plates = screen.getPlates();
        j = plates.iterator();
        while (j.hasNext()) {
            plate = j.next();
        }
    }

-  **Retrieve Wells within a Plate.**

Given a plate ID, load the wells.

::

    BrowseFacility browse = gateway.getFacility(BrowseFacility.class);
    Collection<WellData> wells = browse.getWells(ctx, plateId);

    Iterator<WellData> i = wells.iterator();
    WellData well;
    while (i.hasNext()) {
        well = i.next();
        //Do something
    }

-  **Retrieve Annotations.**

Load the MapAnnotations (Key-Value pairs) for the logged-in user.

::

    BrowseFacility browse = gateway.getFacility(BrowseFacility.class);
    ImageData image = browse.getImage(ctx, imageId);

    // load only this user's annotations
    List<Long> userIds = new ArrayList<Long>();
    userIds.add(this.user.getId());

    // load only MapAnnotations
    List<Class<? extends AnnotationData>> types = new ArrayList<Class<? extends AnnotationData>>();
    types.add(MapAnnotationData.class);

    MetadataFacility metadata = gateway.getFacility(MetadataFacility.class);
    List<AnnotationData> annotations = metadata.getAnnotations(ctx, image,
           types, userIds);
    for (AnnotationData annotation : annotations) {
        MapAnnotationData mapAnnotation = (MapAnnotationData) annotation;
        List<NamedValue> list = (List<NamedValue>) mapAnnotation
                .getContent();
        System.out.println("\nMapAnnotation ID: "+mapAnnotation.getId());
        for (NamedValue namedValue : list)
            System.out.println(namedValue.name + ": " + namedValue.value);
    }

Raw data access
---------------

-  **Retrieve a given plane.**

This is useful when you need for example the pixels intensity.

::

    try (RawDataFacility rdf = gateway.getFacility(RawDataFacility.class)) {
        PixelsData pixels = image.getDefaultPixels();
        int sizeZ = pixels.getSizeZ();
        int sizeT = pixels.getSizeT();
        int sizeC = pixels.getSizeC();
            
        Plane2D p;
        for (int z = 0; z < sizeZ; z++) 
            for (int t = 0; t < sizeT; t++) 
                for (int c = 0; c < sizeC; c++) {
                    p = rdf.getPlane(ctx, pixels, z, t, c);
                }
    }

-  **Retrieve a given tile.**

::

    try (RawDataFacility rdf = gateway.getFacility(RawDataFacility.class)) {
        PixelsData pixels = image.getDefaultPixels();
        int sizeZ = pixels.getSizeZ();
        int sizeT = pixels.getSizeT();
        int sizeC = pixels.getSizeC();
        int x = 0;
        int y = 0;
        int width = pixels.getSizeX()/2;
        int height = pixels.getSizeY()/2;
        Plane2D p;
        for (int z = 0; z < sizeZ; z++) {
            for (int t = 0; t < sizeT; t++) {
                for (int c = 0; c < sizeC; c++) {
                    p = rdf.getTile(ctx, pixels, z, t, c, x, y, width, height);
                }    
            }
        }
    }

-  **Retrieve a given stack.**

This is useful when you need the pixels intensity.

::

    PixelsData pixels = image.getDefaultPixels();
    int sizeT = pixels.getSizeT();
    int sizeC = pixels.getSizeC();
    long pixelsId = pixels.getId();
    RawPixelsStorePrx store = null;
    try{
        store = gateway.getPixelsStore(ctx);
        store.setPixelsId(pixelsId, false);
        for (int t = 0; t < sizeT; t++) {
            for (int c = 0; c < sizeC; c++) {
                byte[] plane = store.getStack(c, t);
                //Do something
            }
        }
    } finally {
        store.close();
    }   

-  **Retrieve a given hypercube.**

This is useful when you need the pixels intensity.

::

    PixelsData pixels = image.getDefaultPixels();
    long pixelsId = pixels.getId();
    //offset values in each dimension XYZCT
    List<Integer> offset = new ArrayList<Integer>();
    int n = 5;
    for (int i = 0; i < n; i++) {
        offset.add(i, 0);
    }

    List<Integer> size = new ArrayList<Integer>();
    size.add(pixels.getSizeX());
    size.add(pixels.getSizeY());
    size.add(pixels.getSizeZ());
    size.add(pixels.getSizeC());
    size.add(pixels.getSizeT());

    //indicate the step in each direction, step = 1, 
    //will return values at index 0, 1, 2.
    //step = 2, values at index 0, 2, 4 etc.
    List<Integer> step = new ArrayList<Integer>();
    for (int i = 0; i < n; i++) {
        step.add(i, 1);
    }
    RawPixelsStorePrx store = null;
    try {
        store = gateway.getPixelsStore(ctx);
        store.setPixelsId(pixelsId, false);
        byte[] values = store.getHypercube(offset, size, step);
        //Do something
    } finally {
        store.close();
    }

-  **Retrieve a histogram.**

::

    try (RawDataFacility rdf = gateway.getFacility(RawDataFacility.class)) {
        PixelsData pixels = image.getDefaultPixels();
        int[] channels = new int[] { 0 };
        int binCount = 256;
        Map<Integer, int[]> histdata = rdf.getHistogram(ctx, pixels,
                channels, binCount, false, null);
        int[] histogram = histdata.get(0);
        //Do something with the histogram data
    }

Write data
----------

-  **Create a dataset and link it to an existing project.**

::
    
    DataManagerFacility dm = gateway.getFacility(DataManagerFacility.class);
    
    //Using IObject directly
    Dataset dataset = new DatasetI();
    dataset.setName(omero.rtypes.rstring("new Name 1"));
    dataset.setDescription(omero.rtypes.rstring("new description 1"));
    ProjectDatasetLink link = new ProjectDatasetLinkI();
    link.setChild(dataset);
    link.setParent(new ProjectI(projectId, false));
    IObject r = dm.saveAndReturnObject(ctx, link);
    
    //Using the pojo
    DatasetData datasetData = new DatasetData();
    datasetData.setName("new Name 2");
    datasetData.setDescription("new description 2");
    BrowseFacility b = gateway.getFacility(BrowseFacility.class);
    ProjectData projectData = b.getProjects(ctx, Collections.singleton(projectId)).iterator().next();
    datasetData.setProjects(Collections.singleton(projectData));
    DataObject r2 = dm.saveAndReturnObject(ctx, datasetData);

- **Import images into a dataset.**

Using the Java API directly:

::
    
    String paths = new String[] {"/pathTo/image1.dv", "/pathTo/image2.dv"};

    ImportConfig config = new ome.formats.importer.ImportConfig();
    
    config.email.set("");
    config.sendFiles.set(true);
    config.sendReport.set(false);
    config.contOnError.set(false);
    config.debug.set(false);

    config.hostname.set("localhost");
    config.port.set(4064);
    config.username.set("root");
    config.password.set("omero");
    
    // the imported image will go into 'orphaned images' unless
    // you specify a particular existing dataset like this:    
    // config.targetClass.set("omero.model.Dataset");
    // config.targetId.set(1L);
        
    OMEROMetadataStoreClient store;
    try {
        store = config.createStore();
        store.logVersionInfo(config.getIniVersionNumber());
        OMEROWrapper reader = new OMEROWrapper(config);
        ImportLibrary library = new ImportLibrary(store, reader);

        ErrorHandler handler = new ErrorHandler(config);
        library.addObserver(new LoggingImportMonitor());

        ImportCandidates candidates = new ImportCandidates(reader, paths, handler);
        reader.setMetadataOptions(new DefaultMetadataOptions(MetadataLevel.ALL));
        library.importCandidates(config, candidates);

        store.logout();

    } catch (Exception e) {
        e.printStackTrace();
    }

-  **Create a tag (tag annotation) and link it to an existing project.**

::

    DataManagerFacility dm = gateway.getFacility(DataManagerFacility.class);
        
    TagAnnotation tag = new TagAnnotationI();
    tag.setTextValue(omero.rtypes.rstring("new tag 1"));
    tag.setDescription(omero.rtypes.rstring("new tag 1"));
        
    //Using the model object (recommended)
    TagAnnotationData tagData = new TagAnnotationData("new tag 2");
    tagData.setTagDescription("new tag 2");
        
    ProjectAnnotationLink link = new ProjectAnnotationLinkI();
    link.setChild(tag);
    link.setParent(new ProjectI(info.getProjectId(), false));
    IObject r = dm.saveAndReturnObject(ctx, link);
    //With model object
    link = new ProjectAnnotationLinkI();
    link.setChild(tagData.asAnnotation());
    link.setParent(new ProjectI(info.getProjectId(), false));
    r = dm.saveAndReturnObject(ctx, link);

-  **Create a map annotation (list of key: value pairs) and link it to an existing project.**

::

    List<NamedValue> result = new ArrayList<NamedValue>();
    result.add(new NamedValue("mitomycin-A", "20mM"));
    result.add(new NamedValue("PBS", "10mM"));
    result.add(new NamedValue("incubation", "5min"));
    result.add(new NamedValue("temperature", "37"));
    result.add(new NamedValue("Organism", "Homo sapiens"));
    MapAnnotationData data = new MapAnnotationData();
    data.setContent(result);
    data.setDescription("Training Example");
    //Use the following namespace if you want the annotation to be editable
    //in the webclient and insight
    data.setNameSpace(MapAnnotationData.NS_CLIENT_CREATED);
    DataManagerFacility fac = gateway.getFacility(DataManagerFacility.class);
    fac.attachAnnotation(ctx, data, new ProjectData(new ProjectI(projectId, false)));

-  **Create a file annotation and link to an image.**

To attach a file to an object e.g. an image, few objects need to be
created:

#. an ``OriginalFile``
#. a ``FileAnnotation``
#. a link between the ``Image`` and the ``FileAnnotation``.

::

    int INC = 262144;
    DataManagerFacility dm = gateway.getFacility(DataManagerFacility.class);
        
    //To retrieve the image see above.
    File file = File.createTempFile("temp-file-name_", ".tmp"); 
    String name = file.getName();
    String absolutePath = file.getAbsolutePath();
    String path = absolutePath.substring(0, 
            absolutePath.length()-name.length());
    
    //create the original file object.
    OriginalFile originalFile = new OriginalFileI();
    originalFile.setName(omero.rtypes.rstring(name));
    originalFile.setPath(omero.rtypes.rstring(path));
    originalFile.setSize(omero.rtypes.rlong(file.length()));
    final ChecksumAlgorithm checksumAlgorithm = new ChecksumAlgorithmI();
    checksumAlgorithm.setValue(omero.rtypes.rstring(ChecksumAlgorithmSHA1160.value));
    originalFile.setHasher(checksumAlgorithm);
    originalFile.setMimetype(omero.rtypes.rstring(fileMimeType)); // or "application/octet-stream"
    //Now we save the originalFile object
    originalFile = (OriginalFile) dm.saveAndReturnObject(ctx, originalFile);

    //Initialize the service to load the raw data
    RawFileStorePrx rawFileStore = gateway.getRawFileService(ctx);
    
    long pos = 0;
    int rlen;
    byte[] buf = new byte[INC];
    ByteBuffer bbuf;
    //Open file and read stream
    try (FileInputStream stream = new FileInputStream(file)) {
        rawFileStore.setFileId(originalFile.getId().getValue());
        while ((rlen = stream.read(buf)) > 0) {
            rawFileStore.write(buf, pos, rlen);
            pos += rlen;
            bbuf = ByteBuffer.wrap(buf);
            bbuf.limit(rlen);
        }
        originalFile = rawFileStore.save();
    } finally {
       rawFileStore.close();
    }
    //now we have an original File in DB and raw data uploaded.
    //We now need to link the Original file to the image using 
    //the File annotation object. That's the way to do it.
    FileAnnotation fa = new FileAnnotationI();
    fa.setFile(originalFile);
    fa.setDescription(omero.rtypes.rstring(description)); // The description set above e.g. PointsModel
    fa.setNs(omero.rtypes.rstring(NAME_SPACE_TO_SET)); // The name space you have set to identify the file annotation.

    //save the file annotation.
    fa = (FileAnnotation) dm.saveAndReturnObject(ctx, fa);

    //now link the image and the annotation
    ImageAnnotationLink link = new ImageAnnotationLinkI();
    link.setChild(fa);
    link.setParent(image.asImage());
    //save the link back to the server.
    link = (ImageAnnotationLink) dm.saveAndReturnObject(ctx, link);
    // o attach to a Dataset use DatasetAnnotationLink;

-  **Load all the file annotations with a given namespace.**

::

    long userId = gateway.getLoggedInUser().getId();
    List<String> nsToInclude = new ArrayList<String>();
    nsToInclude.add(NAME_SPACE_TO_SET);
    List<String> nsToExclude = new ArrayList<String>();
    ParametersI param = new ParametersI();
    param.exp(omero.rtypes.rlong(userId)); //load the annotation for a given user.
    IMetadataPrx proxy = gateway.getMetadataService(ctx);
    List<Annotation> annotations = proxy.loadSpecifiedAnnotations(
            FileAnnotation.class.getName(), nsToInclude, nsToExclude, param);
    //Do something with annotations.

-  **Read the attachment.**

First load the annotations, cf. above.

::

    Iterator<Annotation> j = annotations.iterator();
    Annotation annotation;
    FileAnnotationData fa;
    RawFileStorePrx store = gateway.getRawFileService(ctx);
    File file = File.createTempFile("temp-file-name_", ".tmp"); 
    int index = 0;
    
    OriginalFile of;
    try (FileOutputStream stream = new FileOutputStream(file)) {
        while (j.hasNext()) {
            annotation = j.next();
            if (annotation instanceof FileAnnotation && index == 0) {
                fa = new FileAnnotationData((FileAnnotation) annotation);
                //The id of the original file
                of = getOriginalFile(fa.getFileID());
                store.setFileId(fa.getFileID());
                int offset = 0;
                long size = of.getSize().getValue();
                //name of the file
                String fileName = of.getName().getValue();
                try {
                    for (offset = 0; (offset+INC) < size;) {
                        stream.write(store.read(offset, INC));
                        offset += INC;
                    }   
                } finally {
                    stream.write(store.read(offset, (int) (size-offset))); 
                }
                index++;
            }
        }
    } finally {
        store.close();
    }
    file.delete();

.. _java_omero_tables_code_samples:

How to use OMERO tables
-----------------------

-  **Create and read a table.**

In the following example, we create a table with 2 columns.

::

    TableDataColumn[] columns = new TableDataColumn[3];
    columns[0] =  new TableDataColumn("ID", 0, Long.class);
    columns[1] =  new TableDataColumn("Name", 1, String.class);
    columns[2] =  new TableDataColumn("Value", 2, Double.class);

    Object[][] data = new Object[3][5];
    data[0] = new Long[] {1l, 2l, 3l, 4l, 5l};
    data[1] = new String[] {"one", "two", "three", "four", "five"};
    data[2] = new Double[] {1d, 2d, 3d, 4d, 5d};

    TableData tableData = new TableData(columns, data);

    TablesFacility fac = gateway.getFacility(TablesFacility.class);

    // Attach the table to the image
    tableData = fac.addTable(ctx, image, "My Data", tableData);

    // Find the table again
    Collection<FileAnnotationData> tables = fac.getAvailableTables(ctx, image);
    long fileId  = tables.iterator().next().getFileID();

    // Request second and third column of the first three rows
    TableData tableData2 = fac.getTable(ctx, fileId, 0, 2, 1, 2);

    // do something, e.g. print to System.out
    int nRows = tableData2.getData()[0].length;
    for (int row = 0; row < nRows; row++) {
        for (int col = 0; col < tableData2.getColumns().length; col++) {
            Object o = tableData2.getData()[col][row];
            System.out.print(o + " ["
                    + tableData2.getColumns()[col].getType() + "]\t");
        }
        System.out.println();
    }


ROIs
----

To learn about the model see the
:model_doc:`ROI Model documentation <developers/roi.html>`. Note that
annotations can be linked to ROI or shape.

-  **Create ROI.**

In this example, we create an ROI with a rectangular shape and attach it
to an image.

::

    DataManagerFacility dm = gateway.getFacility(DataManagerFacility.class);
    ROIFacility roifac = gateway.getFacility(ROIFacility.class);

    //To retrieve the image see above.
    ROIData data = new ROIData();
    data.setImage(image);
    //Create a rectangle.
    RectangleData rectangle = new RectangleData(10, 10, 10, 10);
    rectangle.setZ(0);
    rectangle.setT(0);
    data.addShapeData(rectangle);

    //Add a mask
    PixelsData pixels = image.getDefaultPixels();
    long pixelsId = pixels.getId();
    RawPixelsStorePrx store = gateway.getPixelsStore(ctx);
    try {
        store.setPixelsId(pixelsId, false);
        byte[] mask = store.getStack(0, 0);
        MaskData maskData = new MaskData(10, 10, 100.0, 100.0, mask);
        maskData.setZ(0);
        maskData.setT(0);
        data.addShapeData(maskData);
    } finally {
        store.close();
    }

    //Create an ellipse.
    EllipseData ellipse = new EllipseData(10, 10, 10, 10);
    //Not setting the Z and T for this shape object, this is also allowed in the model.
    //set angle of rotation
    double theta = 10;
    //create transform object
    AffineTransformI newTform = omero.model.AffineTransformI();
    newTform.setA00(omero.rtypes.rdouble(cos(theta)));
    newTform.setA10(omero.rypes.rdouble(-sin(theta)));
    newTform.setA01(omero.rypes.rdouble(sin(theta)));
    newTform.setA11(omero.rypes.rdouble(cos(theta)));
    newTform.setA02(omero.rypes.rdouble(0));
    newTform.setA12(omero.rypes.rdouble(0));
    //add transform
    ellipse.setTransform(newTform);
    data.addShapeData(ellipse);

    // Save ROI and shape
    ROIData roiData = roifac.saveROIs(ctx, image.getId(), Arrays.asList(data)).iterator().next();

    //now check that the shape has been added.
    //Retrieve the shape on plane (z, t) = (0, 0)
    List<ShapeData> shapes = roiData.getShapes(0, 0);
    Iterator<ShapeData> i = shapes.iterator();
    while (i.hasNext()) {
      ShapeData shape = i.next();
      // plane info
      int z = shape.getZ();
      int t = shape.getT();
      long id = shape.getId();
      if (shape instanceof RectangleData) {
        RectangleData rectData = (RectangleData) shape;
        //Insert code to handle rectangle
      } else if (shape instanceof EllipseData) {
        EllipseData ellipseData = (EllipseData) shape;
        //Insert code to handle ellipse
      } else if (shape instanceof LineData) {
        LineData lineData = (LineData) shape;
        //Insert code to handle line
      } else if (shape instanceof PointData) {
        PointData pointData = (PointData) shape;
        //Insert code to handle point
      } else if (shape instanceof MaskData) {
        MaskData maskData1 = (MaskData) shape;
        //Insert code to handle mask
      }

      //Check if the shape has transform
      //http://blog.openmicroscopy.org/data-model/future-plans/2016/06/20/shape-transforms/
      AffineTransformI transform = shape.getTransform();
      if (transform != null){

        double xScaling = transform.getA00.getValue();
        double xShearing = transform.getA01.getValue();
        double xTranslation = transform.getA02.getValue();
            
        double yScaling = transform.getA11.getValue();
        double yShearing = transform.getA10.getValue();
        double yTranslation = transform.getA12.getValue();
        //Insert code to handle transforms
      }
    }

-  **Retrieve ROIs linked to an Image.**

::

    ROIFacility roifac = gateway.getFacility(ROIFacility.class);

    //Retrieve the roi linked to an image
    List<ROIResult> roiresults = roifac.loadROIs(ctx, image.getId());
    ROIResult r = roiresults.iterator().next();
    if (r == null) return;
    Collection<ROIData> rois = r.getROIs();
    List<Shape> list;
    Iterator<Roi> j = rois.iterator();
    while (j.hasNext()) {
      roi = j.next();
      list = roi.copyShapes();
      // Do something
    }

-  **Remove a shape from ROI.**

::
    
    DataManagerFacility dm = gateway.getFacility(DataManagerFacility.class);
    ROIFacility roifac = gateway.getFacility(ROIFacility.class);

    //Retrieve the roi linked to an image
    List<ROIResult> roiresults = roifac.loadROIs(ctx, image.getId());
    ROIResult r = roiresults.iterator().next();
    List<Roi> rois = r.rois;
    List<Shape> list;
    Iterator<Roi> j = rois.iterator();
    while (j.hasNext()) {
      roi = j.next();
      list = roi.copyShapes();
      // remove the first shape.
      if (list.size() > 0) {
        roi.removeShape(list.get(0));
        // update the roi.
        dm.saveAndReturnObject(ctx, roi).saveAndReturnObject(roi);
      }
    }

-  **Organize ROIs in Folders.**

::
    
    ROIFacility roifac = gateway.getFacility(ROIFacility.class);
    
    Collection<ROIData> rois = ...
    
    // Add each ROI to a different folder
    for (ROIData r : rois) {
        FolderData folder = new FolderData();
        folder.setName("Folder for ROI " + r.getId());
        roifac.addRoisToFolders(ctx, image.getId(), Arrays.asList(r),
                Arrays.asList(folder));
    }

    // Get the ROI folders associated with an image
    Collection<FolderData> folders = roifac.getROIFolders(ctx, image.getId());
    for (FolderData folder : folders) {
        Collection<ROIResult> result = roifac.loadROIsForFolder(ctx,
                image.getId(), folder.getId());
        Collection<ROIData> folderRois = result.iterator().next().getROIs();
        // Do something with the ROIs
    }

Delete data
-----------

It is possible to delete Projects, datasets, images, ROIs etc. and
objects linked to them depending on the specified options (see
:doc:`/developers/Modules/Delete`).

-  **Delete Image.**

In the following example, we create an image and delete it.

::

    DataManagerFacility dm = gateway.getFacility(DataManagerFacility.class);
    
    //First create an image.
    ImageData image = new ImageData();
    image.setName("image1");
    image.setDescription("descriptionImage1");
    IObject object = dm.saveAndReturnObject(ctx, image.asIObject());

    Response rsp = dm.delete(ctx, object).loop(10, 500);

Render Images
-------------

-  **Initialize the rendering engine and render an image.**

::

    PixelsData pixels = image.getDefaultPixels();
    long pixelsId = pixels.getId();
    RenderingEnginePrx proxy = null;
    proxy = gateway.getRenderingService(ctx, pixelsId);
    ByteArrayInputStream stream = bull;
    try {
        proxy.lookupPixels(pixelsId);
        if (!(proxy.lookupRenderingDef(pixelsId))) {
            proxy.resetDefaultSettings(true);
            proxy.lookupRenderingDef(pixelsId);
        }
        proxy.load();
        //Now can interact with the rendering engine.
        proxy.setActive(0, Boolean.valueOf(false));
        PlaneDef pDef = new PlaneDef();
        pDef.z = 0;
        pDef.t = 0;
        pDef.slice = omero.romio.XY.value;
        //render the data uncompressed.
        int[] uncompressed = proxy.renderAsPackedInt(pDef);
        byte[] compressed = proxy.renderCompressed(pDef);
        //Create a buffered image
        stream = new ByteArrayInputStream(compressed);
        BufferedImage image = ImageIO.read(stream);
    } finally {
        proxy.close();
        if (stream != null) stream.close();
    }
   

-  **Retrieve thumbnails.**

::
    
    ThumbnailStorePrx store = gateway.getThumbnailService(ctx);
    ByteArrayInputStream stream = null;
    try {
        PixelsData pixels = image.getDefaultPixels();
        store.setPixelsId(pixels.getId())
        //retrieve a 96x96 thumbnail.
        byte[] array = store.getThumbnail(
                omero.rtypes.rint(96), omero.rtypes.rint(96));
        stream = new ByteArrayInputStream(array);
        //Create a buffered image to display
        ImageIO.read(stream);
    } finally {
        store.close();
        if (stream != null) stream.close();
    }

Create Image
------------

The following example shows how to create an Image from an Image already
in OMERO. Similar approach can be applied when uploading an image.

::

    //See above how to load an image.
    PixelsData pixels = image.getDefaultPixels();
    int sizeZ = pixels.getSizeZ();
    int sizeT = pixels.getSizeT();
    int sizeC = pixels.getSizeC();
    int sizeX = pixels.getSizeX();
    int sizeY = pixels.getSizeY();
    long pixelsId = pixels.getId();

    //Read the pixels from the source image.
    RawPixelsStorePrx store = gateway.getPixelsStore(ctx);
    try{
        store.setPixelsId(pixelsId, false);

        List<byte[]> planes = new ArrayList<byte[]>();

        for (int z = 0; z < sizeZ; z++) {
            for (int t = 0; t < sizeT; t++) {
                planes.add(store.getPlane(z, 0, t));
            }
        }
    } finally {
        //Better to close to free space.
        store.close();
    }

    //Now we are going to create the new image.
    IPixelsPrx proxy = gateway.getPixelsService(ctx);

    //Search for PixelsType object matching the source image.
    List<IObject> l = proxy.getAllEnumerations(PixelsType.class.getName());
    Iterator<IObject> i = l.iterator();
    PixelsType type = null;
    String original = pixels.getPixelType();
    while (i.hasNext()) {
        PixelsType o =  (PixelsType) i.next();
        String value = o.getValue().getValue();
        if (value.equals(original)) {
            type = o;
            break;
        }
    }
    if (type == null)
        throw new Exception("Pixels Type not valid.");

    //Create new image.
    String name = "newImageFrom"+image.getId();
    RLong idNew = proxy.createImage(sizeX, sizeY, sizeZ, sizeT, Arrays.asList(0), type, name,
            "From Image ID: "+image.getId());
    if (idNew == null)
        throw new Exception("New image could not be created.");
    IContainerPrx proxyCS = entryUnencrypted.getContainerService();
    List<Image> results = proxyCS.getImages(Image.class.getName(),
                    Arrays.asList(idNew.getValue()), new ParametersI());
    ImageData newImage = new ImageData(results.get(0));

    //Link the new image and the dataset hosting the source image.
    DatasetImageLink link = new DatasetImageLinkI();
    link.setParent(new DatasetI(datasetId, false));
    link.setChild(new ImageI(newImage.getId(), false));
    gateway.getUpdateService(ctx).saveAndReturnObject(link);

    //Write the data.
    try {
        store = gateway.getPixelsStore(ctx);
        store.setPixelsId(newImage.getDefaultPixels().getId(), false);
        int index = 0;
        for (int z = 0; z < sizeZ; z++) {
            for (int t = 0; t < sizeT; t++) {
                store.setPlane(planes.get(index++), z, 0, t);
            }
        }

        //Save the data.
        store.save();
    } finally {
        store.close();
    }

Sudo (working within another user's context)
--------------------------------------------

The next code snippet shows how you can work within another user's context. This
could for example be a data analyst doing some analysis on behalf of a user and
attaching the results to the user's data. The important point is that the user will
be the owner of these results and can work with them as usual. The user and 'analyst'
do not have to be member of a read-annotate group (see :doc:`Server/Permissions`),
but the 'analyst' has to be a 'light administrator' with 'sudo' permission,
see :doc:`Server/LightAdmins`.

::

    AdminFacility admin = gateway.getFacility(AdminFacility.class);

    // Look up the experimenter to sudo for
    ExperimenterData sudoUser = admin.lookupExperimenter(ctx, sudoUsername);

    // Create a SecurityContext for this user within the user's default group
    // and set the 'sudo' flag (i.e. all operations using this context will
    // be performed as this user)
    SecurityContext sudoCtx = new SecurityContext(sudoUser.getGroupId());
    sudoCtx.setExperimenter(sudoUser);
    sudoCtx.sudo();

    // Get a sudouser's dataset (assume the user has at least one dataset)
    BrowseFacility browse = gateway.getFacility(BrowseFacility.class);
    Collection<DatasetData> datasets = browse.getDatasets(sudoCtx, sudoUser.getId());
    DatasetData sudoDataset = datasets.iterator().next();

    // Add a tag to the dataset on behalf of the sudouser (i.e. the sudouser will be
    // the owner of tag).
    DataManagerFacility dm = gateway.getFacility(DataManagerFacility.class);
    TagAnnotationData sudoUserTag = new TagAnnotationData(sudoUsername+"'s tag");
    dm.attachAnnotation(sudoCtx, sudoUserTag, sudoDataset);
    System.out.println("Added '"+sudoUserTag.getContentAsString()+"' "
        + "to dataset "+sudoDataset.getName()+" on behalf of "+sudoUsername);

    // Add a tag to the same dataset as logged in user (i. e. the logged in user will be
    // the owner of the tag). Note: This only works in a read-annotate group where the
    // logged in user is allowed to annotate the sudouser's data, or the logged in user has
    // write permission.
    TagAnnotationData adminTag = new TagAnnotationData(user.getUserName()+"'s tag");
    // Have to use a SecurityContext for the correct group, otherwise this would fail
    // with a security violation
    SecurityContext groupContext = new SecurityContext(sudoUser.getGroupId());
    dm.attachAnnotation(groupContext, adminTag, sudoDataset);
    System.out.println("Added '"+adminTag.getContentAsString()+"'"
        + " to dataset "+sudoDataset.getName()+" as admin.");

Further information
-------------------

For the details behind writing, configuring, and executing a client,
please see |OmeroClients|.

--------------

.. seealso::
    ZeroC_, |OmeroGrid|, :ref:`build#OmeroTools`, |OmeroApi|

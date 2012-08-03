.. _developers/Omero/Matlab:

OMERO Matlab Language Bindings
==============================

See |DevelopingOmeroClients| and
`ObjectModel </ome/wiki/ObjectModel>`_, for an introduction about
**Object**.

.. contents::

Installing and Configuring
--------------------------

Installing the OmeroMatlab Toolbox
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Download the desired version. For the latest build see,
   `<http://hudson.openmicroscopy.org.uk/job/OMERO/lastSuccessfulBuild/>`_
   and download the |OmeroMatlab| zip file. For
   the latest released version visit the main `download page
   <http://www.openmicroscopy.org/site/support/omero4/downloads>`_
-  Unzip the directory anywhere on your system.
-  In Matlab, change to the newly unzipped directory.
-  Run :command:`loadOmero;`
-  The MATLAB files are now on your path, and the necessary jars are on
   your java classpath. You can change directories and still have access
   to OMERO.

Configuring the OmeroMatlab connection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As described under |OmeroClients|, there are
several ways to configure your connection to an OMERO server.
|OmeroMatlab| comes with a few conveniences for
making this work.

If you run ``client = loadOmero;`` (i.e. loadOmero with a return value),
then |OmeroMatlab| will try to configure the
``omero.client`` object for you. First, it checks the ``ICE_CONFIG``
environment variable. If set, it will let the ``omero.client``
constructor initialize itself. Otherwise, it looks for the file
``ice.config`` in the current directory. The
|OmeroMatlab| toolbox comes with a default
ice.config file pointing at localhost, which you can edit for your
server.

Alternatively, you can pass the same parameters to ``loadOmero;`` that
you would pass to ``omero.client``:

::

    >> omero_client_1 = loadOmero('localhost');
    >> omero_client_2 = omero.client('localhost');

Or, if you want a session created directly, the following are
equivalent:

::

    >> [client1, session1] = loadOmero('localhost');
    >> client2 = loadOmero('localhost');
    >> session2 = client2.createSession()

Using the OmeroMatlab omero.client
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Once an active session is available in your workspace, you can acquire
services, make queries, and load binary data. In short, anything the
|OmeroApi| can do. Helper functions and demos are
available for getting a feel for the API.

**TODO: Review the links** See the examples under
:source:`examples` or :source:`components/tools/OmeroM/demo`
on what you can do with |OmeroMatlab|.

Keeping your session alive
~~~~~~~~~~~~~~~~~~~~~~~~~~

For executing any long running task, you will need a background thread
which keeps your session alive. If you are familiar with Matlab
``Timers`` you can use
:source:`omeroKeepAlive.m <components/tools/OmeroM/src/omeroKeepAlive.m>`
directly or modify it to your liking.

::

    >> [c,s] = loadOmero;
    >> t = omeroKeepAlive(c); % Creates a 60-second timer and starts it
    >> ...
    >> delete(t);             % Disables the keep-alive

Alternatively, you can use the Java-based ``enableKeepAlive``-method,
but it is not configurable from within Matlab:

::

    >> c.enableKeepAlive(60); % Calls session.keepAlive() every 60 seconds
    >> c.closeSession();      % Close session to end the keep-alive

Closing & unloading OMERO
~~~~~~~~~~~~~~~~~~~~~~~~~

When you are done with OMERO, it is critical that you close your
connection to save resources.

::

    >> client1.closeSession();
    >> clear client1;
    >> clear session1;

Then if you would like, you can unload OMERO as well:

::

    >> unloadOmero;

**Note: you may see the following warning when unloading OMERO:**

::

    >> unloadOmero
    Warning: Objects of omero/client class exist - not clearing java
    > In javaclasspath>local_javapath at 167
      In javaclasspath at 88
      In javarmpath at 46
      In unloadOmero at 4
    Warning: Objects of omero/client class exist - not clearing java
    > In unloadOmero at 6

This means that there is still an |OmeroMatlab|
object in your workspace. Use "who" to find such objects, and "clear" to
remove them. After that, run ``clear java``:

::

    >> who

    Your variables are:

    omero_client

    >> clear omero_client
    >> clear java

**You should also unload OMERO before installing a new version of
|OmeroMatlab| or calling ``loadOmero`` again.**
If you need to create another session without unloading/loading OMERO
again, use the ``omero.client`` object directly:

::

    >> [c,s] = loadOmero(arg1,arg2);
    >> c = omero.client(arg3,arg4);
    >> s = c.createSession();


Code in Action
--------------

Follow several code samples showing how to interact with some objects.

Connect to OMERO
~~~~~~~~~~~~~~~~

-  **Connect to server**.

Remember to close the session.

::

    client = omero.client(server, 4064); 
    session = client.createSession(username, password);
    %necessary to keep the proxy alive. part of the omero-package
    clientAlive = omeroKeepAlive(client); 

    % If you want to have the data transfer encrypted then you can 
    % use the session variable otherwise use the following 
    unsecureClient = client.createClient(false);
    sessionUnencrypted = unsecureClient.getSession();

    % The id of the user.
    userId = session.getAdminService().getEventContext().userId;

    % The group the user is currently logged in i.e. his/her default group
    groupId = session.getAdminService().getEventContext().groupId;

-  **Close connection**. **IMPORTANT**

::

    client.closeSession();
    unsecureClient.closeSession();

Read Data
~~~~~~~~~

The ``IContainer`` service provides method to load the data management
hierarchy in OMERO -- Projects, Datasets, Etc. A list of examples
follows, indicating how to load Project, Dataset, Screen, etc.

-  **Retrieve the projects owned by the user currently logged in.**

If a Project contains Datasets, the Datasets will automatically be
loaded.

::

    proxy = session.getContainerService();
    %Set the options
    param = omero.sys.ParametersI();
    param.leaves();%indicate to load the images
    %param.noLeaves(); %no images loaded, this is the default value.
    userId = session.getAdminService().getEventContext().userId; %id of the user.
    param.exp(omero.rtypes.rlong(userId));
    projectsList = proxy.loadContainerHierarchy('omero.model.Project', [], param);
    for j = 0:projectsList.size()-1,
        p = projectsList.get(j);
        datasetsList = p.linkedDatasetList;
        for i = 0:datasetsList.size()-1,
            d = datasetsList.get(i);
            % Do something with the dataset 
            dName = d.getName().getValue();
            % If the flag is set to true, you can access the images within the dataset
            % imageList = d.linkedImageList;
            % for k = 0:imageList.size()-1,
               % image = imageList.get(k);
            % end
        end
    end 

-  **Retrieve the Datasets owned by the user currently logged in.**

::

    proxy = session.getContainerService();
    param = omero.sys.ParametersI();
    param.leaves();%indicate to load the images
    userId = session.getAdminService().getEventContext().userId; %id of the user.
    param.exp(omero.rtypes.rlong(userId));
    datasetsList = proxy.loadContainerHierarchy('omero.model.Dataset', [], param);

-  **Retrieve the Images contained in a Dataset.**

::

    proxy = session.getContainerService();
    ids = java.util.ArrayList();
    ids.add(datasetId); %add the id of the dataset.
    param = omero.sys.ParametersI();
    param.leaves(); % indicate to load the images.
    list = proxy.loadContainerHierarchy('omero.model.Dataset', ids, param);
    dataset = list.get(0);
    imageList = dataset.linkedImageList; % The images in the dataset.

-  **Retrieve an image if the identifier is known.**

::

    ids = java.util.ArrayList();
    ids.add(imageId); %add the id of the image.

    proxy = session.getContainerService();
    list = proxy.getImages('omero.model.Image', ids, omero.sys.ParametersI());
    image = list.get(0);

-  **Access information about the image for example to draw it**.

The model is as follows: Image-Pixels i.e. to access valuable data about
the image you need to use the pixels object. We now only support one set
of pixels per image (it used to be more!).

::

    pixelsList = image.copyPixels();
    for k = 0:pixelsList.size()-1,
       pixels = pixelsList.get(k);
       sizeZ = pixels.getSizeZ().getValue(); % The number of z-sections.
       sizeT = pixels.getSizeT().getValue(); % The number of timepoints.
       sizeC = pixels.getSizeC().getValue(); % The number of channels.
       sizeX = pixels.getSizeX().getValue(); % The number of pixels along the X-axis.
       sizeY = pixels.getSizeY().getValue(); % The number of pixels along the Y-axis.
    end

-  **Retrieve Screening data owned by the user currently logged in**.

To learn about the model go to
`ScreenPlateWell </ome/wiki/ScreenPlateWell>`_. Note that the wells are
not loaded.

::

    proxy = session.getContainerService();
    userId = session.getAdminService().getEventContext().userId; %id of the user.
    param = omero.sys.ParametersI;
    param.exp(omero.rtypes.rlong(userId)); %load data for a given user.

    screenList = proxy.loadContainerHierarchy('omero.model.Screen', [], param);
    for j = 0:screenList.size()-1,
    screen = screenList.get(j);
    platesList = screen.linkedPlateList;
    for i = 0:platesList.size()-1,
        plate = platesList.get(i);
        plateAcquisitionList = plate.copyPlateAcquisitions();
        for k = 0:plateAcquisitionList.size()-1,
          pa = plateAcquisitionList.get(i);
        end
    end

-  **Retrieve Wells within a Plate**, see
   `ScreenPlateWell </ome/wiki/ScreenPlateWell>`_.

Given a plate ID, load the wells. You will have to use the
``findAllByQuery`` method.

::

    wellList = session.getQueryService().findAllByQuery(
    ['select well from Well as well '...
    'left outer join fetch well.plate as pt '...
    'left outer join fetch well.wellSamples as ws '...
    'left outer join fetch ws.plateAcquisition as pa '...
    'left outer join fetch ws.image as img '...
    'left outer join fetch img.pixels as pix '...
    'left outer join fetch pix.pixelsType as pt '...
    'where well.plate.id = ', num2str(plateId)], []);
    for j = 0:wellList.size()-1,
        well = wellList.get(j);
        wellsSampleList = well.copyWellSamples();
        well.getId().getValue()
        for i = 0:wellsSampleList.size()-1,
            ws = wellsSampleList.get(i);
            ws.getId().getValue()
            pa = ws.getPlateAcquisition();
        end
    end 

Raw Data access
~~~~~~~~~~~~~~~

You can retrieve data, plane by plane or retrieve a stack.

-  **Retrieve a given plane**.

This is useful when you need the pixels intensity.

::

    % To retrieve the pixels, see above.
    sizeZ = pixels.getSizeZ().getValue();
    sizeT = pixels.getSizeT().getValue();
    sizeC = pixels.getSizeC().getValue();
    pixelsId = pixels.getId().getValue();
    store = session.createRawPixelsStore(); 
    store.setPixelsId(pixelsId, false);
    for z = 0:sizeZ-1,
       for t = 0:sizeT-1,
          for c = 0:sizeC-1,
              plane = store.getPlane(z, c, t);
              tPlane = toMatrix(plane, pixels);
              % do something with the plane
          end
       end
    end
    % close the store
    store.close();

-  **Retrieve a given tile**.

::

    % To retrieve the pixels, see above.
    sizeZ = pixels.getSizeZ().getValue();
    sizeT = pixels.getSizeT().getValue();
    sizeC = pixels.getSizeC().getValue();
    pixelsId = pixels.getId().getValue();
    store = session.createRawPixelsStore(); 
    store.setPixelsId(pixelsId, false);
    x = 0;
    y = 0;
    width = pixels.getSizeX().getValue()/2;
    height = pixels.getSizeY().getValue()/2;
    for z = 0:sizeZ-1,
       for t = 0:sizeT-1,
          for c = 0:sizeC-1,
              tile = store.getTile(z, c, t, x, y, width, height);
              % tPlane = toMatrix(tile, pixels);
              % do something with the tile
          end
       end
    end
    % close the store
    store.close();

-  **Retrieve a given stack**.

This is useful when you need the pixels intensity.

::

    %Create the store to load the stack. No access via the gateway
    store = session.createRawPixelsStore(); 
    store.setPixelsId(pixelsId, false); %Indicate the pixels set you are working on
    for t = 0:sizeT-1,
        for c = 0:sizeC-1,
            stack = store.getStack(c, t);
            % do something with the stack
          end
       end
    end
    store.close();

-  **Retrieve a given hypercube**.

This is useful when you need the pixels intensity.

::

    %Create the store to load the stack. No access via the gateway
    store = session.createRawPixelsStore(); 
    store.setPixelsId(pixelsId, false); %Indicate the pixels set you are working on

    % offset values in each dimension XYZCT
    offset = java.util.ArrayList;
    offset.add(java.lang.Integer(0));
    offset.add(java.lang.Integer(0));
    offset.add(java.lang.Integer(0));
    offset.add(java.lang.Integer(0));
    offset.add(java.lang.Integer(0));

    size = java.util.ArrayList;
    size.add(java.lang.Integer(sizeX));
    size.add(java.lang.Integer(sizeY));
    size.add(java.lang.Integer(sizeZ));
    size.add(java.lang.Integer(sizeC));
    size.add(java.lang.Integer(sizeT));

    % indicate the step in each direction, step = 1, will return values at index 0, 1, 2.
    % step = 2, values at index 0, 2, 4 etc.
    step = java.util.ArrayList;
    step.add(java.lang.Integer(1));
    step.add(java.lang.Integer(1));
    step.add(java.lang.Integer(1));
    step.add(java.lang.Integer(1));
    step.add(java.lang.Integer(1));
    % Retrieve the data
    store.getHypercube(offset, size, step);
    % close the store
    store.close();

Write Data
~~~~~~~~~~

-  **Create a Dataset** and link it to an existing Project.

::

    dataset = omero.model.DatasetI;
    dataset.setName(omero.rtypes.rstring(char('name dataset')));
    dataset.setDescription(omero.rtypes.rstring(char('description dataset')));

    %link Dataset and Project

    link = omero.model.ProjectDatasetLinkI;
    link.setChild(dataset);
    link.setParent(omero.model.ProjectI(projectId, false));

    session.getUpdateService().saveAndReturnObject(link);

-  **Create a tag (tag annotation)** and link it to an existing project.

::

    tag = omero.model.TagAnnotationI;
    tag.setTextValue(omero.rtypes.rstring(char('name tag')));
    tag.setDescription(omero.rtypes.rstring(char('description tag')));

    %link tag and project
    link = omero.model.ProjectAnnotationLinkI;
    link.setChild(tag);
    link.setParent(omero.model.ProjectI(projectId, false));

    session.getUpdateService().saveAndReturnObject(link);

-  **Create a file annotation and link to an image.**

To attach a file to an object e.g. an image, few objects need to be
created:

#. an ``OriginalFile``
#. a ``FileAnnotation``
#. a link between the ``Image`` and the ``FileAnnotation``.

::

    % To retrieve the image see above.
    iUpdate = session.getUpdateService(); % service used to write object

    % create the original file object.
    %read local file
    file = java.io.File(fileToUpload);
    name = file.getName();
    absolutePath = file.getAbsolutePath();
    path = absolutePath.substring(0, absolutePath.length()-name.length());

    originalFile = omero.model.OriginalFileI;
    originalFile.setName(omero.rtypes.rstring(name));
    originalFile.setPath(omero.rtypes.rstring(path));
    originalFile.setSize(omero.rtypes.rlong(file.length()));
    originalFile.setSha1(omero.rtypes.rstring(generatedSha1));
    originalFile.setMimetype(omero.rtypes.rstring(fileMimeType));

    % now we save the originalFile object
    originalFile = iUpdate.saveAndReturnObject(originalFile);

    % Initialize the service to load the raw data
    rawFileStore = session.createRawFileStore();
    rawFileStore.setFileId(originalFile.getId().getValue());

    %  open file and read it

    %code for small file.
    fid = fopen(fileToUpload);
    byteArray = fread(fid,[1, file.length()], 'uint8');
    rawFileStore.write(byteArray, 0, file.length());
    fclose(fid);


    originalFile = rawFileStore.save();
    % Important to close the service
    rawFileStore.close();
    % now we have an original File in DB and raw data uploaded.
    % We now need to link the Original file to the image using the File annotation object. That's the way to do it.
    fa = omero.model.FileAnnotationI;
    fa.setFile(originalFile);
    fa.setDescription(omero.rtypes.rstring(description)); % The description set above e.g. PointsModel
    fa.setNs(omero.rtypes.rstring(NAME_SPACE_TO_SET)) % The name space you have set to identify the file annotation.

    % save the file annotation.
    fa = iUpdate.saveAndReturnObject(fa);

    % now link the image and the annotation
    link = omero.model.ImageAnnotationLinkI;
    link.setChild(fa);
    link.setParent(image);
    % save the link back to the server.
    iUpdate.saveAndReturnObject(link);

    % To attach to a Dataset use omero.model.DatasetAnnotationLinkI;

-  **Load all the annotations with a given namespace linked to images**

::

    userId = session.getAdminService().getEventContext().userId;
    nsToInclude = java.util.ArrayList;
    nsToInclude.add(NAME_SPACE_TO_SET);
    nsToExclude = java.util.ArrayList;
    options = omero.sys.ParametersI;
    options.exp(omero.rtypes.rlong(userId)); %load the annotation for a given user.
    metadataService = session.getMetadataService();
    % retrieve the annotations linked to images, for datasets use: 'omero.model.Dataset'
    annotations = metadataService.loadSpecifiedAnnotations('omero.model.FileAnnotation', nsToInclude, nsToExclude, options);
    for j = 0:annotations.size()-1,
        annotations.get(j).getId().getValue();
    end

-  **Read the attachment**.

First load the annotation, cf. above.

::

    % Let's call fa the file annotation
    originalFile = fa.getFile();
    store = session.createRawFileStore();
    store.setFileId(originalFile.getId().getValue());

    % read data
        
    fid = fopen('mydataBack.txt', 'w');
    fwrite(fid, rawFileStore.read(0, originalFile.getSize().getValue()), 'uint8');
    fclose(fid);

    store.close();

How to use OMERO tables
~~~~~~~~~~~~~~~~~~~~~~~

-  **Create a table**. In the following example, we create a table with
   2 columns.

::

    name = char(java.util.UUID.randomUUID());
    columns = javaArray('omero.grid.Column', 2)
    columns(1) = omero.grid.LongColumn('Uid', 'testLong', []);
    valuesString = javaArray('java.lang.String', 1);
    columns(2) = omero.grid.StringColumn('MyStringColumn', '', 64, valuesString);

    %create a new table.
    table = session.sharedResources().newTable(1, name);

    %initialize the table
    table.initialize(columns);
    %add data to the table.
    data = javaArray('omero.grid.Column', 2);
    data(1) = omero.grid.LongColumn('Uid', 'test Long', [2]);
    valuesString = javaArray('java.lang.String', 1);
    valuesString(1) = java.lang.String('add');
    data(2) = omero.grid.StringColumn('MyStringColumn', '', 64, valuesString);
    table.addData(data);
    file = table.getOriginalFile(); % if you need to interact with the table

-  **Read the contents of the table**.

::

    of = omero.model.OriginalFileI(file.getId(), false); 
    tablePrx = session.sharedResources().openTable(of);

    %read headers
    headers = tablePrx.getHeaders();
    for i=1:size(headers, 1),
        headers(i).name; % name of the header
        %do something
    end

    % Depending on size of table, you may only want to read some blocks.
    cols = [0:size(headers, 1)-1]; % The number of columns we wish to read.
    rows = [0:tablePrx.getNumberOfRows()-1]; % The number of rows we wish to read.
    data = tablePrx.slice(cols, rows); % read the data.
    c = data.columns;
    for i=1:size(c),
        column = c(i);
        %do something
    end
    tablePrx.close(); % Important to close when done.

ROIs
~~~~

To learn about the model see
`http://www.openmicroscopy.org/site/support/file-formats/working-with-ome-xml/roi <http://www.openmicroscopy.org/site/support/file-formats/working-with-ome-xml/roi>`_
. Note that annotation can be linked to ROI.

-  **Create ROI.**

In this example, we create an ROI with a rectangular shape and attach it
to an image.

::

    % First create a rectangular shape.
    rect = omero.model.RectI;
    rect.setX(omero.rtypes.rdouble(0));
    rect.setY(omero.rtypes.rdouble(0));
    rect.setWidth(omero.rtypes.rdouble(10));
    rect.setHeight(omero.rtypes.rdouble(20));
    % indicate on which plane to attach the shape
    rect.setTheZ(omero.rtypes.rint(0));
    rect.setTheT(omero.rtypes.rint(0));

    % First create an ellipse shape.
    ellipse = omero.model.EllipseI;
    ellipse.setCx(omero.rtypes.rdouble(0));
    ellipse.setCy(omero.rtypes.rdouble(0));
    ellipse.setRx(omero.rtypes.rdouble(10));
    ellipse.setRy(omero.rtypes.rdouble(20));
    % indicate on which plane to attach the shape
    ellipse.setTheZ(omero.rtypes.rint(0));
    ellipse.setTheT(omero.rtypes.rint(0));

    % Create the roi.
    roi = omero.model.RoiI;
    % Attach the shapes to the roi, several shapes can be added.
    roi.addShape(rect);
    roi.addShape(ellipse);

    % Link the roi and the image
    roi.setImage(omero.model.ImageI(imageId, false));
    % save
    iUpdate = session.getUpdateService(); 
    roi = iUpdate.saveAndReturnObject(roi);
    % Check that the shape has been added.
    numShapes = roi.sizeOfShapes;
    for ns = 1:numShapes
       shape = roi.getShape(ns-1);
    end

-  **Retrieve ROIs linked to an Image.**

::

    service = session.getRoiService();
    roiResult = service.findByImage(imageId, []);
    rois = roiResult.rois;
    n = rois.size;
    shapeType = '';
    for thisROI  = 1:n
        roi = rois.get(thisROI-1);
        numShapes = roi.sizeOfShapes; % an ROI can have multiple shapes.
        for ns = 1:numShapes
            shape = roi.getShape(ns-1); % the shape
            if (isa(shape, 'omero.model.Rect'))
               %handle rectangle
               rectangle = shape;
               rectangle.getX().getValue()
            elseif (isa(shape, 'omero.model.Ellipse'))
               ellipse = shape;
               ellipse.getCx().getValue()
            elseif (isa(shape, 'omero.model.Point'))
               point = shape;
               point.getX().getValue();
            elseif (isa(shape, 'omero.model.Line'))
               line = shape;
               line.getX1().getValue();
            end
        end
    end

-  **Remove a shape from ROI.**

::

    // Retrieve the roi linked to an image
    service = session.getRoiService();
    roiResult = service.findByImage(imageId, []);
    n = rois.size;
    for thisROI  = 1:n
        roi = rois.get(thisROI-1);
        numShapes = roi.sizeOfShapes; % an ROI can have multiple shapes.
        for ns = 1:numShapes
            shape = roi.getShape(ns-1); % the shape
            % remove the shape
            roi.removeShape(shape);
        end
        %Update the roi.
        roi = iUpdate.saveAndReturnObject(roi);
    end

Delete data
~~~~~~~~~~~

It is possible to delete Projects, Datasets, Images, ROIs etc and
objects linked to them depending on the specified options (see
`Delete </ome/wiki/Delete>`_).

-  **Delete Image**.

In the following example, we create an Image and delete it.

::

    % First create the image.
    image = omero.model.ImageI;
    image.setName(omero.rtypes.rstring('image name'))
    image.setAcquisitionDate(omero.rtypes.rtime(2000000));
    image = service.saveAndReturnObject(image);
    imageId = image.getId().getValue();

    % Create the command to delete the Image using a delete callback.
    % You can delete more than one image at a time.
    list = javaArray('omero.api.delete.DeleteCommand', 1);
    % Indicate the type of object e.g. /Image, /Project etc., the identifier
    % and the annotations to keep (nothing in the following example)
    list(1) = omero.api.delete.DeleteCommand('/Image', imageId, []);
    %Delete the image.
    prx = session.getDeleteService().queueDelete(list);

Render Images
~~~~~~~~~~~~~

-  **Initialize the rendering engine and render an Image.**

::

    % See load section to find out how to load pixels.
    % Create rendering engine.
    pixelsId = pixels.getId().getValue(); % see Load data section
    re = session.createRenderingEngine();
    re.lookupPixels(pixelsId);
    % Check if default required.
    if (~re.lookupRenderingDef(pixelsId)) 
        re.resetDefaults();
        re.lookupRenderingDef(pixelsId);
    end
    % start the rendering engine
    re.load();

    % render a Plane as compressed. Possible to render it uncompressed.
    pDef = omero.romio.PlaneDef;
    pDef.z = re.getDefaultZ();
    pDef.t = re.getDefaultT();
    pDef.slice = omero.romio.XY.value;

    % Number of channels.
    sizeC = pixels.getSizeC().getValue()-1;
    if (sizeC == 0)
        re.setActive(0, 1);
    else 
        for k = 0:sizeC,
            re.setActive(k, 0);
            values = re.renderCompressed(pDef);
            stream = java.io.ByteArrayInputStream(values);
            image = javax.imageio.ImageIO.read(stream);
            stream.close();
            figure(k+1);
            imshow(JavaImageToMatlab(image));
            %make all the channels active.
            for i = 0:sizeC,
               re.setActive(i, 1);
            end
        end
    end

    % All channels active and save the image as a JPEG.
    figure(pixels.getSizeC().getValue()+2);
    values = re.renderCompressed(pDef);
    stream = java.io.ByteArrayInputStream(values);
    image = javax.imageio.ImageIO.read(stream);
    stream.close();
    imshow(JavaImageToMatlab(image));
    %file = [imagename '.jpg'];
    %fid = fopen(file, 'wb');
    %fwrite(fid, values, 'int8');
    %fclose(fid);
    %delete(file);

    %Close the rendering engine.
    re.close();

-  **Retrieves thumbnails**

::

    store = session.createThumbnailStore();
    map = store.getThumbnailByLongestSideSet(omero.rtypes.rint(96), java.util.Arrays.asList(java.lang.Long(pixelsId)));
    %Display the thumbnail;
    collection = map.values();
    i = collection.iterator();
    while (i.hasNext())
       figure(100);
       stream = java.io.ByteArrayInputStream(i.next());
       image = javax.imageio.ImageIO.read(stream);
       stream.close();
       imshow(JavaImageToMatlab(image));
    end

Create Image
~~~~~~~~~~~~

The following example shows how to create an Image from an Image already
in OMERO. Similar approach can be applied when uploading an image.

::

    % See above how to load the pixels


    sizeZ = pixels.getSizeZ().getValue() % The number of z-sections.
    sizeT = pixels.getSizeT().getValue(); % The number of timepoints.
    sizeC = pixels.getSizeC().getValue(); % The number of channels.
    sizeX = pixels.getSizeX().getValue();
    sizeY = pixels.getSizeY().getValue();

    % Initialize the raw pixels store

    pixelsId = pixels.getId().getValue()
    store = session.createRawPixelsStore();
    store.setPixelsId(pixelsId, false);

    map = java.util.HashMap;
    for z = 0:sizeZ-1,
      for t = 0:sizeT-1,
        planeC1 = store.getPlane(z, 0, t);
        map.put(linearize(z, t, sizeZ), planeC1); % linearize does sizeZ*t+z
      end
    end

    % Close to free space.
    store.close();

    % Retrieve the pixels type of the source image

    proxy = session.getPixelsService();
    l = proxy.getAllEnumerations('omero.model.PixelsType');
    original = pixels.getPixelsType().getValue().getValue();
    for j = 0:l.size()-1,
        type = l.get(j);
        if (type.getValue().getValue() == original)
            break;
        end
    end

    % Create the new image
    description = char(['Source Image ID: ' int2str(image.getId().getValue())]);
    name = char(['newImageFrom' int2str(image.getId().getValue())]);
    idNew = proxy.createImage(sizeX, sizeY, sizeZ, sizeT, java.util.Arrays.asList(java.lang.Integer(0)), type, name, description);
        
        
    %Load the new image.
    list = iContainer.getImages('omero.model.Image', java.util.Arrays.asList(java.lang.Long(idNew.getValue())), omero.sys.ParametersI()); 
    if (list.size == 0)
       exception = MException('OMERO:CreateImage', 'Image Id not valid');
       throw(exception);
    end

    imageNew = list.get(0);

    %load the dataset hosting the source image and link it to the new image.
    param = omero.sys.ParametersI();
    param.noLeaves(); % indicate to load the images.
    % load the dataset
    results = session.getContainerService().loadContainerHierarchy('omero.model.Dataset', java.util.Arrays.asList(datasetId), param);
    if (results.size == 0)
       exception = MException('OMERO:CreateImage', 'Dataset Id not valid');
       throw(exception);
    end
    dataset = results.get(0);
    link = omero.model.DatasetImageLinkI;
    link.setChild(omero.model.ImageI(imageNew.getId().getValue(), false));
    link.setParent(omero.model.DatasetI(dataset.getId().getValue(), false));

    session.getUpdateService().saveAndReturnObject(link);


    %Copy the data.
    pixelsNewList = imageNew.copyPixels();
    pixelsNew = pixelsNewList.get(0);
    pixelsNewId = pixelsNew.getId().getValue()
    store = session.createRawPixelsStore();
    store.setPixelsId(pixelsNewId, false);
        
    for z = 0:sizeZ-1,
       for t = 0:sizeT-1,
          index = linearize(z, t, sizeZ);
          store.setPlane(map.get(index), z, 0, t); % copy the raw data
       end
    end

    %save the data
    store.save();

    %close
    store.close();

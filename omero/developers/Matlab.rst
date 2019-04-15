OMERO MATLAB language bindings
==============================

See |DevelopingOmeroClients| and |OmeroModel|, for an introduction to
**Object**.

.. highlight:: matlab

Installing the OMERO.matlab toolbox
-----------------------------------

-  Download the latest released version from the
   `Downloads page <https://www.openmicroscopy.org/omero/downloads/>`_.
-  Unzip the directory anywhere on your system.
-  In MATLAB, move to the newly unzipped directory and run ``loadOmero;``.
-  The MATLAB files are now on your path, and the necessary jars are on
   your Java classpath. You can change directories and still have access
   to OMERO.

Once OMERO.matlab is installed, the typical workflow is:

#. :ref:`connection_init`
#. :ref:`connection_keepalive`
#. :ref:`unsecure_client` (optional)
#. Do some work (load objects, work with them, upload to the server, etc.)
#. :ref:`connection_close`
#. :ref:`unload` (optional)

As a quickstart example, the following lines create a secure connection to a
server, read a series of images and close the connection.

::

   client = loadOmero(servername);
   session = client.createSession(user, password);
   client.enableKeepAlive(60);
   images = getImages(session, ids);
   client.closeSession();

Examples of usage of the OMERO.matlab toolbox are provided in the
:matlab_sourcedir:`training examples <examples>` directory.

Configuring the OMERO.matlab connection
---------------------------------------

.. _connection_init:

Creating a connection
^^^^^^^^^^^^^^^^^^^^^

As described under |OmeroClients|, there are several ways to configure your
connection to an OMERO server. OMERO.matlab comes with a few conveniences for
making this work.

If you run ``client = loadOmero();`` (i.e. loadOmero without an input argument),
then OMERO.matlab will try to configure the
``omero.client`` object for you. First, it checks the :envvar:`ICE_CONFIG`
environment variable. If set, it will let the ``omero.client``
constructor initialize itself. Otherwise, it looks for the file
:file:`ice.config` in the current directory. The OMERO.matlab toolbox comes
with a default :file:`ice.config` file pointing at ``localhost``. To use this
configuration file, you should replace ``localhost`` by your server address.

Alternatively, you can pass the server address to ``loadOmero;`` to create a client::

    >> client = loadOmero(servername);

Or, if you want a session created directly using the configuration :file:`ice.config` file::

    >> [client, session] = loadOmero('ice.config');

This is equivalent to::

    >> client = loadOmero(servername, port);
    >> session = client.createSession(username, password)

where the variables ``servername``, ``port``, ``username`` and ``password`` are the values set in :file:`ice.config` for the previous example. The default port will be used if not specified.

.. _connection_keepalive:

Keeping your session alive
^^^^^^^^^^^^^^^^^^^^^^^^^^

For executing any long running task, you will need a background thread
which keeps your session alive. If you are familiar with MATLAB
``Timers`` you can use
:matlab_source:`omeroKeepAlive.m <src/main/omeroKeepAlive.m>`
directly or modify it to your liking. By default the function creates a default 60-second timer.

::

    >> [client, session] = loadOmero('ice.config');
    >> timer = omeroKeepAlive(client); % Create timer and starts it.
    >> …
    >> delete(timer);             % Disable the keep-alive

Alternatively, you can use the Java-based ``enableKeepAlive`` method,
but it is not configurable from within MATLAB. In that case, you will need to specify the time interval::

    client.enableKeepAlive(60); % Call session.keepAlive() every 60 seconds
    client.closeSession();      % Close session to end the keep-alive

Working in a different group
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Each session is created within a given context, defining not only the session
user but also the session group. The session context can be retrieved using the
administration service::

    eventContext = session.getAdminService().getEventContext();
    groupId = eventContext.groupId;

Most read and write operations described below are performed in the context
of the session group when using the default parameters. Since OMERO 5.1.4, it
is possible to specify a different context than the session group for reading
and writing data using the ``group`` parameter/key value in the OMERO.matlab
functions. Retrieving objects by identifiers is also done across all groups by
default.

.. seealso::
    :doc:`/developers/Server/Permissions`
        Developer documentation about the OMERO permissions system

.. _unsecure_client:

Creating an unencrypted session
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Once a session has been created, if you want to speed up the data transfer,
you can create and use an unencrypted session as::

    unsecureClient = client.createClient(false);
    sessionUnencrypted = unsecureClient.getSession();

.. _connection_close:

Closing your connection
^^^^^^^^^^^^^^^^^^^^^^^

When you are done with OMERO, it is critical that you close your connection to
save resources::

    client.closeSession();
    clear client;
    clear session;

If you created an unencrypted session, you will need to close the unsecure
session as well::

    client.closeSession();
    unsecureClient.closeSession();
    clear client;
    clear unsecureClient;
    clear session;
    clear sessionUnencrypted;

.. _unload:

Unloading OMERO
^^^^^^^^^^^^^^^

Then if you would like, you can unload OMERO as well::

    unloadOmero();

You may see the following warning when unloading OMERO::

    >> unloadOmero()
    Warning: Objects of omero/client class exist - not clearing java
    > In javaclasspath>doclear at 377
      In javaclasspath>local_javapath at 194
      In javaclasspath at 105
      In javarmpath at 48
      In unloadOmero at 75

    ===============================================================
    While unloading OMERO, found java objects left in workspace.
    Please remove with 'clear <name>' and then run 'unloadOmero'
    again.  Printing all objects...
    ===============================================================

      Name      Size            Bytes  Class           Attributes

      c         1x1                    omero.client

    Closing session(s) for 1 found client(s): c

This means that there is still an OMERO.matlab object in your workspace. If
not listed, use ``whos`` to find such objects, and ``clear`` to remove them.
After that, run ``unloadOmero()`` again::

    >> clear c
    >> unloadOmero()

.. warning::
    You should also unload OMERO before installing a new version of
    OMERO.matlab or calling ``loadOmero`` again.

If you need to create another session without unloading/loading OMERO
again, use the ``omero.client`` object directly::

    >> client = loadOmero(servername,port);
    >> client = omero.client(username_1, password_1);
    >> session = c.createSession();


Reading data
------------

The ``IContainer`` service provides methods to load the data management
hierarchy in OMERO -- projects, datasets, etc.. A list of examples follows
indicating how to load projects, datasets, screens.

-  **Projects**

The projects owned by the session user in the context of the session group can
be retrieved using the
:matlab_source:`getProjects <src/main/io/getProjects.m>` function::

    projects = getProjects(session)

If the project identifiers are known, they can be retrieved independently of
their owner or group using::

    projects = getProjects(session, ids)

If the projects contain datasets, the datasets will automatically be loaded::

    for j = 1 : numel(projects) % Matlab list, index starts at 1
        % Get all the datasets in the Project
        datasetsList = projects(j).linkedDatasetList; % Java List
        % convert it to a Matlab list for convenience
        datasets = toMatlabList(datasetsList);
        % Iterate through datasets
        for i = 1 : numel(datasets) 
            d = datasets(i);
        end
    end

If the datasets contain images, the images are not automatically loaded. To
load the whole graph (projects, datasets, images), pass `true` as an optional
argument::

    % Load the specified Projects and the whole graph 
    loadedProjects = getProjects(session, ids, true)
    % Get the first project
    project_1 = loadedProjects(1) % Matlab array, index starts at 1
    % Get all the datasets in the Project
    datasets = project_1.linkedDatasetList;
    % Get the first dataset in the Java list, index starts at 0
    dataset_1 = datasets.get(0);
    dataset_name = dataset_1.getName().getValue(); % dataset's name
    dataset_id = dataset_1.getId().getValue(); % dataset's id
    % Retrieve all the images in the datasets as a Java List (index will start at 0)
    imageList = dataset_1.linkedImageList;
    % convert it to a Matlab list for convenience
    images = toMatlabList(imageList);
    % Iterate through the images
    for i = 1 : numel(images)
        image = images(i);
        image_name = image.getName().getValue(); % image's name
        image_id = image.getId().getValue(); % image's id
    end


.. warning::
  Loading the entire projects/datasets/images graph can be time-consuming and
  memory-consuming depending on the amount of data.

To return the orphaned datasets i.e. datasets not in a project, as well as the projects, you can query the second output argument of
:matlab_source:`getProjects <src/main/io/getProjects.m>`::

    [projects, orphanedDatasets] = getProjects(session)

To filter projects by owner, use the ``owner`` parameter/key value. A value of
``-1`` means projects are retrieved independently of their owner::

    % Returns all projects owned by the specified user in the context of the
    % session group
    projects = getProjects(session, 'owner', ownerId);
    % Returns all projects with the input identifiers owned by the specified
    % user
    projects = getProjects(session, ids, 'owner', ownerId);
    % Returns all projects owned by any user in the context of the session
    % group
    projects = getProjects(session, 'owner', -1);

To filter projects by group, use the ``group`` parameter/key value. A value of
``-1`` means projects are retrieved independently of their group::

    % Returns all projects owned by the session user in the specified group
    projects = getProjects(session, 'group', groupId);
    % Returns all projects with the input identifiers in the specified group
    projects = getProjects(session, ids, 'group', groupId);
    % Returns all projects owned by the session user across groups
    projects = getProjects(session, 'group', -1);

-  **Datasets**

The datasets owned by the session user in the context of the session group can
be retrieved using the
:matlab_source:`getDatasets <src/main/io/getDatasets.m>` function::

    datasets = getDatasets(session)

If the dataset identifiers are known, they can be retrieved independently of
their owner or group using::

    datasets = getDatasets(session, ids)

If the datasets contain images, the images are not automatically loaded. To
load the whole graph (datasets, images), pass `true` as an optional argument::

    loadedDatasets = getDatasets(session, ids, true);
    % Get the first dataset
    dataset_1 = loadedDatasets(1); % Matlab array, index starts at 1
    % Get the all the images in the dataset as the Java list, index starts at 0
    imageList = dataset_1.linkedImageList;


To filter datasets by owner, use the ``owner`` parameter/key value. A value of
``-1`` means datasets are retrieved independently of their owner::

    % Returns all datasets owned by the specified user in the context of the
    % session group
    datasets = getDatasets(session, 'owner', ownerId);
    % Returns all datasets with the input identifiers owned by the specified
    % user
    datasets = getDatasets(session, ids, 'owner', ownerId);
    % Returns all datasets owned by any user in the context of the session
    % group
    datasets = getDatasets(session, 'owner', -1);

To filter datasets by group, use the ``group`` parameter/key value. A value of
``-1`` means datasets are retrieved independently of their group::

    % Returns all datasets owned by the session user in the specified group
    datasets = getDatasets(session, 'group', groupId);
    % Returns all datasets with the input identifiers in the specified group
    datasets = getDatasets(session, ids, 'group', groupId);
    % Returns all datasets owned by the session user across groups
    datasets = getDatasets(session, 'group', -1);

-  **Images**

The images owned by the session user in the context of the session group can
be retrieved using the
:matlab_source:`getImages <src/main/io/getImages.m>` function::

    images = getImages(session)

If the image identifiers are known, they can be retrieved independently of
their owner or group using::

    images = getImages(session, ids)

All the images contained in a subset of datasets of known identifiers
``datasetsIds`` can be returned independently of their owner or group using::

    datasetImages = getImages(session, 'dataset', datasetsIds)

All the images contained in all the datasets under a subset of projects of
known identifiers ``projectIds`` can be returned independently of their owner
or group using::

    projectImages = getImages(session, 'project', projectIds)

To filter images by owner, use the ``owner`` parameter/key value. A value of
``-1`` means images are retrieved independently of their owner::

    % Returns all images owned by the specified user in the context of the
    % session group
    images = getImages(session, 'owner', ownerId);
    % Returns all images with the input identifiers owned by the specified user
    images = getImages(session, ids, 'owner', ownerId);
    % Returns all images owned by any user in the context of the session
    % group
    images = getImages(session, 'owner', -1);

To filter images by group, use the ``group`` parameter/key value. A value of
``-1`` means images are retrieved independently of their group::

    % Returns all images owned by the session user in the specified group
    images = getImages(session, 'group', groupId);
    % Returns all images with the input identifiers in the specified group
    images = getImages(session, ids, 'group', groupId);
    % Returns all images owned by the session user across groups
    images = getImages(session, 'group', -1);

The ``Image``-``Pixels`` model (see :doc:`/developers/Model`) implies you need to use the ``Pixels`` objects
to access valuable data about the ``Image``::

    pixels = image.getPrimaryPixels();
    sizeZ = pixels.getSizeZ().getValue(); % The number of z-sections.
    sizeT = pixels.getSizeT().getValue(); % The number of timepoints.
    sizeC = pixels.getSizeC().getValue(); % The number of channels.
    sizeX = pixels.getSizeX().getValue(); % The number of pixels along the X-axis.
    sizeY = pixels.getSizeY().getValue(); % The number of pixels along the Y-axis.

-  **Screens**

The screens owned by the session user in the context of the session group can
be retrieved using the
:matlab_source:`getScreens <src/main/io/getScreens.m>` function::

    screens = getScreens(session)

If the screen identifiers are known, they can be retrieved independently of
their owner or group using::

    screens = getScreens(session, ids)

Note that the wells are not loaded. The plate objects can be accessed using::

    for j = 1 : numel(screens), % Matlab array, index start at 1
        platesList = screens(j).linkedPlateList; % Java List, index start at 0
        for i = 0 : platesList.size()-1,
            plate = platesList.get(i);
            plateAcquisitionList = plate.copyPlateAcquisitions(); % Java List
            for k = 0 : plateAcquisitionList.size()-1,
                pa = plateAcquisitionList.get(i);
        end
    end

To return the orphaned plates as well as the screens, you can query the
second output argument of
:matlab_source:`getScreens <src/main/io/getScreens.m>`::

    [screens, orphanedPlates] = getScreens(session)

To filter screens by owner, use the ``owner`` parameter/key value. A value of
``-1`` means screens are retrieved independently of their owner::

    % Returns all screens owned by the specified user in the context of the
    % session group
    screens = getScreens(session, 'owner', ownerId);
    % Returns all screens with the input identifiers owned by the specified
    % user
    screens = getScreens(session, ids, 'owner', ownerId);
    % Returns all screens owned by any user in the context of the session
    % group
    screens = getScreens(session, 'owner', -1);

To filter screens by group, use the ``group`` parameter/key value. A value of
``-1`` means screens are retrieved independently of their group::

    % Returns all screens owned by the session user in the specified group
    screens = getScreens(session, 'group', groupId);
    % Returns all screens with the input identifiers in the specified group
    screens = getScreens(session, ids, 'group', groupId);
    % Returns all screens owned by the session user across groups
    screens = getScreens(session, 'group', -1);

-  **Plates**

The screens owned by the session user in the context of the session group can
be retrieved using the
:matlab_source:`getPlates <src/main/io/getPlates.m>` function::

    plates = getPlates(session)

If the plate identifiers are known, they can be retrieved independently of
their owner or group using::

    plates = getPlates(session, ids)

To filter plates by owner, use the ``owner`` parameter/key value. A value of
``-1`` means plates are retrieved independently of their owner::

    % Returns all plates owned by the specified user in the context of the
    % session group
    plates = getPlates(session, 'owner', ownerId);
    % Returns all plates with the input identifiers owned by the specified user
    plates = getPlates(session, ids, 'owner', ownerId);
    % Returns all plates owned by any user in the context of the session
    % group
    plates = getPlates(session, 'owner', -1);

To filter plates by group, use the ``group`` parameter/key value. A value of
-1 means plates are retrieved independently of their group::

    % Returns all plates owned by the session user in the specified group
    plates = getPlates(session, 'group', groupId);
    % Returns all plates with the input identifiers in the specified group
    plates = getPlates(session, ids, 'group', groupId);
    % Returns all plates owned by the session user across groups
    plates = getPlates(session, 'group', -1);

-  **Wells**

Given a plate identifier, the wells can be loaded using the ``findAllByQuery``
method::

    wellList = session.getQueryService().findAllByQuery(
    ['select well from Well as well '...
    'left outer join fetch well.plate as pt '...
    'left outer join fetch well.wellSamples as ws '...
    'left outer join fetch ws.plateAcquisition as pa '...
    'left outer join fetch ws.image as img '...
    'left outer join fetch img.pixels as pix '...
    'left outer join fetch pix.pixelsType as pt '...
    'where well.plate.id = ', num2str(plateId)], []);
    % wellList is a Java List, index starts at 0
    for j = 0 : wellList.size()-1,
        well = wellList.get(j);
        wellsSampleList = well.copyWellSamples();
        well.getId().getValue()
        % The wellList returned from the server is not sorted by wellIds, 
        % please extract the wellRow and wellColumn for every well,
        % to populate your results appropriately 
        wellRow = well.getRow().getValue();
        wellColumn = well.getColumn().getValue();
        for i = 0 : wellsSampleList.size()-1,
            ws = wellsSampleList.get(i);
            ws.getId().getValue()
            pa = ws.getPlateAcquisition();
        end
    end

-  **Channel**

A channel associated to an image has an object called a logicalChannel associated to it.
That entity contains valuable information e.g. emission wavelength, name, etc.
Given an Image, retrieve channels associated to an image on the OMERO server and the name of the channel::

    channels = loadChannels(session, image);
    for j = 1 : numel(channels) % Matlab array
        channel = channels(j);
        channelId = channel.getId().getValue();
        lc = channel.getLogicalChannel();
        channelName = lc.getName().getValue();
    end


Raw data access
---------------

You can retrieve data, plane by plane or retrieve a stack.
The values are ``z`` in ``[0, sizeZ - 1]``, ``c`` in ``[0, sizeC - 1]``
and ``t`` in ``[0, sizeT - 1]``.

-  **Plane**

The plane of an input image at coordinates ``(z, c, t)`` can be retrieved using
the :matlab_source:`getPlane <src/main/image/getPlane.m>`
function::

    plane = getPlane(session, image, z, c, t);

Alternatively, the image identifier can be passed to the function::

    plane = getPlane(session, imageId, z, c, t);

-  **Tile**

The tile of an input image at coordinates ``(z, c, t)`` originated at ``(x, y)`` (where ``x`` in ``[0, sizeX - 1]``, ``y`` in ``[0, sizeY - 1]``) and
of dimensions ``(w, h)`` can be retrieved using the
:matlab_source:`getTile <src/main/image/getTile.m>` function::

    tile = getTile(session, image, z, c, t, x, y, w, h);

Alternatively, the image identifier can be passed to the function::

    tile = getTile(session, imageId, z, c, t, x, y, w, h);

-  **Stack**

The stack of an input image at coordinates ``(c, t)`` can be retrieved using the
:matlab_source:`getStack <src/main/image/getStack.m>` function::

    stack = getStack(session, image, c, t);

Alternatively, the image identifier can be passed to the function::

    stack = getStack(session, imageId, c, t);

All the methods described above will internally initialize a raw pixels store
to retrieve the pixels data and close this store at the end of the call. This
is inefficient when multiple planes/tiles/stacks need to be retrieved. For
each function, it is possible to initialize a pixels store and pass this store
directly to the pixel retrieval function, e.g.::

  [store, pixels] = getRawPixelsStore(session, image);
  for z = 0 : sizeZ - 1
    for c = 0 : sizeC - 1
      for t = 0 : sizeT - 1
        plane = getPlane(pixels, store, z, c, t);
      end
    end
  end
  store.close();

-  **Hypercube**

This is useful when you need the ``Pixels`` intensity.

::

    % Create the store to load the stack. No access via the gateway
    store = session.createRawPixelsStore();
    % Indicate the pixels set you are working on
    store.setPixelsId(pixelsId, false);

    % Offset values in each dimension XYZCT
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

    % Indicate the step in each direction,
    % step = 1, will return values at index 0, 1, 2.
    % step = 2, values at index 0, 2, 4, etc.
    step = java.util.ArrayList;
    step.add(java.lang.Integer(1));
    step.add(java.lang.Integer(1));
    step.add(java.lang.Integer(1));
    step.add(java.lang.Integer(1));
    step.add(java.lang.Integer(1));
    % Retrieve the data
    store.getHypercube(offset, size, step);
    % Close the store
    store.close();

.. seealso::
  :matlab_source:`RawDataAccess.m <examples/RawDataAccess.m>`
    Example script showing methods to retrieve the pixel data from an image

Annotations
-----------

-  **Reading annotations by ID**

If the identifier of the annotation of a given type is known, the annotation
can be retrieved from the server using the generic :matlab_source:`getAnnotations <src/main/annotations/getAnnotations.m>` function::

    tagAnnotations = getAnnotations(session, 'tag', tagIds);

Shortcut functions are available for the main object and annotation types,
e.g. to retrieve tag annotations::

    tagAnnotations = getTagAnnotations(session, tagIds);

-  **Reading annotations linked to an object**

The annotations of a given type linked to a given object can be
retrieved using the generic :matlab_source:`getObjectAnnotations <src/main/annotations/getObjectAnnotations.m>` function::

    tagAnnotations = getObjectAnnotations(session, 'tag', 'image', imageIds);

Shortcut functions are available for the main object and annotation
types, e.g. to retrieve the tag annotations linked to images::

    tagAnnotations = getImageTagAnnotations(session, imageIds);

Annotations can be filtered by namespace. To include only annotations with a
given namespace ``ns``, use the ``include`` parameter/key value::

   tagAnnotations = getImageTagAnnotations(session, imageIds, 'include', ns);

To exclude all annotations with a given namespace ``ns``, use the ``exclude``
parameter/key value::

   tagAnnotations = getImageTagAnnotations(session, imageIds, 'exclude', ns);

By default, only the annotations owned by the session owner are returned. To
specify the owner of the annotations, use the ``owner`` paramter/key value
pair. For instance to return all tag annotations owned by user with an identifier equals to 5::

    tagAnnotations = getImageTagAnnotations(session, imageIds, 'owner', 5);

To retrieve all annotations independently of their owner, use ``-1`` as the owner
identifier::

   tagAnnotations = getImageTagAnnotations(session, imageIds, 'owner', -1);

-  **Reading file annotations**

The content of a file annotation can be downloaded to local disk using the
:matlab_source:`getFileAnnotationContent <src/main/annotations/getFileAnnotationContent.m>`
function. If the file annotation has been retrieved from the server as
``fileAnnotation``, then the content of its ``OriginalFile`` can be downloaded
under ``target_file`` using::

    getFileAnnotationContent(session, fileAnnotation, target_file);

Alternatively, if only the identifier of the file annotation ``faId`` is
known::

    getFileAnnotationContent(session, faId, target_file);

-  **Writing and linking annotations**

New annotations can be created using the corresponding ``write*Annotation``
function::

    % Create a comment annotation
    commentAnnotation = writeCommentAnnotation(session, 'comment');
    % Create a double annotation
    doubleAnnotation = writeDoubleAnnotation(session, .5);
    % Create a map annotation
    mapAnnotation = writeMapAnnotation(session, 'key', value);
    % Create a tag annotation
    tagAnnotation = writeTagAnnotation(session, 'tag name');
    % Create a timestamp annotation
    timestampAnnotation = writeTimestampAnnotation(session, now);
    % Create an XML annotation
    xmlAnnotation = writeXmlAnnotation(session, xmlString);

File annotations can also be created from the content of a
:file:`local_file_path`::

    fileAnnotation = writeFileAnnotation(session, local_file_path);

Each annotation creation function uses the context of the session group by
default. To create the annotation in a different group, use the ``group``
key/value pair::

    commentAnnotation = writeCommentAnnotation(session, 'comment', 'group', groupId);
    doubleAnnotation = writeDoubleAnnotation(session, .5, 'group', groupId);
    mapAnnotation = writeMapAnnotation(session, 'key', value, 'group', groupId);
    tagAnnotation = writeTagAnnotation(session, 'tag name', 'group', groupId);
    timestampAnnotation = writeTimestampAnnotation(session, now, 'group', groupId);
    xmlAnnotation = writeXmlAnnotation(session, xmlString, 'group', groupId);
    fileAnnotation = writeFileAnnotation(session, local_file_path, 'group', groupId);

Existing annotations can be linked to existing objects on the server using the
:matlab_source:`linkAnnotation <src/main/annotations/linkAnnotation.m>`
function. For example, to link a tag annotation and a file annotation to the
image ``image_id``::

    link1 = linkAnnotation(session, tagAnnotation, 'image', imageId);
    link2 = linkAnnotation(session, fileAnnotation, 'image', imageId);

For existing file annotations, it is possible to replace the content of the
original file without having to recreate a new file annotation using the
:matlab_source:`updateFileAnnotation <src/main/annotations/updateFileAnnotation.m>` function.
If the file annotation has been retrieved from the server as
``fileAnnotation``, then the content of its ``OriginalFile`` can be replaced
by the content of ``local_file_path`` using::

    updateFileAnnotation(session, fileAnnotation, local_file_path);

.. seealso::
  :matlab_source:`WriteData.m <examples/WriteData.m>`
    Example script showing methods to write, link and retrieve annotations.

Writing data
------------

-  **Projects/Datasets**

Projects and datasets can be created in the context of the session group
using the :matlab_source:`createProject <src/main/io/createProject.m>` and :matlab_source:`createDataset <src/main/io/createDataset.m>` functions::

    % Create a new project in the context of the session group
    newproject = createProject(session, 'project name');
    % Create a new dataset in the context of the session group
    newdataset = createDataset(session, 'dataset name');

Writing projects/datasets in a different context than the session group can be
achieved by passing the group identifier using the `group` parameter::

    % Create a new project in the specified group
    newproject = createProject(session, 'project name', 'group', groupId);
    % Create a new dataset in the specified group
    newdataset = createDataset(session, 'dataset name', 'group', groupId);

When creating a dataset, it is possible to link it to an existing project
using either the project object or its identifier. In this case, the group
context is determined by the parent project::

    % Create two new projects in different groups
    project1 = createProject(session, 'project name');
    project2 = createProject(session, 'project name', 'group', groupId);
    % Create new datasets linked to each project
    dataset1 = createDataset(session, 'dataset name', project1);
    dataset2 = createDataset(session, 'dataset name', project2.getId().getValue());

-  **Screens/Plates**

Screens and plates can be created in the context of the session group
using the :matlab_source:`createScreen <src/main/io/createScreen.m>` and :matlab_source:`createPlate <src/main/io/createPlate.m>` functions::

    % Create a new screen in the context of the session group
    newscreen = createScreen(session, 'screen name');
    % Create a new plate in the context of the session group
    newplate = createPlate(session, 'plate name');

Writing screens/plates in a different context than the session group can be
achieved by passing the group identifier using the `group` parameter::

    % Create a new screen in the specified group
    newscreen = createScreen(session, 'screen name', 'group', groupId);
    % Create a new plate in the specified group
    newplate = createPlate(session, 'plate name', 'group', groupId);

When creating a plate, it is possible to link it to an existing screen
using either the screen object or its identifier. In this case, the group
context is determined by the parent screen::

    % Create two new projects in different groups
    screen1 = createScreen(session, 'screen name');
    screen2 = createScreen(session, 'screen name', 'group', groupId);
    % Create new datasets linked to each project
    plate1 = createPlate(session, 'plate name', screen1);
    plate2 = createPlate(session, 'plate name', screen2.getId().getValue());

.. seealso::
  :matlab_source:`WriteData.m <examples/WriteData.m>`
    Example script showing methods to create projects, datasets, plates and
    screens.

How to use OMERO tables
-----------------------

-  **Create a table**. In the following example, a table is created with
   2 columns and is linked to an Image.

::

    name = char(java.util.UUID.randomUUID());
    columns = javaArray('omero.grid.Column', 2);
    columns(1) = omero.grid.LongColumn('Uid', 'testLong', []);
    valuesString = javaArray('java.lang.String', 1);
    columns(2) = omero.grid.StringColumn('MyStringColumn', '', 64, valuesString);

    % Create a new table.
    table = session.sharedResources().newTable(1, name);

    % Initialize the table
    table.initialize(columns);
    
    % Create and populate omero.grid (The following java wrapping logic is compatible Matlab2014b onwards)
    data = javaArray('omero.grid.Column', 2);
    data(1) = omero.grid.LongColumn('Uid', 'test Long', [2]);
    valuesString = javaArray('java.lang.String', 1);
    valuesString(1) = java.lang.String('add');
    data(2) = omero.grid.StringColumn('MyStringColumn', '', 64, valuesString);
    
    % Add data to the table.
    table.addData(data);
    file = table.getOriginalFile(); % if you need to interact with the table

    % link table to an Image
    fa = omero.model.FileAnnotationI;
    fa.setFile(file);
    % Currently OMERO.tables are displayed only in OMERO.web and 
    % for Screen/plate/wells alone. In all cases the file annotation
    % needs to contain a namespace.
    fa.setNs(rstring(omero.constants.namespaces.NSBULKANNOTATIONS.value));
    link = linkAnnotation(session, fa, 'image', imageId);

-  **Read the contents of the table**.

::

    of = omero.model.OriginalFileI(file.getId(), false);
    tablePrx = session.sharedResources().openTable(of);

    % Read headers
    headers = tablePrx.getHeaders();
    for i = 1 : size(headers, 1)
        headers(i).name; % name of the header
        % Do something
    end

    % Depending on the size of table, you may only want to read some blocks.
    cols = [0:size(headers, 1)-1]; % The number of columns you wish to read.
    rows = [0:tablePrx.getNumberOfRows()-1]; % The number of rows you wish to read.
    data = tablePrx.slice(cols, rows); % Read the data.
    c = data.columns;
    for i = 1 : size(c)
        column = c(i);
        % Do something
    end
    tablePrx.close(); % Important to close when done.

ROIs
----

To learn about the model, see the
:model_doc:`developers guide to the ROI model <developers/roi.html>`. Note
that annotations can be linked to ROI.

-  **Creating ROI**

This example creates a ROI with shapes, a rectangle, an ellipse and a polygon, and
attaches it to an image::

    % First create a rectangular shape.
    rectangle = createRectangle(0, 0, 10, 20);
    % Indicate on which plane (z, c, t) to attach the shape
    setShapeCoordinates(rectangle, 0, 0, 0);

    % First create an ellipse shape.
    ellipse = createEllipse(0, 0, 10, 20);
    % Indicate on which plane (z, c, t) to attach the shape
    setShapeCoordinates(ellipse, 0, 0, 0);

    % First create a polygon shape.
    % Specify x-coordinates, y-coordinates
    polygon = createPolygon([1 5 10 8], [1 5 5 10]);
    % Indicate on which plane (z, c, t) to attach the shape
    setShapeCoordinates(polygon, 0, 0, 0);

    % Create the roi.
    roi = omero.model.RoiI;
    % Attach the shapes to the roi, several shapes can be added.
    roi.addShape(rectangle);
    roi.addShape(ellipse);
    roi.addShape(polygon);

    % Link the roi and the image
    roi.setImage(omero.model.ImageI(imageId, false));
    % Save
    iUpdate = session.getUpdateService();
    roi = iUpdate.saveAndReturnObject(roi);
    % Check that the shape has been added.
    numShapes = roi.sizeOfShapes;
    for ns = 1 : numShapes
       shape = roi.getShape(ns-1);
    end

.. seealso::

    :matlab_sourcedir:`ROI utility functions <src/main/roi>`
        OMERO.matlab functions for creating and managing Shape and ROI
        objects.

-  **Retrieving ROIs linked to an image**

::

    service = session.getRoiService();
    roiResult = service.findByImage(imageId, []);
    rois = roiResult.rois;
    n = rois.size;
    shapeType = '';
    for thisROI  = 1 : n
        roi = rois.get(thisROI-1);
        numShapes = roi.sizeOfShapes;
        for ns = 1 : numShapes
            shape = roi.getShape(ns-1);
            if (isa(shape, 'omero.model.Rectangle'))
               rectangle = shape;
               rectangle.getX().getValue();
            elseif (isa(shape, 'omero.model.Ellipse'))
               ellipse = shape;
               ellipse.getX().getValue();
            elseif (isa(shape, 'omero.model.Point'))
               point = shape;
               point.getX().getValue();
            elseif (isa(shape, 'omero.model.Line'))
               line = shape;
               line.getX1().getValue();
            end
        end
    end

- **Adding Transforms to a Shape object**

::
    
    % Apply rotation alone to an ellipse object
    % (angle of rotation set to 10 degrees)
    % create ellipse (shape object)
    ellipse = createEllipse(0, 0, 10, 20);
    setShapeCoordinates(ellipse, 0, 0, 0);
    % set angle of rotation
    theta = 10;
    % create transform object
    newTform = omero.model.AffineTransformI;
    newTform.setA00(rdouble(cos(theta)));
    newTform.setA10(rdouble(-sin(theta)));
    newTform.setA01(rdouble(sin(theta)));
    newTform.setA11(rdouble(cos(theta)));
    newTform.setA02(rdouble(0));
    newTform.setA12(rdouble(0));
    % apply transform
    ellipse.setTransform(newTform);
    % Create the ROI
    roi = omero.model.RoiI;
    roi.addShape(ellipse);
    roi = session.getUpdateService().saveAndReturnObject(roi);

-  **Retrieving Transforms linked to an Image**

::  

    for i = 1 : nShapes
        shape = roi.getShape(i - 1);
        
        %http://blog.openmicroscopy.org/data-model/future-plans/2016/06/20/shape-transforms/
        transform = shape.getTransform();
        xScaling = transform.getA00().getValue();
        xShearing = transform.getA01().getValue();
        xTranslation = transform.getA02().getValue();
            
        yScaling = transform.getA11().getValue();
        yShearing = transform.getA10().getValue();
        yTranslation = transform.getA12().getValue();
        
        %tformMatrix = [A00, A10, 0; A01, A11, 0; A02, A12, 1];
        tformMatrix = [xScaling, yShearing, 0; xShearing, yScaling, 0; xTranslation, yTranslation, 1];
        
        fprintf(1, 'Shape Type : %s\n', char(shape.toString));
        fprintf(1, 'xScaling : %s\n', num2str(tformMatrix(1,1)));
        fprintf(1, 'yScaling : %s\n', num2str(tformMatrix(2,2)));
        fprintf(1, 'xShearing : %s\n', num2str(tformMatrix(2,1)));
        fprintf(1, 'yShearing : %s\n', num2str(tformMatrix(1,2)));
        fprintf(1, 'xTranslation: %s\n', num2str(tformMatrix(3,1)));
        fprintf(1, 'yTranslation: %s\n', num2str(tformMatrix(3,2)));
    end

-  **Removing a shape from ROI**

::

    // Retrieve the roi linked to an image
    service = session.getRoiService();
    roiResult = service.findByImage(imageId, []);
    n = rois.size;
    for thisROI  = 1 : n
        roi = rois.get(thisROI-1);
        numShapes = roi.sizeOfShapes;
        for ns = 1:numShapes
            shape = roi.getShape(ns-1);
            % Remove the shape
            roi.removeShape(shape);
        end
        % Update the roi.
        roi = iUpdate.saveAndReturnObject(roi);
    end

-  **Analyzing shapes**

::

    // Retrieve the roi linked to an image
    service = session.getRoiService();
    roiResult = service.findByImage(imageId, []);
    n = rois.size;
    toAnalyse = java.util.ArrayList;
    for thisROI  = 1 : n
        roi = rois.get(thisROI-1);
        numShapes = roi.sizeOfShapes;
        for ns = 1:numShapes
            shape = roi.getShape(ns-1);
            toAnalyse.add(java.lang.Long(shape.getId().getValue()));
        end
    end
    //For convenience, we assume the shapes are on the first plane
    z = 0;
    c = 0;
    t = 0;
    stats = service.getShapeStatsRestricted(toAnalyse, z, t, [c]);
    calculated = stats(1,1);
    mean = calculated.mean(1,1);

Deleting data
-------------

It is possible to delete projects, datasets, images, ROIs, etc. and
objects linked to them depending on the specified options (see
:doc:`/developers/Modules/Delete`). For example, images of known identifiers
can be deleted from the server using the
:matlab_source:`deleteImages <src/main/delete/deleteImages.m>`
function::

    deleteImages(session, imageIds);

.. seealso::

    :matlab_source:`deleteProjects <src/main/delete/deleteProjects.m>`, :matlab_source:`deleteDatasets <src/main/delete/deleteDatasets.m>`, :matlab_source:`deleteScreens <src/main/delete/deleteScreens.m>`, :matlab_source:`deletePlates <src/main/delete/deletePlates.m>`
        Utility functions to delete objects.

Rendering images
-----------------

The :matlab_source:`RenderImages.m <examples/RenderImages.m>` example
script shows how to initialize the rendering engine and render an image.

Creating Image
--------------

The :matlab_source:`CreateImage.m <examples/CreateImage.m>` example
script shows how to create an image in OMERO. A similar approach can be
applied when uploading an image. To upload individual planes onto the server,
the data must be converted into a byte (int8) array first. If the ``Pixels``
object has been created, this conversion can done using the
:matlab_source:`toByteArray <src/main/helper/toByteArray.m>`
function.

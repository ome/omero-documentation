MATLAB and Python
=================

MATLAB functionality can be mixed into Python scripts using the
MATLAB Engine API for Python.

Installing MATLAB Engine API
----------------------------

To install the MATLAB Engine API for Python follow the
`installation guide <https://www.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html>`_. You only need to run ``python setup.py install``, most likely as an administrator.
It is possible to install the engine into a virtual environment.

Example MATLAB scripts
----------------------

Below are some sample scripts showing MATLAB being launched from
OMERO.scripts. MATLAB functions can also call the |OmeroJava| interface to 
access the server from the MATLAB functions.

Calling a simple MATLAB function
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    import omero.scripts as scripts

    import matlab.engine

    client = scripts.client('prime.py',
                            """
    This script checks if the specified number is a prime number.
        """,
        scripts.Long(
            "x", optional=False, grouping="1",
            description="Number to check."))
    try:
        # process the list of args above.
        params = {}
        for key in client.getInputKeys():
            if client.getInput(key):
                params[key] = client.getInput(key, unwrap=True)
        x = params.get("x")
        # start the MATLAB engine
        eng = matlab.engine.start_matlab("-nodisplay")
        tf = eng.isprime(x)
        print(tf)
        eng.quit()
    finally:
        client.closeSession()


Using the OMERO interface inside MATLAB
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This example shows the MATLAB script being called, passed to the client
object and accessing the same client instance as the script.

You will need to have the OMERO.matlab toolbox installed on the server:

  - download the toolbox from the `OMERO Downloads page <https://www.openmicroscopy.org/omero/downloads/>`_
  - unzip
  - enter the full path to the toolbox in the OMERO script below.

Create a ``frap.m``, copy the MATLAB function below.
Save the file to the server. Enter the full path to the directory
containing the scipt in the example OMERO script below.

Note that this script expects to run on timelapse images with at least one Ellipse
not linked to a T-index.

::

    import omero

    import omero.scripts as scripts
    from omero.rtypes import rlong
    from omero.gateway import BlitzGateway
    from omero.rtypes import robject, rstring

    import matlab.engine


    dataTypes = [rstring('Dataset')] 
    client = scripts.client('frap.py',
                            """
    This script does simple FRAP analysis using Ellipse ROIs previously
    saved on images. If matplotlib is installed, data is plotted and new
    OMERO images are created from the plots.
    Call the matlab frap code.
        """,
        scripts.String(
            "Data_Type", optional=False, grouping="1",
            description="Choose source of images",
            values=dataTypes, default="Dataset"),

        scripts.Long(
            "ID", optional=False, grouping="2",
            description="Dataset ID."))
    try:
        # process the list of args above.
        params = {}
        for key in client.getInputKeys():
            if client.getInput(key):
                params[key] = client.getInput(key, unwrap=True)
        dataset_id = params.get("ID")
        # wrap client to use the Blitz Gateway
        conn = BlitzGateway(client_obj=client)
        # start the MATLAB engine
        eng = matlab.engine.start_matlab("-nodisplay")
        # Add the OMERO.matlab toolbox the MATLABPATH
        eng.addpath("PATH_TO_TOOLBOX/OMERO.matlab-xxx")
        # Add the frap function to the MATLABPATH.
        # For convenience this could
        # be placed in the OMERO.matlab toolbox folder
        eng.addpath("PATH_TO_FRAP")
        eng.frap(conn.getEventContext().sessionUuid, dataset_id, nargout=0)
        eng.quit()
        client.setOutput("Message", rstring("frap script completed"))

    finally:
        client.closeSession()

The MATLAB frap function
^^^^^^^^^^^^^^^^^^^^^^^^
::

    function T = frap(sessionId, datasetId)

    p = inputParser;
    p.addRequired('sessionId',@(x) isscalar(x));
    p.addRequired('datasetId',@(x) isscalar(x));

    client = loadOmero();
    client.enableKeepAlive(60);
    % Join an OMERO session
    session = client.joinSession(sessionId);
    % Initiliaze the service used to load the Regions of Interest (ROI)
    service = session.getRoiService();

    % Retrieve the Dataset with the Images
    dataset = getDatasets(session, datasetId, true);
    images = toMatlabList(dataset.linkedImageList);

    % Iterate through the images

    for i = 1 : numel(images)
        image = images(i);
        imageId = image.getId().getValue();
        pixels = image.getPrimaryPixels();
        sizeT = pixels.getSizeT().getValue(); % The number of timepoints

        % Load the ROIs linked to the Image. Only keep the Ellipses
        roiResult = service.findByImage(imageId, []);
        rois = roiResult.rois;
        if rois.size == 0
            continue;
        end
        toAnalyse = java.util.ArrayList;
        for thisROI  = 1:rois.size
            roi = rois.get(thisROI-1);
            for ns = 1:roi.sizeOfShapes
                shape = roi.getShape(ns-1);
                if (isa(shape, 'omero.model.Ellipse'))
                    toAnalyse.add(java.lang.Long(shape.getId().getValue()));
                end
            end
        end

        % We analyse the first z and the first channel
        keys = strings(1, sizeT);
        values = strings(1, sizeT);
        means = zeros(1, sizeT);
        for t = 0:sizeT-1
            % OMERO index starts at 0
            stats = service.getShapeStatsRestricted(toAnalyse, 0, t, [0]);
            calculated = stats(1,1);
            mean = calculated.mean(1,1);
            index = t+1;
            keys(1, index) = num2str(t);
            values(1, index) = num2str(mean);
            means(1, index) = mean;
        end
        % create a map annotation and link it to the Image
        mapAnnotation = writeMapAnnotation(session, cellstr(keys), cellstr(values), 'namespace', 'demo.simple_frap_data');
        linkAnnotation(session, mapAnnotation, 'image', imageId);

        % Create a CSV
        headers = 'Image_name,ImageID,Timepoint,Mean';
        tmpName = [tempname,'.csv'];
        [filepath,imageName,ext] = fileparts(tmpName);
        f = fullfile(filepath, 'results_frap.csv');
        fileID = fopen(f,'w');
        fprintf(fileID,'%s\n',headers);
        for j = 1 : numel(keys)
            row = strcat(char(imageName), ',', num2str(imageId), ',', keys(1, j), ',', values(1, j));
            fprintf(fileID,'%s\n',row);
        end
        fclose(fileID);
        % Create a file annotation
        fileAnnotation = writeFileAnnotation(session, f, 'mimetype', 'text/csv', 'namespace', 'training.demo');
        linkAnnotation(session, fileAnnotation, 'image', imageId);

        % Plot the result
        time = 1:sizeT;
        fig = plot(means);
        xlabel('Timepoint'), ylabel('Values');
        % Save the plot as png
        name = strcat(char(image.getName().getValue()),'_FRAP_plot.png');
        saveas(fig,name);
        % Upload the Image as an attachment
        fileAnnotation = writeFileAnnotation(session, name);
        linkAnnotation(session, fileAnnotation, 'image', imageId);
        % Delete the local file
        delete(name)
    
    end

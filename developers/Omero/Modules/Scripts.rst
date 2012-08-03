.. _developers/Omero/Modules/Scripts:

OMERO.Scripts
=============

.. contents:

` MOVIE: introduction to
OMERO.scripts <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-3/mov/ScriptingWorkflow-4.3.mov>`_

:ref:`developers/Omero/Modules/Scripts` is the scripting service for scripting in OMERO.
`OmeroBlitz </ome/wiki/OmeroBlitz>`_ provides a service to run scripts
on the server. The scripts are then passed on to a grid of processors
called OMERO.grid that executes the script and returns the result to the
server which in turn passes the result onto the caller. All scripts
which run on :ref:`developers/Omero/Modules/Scripts` are of the form

::

    # import the omero package and the omero.scripts package.
    import omero, omero.scripts as script

    '''
    This method creates the client script object, with name SCRIPTNAME and SCRIPTDESCRIPTION.
    The script then supplies a number of variables that are both inputs and outputs to the 
    script. The types allowed are defined in the script package, with the qualifier after the 
    variable of in, out or inout depending on whether the variable if for input, output or input
    and output.
    '''  
    client = script.client("SCRIPTNAME", "SCRIPTDESCRIPTION", 
             script.TYPE("VARIABLENAME").[in()|out()|inout()], ...)
    # create a session on the server.
    client.createSession()

    # All variables are stored in a map accessed by getInput and setOutput via the client object.
    VARIABLENAME = client.getInput("VARIABLENAME");
    client.setOutput("VARIABLENAME", value);

Getting Started
---------------

For a tutorial on how to get started with the scripting service, see
:ref:`developers/Omero/Modules/Scripts/Guide`.

The iScript Service
-------------------

The Omero.blitz server provides a service call iScript that provides
methods to upload, delete, query and runscripts. To access these methods
a session needs to be created and the script service started. However,
you may find it more convenient to use the command line
`` bin/omero script `` or the OMERO.insight client to work with scripts
as described on the :ref:`developers/Omero/Modules/Scripts/Guide`.
The methods of the script service are below (bottom of page).

Debugging the Scripts
---------------------

The stderr and stdout from running a script should always be returned to
you, either when running scripts from the command line, via
OMERO.insight or using the scripts API. This should allow you to debug
any problems you have.

You can also look at the output from the script in the OriginalFile
directory, commonly stored in /OMERO/File/. The script file when
executed is uploaded as a new OriginalFile, and the standard error,
standard out are saved as the next two OriginalFiles after that. These
files can be opened in a text editor to examine contents.

Sample Scripts
--------------

Below are a set of sample scripts. You can find more under the
:source:` OmeroPy/scripts <components/tools/OmeroPy/scripts>`
source code directory or download from OMERO.insight (from the
bottom-left of any run-script dialog).

Ping script
~~~~~~~~~~~

This script echos the input parameters as outputs.

::

    import omero, omero.scripts as script
    client = script.client("ping.py", "simple ping script", 
             script.Long("a").inout(), script.String("b").inout())
    client.createSession()

    keys = client.getInputKeys()
    print "Keys found:"
    print keys
    for key in keys:
          client.setOutput(key, client.getInput(key))

Access the pixels object from the server.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This method shows an example of accessing the iPixels service on the
server to get the pixels description of pixels supplied as a parameter.

::

    import omero, omero.scripts as s

    client = s.client("getPixels.py", "get Pixels from the server", s.Long("pixelsId").in())
    session = client.createSession()

    # get the pixels Id from the parameters.
    pixelsId = client.getInput("pixelsId").val

    # Access the pixels service. 
    pixelsService = session.getPixelsService()

    # get the pixels for the pixels with Id=pixelsId.
    pixels = pixelsService.retrievePixDescription(pixelsId);

    '''
    now we have the pixels in hand we should do something with them
    print the width of the pixels. 
    '''
    print pixels.sizeX.val

    #print the height of the pixels.
    print pixels.sizeY.val

Matlab and Scripting
====================

The scripting service can run matlab scripts too. This is done using the
python package Mlabwrap,
` http://www.scipy.org/MlabWrap <http://www.scipy.org/MlabWrap>`_, this
allows access to Matlab functions from OMERO.blitz scripts.

Installing Mlabwrap
-------------------

To install MlabWrap? follow the installation guide at
` http://www.scipy.org/MlabWrap <http://www.scipy.org/MlabWrap>`_ and
make sure that the paths are set for the environment variables:
 LD\_LIBRARY\_PATH=$MATLABROOT/bin/Platform
 MLABRAW\_CMD\_STR=$MATLABROOT/bin/matlab

Example Matlab scripts
----------------------

Below are some sample scripts showing Matlab being launched from
OMERO.scripts. Matlab functions can also call the
`OmeroJava </ome/wiki/OmeroJava>`_ interface to access the server from
the Matlab functions.

Calling a simple Matlab function
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    import omero, omero.scripts as script
    # import mlabwrap to launch matlab.
    from mlabwrap import matlab;  
    client = script.client("rand.py", "Get matrix of random numbers drawn from a uniform distribution",  
                            script.Long("x").inout(), script.Long("y").inout())
    client.createSession()

    x = client.getInput("x").val
    y  = client.getInput("y").val

    # call the matlab rand function via mlabwrap will automatically launch matlab 
    # if it's not already running on the system and call the rand method.
    val = matlab.rand(x,y);
    print val

Using the OmeroJ interface inside Matlab
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example shows the matlab script being called, passed the client
object and accessing the same client instance as the script.

::

    import omero, omero.scripts as script
    # import mlabwrap to launch matlab.
    from mlabwrap import matlab;  
    client = script.client("projection.py", "Call the matlab projection code",  
                            script.String("iceConfig").in(), script.String("user").in(),
                            script.String("password"),
                            script.Long("pixelsId").inout(), script.String("method").inout()
                            script.Long("stack").inout())
    client.createSession()

    iceConfig = client.getInput("pixelsId").val
    user = client.getInput("pixelsId").val
    password = client.getInput("pixelsId").val
    method  = client.getInput("method").val
    stack = client.getInput("stack").val;

    image = matlab.performProjection(iceConfig, username, password, pixelsId, stack, method);

The matlab projection method

::

    function performProjection(iceConfig, username, password, pixelsId, zSection, method)

    omerojavaService = createOmeroJavaService(iceConfig, username, password);
    pixels = getPixels(omerojavaService, pixelsId);
    stack = getPlaneStack(omerojavaService, pixelsId, zSection);
    projectedImage = ProjectionOnStack(stack, method);

::

    function [resultImage] = ProjectionOnStack(imageStack,type)

    [zSections, X, Y] = size(imageStack);

    if(strcmp(type,'mean') || strcmp(type, 'sum'))
        resultImage = squeeze(sum(imageStack));
        if(strcmp(type,'mean'))
            resultImage = resultImage./zSections;
        end
    end
    if(strcmp(type,'max'))
        resultImage = squeeze(max(imageStack,[],1));
    end

**Method Detail**

getScripts
~~~~~~~~~~

::

    java.util.Map getScripts()
                             throws ApiUsageException,
                                    SecurityViolation

This method returns the scripts on the server as by id and name.

**Returns:**

see above.

**Throws:**

``ApiUsageException``

``SecurityViolation``

--------------

deleteScript
~~~~~~~~~~~~

::

    void deleteScript(long id)
                      throws ApiUsageException,
                             SecurityViolation

Delete the script on the server with id.

**Parameters:**

``id`` - Id of the script to delete.

**Throws:**

``ApiUsageException``

``SecurityViolation``

--------------

getScriptID
~~~~~~~~~~~

::

    long getScriptID(java.lang.String scriptName)
                     throws ApiUsageException,
                            SecurityViolation

Get the id of the script with name, scriptName, the script service
ensures that all script names are unique.

**Parameters:**

``scriptName`` - The name of the script.

**Returns:**

see above.

**Throws:**

``ApiUsageException``

``SecurityViolation``

--------------

uploadScript
~~~~~~~~~~~~

::

    long uploadScript(java.lang.String script)
                      throws ApiUsageException,
                             SecurityViolation

Upload the script to the server and get the id. This method checks that
a script with that names does not exist and that the script has
parameters.

**Parameters:**

``script`` - see above.

**Returns:**

The new id of the script.

**Throws:**

``ApiUsageException``

``SecurityViolation``

--------------

getScript
~~~~~~~~~

::

    java.lang.String getScript(long id)
                               throws ApiUsageException

Get the script from the server with id.

**Parameters:**

``id`` - see above.

**Returns:**

see above.

**Throws:**

``ApiUsageException``

--------------

getParams
~~~~~~~~~

::

    java.util.Map getParams(long id)
                            throws ApiUsageException

Get the parameters that the script takes. This is a key-value pair map,
the key being the variable name, and the value the type of the variable.

**Parameters:**

``id`` - see above.

**Returns:**

see above.

**Throws:**

``ApiUsageException``

--------------

runScript
~~~~~~~~~

::

    java.util.Map runScript(long id,
                            java.util.Map paramMap)
                            throws ApiUsageException,
                                   SecurityViolation

Run the script on the server with id, and using the parameters,
paramMap. The server checks that all the parameters expected by the
script are supplied in the paramMap and that their types match. Once
executed the script then returns a resultMap which is a key-value pair
map, the key being the result variable name and the value being the
value of the variable.

**Parameters:**

``id`` - see above.

``paramMap`` - see above.

**Returns:**

see above.

**Throws:**

``ApiUsageException``

``SecurityViolation``

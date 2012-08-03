.. _developers/Omero/Modules/Scripts/Guide:

Scripting Service User Guide
============================

`|Browsing scripts in
Insight| </ome/attachment/wiki/OmeroPy/ScriptingServiceGuide/scripts.png>`_

Since the 4.2 release, OMERO allows Python scripts to be uploaded to the
server and registered in the server database. These scripts can then be
called from a client with the scripts running on the server. This allows
extra functionality to be added to an OMERO server.

This is a guide to getting started with the scripting service, without
going into the 'behind the scenes' details. More technical details can
be found on the `OmeroScripts </ome/wiki/OmeroScripts>`_ page.

In addition to this guide, you may find the following pages useful for
more information on using the OMERO Python API:
`PythonClientBeginners </ome/wiki/PythonClientBeginners>`_,
|OmeroClients|, |BlitzGateway|.

Some example code
`PythonClientCodeExamples </ome/wiki/PythonClientCodeExamples>`_ are
provided, which can be used in client scripts or scripting-service
scripts.

Scripts can be run from Insight, using a UI generated from the script.
The script results can also be handled by Insight. Scripts should
conform to the :ref:`developers/Omero/Modules/Scripts/StyleGuide`
in order to improve usability of the script.

The basic steps in a script-writing workflow are:

-  Write a script using your favorite text editor, save locally
-  Use command line (or OMERO.insight client) to upload script to server
-  Use command line (or OMERO.insight client) to run script on the
   server (results will be displayed)
-  Edit script and replace copy on server and run again....etc.

Script-writing (as 'Admin')
---------------------------

The workflow of writing, uploading, running, editing and deploying
scripts is slightly different depending on whether you have admin access
to your chosen server. Working with scripts is more straight-forward if
you have admin access to a server - this is the preferred workflow
(below). See bottom of page for the 'User' workflow.

It is assumed that scripts written by a server admin are "trusted" to
run on the server without causing any disruption or security risks.
Also, official scripts are available to all regular users of the server.

Download / Edit script
~~~~~~~~~~~~~~~~~~~~~~

The easiest way to get started is to take an existing script and edit it
for your needs. An example created for the purpose of this tutorial can
be found at 
:source:`Edit_Descriptions.py <examples/ScriptingService/Edit_Descriptions.py>`.
You should organise your scripts on your local machine in a way that
makes sense to users, since your local file paths will be mimicked on
the server and used to organise script menus in Insight (see screen-shot
above).

::

    # Save the script to a suitable location. The tutorial will use this location:
    # Desktop/scripts/demo_tutorial/Edit_Descriptions.py

The action of this script (editing Image descriptions) is trivial but it
demonstrates a number of features that you may find useful, including
conventions for inputs and outputs to improve interaction with
OMERO.insight (as discussed on the `developers/Omero/Modules/Scripts/StyleGuide`).

The script is well documented and should get you started. A few points
to note:

Since the OMERO 4.3 release, if you are using the |BlitzGateway|,
you can get a connection wrapper like this:

::

    from omero.gateway import BlitzGateway

    conn = BlitzGateway(client_obj=client)
    # now you can do E.g. conn.getObject("Image", imageId) etc.

Alternatively, if you are working directly with the OMERO services, you
can get a service factory like this:

::

    session = client.getSession()
    # now you can do E.g. session.getQueryService() etc. 

More Example Scripts
~~~~~~~~~~~~~~~~~~~~

Several official scripts are included in the release of OMERO and can be
found under the lib/scripts/omero/ directory of the server package. Any
script can also be download from the OMERO.insight client (bottom-left
of the run-script dialog).

Warning: If you wish to edit the official scripts that are part of the
OMERO release, you should be prepared to apply the same changes to
future releases of these scripts from OMERO. If you think that your
changes should be included as part of future released scripts, please
let us know.

Upload Script
~~~~~~~~~~~~~

You can use the command line, OMERO.insight or the server file system to
upload scripts. The 'script' command line tool is discussed in more
detail below.

You may find it useful to add the OMERO.server/bin/ folder to your PATH
so you can call 'bin/omero' commands when working in the scripts folder.
E.g:

::

    export PATH=$PATH:/Users/will/Desktop/OMERO.server-Beta-4.3/bin/

Upload the script we saved earlier, specifying it as 'official' (trusted
to run on the server processor). You will need to log in the first time
you use the 'script' command. The new script ID will be printed out:

::

    $ cd Desktop/scripts/
    $ omero script upload demo_tutorial/Edit_Descriptions.py --official
    Previously logged in to localhost:4064 as root
    Server: [localhost]          # hit 'enter' to accept default login details
    Username: [root]
    Password:
    Created session 09fcf689-cc85-409d-91ac-f9865dbfd650 (root@localhost:4064). Idle timeout: 10.0 min. Current group: system
    Uploaded official script as original file #301

You can add, remove and edit scripts directly in the
OMERO\_HOME/lib/scripts/omero/ folder. Any changes made here will be
detected by OMERO. Official scripts are uniquely identified on the OMERO
server by their 'path' and 'name'.

Any folders in the script path are created on the server under
/lib/scripts/ E.g. the above example will be stored at
/lib/scripts/examples/Edit\_Descriptions.py

The ID of the script is printed after upload and can also be determined
by listing scripts (see below).

Run Script
~~~~~~~~~~

You can run the script from OMERO.insight by browsing the scripts (see
screen-shot above). A UI will be generated from the chosen script and
the currently selected images or datasets will be populated if the
script supports this (see `developers/Omero/Modules/Scripts/StyleGuide`).

Or launch the script from the command line, specifying the script ID.
You will be asked to provide input for any non-optional parameters that
do not have default values specified. Any stdout and stderr will be
displayed as well as any outputs that the script has returned.

::

    wjm:examples will$ omero script launch 301  # script ID
    Using session 1202acc0-4424-4fa2-84fe-7c9e069d3563 (root@localhost:4064). Idle timeout: 10.0 min. Current group: system
    Enter value for "IDs": 1201
    Job 1464 ready
    Waiting....
    Callback received: FINISHED

        *** start stdout ***
        * {'IDs': [1201L], 'Data_Type': 'Dataset'}
        * Processing Images from Dataset: LSM - .mdb
        * Editing images with this description: 
        * No description specified
        * 
        *    Editing image ID: 15651 Name: sample files.mdb [XY-ch-02]
        *    Editing image ID: 15652 Name: sample files.mdb [XY-ch-03]
        *    Editing image ID: 15653 Name: sample files.mdb [XY-ch]
        *    Editing image ID: 15654 Name: sample files.mdb [XYT]
        *    Editing image ID: 15655 Name: sample files.mdb [XYZ-ch-20x]
        *    Editing image ID: 15656 Name: sample files.mdb [XYZ-ch-zoom]
        *    Editing image ID: 15658 Name: sample files.mdb [XYZ-ch0]
        *    Editing image ID: 15657 Name: sample files.mdb [XYZ-ch]
        * 
        *** end stdout ***


        *** out parameters ***
        * Message=8 Images edited
        ***  done ***

Parameter values can also be specified in the command.

::

    # simply specify the required parameters that don't have defaults
    $ omero script launch 301 IDs=1201 

    # can also specify additional parameters
    $ omero script launch 301 Data_Type='Image' IDs=15652,15653 New_Description="Adding description from script to Image"

Edit and Replace
~~~~~~~~~~~~~~~~

Edit the script and upload it to replace the previous copy, specifying
the ID of the file to replace.

::

    $ omero script replace 301 examples/Edit_Descriptions.py

Finally, you can upload and run your scripts from Insight.

Other 'script' commands
~~~~~~~~~~~~~~~~~~~~~~~

Start by printing help for the script command:

::

    $ omero script -h
    usage: /Users/will/Documents/workspace/Omero/dist/bin/omero script
           [-h] <subcommand> ...

    Support for launching, uploading and otherwise managing OMERO.scripts

    Optional Arguments:
      In addition to any higher level options

      -h, --help          show this help message and exit

    Subcommands:
      Use /Users/will/Documents/workspace/Omero/dist/bin/omero script <subcommand> -h for more information.

      <subcommand>
        demo              Runs a short demo of the scripting system
        list              List files for user or group
        cat               Prints a script to standard out
        edit              Opens a script in $EDITOR and saves it back to the server
        params            Print the parameters for a given script
        launch            Launch a script with parameters
        disable           Makes script non-executable by setting the mimetype
        enable            Makes a script non-executable (sets mimetype to text/x-python)
        jobs              List current jobs for user or group
        serve             Start a usermode processor for scripts
        upload            Upload a script
        replace           Replace an existing script with a new value
        run               Run a script with the OMERO libraries loaded and current login

To list scripts on the server:

::

    $ omero script list
    Using session 09fcf689-cc85-409d-91ac-f9865dbfd650 (root@localhost:4064). Idle timeout: 10.0 min. Current group: system
     id  | Official scripts                            
    -----+---------------------------------------------
     201 | /omero/analysis_scripts/flim-omero.py       
     1   | /omero/analysis_scripts/FLIM.py             
     202 | /omero/export_scripts/Batch_Image_Export.py 
     203 | /omero/export_scripts/Make_Movie.py         
     204 | /omero/figure_scripts/Movie_Figure.py       
     205 | /omero/figure_scripts/Movie_ROI_Figure.py   
     206 | /omero/figure_scripts/ROI_Split_Figure.py   
     207 | /omero/figure_scripts/Split_View_Figure.py  
     208 | /omero/figure_scripts/Thumbnail_Figure.py   
     8   | /omero/import_scripts/Populate_ROI.py       
     9   | /omero/setup_scripts/FLIM_initialise.py     
     209 | /omero/util_scripts/Channel_Offsets.py      
     210 | /omero/util_scripts/Combine_Images.py       
     211 | /omero/util_scripts/Images_From_ROIs.py     
    (14 rows)

If you want to know the parameters for a particular script you can use
the params command. This prints out the details of the script, including
the inputs.

::

    $ wjm:examples will$ omero script params 301
    Using session 1202acc0-4424-4fa2-84fe-7c9e069d3563 (root@localhost:4064). Idle timeout: 10.0 min. Current group: system

    id:  301
    name:  Edit_Descriptions.py
    version:  
    authors:  
    institutions:  
    description:  Edits the descriptions of multiple Images,
    either specified via Image IDs or by the Dataset IDs.
    See http://trac.openmicroscopy.org.uk/ome/wiki/OmeroPy/ScriptingServiceGuide for the tutorial that uses this script.
    namespaces:  
    stdout:  text/plain
    stderr:  text/plain
    inputs:
      New_Description - The new description to set for each Image in the Dataset
        Optional: True
        Type: ::omero::RString
        Min: 
        Max: 
        Values: 
      IDs - List of Dataset IDs or Image IDs
        Optional: False
        Type: ::omero::RList
        Subtype: ::omero::RLong
        Min: 
        Max: 
        Values: 
      Data_Type - The data you want to work with.
        Optional: False
        Type: ::omero::RString
        Min: 
        Max: 
        Values: Dataset, Image
    outputs:

Regular User workflow
---------------------

If you are using a server for which you do not have admin access, you
must upload scripts as 'user' scripts, which are not trusted to run on
the server machine. The OMERO scripting service will still execute these
scripts in a similar manner to official 'trusted' scripts but behind the
scenes it uses the client machine to execute the script. This means that
any package imports required by the script should be available on the
client machine.

The first step is to connect to the server and set up the processor on
the client (See diagram to the right). `|User Processor
diagram| </ome/attachment/wiki/OmeroPy/ScriptingServiceGuide/Picture%204.png>`_

-  You need to download 'Ice' from ZeroC and set the environment
   variables, as described
   ` here <http://www.openmicroscopy.org.uk/site/support/omero4/server/install-omero-4.1-on-mac-os-x-10.5>`_.
-  You also need the OMERO server download. Go to the `OMERO
   downloads <http://www.openmicroscopy.org/site/support/omero4/downloads>`_
   page and get the appropriate server package (Version must be OMERO
   4.2 or later and match the server you are connecting to). Unzip the
   package in a suitable location.

In a command line terminal, change into the unzipped OMERO package,
connect to the server and start user processor. For example for host:
openmicroscopy.org.uk and user: will

::

    $ cd Desktop/OMERO.server-Beta-4.2/
    $ bin/omero -s openmicroscopy.org.uk -u will script serve user
    $ password: ......

If you want to run scripts belonging to another user in the same
collaborative group you need to set up your local user processor to
accept scripts from that user. First, find the ID of the user, then
start the user processor and give it the user's ID:

::

    $ cd Desktop/OMERO.server-Beta-4.2/
    $ bin/omero -s openmicroscopy.org.uk -u will user list
    $ bin/omero -s openmicroscopy.org.uk -u will script serve user=5

From this point on, the user and admin workflows are the same, except
for a couple of options that are not available to regular users. Also
see below.

NB. Because non-official scripts do not have a unique path name, you
will be able to run the upload command multiple times on the same file.
This will create multiple copies of a file in OMERO and then you will
have to choose the most recent one (highest ID) if you want to run the
latest script. It is best to avoid this and use the 'replace' command as
for official scripts.

To list user scripts:

::

    $ omero -s openmicroscopy -u will script list user      # lists user scripts
     id  | Scripts for user                                                                            
    -----+---------------------------------------------------------------------------------------------
     151 | examples/HelloWorld.py        
     251 | examples/Edit_Descriptions.py

You can list scripts belonging to another user that are available for
you (E.g. You are both in the same collaborative group) by using the
user ID as described above:

::

    $ omero user list
    $ omero script list user=5

User scripts can be run from Insight. They will be found under 'User
Scripts' in the scripts menu. Remember, for user scripts you will need
to have the User-Processor running.

Attachments
~~~~~~~~~~~

-  `Picture
   4.png </ome/attachment/wiki/OmeroPy/ScriptingServiceGuide/Picture%204.png>`_
   `|Download| </ome/raw-attachment/wiki/OmeroPy/ScriptingServiceGuide/Picture%204.png>`_
   (39.6 KB) - added by *wmoore* `2
   years </ome/timeline?from=2010-06-07T11%3A03%3A30%2B01%3A00&precision=second>`_
   ago. User Processor diagram
-  `scripts.png </ome/attachment/wiki/OmeroPy/ScriptingServiceGuide/scripts.png>`_
   `|image4| </ome/raw-attachment/wiki/OmeroPy/ScriptingServiceGuide/scripts.png>`_
   (59.3 KB) - added by *wmoore* `2
   years </ome/timeline?from=2010-07-07T16%3A01%3A22%2B01%3A00&precision=second>`_
   ago. Browsing scripts in Insight

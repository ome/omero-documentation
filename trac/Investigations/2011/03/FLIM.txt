Running FLIM on OMERO
=====================

This page describes the steps required to run a the FLIM script from the
` The Data Analysis Group <http://www.compbio.dundee.ac.uk/DAG/>`_ on
the cluster at the ` DIG <http://research.nesc.ac.uk/node/2>`_ Edinburgh
using\ ` rapid <http://research.nesc.ac.uk/rapid>`_.

To run the script on the cluster at Edinburgh you need to:

-  Install the
   ` GridEngine <http://wikis.sun.com/display/GridEngine/Home>`_ on the
   computers
-  Install ` rapid <http://research.nesc.ac.uk/rapid>`_
-  Modify the script to communicate with OMERO.

   -  Install the required packages for the script.

-  Create a Rapid portlet

Platform information
--------------------

    The cluster that was set up in Edinburgh is running GridEngine 6.2
    on Ubuntu 10.10. All packages are installled using apt-get where
    possible.

Installing GridEngine
---------------------

update the /etc/source.list so that the lines

::

    deb http://archive.canonical.com/ ubuntu maverick partner
    deb-src http://archive.canonical.com/ ubuntu maverick partner
    deb http://extras.canonical.com/ ubuntu maverick main
    deb-src http://extras.canonical.com/ ubuntu maverick main

are uncommented, then update apt using:

::

    sudo apt-get update

On the master system install:

::

    sudo apt-get install gridengine-client gridengine-common gridengine-master gridengine-qmon

On the slave system type:

::

    sudo apt-get install gridengine-exec gridengine-client

Notice that gridengine-exec is not installed on the master system, if it
is a smaller cluster it could be installed there too.

add both master and slave addresses to the /etc/hosts files on both
slave and master systems. log into the master system, and start qmon

::

    ssh -X me@myComputer
    sudo qmon

Then go into the hosts, users and queue menu's to configure the system
for the slave and master systems.

Configuring hosts
~~~~~~~~~~~~~~~~~

::

    Tab "Host Configuration" -> Tab "Administration Host" -> Add master node
    Tab "Host Configuration" -> Tab "Submit Host" -> Add master node
    Tab "Host Configuration" -> Tab "Execution Host" -> Add slave nodes such as node01, node02 ...

    The slave nodes have a number of slots, this is the number of concurrent jobs that may be running on that host.
    Click on "Done" to finish

Configuring User
~~~~~~~~~~~~~~~~

Add or delete users that are allowed to access SGE here. In this
example, a user is added to an existing group and later this group will
be allowed to submit jobs. Everything else is left as default values.

Users have to be added in order to submit jobs with SGE.

::

    Tab "User Configuration" -> Tab "Userset" -> Highlight userset "arusers" and click on "Modify" 
    Enter Username in "User/Group" field 
    Click "Ok" to finish

Configuring Queue
~~~~~~~~~~~~~~~~~

While Host Configuration deals what computing resources are available
and User Configuration defines who have access to the resources, this
Queue Control defines ways to connect hosts and users.

::

    Tab "Queue Control" -> Tab "Hosts" -> Confirm the execution hosts show up there.

    Tab "Queue Control" -> Tab "Cluster Queues" -> Click on "Add" -> Name the queue, add execution nodes to Hostlist and
       Tab "Use access" -> allow access to user group arusers;
       Tab "General Configuration" -> Field "Slots" -> Raise the number to total CPU cores on slave nodes (ok to use a bigger number than actual CPU cores).

    Tab "Queue Control" -> Tab "Queue Instances" -> This is the place to manually assign hosts to queues, and control the the state (active, suspend ...) of hosts.

Configuring the Parallel Environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To run the script we need to configure the parallel environment to run
MPI jobs.

Tab "Parallel Environment" -> Add

::

    name: openmpi
    Slots: 10
    Users: NONE
    Xusers: NONE
    Start Proc Args: /bin/true
    Stop Proc Args: /bin/true
    Allocation Rule: $round_robin
    Urgency Slots: min
    Control Slave: true
    Job is first task: false
    Accounting Summary: false

To allow host to work with MPI and start jobs without requesting
passwords you will need to set up the ssh configuration ./.ssh/config

::

    StrictHostKeyChecking no
    BatchMode no

add all hosts to the known\_hosts and add public keys for each server in
the authorized\_keys file. This includes adding the host to itself, as
MPI will ssh into the same client.

Installing MPI
--------------

mpi4py needs to be installed on all nodes:

Download ` mpi4py <http://mpi4py.googlecode.com/>`_ install

::

    setup.py build 
    sudo setup.py install

To install on Mac OS X you will need to specify the architecture and the
SDK locations.

::

    10.5

    env MACOSX_DEPLOYMENT_TARGET=10.5 SDKROOT=/ ARCHFLAGS='-arch x86_64'  python setup.py install

::

    10.6
    env MACOSX_DEPLOYMENT_TARGET=10.6 SDKROOT=/ ARCHFLAGS='-arch x86_64'  python setup.py install

This page gives a good overview of compiling MPI for mac.

` mpi4py <http://mpi4py.scipy.org/docs/usrman/appendix.html>`_

Installing Rapid
----------------

Download and install liferay,
` Liferay <http://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.0.6/liferay-portal-tomcat-6.0.6-20110225.zip/download>`_
Download the Rapid zip file ` Rapid
Zip <https://downloads.sourceforge.net/project/rapidportlet/rapidportlet-1.5.1.tgz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Frapidportlet%2Ffiles%2F&ts=1281627822&mirror=kent>`_

Unzip the Rapid files into a directory, to run rapid just copy the
rapid.xml to the bin directory and run rapid.

copy the war file into the deploy folder in liferay, the new portlet
should be created.

Documentation on creating portlets for rapid are in the ` rapid
manual <http://research.nesc.ac.uk/files/rapid_manual-1.5.0.pdf>`_

The rapid portlet deployed in Edinburgh is here `rapid definition
file </ome/attachment/wiki/FLIM/rapid.xml>`_
`|Download| </ome/raw-attachment/wiki/FLIM/rapid.xml>`_

Installing OMERO
----------------

The OMERO install scripts were used to set up the requisite packages to
connect to OMERO.

Shell script to install basic packages
`basic </ome/attachment/wiki/FLIM/ubuntu-root-install.sh>`_
`|image2| </ome/raw-attachment/wiki/FLIM/ubuntu-root-install.sh>`_ Shell
script to install OMERO packages
`omero </ome/attachment/wiki/FLIM/ubuntu-omero-install.sh>`_
`|image3| </ome/raw-attachment/wiki/FLIM/ubuntu-omero-install.sh>`_

Modifying the FLIM script
-------------------------

To get the FLIM script to run against OMERO there were several changes
to the script, both the `original
script </ome/attachment/wiki/FLIM/flim_mpi4.py>`_
`|image4| </ome/raw-attachment/wiki/FLIM/flim_mpi4.py>`_ and `omero
script </ome/attachment/wiki/FLIM/flim-omero.py>`_
`|image5| </ome/raw-attachment/wiki/FLIM/flim-omero.py>`_ are attached.

Original Script workflow
~~~~~~~~~~~~~~~~~~~~~~~~

The original script takes several parameters from the command line,
these are:

-  Positive directory, the experimental condition.
-  Negative directory, the control.
-  The Instrument response file, this determines the number of
   timepoints in the file.
-  The X,Y-resolution of the file, it is assumed that the image is
   square.

::

    The script starts the MPI world where it receives the number of nodes and the script gets assigned it's rank. 
    The script then gets the list of all files from both control and experimental directories, 

    Rank 0 script
     Open a new tex file and create the appropriate headers.

    loop 
      Rank 0 script 
        Performs segmentation on the current image, and broadcasts the pixels to fit, and average pixels.
        Scatter pixel lists to each Rank N script.
      Rank N scripts
        Fit the pixels they have been assigned
      Rank 0 script 
        Gather all results, including a2, k2 fitted values if in experimental condition.
        Calculate the fit values, etc, write the results to the tex file. 
    end loop
    Rank 0 script
      Write the last outputs to the tex file.

The script then runs latex of the tex file created by the Rank 0 script,
this is the file output of the original script.

The method for reading data in the original script:

::

    def procRead(d_args):
      fd=open(d_args['f']+'.raw','rb')
      shape=(d_args['t'],d_args['s']*d_args['s'])
      rawdata = npy.fromfile(file=fd, dtype=npy.uint16).byteswap().reshape(shape)
      return rawdata

The method for reading the irf file in the original script:

::

    def procTP(s_tpfile):
      # Open and read 
      fd=open(s_tpfile,'r')
      a_tp=npy.loadtxt(fd)
      return a_tp

The OMERO script workflow
~~~~~~~~~~~~~~~~~~~~~~~~~

The OMERO script runs in a very similar workflow to the original script.
The OMERO script passes different parameters to the original script:

-  The address of the OMERO server
-  The username.
-  The password.
-  The dataset id containing the experimental images in the OMERO
   server.
-  The dataset id containing the control images in the OMERO server.
-  The id of the Instrument response file in the server.

::

    The script starts the MPI world where it receives the number of nodes and the script gets assigned it's rank. 
    The script then gets the list of all files from both control and experimental directories, 

    Rank 0 script
     Open a new tex file and create the appropriate headers.

    loop 
      Rank 0 script 
        Performs segmentation on the current image, and broadcasts the pixels to fit, and average pixels.
        Scatter pixel lists to each Rank N script.
      Rank N scripts
        Fit the pixels they have been assigned
      Rank 0 script 
        Gather all results, including a2, k2 fitted values if in experimental condition.
        Calculate the fit values, etc, write the results to the tex file. 
        Upload all results csv files(a1, a2, k1, k2, ...) to the image. 
    end loop
    Rank 0 script
      Write the last outputs to the tex file.
      Upload the latex file to the control dataset.

The method for reading data in the OMERO script:

::

    def procRead(rawPixelsStore, pixels):
      id = pixels.getId().getValue();
      sizeC = pixels.getSizeC().getValue();
      sizeX = pixels.getSizeX().getValue();
      sizeY = pixels.getSizeY().getValue();

      imageCXY = script_utils.readFlimImageFile(rawPixelsStore, pixels);
      imageCD = imageCXY.reshape(sizeC,sizeX*sizeY);
      return imageCD

The method for reading the irf file in the OMERO script:

::

    def procTP(rawFileStore, queryService, instrumentResponseFileId):
      return script_utils.readFileAsArray(rawFileStore, queryService, instrumentResponseFileId, 256, 2, separator = ' ');

The method for uploading and attaching a file to an OMERO project.

::

    def attachFileToProject(containerService, queryService, updateService, rawFileStore, projectId, localName):
      project = getProject(containerService, projectId);
      return script_utils.uploadAndAttachFile(queryService, updateService, rawFileStore, project, localName, 'PDF', description=None, namespace=None, origFilePathName=None);

The method for uploading and attaching a file to an OMERO Image.

::

    def attachFileToImage(gateway, queryService, updateService, rawFileStore, imageID, localName):
      image = getImage(gateway, imageID);
      return script_utils.uploadAndAttachFile(queryService, updateService, rawFileStore, image, localName, 'CSV', description=None, namespace=NAMESPACE, origFilePathName=None);

The method for getting the pixels id's in the different dataset:

::

    def pixelsInDataset(containerService, datasetId):
      Images = containerService.getImages('DatasetI',[datasetId],None,None)
      pixels = [];
      for image in Images:
        pixels.append(image.getPixels(0));
      return pixels;

Attachments
~~~~~~~~~~~

-  `flim\_mpi4.py </ome/attachment/wiki/FLIM/flim_mpi4.py>`_
   `|image6| </ome/raw-attachment/wiki/FLIM/flim_mpi4.py>`_ (23.1 KB) -
   added by *dzmacdonald* `17
   ago. Original FLIM script
-  `flim-omero.py </ome/attachment/wiki/FLIM/flim-omero.py>`_
   `|image7| </ome/raw-attachment/wiki/FLIM/flim-omero.py>`_ (30.7 KB) -
   added by *dzmacdonald* `17
   ago. FLIM Omero script
-  `ubuntu-omero-install.sh </ome/attachment/wiki/FLIM/ubuntu-omero-install.sh>`_
   `|image8| </ome/raw-attachment/wiki/FLIM/ubuntu-omero-install.sh>`_
   (1.8 KB) - added by *dzmacdonald* `17
   ago. ubuntu-omero-install.sh
-  `ubuntu-root-install.sh </ome/attachment/wiki/FLIM/ubuntu-root-install.sh>`_
   `|image9| </ome/raw-attachment/wiki/FLIM/ubuntu-root-install.sh>`_
   (2.2 KB) - added by *dzmacdonald* `17
   ago. ubuntu-root-install.sh
-  `rapid.xml </ome/attachment/wiki/FLIM/rapid.xml>`_
   `|image10| </ome/raw-attachment/wiki/FLIM/rapid.xml>`_ (4.3 KB) -
   added by *dzmacdonald* `17
   ago. rapid.xml

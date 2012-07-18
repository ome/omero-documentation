Title: Virtual Appliance Description:

Virtualisation enables canned, ready to run software environments to be
created and used, in the form of Virtual Machines (VM), or to be
distributed for others to use, in the form of Virtual Appliances. A
Virtual Appliance is essentially a file that describes how to create a
new Virtual Machine on demand. The virtualised software environment can
contain an entire operating system (OS), such as Windows or Linux, and
any other software that runs in that OS, such as, in this case,
OMERO.server and its associated software prerequisites. Once created and
started, you can log into the OS and use it as though it were a real
machine. One way to think of this is as though you had an entire
computer in a window on your desktop.

When using virtualisation software, the OS that is running the
virtualisation software is referred to as the "**host OS**\ ". When you
use virtualisation, the OS running within a virtual machine is referred
to as the "**guest OS**\ ". This allows us to be explicit about which OS
we are working in.

Effectively this means that the OME Project can distribute a canned,
ready-to-run environment containing an OMERO.server, thus freeing you
from having to install OMERO.server yourself, and letting you
concentrate on evaluating the functionality of the OMERO.server and its
clients.

**NOTE:** The virtual hard-drive used by the OMERO virtual appliance is
30GB in size and you should probably keep track of the amount of this
space that you have consumed and, if necessary, delete data that is not
required. If your data is likely to exceed this space whilst you are
evaluating OMERO then it is worthwhile going through the `"Increasing HD
Size procedure" <increasing-hd-size>`_ before you start working with
OMERO in earnest.

Getting Started
===============

To use the virtual appliance you should do the following:

-  Install VirtualBox
-  Download the OMERO.server virtual appliance
-  Import the virtual appliance into Virtual Box to create a virtual
   machine
-  Start the virtual machine

Each of these points is outlined in more detail in the remainder of this
page...

Install VirtualBox
------------------

In order to use the OMERO.server virtual appliance you need to install
VirtualBox. Download VirtualBox from
`here <http://www.virtualbox.org/wiki/Downloads>`_ and follow the
installation process for your platform. If in doubt you should download,
or upgrade to, the latest version of VirtualBox. Once VirtualBox is
installed run the application. Depending upon your platform & version,
the VirtualBox interface should look similar to the following
screenshot:

Download the OMERO.server Virtual Appliance
-------------------------------------------

The virtual appliance can be downloaded from
`here <http://hudson.openmicroscopy.org.uk/job/OMERO-trunk-virtualbox/lastSuccessfulBuild/artifact/src/docs/install/VM/omero-vm.ova>`_
and should have a filename similar to, e.g. omero-vm.ova

Import OMERO Virtual Appliance into VirtualBox
----------------------------------------------

-  Start VirtualBox then select **'File/Import Appliance'**. You will be
   presented with a dialogue box.
-  Select choose then navigate to the location where you downloaded the
   the virtual appliance file.
-  Select your OVA file then click **open**.

This process is indicated in the following screenshot:

-  Click **continue**. You will be presented with a range of options for
   the VM that will be built from the appliance.

-  You can accept the defaults by clicking **Done**.

You should now see a progress bar as your new virtual machine is built
from the appliance. This import process can take a few minutes depending
upon your hardware. Feel free to make a coffee whilst you are waiting ;)

When the import procedure is complete your new VM should appear in the
VirtualBox VM library ready for use.

Networking
----------

Our virtual appliance is distributed with VirtualBox's built in
Host-Only Network Address Translation (NAT) preconfigured. This means
that the IP address for the VM is 10.0.2.15 which is the default
VirtualBox Host-Only NAT address. Using this address is the simplest way
to distribute a virtual appliance when you do not know the setup of a
user's network.

Port-Forwarding Settings
~~~~~~~~~~~~~~~~~~~~~~~~

Your host OS cannot connect directly to 10.0.2.15 but needs to use
port-forwarding. This means that you connect to your localhost on a
specific port and the communications to and from that port are forwarded
to specified ports on the guest VM.

Our virtual appliance should be preconfigured with the correct
port-forwarding setting configured during the import process. However,
it is best to double check that these settings are correctly set up:

-  Select your VM in the VirtualBox VM Library
-  Click on **Settings** then select the **Network** tab
-  Click on **Advanced**
-  Click on **Port Forwarding**

If the table in the window that appears is empty then port forwarding is
not setup. The required port-forwarding settings are as follows:

.. raw:: html

   <table border="1" cellpadding="10" cellspacing="2">
       <tr>
           <th>

Name

.. raw:: html

   </th><th>

Protocol

.. raw:: html

   </th><th>

Host IP

.. raw:: html

   </th><th>

Host Port

.. raw:: html

   </th><th>

Guest IP

.. raw:: html

   </th><th>

Guest Port

.. raw:: html

   </th>
       </tr>
       <tr>
   <td>

omero-ssl

.. raw:: html

   </td><td>

TCP

.. raw:: html

   </td><td>

127.0.0.1

.. raw:: html

   </td><td>

4064

.. raw:: html

   </td><td>

10.0.2.15

.. raw:: html

   </td><td>

4064

.. raw:: html

   </td>
       </tr>
       <tr>  
   <td>

omero-unsec

.. raw:: html

   </td><td>

TCP

.. raw:: html

   </td><td>

127.0.0.1

.. raw:: html

   </td><td>

4063

.. raw:: html

   </td><td>

10.0.2.15

.. raw:: html

   </td><td>

4063

.. raw:: html

   </td>
       </tr>
       <tr>
           <td>

omero-web

.. raw:: html

   </td><td>

TCP

.. raw:: html

   </td><td>

127.0.0.1

.. raw:: html

   </td><td>

8080

.. raw:: html

   </td><td>

10.0.2.15

.. raw:: html

   </td><td>

4080

.. raw:: html

   </td>
       </tr>
       <tr>
           <td>

ssh

.. raw:: html

   </td><td>

TCP

.. raw:: html

   </td><td>

127.0.0.1

.. raw:: html

   </td><td>

2222

.. raw:: html

   </td><td>

10.0.2.15

.. raw:: html

   </td><td>

22

.. raw:: html

   </td>
       </tr>
   </table>

When correctly setup in VirtualBox your port forwarding settings should
look like this:

If you are on Linux or Mac OS X then you can either use our port
forwarding setup script or else you can set up port forwarding settings
manually. NB. On Microsoft Windows systems you will have to set up port
forwarding manually as the script requires a bash shell. The script can
be downloaded from here and is run by opening a shell and executing the
following command:

::

       $ bash setup_port_forwarding.sh $VMNAME

where $VMNAME is the name of your VM. NB. By default the scripts create
a VM named **omerovm** and the pre-built appliance is named **omero-vm**

Adding port forwarding manually is achieved by editing the port
forwarding table that we displayed before. Use the **+** to add a new
row to the table then clicking in each cell and typing in the required
settings.

Now we are ready to start our VM. Select the VM in the VirtualBox VM
library then click **start**.

A window should open containing a console for your VM which should now
be going through it's standard boot process. OMERO.server is
automatically started at boot time which means that you should be able
to interact with OMERO without further setup.

Credentials
-----------

There are a number of accounts that are preconfigured in the OMERO
virtual appliance. Two of these are OS accounts, for logging into the VM
as either the **root** user or the **omero** user. There is also a
single OMERO.server account which is used to access the OMERO.server
software as the OMERO.server **root** user

Virtual Appliance OS Credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. raw:: html

   <table border="1" cellpadding="10" cellspacing="2">
       <tr>
           <th>

username

.. raw:: html

   </th><th>

password

.. raw:: html

   </th>
       </tr>
       <tr>
           <td>

root

.. raw:: html

   </td><td>

swordfish

.. raw:: html

   </td>
       <tr>  
       <tr>
           <td>

omero

.. raw:: html

   </td><td>

omero

.. raw:: html

   </td>
       <tr>  
   </table>

OMERO.server Credentials
~~~~~~~~~~~~~~~~~~~~~~~~

.. raw:: html

   <table border="1" cellpadding="10" cellspacing="2">
       <tr>
           <th>

username

.. raw:: html

   </th><th>

password

.. raw:: html

   </th>
       </tr>
       <tr>
   <td>

root

.. raw:: html

   </td><td>

omero

.. raw:: html

   </td>
       <tr>    
   </table>

You can use this administrative account to create as many user level
accounts as you require in the usual way.

Working with the OMERO.VM
-------------------------

Now that your VM is up and running you have a choice about how to
interact with it.

-  You can connect to OMERO.web from your host browser. Go to
   http://localhost:8080/webclient.
-  You can **use OMERO.clients from within your host OS.** This will
   allow you to import data via a GUI and manage that data once
   imported. To do so, `download the insight client <../../downloads>`_
   and follow the instructions below. More information can be found
   under the `"Getting Started" <../tutorial/getting-started>`_ section
   which details how to use the OMERO.clients.
-  Alternatively, you can interact with the server command line
   interface by SSH'ing into the guest VM or by opening a console within
   the VM itself. Administrators may need to use one of these methods to
   restart the server and/or change configuration parameters. In this
   case you must have an SSH client installed on your host machine that
   you will then use to connect to the OMERO.server.

**NB.** The following example assume that the OMERO VM is up & running
on the same machine that you are working on.

OMERO.web
~~~~~~~~~

Go directly to http://localhost:8080/webclient to log in with user:
"root" / pw: "omero".

OMERO.insight
~~~~~~~~~~~~~

You can run regular OMERO clients on your host machine and connect to
the server in the VM. Our example uses OMERO.insight running on Mac OS X
to connect to the VM.

-  `Download <https://www.openmicroscopy.org/site/support/omero4/downloads>`_
   & `install <../tutorial/getting-started>`_ OMERO.insight
-  Start OMERO.insight
-  Click the spanner icon situated above the password box so that we can
   enter the server settings box which looks like this:

-  Use the *+* icon to add a new server entry with the address
   *localhost* and the port *4064* then click apply
-  You can now use the login credentials given above to log into insight
   using the following window (user: "root" / pw: "omero"):

-  Insight should now load up & look like so:

You can now use insight to import & manage images on a locally running
virtual server just like you could using a remote server.

Secure Shell
~~~~~~~~~~~~

You can log into your VM using Secure Shell (SSH) which will give you a
command line interface to the VM from where you can use the OMERO.server
`command line
interface <http://trac.openmicroscopy.org.uk/ome/wiki/OmeroCli>`_. In
the following example, we assume that you have an SSH client installed
on your host machine and also that your VM is up and running.

You can log into the VM using the above credentials and the following
command typed into a terminal:

::

    $ ssh omero@localhost -p 2222

This invokes the SSH program telling it to login to the localhost on
port 2222 using the username *omero*. Remember that earlier we set up
port forwarding to forward port 2222 on the host machine to port 22 (the
default SSH port) on the guest VM. If all goes well you will be prompted
for a password. Once you have successfully entered your password you
should be greeted by a prompt similar to the following:

::

    omero@omerovm:~$

There are two potential complications to this method, (1) if you have
used a VM before then there could be old SSH fingerprints set up, (2)
the first time that you log into the VM you will be asked to confirm
that wish to continue connecting. If you get the following message after
you invoke ssh:

then you can remove the old fingerprints with the following command
typed into the terminal:

::

    $ ssh-keygen -R [localhost]:2222 -f ~/.ssh/known_hosts

as illustrated in this screenshot:

The first time that you log into the VM you will also be asked to
confirm that you wish to connect to this machine by a message similar to
the following:

You should confirm that you wish to continue connecting, after which you
will be prompted for your password as usual:

After which, if all has gone well, you should have a prompt indicating
that you have a shell open and logged into the VM:

Log into the VM directly
~~~~~~~~~~~~~~~~~~~~~~~~

    **NOTE:** Due to the frequent changes in the VirtualBox Guest
    Additions, key mappings between the host and guest OS do not always
    work. We recommend using SSH as the primary way of interacting with
    the Virtual Appliance CLI.

When you start your VM using the Virtual Box GUI, as outlined above, a
window will be displayed showing the boot process for the machine as it
starts up, just like with a real piece of hardware. Once the boot
process has finished you will see a prompt displayed in this window like
so:

you can log into the console of the VM directly using the user account
credentials above.

There is no GUI on the current OMERO virtual appliance so you will have
to be happy using the Bash shell which looks like this:

From here you can interact with OMERO.server via the `OMERO command line
interface <http://trac.openmicroscopy.org.uk/ome/wiki/OmeroCli>`_. You
will need to login as the 'omero' user to access the OMERO CLI (user:
"omero" / pw: "omero"). Logout using Ctrl-D.

Known Issues
------------

Networking Not Working
~~~~~~~~~~~~~~~~~~~~~~

Occasionally, during the boot process, the VirtualBox DHCP server fails
to allocate an IP address to the OS in the guest VM. This means that
OMERO.clients, such as OMERO.Insight, cannot connect to the OMERO.server
in the VM.

-  \*\* CAUSE: \*\* We believe that this is an intermittent VirtualBox
   bug that resurfaces across many versions `VirtualBox
   #4038 <https://www.virtualbox.org/ticket/4038>`_ & previously
   `VirtualBox #3655 <https://www.virtualbox.org/ticket/3655>`_

-  \*\* DIAGNOSIS: \*\* Check whether the guest VM has been allocated
   the reserved host-only NAT IP address. If 10.0.2.15 does not appear
   in the output from ifconfig then this issue has occurred. The easiest
   way to verify this is to log into the guest VM console and check the
   output from executing the following command:

   ::

       $ ifconfig

-  \*\* SOLUTION: \*\* An easy, but unreliable, fix is to reboot the
   guest VM. The preferred fix is to log into the guest VM console and
   execute the following commands which will cause the guest OS to
   release it's IP lease before requesting a new lease:

   ::

       $ dhclient -r
       $ dhclient -eth0

Port conflict when OMERO.server already running in Host OS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you are already running an instance of the OMERO.server in your host
OS then there will be a conflict due to the ports assigned to VirtualBox
port-forwarding being the same as those already in use by the
OMERO.server in the host OS.

-  \*\* SOLUTION 1: \*\* Turn off the OMERO.server in the host
   environment by issuing the following command:

   ::

       $ omero admin stop

-  \*\* SOLUTION 2: \*\* Alter the port-forwarding settings for your
   OMERO.VM as described in the `port-forwarding
   section </site/support/omero4/getting-started/demo/virtual_appliance#portforwarding>`_
   section. For example, increment the host port settings for omero-ssl,
   omero-unsec, and omero-web. NB. We are assuming that your host OS is
   not already running services on those ports. You can check whether
   something is already listening on any of these ports by running the
   following commands (Mac OS X) which should return the prompt without
   any further output if there is nothing listening:

   ::

       $ lsof -nP | grep -E '(:4063)|(:4064)'

VM won't boot because the HDD is full
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you manage to fill the virtual HDD used by your VM then you will
likely discover that the OS is unable to boot and you cannot therefore
get access to your OMERO.server install. If this occurs you may also get
a "errno 28: no space left on device" message. To log into your VM you
will need to use the recovery mode. Start the VM and at the Grub screen,
use the down arrow followed by return to select the following entry:

::

        Ubuntu, with Linux 3.0.0-12-generic (recovery mode)

as seen in this screenshot:

Don't worry if your VM has a kernel number different to
3.0.0-12-generic, the important thing is that you select the entry
labelled recovery mode. At this point the VM should rapidly boot into
the recovery mode which will enable you to log in using the root
password *swordfish*.

Once you have logged in you have a number of things that you can do but
the recommended courses of action are either:

1. Delete unneeded files using standard Linux command line tools like
   *rm* to make space for the VM to boot normally then use your favoured
   OMERO client to login and delete more files. A useful place to start
   might be by deleting the logs stored in /var/logs.
2. Increase the size of your virtual HDD. If you have filled your
   existing HDD then it is likely that the volume of data that you are
   storing in the OMERO VM is too big for the default HDD. You should
   follow the instructions on the `"Increasing HD Size
   procedure" <increasing-hd-size>`_ page to ensure that the size of
   virtual HDD you have available is commensurate with the volumes of
   data that you are collecting.


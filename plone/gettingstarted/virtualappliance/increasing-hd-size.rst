Title: Increasing HD Size Description: Image data can become very large
and can easily fill available hard-drive space. The OMERO virtual
appliance (VA) is similar to a non-virtualised installation in that the
amount of disk space available is limited. By default, the OMERO virtual
appliance is supplied with a 30GB virtual hard-drive. Before using the
appliance you should consider the volume of data that you will need to
work with whist evaluating OMERO and whether you should increase the
size of the virtual hard-drive to suit your needs. The remainder of this
page is a step-by-step guide that demonstrates how to increase your
virtual hard-drive.

Please bear in mind that this is not a risk-free procedure and that you
should ensure that you have a backup of your Virtual Machine (VM) before
proceeding.

Preliminary Steps
-----------------

Download an Ubuntu Linux ISO
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Download an `Ubuntu Linux
iso <http://www.ubuntu.com/download/ubuntu/download>`_. The default,
currently Ubuntu 11.10 32bit, is fine. We will need this later in the
process. ### Backup your VM ### Before we do anything else we should
create a clone of the omero-vm and subsequently work on the copy. This
way if something gets broken we can always start again. The easiest way
to do this is from the command line. **NB.** If you are on Windows then
you should navigate to C:\\Program Files\\Oracle\\VirtualBox\\ because
the VBoxManage tools are not added to your path by default. So, start a
shell and, assuming that your VM has the default name of omero-vm, use
the following command:

::

      $ VBoxManage clonevm omero-vm --mode machine --options keepallmacs --name omero-vm-2 --register

This will create a copy of our VM called omero-vm-2 which we will make
alterations to. This means that we can always return to the original
omero-vm if we break anything. From now on **ONLY** make changes to
omero-vm-2

Extending the HDD
-----------------

By default our virtual hard drive attached to omero-vm-2 is of a type
which cannot be extended; so we need to change this by cloning our HDD
from the VDMK type to VDI type:

::

      $ VBoxManage clonehd omero-vm-2-disk1.vmdk omero-vm-2-disk1.vdi --format VDI

We now need to increase the size of our virtual HDD. In the following
command I am resizing the HDD to 60GB but you should select a size to
suit the amount of data you plan to store in OMERO:

::

      $ VBoxManage modifyhd omero-vm-2-disk1.vdi --resize 60000

We now need to tell VirtualBox to use omero-vm-2-disk1.vdi instead of
omero-vm-2-disk1.vmdk which is currently attached to the VM. Start
VirtualBox and select omero-vm-2 in the VM library.

Click settings then select the storage tab.

Right-click on omero-vm-2-disk1.vmdk and select remove attachment. Next
to the SATA CONTROLLER entry click the right hand plus icon & in the
pop-up dialog "Choose existing disk". Now navigate to the location where
VirtualBox stores your virtual machines and enter the omero-vm-2
directory. Select the omero-vm-2 disk1.vdi and click open.

Whilst we are on the storage tab we can attach the Ubuntu iso that we
downloaded earlier to our VM. We are going to temporarily use the Ubuntu
iso to boot the VM so that we can use some of the tools in the Ubuntu
iso to make changes to the filesystem within our VM. Add an IDE
Controller using the "Add Controller" icon . Select this new controller
then click 'Add CD/DVD device' then 'Choose Disk'. Navigate to the
location of your Ubuntu iso, select it and click OK.

The storage for your OMERO VM should now look similar to the following:

Click OK to return to the VirtualBox VM library. With omero-vm-2
selected ensure that the storage details match what you expect, e.g.
omero-vm-2-disk1.vdi is connected to youSATA Port 0. The size for this
disk should also more or less match what you specified earlier with the
'VBoxManage modifyhd' command. Don't worry if the numbers do not exactly
matchup, for example, I specified a virtualised HDD of 60GB and the
reported size is 58.59GB.

Start the omero-vm-2 VM. Ubuntu linux should boot and you should
eventually see a Welcome screen giving you the option to try or install
Ubuntu.

Select try Ubuntu and you should be presented with a graphical desktop.

Start the gparted tool using the menu option under System ->
Administration -> GParted Partition Editor

The GParted GUI will display:

Right-click the entry for /dev/sda5 and select Swapoff.

Now right click on /dev/sda5 and click Delete to remove the swap
partition.

Delete /dev/sda2 in the same way. This should leave us with two entries,
one for /dev/sda1 and one for unallocated space.

We now need to resize our /dev/sda1 partition. Right-click /dev/sda1 and
select resize. Now drag the right arrow to the right until the entry for
'Free space following (MiB)' is about 2000 then click 'Resize/Move'.

Right click the entry for unallocated space and select 'New' from the
pop-up menu. Select 'linux-swap' from the 'File system' drop-down menu
then 'Add'.

Up until this point we haven't actually applied any of our changes to
the hdd, we have only specified a list of changes that should be made.
We can now go ahead and apply them by selecting the Edit -> Apply All
Operations menu item then clicking 'Apply' in the confirmation dialog
box.

When the operations have completed dismiss the dialog with the 'Close'
button, close GParted, then shutdown the VM.

We no longer need the Ubuntu ISO so we can detach it from our VM. Ensure
that omero-vm-2 is selected then click 'Settings' and select the
'Storage' tab. Right-click the IDE Controller entry and select 'Remove
Controller' then click 'OK' to return the VirtualBox VM library.

Start the omero-vm-2 VM and allow it to boot. Log in as root then issue
the df -h command. Verify that the size of the /dev/sda1 is
approximately what you expect, e.g. if you allocated a 60GB virtual HDD
then after size conversions and swap allocation we should end up with
/dev/sda1 reported as being around 56GB.

Now, within the VM we need to add the UUID of the new swap partition to
the /etc/fstab file because we deleted the old one & created a new swap
which means that the IDs will no longer match.

::

      $ vim /etc/fstab

Move your cursor to the entry that looks similar to the following:

::

      UUID=SOME-LONG-ALPHA-NUMERIC-STRING none swap sw 0 0

then press i to entry "insert mode". Now delete the alphanumeric string
so that the entry looks similar to the following:

::

      UUID= none swap sw 0 0

and place your cursor after the equals sign. We will now issue a command
from within the VIM editor to insert our new swap UUID into the fstab
file.

::

      [Insert Mode] <CTRL-R> =system('/sbin/blkid -t TYPE=swap | cut -c18-53') <return>

Save your file and quit VIM

::

      [Command Mode] :wq <return>

Now reboot your VM with: $ shutdown -r now

Once your VM has rebooted you should now have a working VM with a larger
virtual HDD.

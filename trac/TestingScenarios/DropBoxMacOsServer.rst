31.1 DropBox Mac OS server
~~~~~~~~~~~~~~~~~~~~~~~~~~

**\* Prerequisites: local server - user creates a folder
DropBox/username in local binary repository.**

**\* Note: For moving the scenario forward a remote server: a
DropBox/username folder exists that the user has write access to will be
implemented.**

**\* Note: images are not imported into a dataset so the images will be
orphaned.**

-  Create a subfolder under DropBox called root.

-  Copy a single image file into DropBox/root

    Wait at least a couple of minutes Check it is imported using a
    client.

-  Create a subfolder under DropBox/root called somename

   -  Copy an image file that has a companion file (e.g. dv and log)
      into somename
   -  Wait 30 seconds
   -  Copy the companion file into somename
   -  Wait at least a couple of minutes
   -  Check it is imported using a client and that companion file is
      there.
   -  (If you initially wait more than 60 seconds the companion file
      should not be attached. Could check?)

-  Create a subfolder DropBox/root/someothername

   -  Copy the companion file into DropBox/root/someothername
   -  Wait 30 seconds
   -  Copy the associated image file into DropBox/root/someothername
   -  Wait at least a couple of minutes
   -  Check it is imported using a client and that companion file is
      there.
   -  (If you initially wait more than 60 seconds the companion file
      should not be attached. Could check?)

-  Copy a folder containing several images/companion files into
   DropBox/root

   -  Wait at least a couple of minutes
   -  Check they are all imported using a client.

-  Copy a nested folder containing a SPW files into DropBox/root

   -  Wait at least a couple of minutes.
   -  Check they it is imported using a client.

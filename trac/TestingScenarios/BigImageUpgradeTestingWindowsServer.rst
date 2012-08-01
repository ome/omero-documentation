25.2 Big Image Upgrade Testing Windows Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[**UPDATED for 4.3.2**\ ]

**Prerequisites: Images to use for the test from squig in the folder
test images good :**

Images to use for the test: .BMP

-  /bmp/6kx6k-grey.bmp
-  /bmp/6kx6k.bmp
-  /bmp/8kx8k-grey.bmp
-  /bmp/8kx8k.bmp

.PNG

-  /png/4kx4k.png
-  /png/8kx8k.png

TIF

-  /tif/4kx4k.tif
-  /tif/8kx8k.tif

-  Install 4.2.2 server and increase Java memory to 4096M in
   template.xml.
-  Using a 4.2.2 client of OMERO upload big images listed in the
   prerequisite images (e.g. /bmp/8kx8k.bmp ).
-  Upgrade to the newest 4.3.x server. (See
   ` http://openmicroscopy.org/site/support/omero4/server/upgrade <http://openmicroscopy.org/site/support/omero4/server/upgrade>`_,
   remember about config files).
-  Now again try to view the same big image.
-  An exception (which should be hidden from the user) is thrown which
   implies, "this image needs a pyramid created. please try again").
   Server log should show "Missing
   pyramid:/OMERO/Pixels/PIXEL\_ID\_pyramid"
-  In the background, the server generates the pyramid.
-  On clicking on the same big Image for a second time, the image will
   be viewable.

22.2 Delete Image and binary data Mac OS server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **Scenario Updated for 4.3.1**

All these should behave the same in both clients.

-  Delete Image and binary data

   -  first note the Image ID and get the pixels ID, the Thumbnail ID
      and OriginalFile ID(s)
   -  E.g. psql: select \* from pixels where pixels.image=<imageId>
   -  check that these files exist under omero.data.dir (Pixels,
      Thumbnails, Files)
   -  delete the Image
   -  check that the files noted above have been deleted.

-  Delete Image and binary data

   -  first note the Image ID and get the pixels ID, the Thumbnail ID
      and OriginalFile ID(s)
   -  E.g. psql: select \* from pixels where pixels.image=<imageId>
   -  Check that these files exist under omero.data.dir (Pixels,
      Thumbnails, Files)
   -  Delete the Image.
   -  Check that the files noted above have been deleted.

-  Try to delete any remaining files using cleanse.

   -  bin/omero admin cleanse --dry-run
   -  note whether undeleted files are marked for deletion.
   -  bin/omero admin cleanse (NOTE These last two points are optional
      under Mac)
   -  note whether undeleted files have now been deleted.

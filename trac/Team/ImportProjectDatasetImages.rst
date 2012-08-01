1. Import Project/Dataset Images
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

` OMEROimporter.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-3-0/mov/OMEROimporter.mov>`_

-  Already installed importer
-  Add server using + button
-  Log in to server
-  Browse file formats in drop-down list (leave as 'All supported file
   types')
-  Browse "test\_images\_good/" & select a few non-screen files in a
   folder.
-  Hit + button.
-  Create new Project
-  Create new Dataset, with description
-  Choose 'full path' for image name
-  Click "Add to queue". Files should be added to queue
-  Remove the image from the queue (to make sure this feature works)
-  Re-add the image, selecting the same Project/Dataset and other
   options (to make sure this feature works)
-  Click "Import" to start the import.
-  Click "Output Text" tab. See various info - with no errors.
-  View "Debug Text" for more info.
-  If the "Import History tab is grey, skip to the final step.
-  Otherwise Click on "Import History" tab & select import from 'Today'
   on left
-  Files should be shown in the list with a green checkmark
-  Click 'Re-Import' to add files to import queue
-  Check that files have been added to import queue [and import OK]
-  Check for password change issues:

   -  Login with both importer + insight
   -  Change user password in insight
   -  Try to import something with importer.

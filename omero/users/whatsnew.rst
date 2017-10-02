What's new for OMERO 5.4 for users
==================================

Updates and new features for OMERO 5.4 include:

- Your system administrator can now create
  :doc:`/sysadmins/restricted-admins` to allow facility
  managers, image analysts etc. to organize users and data in OMERO
  without having to be granted full administrator privileges. This is a way to
  cater for the needs for some trusted users to act on behalf of all the OMERO
  users in a facility, with access to all the groups and data in OMERO. Full administrators and administrators with restricted privileges can now create Project/Dataset/Screen on behalf of other users in OMERO.web or transfer all the data of a given user using the :program:`chown` command.

- Improvements to OMERO.web including the display of fields within Wells, handling of float
  images with small dynamic range and the ability to export images in plate as OME-TIFF as well as a number of minor bug fixes.

- The 'Reverse Intensity' command in the image viewers has been renamed to
  'Invert'.

- The display of Tables data removed in 5.3 has been added back to the Image Viewer.

- Updated Bio-Formats bringing improved file format support.

See the :help:`User help website <>` for information on how to incorporate
these new features into your current workflows.

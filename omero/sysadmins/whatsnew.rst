What's new for OMERO 5.4 for sysadmins
======================================

- :doc:`version-requirements` has been updated to reflect other changes in
  version support for 5.4.0 and tentative plans for 5.5.0.

- Walkthroughs have been added for :doc:`installing OMERO.web <unix/install-web/web-deployment>` either separately from
  or with OMERO.server on a variety of platforms.

- A walkthrough has been added for :doc:`unix/server-debian9-ice36`.

- :doc:`admins-with-restricted-privileges` can now be created to allow
  facility managers, image analysts etc. to organize users and data in OMERO
  without having to be granted full administrator privileges. Full administrators and administrators with restricted privileges can now create Project/Dataset/Screen on behalf of other users in OMERO.web.

- The Public user is restricted to GET requests by default. This can be
  changed by setting the new configuration property
  :property:`omero.web.public.get_only`.

For a full list of bug fixes and other improvements, see the
:doc:`/users/history`.

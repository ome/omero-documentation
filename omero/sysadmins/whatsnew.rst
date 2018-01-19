What's new for OMERO 5.4 for sysadmins
======================================

- :doc:`version-requirements` has been updated to reflect other changes in
  version support for 5.4.0 and tentative plans for 5.5.0.

- Walkthroughs have been added for 
  :doc:`installing OMERO.web <unix/install-web/web-deployment>` either
  separately from or with OMERO.server on a variety of platforms.

- A walkthrough has been added for :doc:`unix/server-debian9-ice36`.

- A walkthrough has been added to :doc:`public`, based on a concrete
  use-case in Dundee.

- :doc:`restricted-admins` can now be created to allow
  facility managers, image analysts etc. to organize users and data in OMERO
  without having to be granted full administrator privileges. Full
  administrators and administrators with restricted privileges can now create
  Project/Dataset/Screen on behalf of other users in OMERO.web or transfer all
  the data of a given user using the :program:`chown` command.

- The Public user is restricted to GET requests by default. This can be
  changed by setting the new configuration property
  :property:`omero.web.public.get_only`.

- It is now possible to include an html template in the base `core_html` 
  template so it can be used for all webclient pages.

- The OMERO.web part of the :program:`omero admin diagnostics` command has
  been moved to :program:`omero web diagnostics` as OMERO.web can be installed
  separately from the OMERO.server.

For a full list of bug fixes and other improvements, see the
:doc:`/users/history`.

What's new for OMERO 5.4 for sysadmins
======================================

- :doc:`version-requirements` has been updated to reflect other changes in
  version support for 5.4.0 and tentative plans for 5.5.0.
  
- All official OMERO.web apps can now be installed from PyPI_. You should
  reinstall your plugins when you upgrade.

- Windows support has been discontinued, see
  :doc:`/sysadmins/windows-migration`.

- OMERO.web has been decoupled from the server and can now be deployed
  separately. It now requires Python 2.7 meaning systems still running on
  CentOS 6 may require upgrading.
  
- Support for deploying OMERO.web using Apache has been dropped; if your
  organization’s policies only allow Apache to be used as the external-facing
  web-server you should configure Apache to proxy connections to an NGINX
  instance running on your OMERO server i.e. use Apache as a reverse proxy.

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

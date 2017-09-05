What's new for OMERO 5.3 for sysadmins
======================================

- Ice 3.6 is now the default supported version. With Ice 3.6, the Python
  bindings are provided separately, allowing you to install the RPM
  packages provided by ZeroC. Then run ``pip install zeroc-ice`` to install
  the Ice Python bindings if your package manager does not provide the Ice
  Python packages.

- :doc:`version-requirements` has been updated to reflect other changes in
  version support for 5.3.0 and tentative plans for 5.4.0.
  
- All official OMERO.web apps can now be installed from PyPI. You should
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

- jQuery cache is now disabled by default.

- A new script is available to allow users to migrate annotations from Images
  to Wells which you may wish to run server-side when upgrading. These
  annotations will be reindexed automatically so your users can search Wells
  by annotations in the new GUI for Screen Plate Well data.

- New options have been added for customizing the tree in the clients, see
  :ref:`client configuration properties <client_configuration>`.

- The default output when importing data via the |CLI| has been updated to
  give an Image or Plate ID list in the form of ``Image:1,2,3,4`` or
  ``Plate:101`` to be more usable by scripts etc. The previous behavior can
  be restored by using ``--output legacy``.

- The Public user is restricted to GET requests by default. This can be changed
  by setting the new configuration property :property:`omero.web.public.get_only`.

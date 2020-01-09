What's new for OMERO 5.6 for developers
=======================================

This release focuses on migrating all Python components to Python 3,
and decoupling them into separate repositories with the benefit of
permitting each to be released to PyPI independently:

- https://github.com/ome/omero-py
- https://github.com/ome/omero-web
- https://github.com/ome/omero-dropbox
- https://github.com/ome/omero-marshal

For details on migrating your own code to Python 3, see
:doc:`python3-migration`.

You may also find the Sysadmins :doc:`/sysadmins/python3-migration` page useful.

Other changes which you need to be aware of:

- The `path` module is now named `omero_ext.path`.

For a full list of api changes, bug fixes and other improvements,
see the :doc:`/users/history`.

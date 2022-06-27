What's new for OMERO 5.6 for developers
=======================================

This release focuses on migrating all Python components to Python 3,
and decoupling them into separate repositories with the benefit of
permitting each to be released to PyPI independently:

- :omero_subs_github_repo_root:`omero-py <omero-py>`
- :omero_subs_github_repo_root:`omero-web <omero-web>`
- :omero_subs_github_repo_root:`omero-dropbox <omero-dropbox>`
- :omero_subs_github_repo_root:`omero-marshal <omero-marshal>`

For details on migrating your own code to Python 3, see
:doc:`python3-migration`.

You may also find the Sysadmins :doc:`/sysadmins/python3-migration` page useful.

Other changes which you need to be aware of:

- The `path` module is now named `omero_ext.path`.

For a full list of api changes, bug fixes and other improvements,
see the :doc:`/users/history`.

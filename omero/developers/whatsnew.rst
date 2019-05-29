What's new for OMERO 5.4 for developers
=======================================

Python BlitzGateway
^^^^^^^^^^^^^^^^^^^

- New in 5.4.0 are Restricted Administrators. These are Admins that have a subset of Full Admin privileges.
- Previously if ``conn.isAdmin()`` is true for the current user, they could perform all actions allowed for Full Admins.
- Now, this will return True for Full Admins and Restricted Admins, but the user may not be allowed to perform some actions.
- Use ``conn.isFullAdmin()`` to check if user is a Full Administrator.
- To get the current user's privileges, use ``conn.getCurrentAdminPrivileges()``
- This will return list e.g. ``["Chgrp", "Chown", "ModifyGroup", "ModifyGroupMembership", Sudo", "DeleteFile"]``
- Can also check this for another user with ``conn.getAdminPrivileges(user_id)``
- For a full list of available privileges, use::

    for p in conn.getEnumerationEntries('AdminPrivilege'):
        print p.getValue()

- See :doc:`/sysadmins/restricted-admins` to know which privileges are required for which actions.


Java Gateway
^^^^^^^^^^^^
- Added various methods for dealing with :doc:`/sysadmins/restricted-admins`
  to the :javadoc_gateway_java:`AdminFacility <omero/gateway/facility/AdminFacility.html>`.

Integration tests
^^^^^^^^^^^^^^^^^

- Provide a way for applications and plugins in separate repositories to more
  simply run integration tests. See
  `omero-test-infra <https://github.com/openmicroscopy/omero-test-infra>`_
  for more information.

Deprecations
^^^^^^^^^^^^

OMERO Model
-----------

- :ref:`ome.model.jobs.ImportJob <OMERO model class ImportJob>`
  to be removed in OMERO 6.0.
- :ref:`ome.model.roi.Path <OMERO model class Path>`
  to be removed in OMERO 6.0.


Python BlitzGateway
-------------------

- ``channel.isReverseIntensity()``. Renamed to ``channel.isInverted()``.
- ``image.setReverseIntensity()``. Renamed to ``image.setChannelInverted()``.
- ``image.setActiveChannels(reverseMaps)`` parameter renamed to ``invertMaps``.
- In ``conn.createOriginalFileFromFileObj()`` and ``conn.createOriginalFileFromLocalFile()`` the ``ns`` parameter is deprecated.

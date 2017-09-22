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

- See :doc:`/sysadmins/admins-with-restricted-privileges` to know which privileges are required for which actions.


Graphs
^^^^^^


Java Gateway
^^^^^^^^^^^^
- Added various methods for dealing with :doc:`/sysadmins/admins-with-restricted-privileges` to the :javadoc:`AdminFacility <omero/gateway/facility/AdminFacility.html>`
 

OMERO Model
^^^^^^^^^^^


Deprecations
^^^^^^^^^^^^

Python BlitzGateway
-------------------

- ``channel.isReverseIntensity()``. Renamed to ``channel.isInverted()``.
- ``image.setReverseIntensity()``. Renamed to ``image.setChannelInverted()``.
- ``image.setActiveChannels(reverseMaps)`` parameter renamed to ``invertMaps``.
- In ``conn.createOriginalFileFromFileObj()`` and ``conn.createOriginalFileFromLocalFile()`` the ``ns`` parameter is deprecated.

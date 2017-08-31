Adjusting administrator restrictions
====================================

OMERO 5.4 introduced the concept of a :doc:`restricted administrator
<../admins-with-restricted-privileges>`. The meaning and representation
of the server's underlying permissions restrictions is described in
:doc:`developer documentation</developers/Server/LightAdmins>`.
OMERO.web offers easy management of restrictions and is recommended for
setting up restricted administrators via its :help:`Admin tab
<facility-manager#lightadmin>`.

OMERO.cli does not offer easy management of restrictions because support
is yet to be added. In the meantime it can already manipulate
administrator restrictions in the awkward manner described hereunder.

.. warning::

  OMERO.web provides a simplified view of the available restrictions:
  the :doc:`permissions mapping <../mapping-restricted-admins>` is such that checking *one* box in the web interface may lift *multiple* underlying
  restrictions from an administrator. The recommended OMERO.web
  management interface may thus prove confusing if OMERO.cli has been
  used to set a combination of restrictions that does not correspond to
  those bundles of related restrictions available in OMERO.web.


View an administrator's restrictions
------------------------------------

For an administrator with user ID 123,

.. code-block:: shell

  $ bin/omero hql "SELECT ap.name FROM Experimenter user JOIN user.config AS ap WHERE user.id = 123 AND ap.name LIKE 'AdminPrivilege:%' AND LOWER(ap.value) <> 'true' ORDER BY ap.name"

lists their applicable restrictions such that the administrator may
*not* exercise privileges for that operation.


Set a restriction on an administrator
-------------------------------------

For an administrator with user ID 123,

.. code-block:: shell

  $ bin/omero obj map-set Experimenter:123 config AdminPrivilege:SomePrivilege false

restricts them so that they may no longer exercise `SomePrivilege`.

Clear a restriction from an administrator
-----------------------------------------

For an administrator with user ID 123,

.. code-block:: shell

  $ bin/omero obj map-set Experimenter:123 config AdminPrivilege:SomePrivilege true

removes a restriction so that they may exercise `SomePrivilege`.

.. note::

  You may not clear a restriction from an administrator if you have that
  same restriction applying to yourself.

.. warning::

  Never clear `AdminPrivilege:ReadSession` from a restricted
  administrator unless clearing *all* their restrictions to make them
  into a full administrator. No restricted administrator should be able
  to read all OMERO sessions.

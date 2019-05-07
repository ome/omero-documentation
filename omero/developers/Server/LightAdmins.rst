The server's view of administrator restrictions
===============================================

OMERO 5.4 introduced the concept of a restricted administrator. These
are generally more powerful than normal OMERO users and group owners but
they do not have all the powers of full administrators such as ``root``.
A restricted administrator is the same as a full administrator except
that *in specific ways* it is as if they are not an administrator at
all. Those specific ways are exactly the restrictions listed in their
user's ``Experimenter.config`` property. For that property, a name of
``AdminPrivilege:Dance`` (just an example!) with a value of ``false``
indicates that the restricted administrator's ability to dance is not
that of a full administrator. Their ability to dance is instead that of
a normal user who is not a member of the ``system`` group. A member of
the ``system`` group with an empty ``config`` property is a full
administrator without restrictions.


Restrictions
------------

The :model_source:`meta.ome.xml mapping
<src/main/resources/mappings/meta.ome.xml>` lists all the values
of the :javadoc:`AdminPrivilege
<slice2html/omero/model/AdminPrivilege.html>` enumeration. Each of those
values corresponds to a kind of operation for which full administrators
have greater privilege. If an administrator has any of the below
restrictions then they do *not* have greater privilege for the
corresponding operation. It instead becomes as if they were but a normal
user in that respect.

``Chgrp``
    move data to other groups

``Chown``
    give data to other users

``WriteOwned``
    create or edit OMERO model objects that have an owner and are not
    ``OriginalFile`` instances

``WriteFile``
    create or edit ``OriginalFile`` objects that are in neither the
    managed repository nor the script repository

``WriteManagedRepo``
    create or edit ``OriginalFile`` objects that are in the managed
    repository, which is to where imported image files are uploaded

``WriteScriptRepo``
    create or edit ``OriginalFile`` objects that are in the script
    repository, which is where official scripts reside

``DeleteOwned``
    delete OMERO model objects that have an owner and are not
    ``OriginalFile`` instances

``DeleteFile``
    delete ``OriginalFile`` objects that are in neither the managed
    repository nor the script repository

``DeleteManagedRepo``
    delete ``OriginalFile`` objects that are in the managed repository,
    which is to where imported image files are uploaded

``DeleteScriptRepo``
    delete ``OriginalFile`` objects that are in the script repository,
    which is where official scripts reside

``ModifyGroup``
    make changes to groups, such as their name or permissions level

``ModifyGroupMembership``
    make changes to who is a member or owner of which group

``ModifyUser``
    make changes to users, such as their name or institution

``Sudo``
    become another user

``ReadSession``
    read other users' session UUIDs


Bundling restrictions
---------------------

It often makes sense to apply all but a certain bundle of restrictions
to a user. For example, users working with other users' data may benefit
from being able to go beyond their normal group restrictions only for
the operations of ``WriteOwned``, ``WriteManagedRepo``,
``WriteScriptRepo``, ``Chgrp``. A facility manager importing on behalf
of other users may appropriately be given all but the ``Sudo``
restriction. A human resources representative may be given all but the
``ModifyGroup``, ``ModifyGroupMembership``, ``ModifyUser`` restrictions.
Much depends on how personnel roles are handled in each specific
institution.

.. warning::

    The ``ReadSession`` restriction should be applied to *all*
    restricted administrators. Without that restriction members of the
    ``system`` group can read other users' session UUIDs and join those
    sessions as the user. In contrast, while an administrator without
    the ``Sudo`` restriction can become other users, the security system
    prevents their using sudo to elevate their own administrative
    powers. An administrator cannot sudo to become ``root`` to escape
    their restrictions. :javadoc_server:`A security filter
    <ome/security/basic/LightAdminPrivilegesSecurityFilter.html>`
    assists in enforcing ``ReadSession``.


Working with restrictions
-------------------------

Restricted administrators
"""""""""""""""""""""""""

Since OMERO 5.4 the :javadoc:`admin service
<slice2html/omero/api/IAdmin.html>` offers operations for managing
restrictions on administrators. ``createLightSystemUser`` creates a new
restricted administrator. ``getAdminPrivileges`` and
``setAdminPrivileges`` manage the restrictions on an existing
administrator.

Using ``setAdminPrivileges`` to set an empty list of privileges fills
that user's ``Experimenter.config`` property with a ``false`` value for
every ``AdminPrivilege`` name. That user does not thus become like a
normal user: they retain all administrative powers not explicitly
restricted, such as being able to read all users' images.

Even for a normal user who is not a member of the ``system`` group and
has no administrative powers, restrictions can still be set in their
``Experimenter.config`` property. Such restrictions have no effect while
that user is not an administrator as they have no administrative powers
to restrict.

``getCurrentAdminPrivileges`` is useful for OMERO clients to find how
the currently logged-in administrator is restricted.
``getAdminsWithPrivileges`` identifies the administrators who are
sufficiently unrestricted in a given way.


Permissions on model objects
""""""""""""""""""""""""""""

OMERO model objects have a :ref:`details property <model details
property>` that bears information on :ref:`object permissions
<permissions object>`. In addition to the existing methods like
``canEdit`` and ``canDelete``, the ``canChgrp`` and ``canChown`` methods
were introduced in OMERO 5.4. Client software may find these permissions
methods a useful guide as to what the current administrator may do to
which objects.


Event context
"""""""""""""

Since OMERO 5.4 the :javadoc:`event context
<slice2html/omero/sys/EventContext.html>` for the current session,
available from the admin service, has additional data members:

* ``adminPrivileges`` that lists the restrictions *not* applying to the
  current session. For non-administrators this list is empty as if they
  are wholly restricted. For restricted administrators it lists only the
  privileges that they enjoy. For full administrators all privileges are
  listed.

* ``sudoerId``, ``sudoerName`` that for sudo sessions notes which
  administrator it was who became the current user.


Integration tests in Java
-------------------------

* :source:`AdminServiceTest
  <components/tools/OmeroJava/test/integration/AdminServiceTest.java>`
  tests the admin service operations for working with restrictions.

* :source:`LightAdminPrivilegesTest
  <components/tools/OmeroJava/test/integration/LightAdminPrivilegesTest.java>`
  tests the restrictions from a security point of view: checking that
  applying even just one restriction to a user prevents all means of
  performing the corresponding operation.

* :source:`LightAdminRolesTest
  <components/tools/OmeroJava/test/integration/LightAdminRolesTest.java>`
  tests various user workflows: checking that with all but a given set
  of restrictions an administrator may perform useful sequences of
  operations.


Mapping of OriginalFile.repo
----------------------------

Since OMERO 5.4 the ``repo`` property of :ref:`OriginalFile <OMERO model
class OriginalFile>` is mapped into the OMERO object model. Because the
interpretation of an ``OriginalFile`` instance depends upon with which
repository the file is associated, for security reasons the server
greatly restricts the mutation of this property: users cannot simply
switch a file from one repository to another.

The server must allow some setting of ``repo``. It currently uses an
indirect means of authenticating legitimately set values. Each running
server has a secret key recorded in the `uuid` property of :ref:`Node
<OMERO model class Node>`. This key is not available to OMERO clients,
it is internal to the server. To set a new file's ``repo`` the
:javadoc_server:`repository DAO
<ome/services/blitz/repo/RepositoryDaoImpl.html>` prefixes the file's
``name`` with the server's secret key. A database trigger recognizes
this key from the ``node`` table, removes the prefix from the ``name``,
then allows the value of ``repo`` to be set.


Database triggers
-----------------

While :javadoc_server:`BasicACLVoter <ome/security/basic/BasicACLVoter.html>`
and :javadoc_server:`OmeroInterceptor
<ome/security/basic/OmeroInterceptor.html>` carry the bulk of the burden
of enforcing restrictions on administrators, together with
:javadoc_server:`AdminImpl <ome/logic/AdminImpl.html>` for the user and group
management restrictions, the database system itself is also a key
enforcement mechanism.

The :javadoc:`update service <slice2html/omero/api/IUpdate.html>` is one
means by which administrators may attempt to perform restricted
operations. Hibernate's interceptors are not wholly suited to blocking
exactly the prohibited actions so further barriers are built into the
database that trigger upon specific data changes. The database must
therefore have enough information to judge if an operation is permitted.
OMERO 5.4 introduced two tables:

``_roles``
    notes the server's configured IDs for special users and groups, such
    as ``root`` and ``system`` which are both usually ``0``; set by
    :javadoc_server:`DBUserCheck <ome/services/util/DBUserCheck.html>` on
    server startup

``_current_admin_privileges``
   notes the restrictions *not* applying to the current user on a
   per-transaction basis; maintained by :javadoc_server:`OmeroInterceptor
   <ome/security/basic/OmeroInterceptor.html>` and frequently cleared by
   :javadoc_server:`LightAdminPrivilegesCleanup
   <ome/security/basic/LightAdminPrivilegesCleanup.html>`

An example database trigger would be ``user_config_delete_trigger`` on
the ``experimenter_config`` table. This trigger raises an exception if,
for example, an ``AdminPrivilege:Dance`` name with a ``false`` value is
to be removed from the ``config`` of a member of the ``system`` group by
a user who themself is restricted from dancing. This prevents the
administrator whose dancing is restricted from lifting that restriction
from another administrator so that they may be the one to newly dance.

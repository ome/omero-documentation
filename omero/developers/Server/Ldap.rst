LDAP plugin design
==================

Once configured, :doc:`/sysadmins/server-ldap` allows sysadmins to control
OMERO's user and group creation via an external, locally-maintained LDAP
server. Due to the flexibility of LDAP, each instance may have a number of
requirements that cannot be supported out of the box. Below, we discuss the
design of the LDAP plugin as well as how it can be extended for local use.

Simple walkthrough
------------------

The LDAP plugin follows these steps:

#. Sysadmin configures properties mapping users and groups from LDAP to
   OMERO.
#. Once LDAP is enabled, any OMERO user who has a value of ``true`` in the
   ``ldap`` column of the ``experimenter`` table will have their password
   checked against LDAP and **not** against OMERO (changing the password via
   OMERO is *not* supported). This functionality is provided by the
   :doc:`/developers/Server/PasswordProvider`. The :abbr:`DN (Distinguished
   Name)` is not stored in the OMERO DB and is retrieved from the LDAP server
   on each user login.
#. If there is no OMERO user for a given name, the LDAP plugin will use
   :property:`omero.ldap.user_filter` and
   :property:`omero.ldap.user_mapping` to look for a valid user:

   #. The ``user_mapping`` property is of the form:
      ``omeName=<ldap attribute>;firstName=<ldapAttribute>;…``
   #. For looking up new users, the plugin will only use the ``omeName``
      attribute. For example, if a user tries to login with "emma" and the
      ``user_mapping`` starts with ``omeName=cn;`` then the LDAP search
      will be for ``(cn=emma)``.
   #. The ``(cn=emma)`` LDAP filter is then added to the value of
      :property:`omero.ldap.user_filter`. For example, if the user filter is
      ``(objectClass=inetOrgPerson)``, the full query for the new user will
      be: ``(&(objectClass=inetOrgPerson)(cn=emma))``

#. **If** the search returns a **single** LDAP user, then an OMERO user will
   be created with all properties mapped according to
   :property:`omero.ldap.user_mapping` and the ``ldap`` property set to
   ``true``.
#. Then the user will be placed in groups according to the value of
   :property:`omero.ldap.new_user_group`, which are created if necessary.
   Details of the various options can be found under
   :doc:`/sysadmins/server-ldap`. Each option is handled by a different
   ``NewUserGroupBean`` implementation.

NewUserGroupBean.java
---------------------

The interface described for the ":bean:" ``new_user_group`` prefix, is
:server_source:`ome.security.auth.NewUserGroupBean <src/main/java/ome/security/auth/NewUserGroupBean.java>`. It defines a
single method: ``groups(…, AttributeSet set)`` which returns a list of
``ExperimenterGroup`` ids (``List<Long>``) which the user should be added to.

Other prefix handlers also implement the interface as examples. In the same
package are:

- ``:attribute:`` -
   :server_source:`AttributeNewUserGroupBean.java <src/main/java/ome/security/auth/AttributeNewUserGroupBean.java>`
- ``:ou:`` -
   :server_source:`OrgUnitNewUserGroupBean <src/main/java/ome/security/auth/OrgUnitNewUserGroupBean.java>`
- ``:query:`` -
   :server_source:`QueryNewUserGroupBean <src/main/java/ome/security/auth/QueryNewUserGroupBean.java>`

.. seealso::

    :doc:`/sysadmins/unix/server-installation`
        Instructions for installing OMERO.server on UNIX and UNIX-like
        platforms

    :doc:`/sysadmins/server-security`
        General instructions on server security

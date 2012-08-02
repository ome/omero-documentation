OMERO LDAP Authentication
=========================

**The official user documentation for the OMERO LDAP plugin has moved to
`http://www.openmicroscopy.org/site/support/omero4/server/install-ldap <http://www.openmicroscopy.org/site/support/omero4/server/install-ldap>`_.**
What remains here is the developer documentation on the design of the
LDAP plugin as well as how to write your own LDAP extension for OMERO.

LDAP Design
-----------

Standard LDAP plugin functioning works so:

#. Sysadmin configures properties mapping users and groups from LDAP to
   OMERO.
#. Once LDAP is enabled, any OMERO user who has a non-null **dn** in the
   **password** table while have their password checked against LDAP.
   (Changing the password via OMERO is *not* supported)
#. If there is no OMERO user for a given name, the LDAP plugin will use
   ``omero.ldap.user_filter`` and ``omero.ldap.user_mapping`` to look
   for a valid user.

   #. The "user\_mapping" property is of the form:
      ``omeName=<ldap attribute>;firstName=<ldapAttribute>;...``
   #. For looking up new user, the plugin will only use the ``omeName``
      attribute. For example, if a user tries to login with "emma" and
      the user\_mapping starts with ``omeName=cn;`` then the LDAP search
      will be for ``(cn=emma)``.
   #. The ``(cn=emma)`` LDAP filter is then added to the value of
      **omero.ldap.user\_filter**. For example, if the user filter is
      ``(objectClass=inetOrgPerson)``, the full query for the new user
      will be: ``(&(objectClass=inetOrgPerson)(cn=emma))``

#. **If** the search returns a **single** LDAP result, then an OMERO
   user will be created with all properties mapped according to
   ``omero.ldap.user_mapping``.
#. Then the user will be placed in groups according to the value of
   ``omero.ldap.new_user_group``, which are created if necessary.

   #. If the value is not prefixed with ":<some value>:", then it is
      taken as the name of the group and all new LDAP users are placed
      in that group.
   #. If it starts with ":ou:", then the first organization unit which a
      user is in will be taken as the group. For example, if a user's dn
      is "``cn=emma,ou=Lab1,ou=People,o=TheUniversity``\ ", the OMERO
      user "emma" will be placed in the group "Lab1".
   #. If **new\_user\_group** starts with ":attribute:", then all the
      values of the given attribute will be taken as group names. For
      example, if the value is ":attribute:memberOf" and "emma" has two
      "memberOf" properties: "memberOf: Lab1" and "memberOf: Lab2", then
      she will be placed in both groups.
   #. If **new\_user\_group** starts with "``:query:``\ ", then a query
      is performed using the value of **omero.ldap.group\_filter**. For
      example, given "new\_user\_group=:query:(member=${dn})" and
      "group\_filter=(objectClass=groupOfNames)", then the query
      "``(&(objectClass=groupOfNames)(member=cn=emma,ou=Lab1,ou=People,o=TheUniversity))``\ "
      will be performed. "emma" will be added to all returned groups.
   #. Finally, if **new\_user\_group** starts with ":bean:" then the
      named bean from the Spring context will be given a chance to
      create any groups it likes.

``NewUserGroupBean.java``
-------------------------

The interface described for the ":bean:" "new\_user\_group\_ prefix, is
:source:`ome.security.auth.NewUserGroupBean <components/server/src/ome/security/auth/NewUserGroupBean.java>`.
It defines a single method: ``groups(..., AttributeSet set)`` which
returns a list of ``ExperimenterGroup`` ids (``List<Long>``) which the
user should be added to.

Other prefix handlers also implement the interface as examples. In the
same package are:

-  ":attribute:" -
   :source:` AttributeNewUserGroupBean.java <components/server/src/ome/security/auth/AttributeNewUserGroupBean.java>`
-  ":query:" -
   :source:` QueryNewUserGroupBean <components/server/src/ome/security/auth/QueryNewUserGroupBean.java>`

--------------

See also: `OmeroInstall </ome/wiki/OmeroInstall>`_,
`OmeroSecurity </ome/wiki/OmeroSecurity>`_

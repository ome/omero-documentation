.. _server/ldap:

OMERO.server LDAP Authentication
================================

`LDAP <http://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol>`_
is an open standard for querying and modifying directory services that
is commonly used for authentication, authorization and accounting (AAA).
OMERO.server supports the use of an LDAP server to query (but not
modify) AAA information for the purposes of automatic user creation.

This allows OMERO users, ''Experimenters'' or ''Scientists'' in OMERO
parlance, to be automatically created and placed in groups according to
your existing institution policies. This can significantly simplify your
user administration burden.

The OMERO.server LDAP implementation can handle a number of use cases.
For example,

-  Allow every ''inetOrgPerson'' under **omero.ldap.base** to login
-  but restrict access based upon an arbitrary LDAP filter, e.g.
   "omero.ldap.user\_filter=(memberOf=dn=someGroup,ou=Lab,o=College)"
-  and add that user to some number of groups, e.g.
   "omero.ldap.new\_user\_group=:query:(member=@{dn})"

How it works
------------

On login, the username provided is searched for in OMERO. If the name
does not exist, then the LDAP plugin is queried for a username matching
the system-wide user filter. If such an LDAP entry exists and the
password matches, a new user with the given username is created, and the
user is added to any groups which match the new\_user\_group setting.

On subsequent logins, the user filter and the password are again checked
the LDAP server, and if there is no longer a match, login is refused. If
you would prefer to only have the user\_filter applied during user
creation and not on every login, see “Legacy Password Providers” below.

LDAP Properties
---------------

The LDAP plugin is configured via several configuration properties, all
starting with "omero.ldap.". The default values for these properties is
set in the file **etc/omero.properties**.

--------------

::

        omero.ldap.config=false
        omero.ldap.urls=ldap://localhost:389
        omero.ldap.username=
        omero.ldap.password=
        omero.ldap.base=ou=example,o=com

These properties are the base requirements for logging in to LDAP. After
having configured your connection, you can turn the LDAP on and off
between restarts by setting "omero.ldap.config" to false.

--------------

::

        omero.ldap.user_filter=(objectClass=person)
        omero.ldap.user_mapping=omeName=cn,firstName=givenName,lastName=sn,email=mail

These two user properties are used to look up users by login name and,
if necessary, create new users based on the information in LDAP.
"omero.ldap.user\_filter" will be AND'ed to the username query, and can
contain any valid LDAP filter string. The username query is taken from
the LDAP attribute which gets mapped to "omeName" by
"omero.ldap.user\_mapping". Here, the "cn" is mapped to omeName, so the
username query is ``(cn=[login name])``. The final query is
``(&(objectClass=person)(cn=[login name]))``, which must return a single
result to be considered valid.

--------------

::

        omero.ldap.group_filter=(objectClass=groupOfNames)
        omero.ldap.group_mapping=name=cn
        omero.ldap.new_user_group=default

The final set of properties are all concerned with what groups a user
will be placed in on creation. The group filter and group mapping work
just as the user filter and mapping do, but may not be used depending on
the value of "new\_user\_group", which can have five separate meanings:

-  If equal to "**:ou:**\ ", then a user's last organizational unit will
   be used as his or her group. For example, the user with the dn
   "cn=frank,ou=TheLab,ou=LifeSciences,o=TheCollege" will be placed in
   the group "TheLab".
-  If prefixed with "**:attribute:**\ ", then the rest of the string is
   taken to be an attribute all of whose values will be taken as group
   names. For example, "omero.ldap.new\_user\_group=:attribute:memberOf"
   would add a user to all the groups named by memberOf.
-  If prefixed with "**:query:**\ ", then the rest of the value is taken
   as a query to be AND'ed to the group filter. In the query, values
   from the user such as "@{cn}", "@{email}", or "@{dn}" can be used as
   place holders.
-  If prefixed with "**:bean:**\ ", then the rest of the string is the
   name of a Spring bean which implements the NewUserGroupBean
   interface. See the developer documentation :ref:`developers/Omero/Server/Ldap` for more info.
-  If not prefixed at all, then the value is simply the name of a group
   which all users from LDAP should be added to.

--------------

LDAP Configuration
------------------

Like many pieces of OMERO.server configuration, LDAP-specific
configuration is done by specifying extra properties during
installation. The default values for the LDAP properties are listed in
the **etc/omero.properties** file inside your OMERO installation
directory.
 
.. note::
    Please remember that once a change has been made, a
    server restart will be needed.

Change any settings that are necessary via bin/omero config.

-  Enable or disable LDAP (true/false)

   ::

       bin/omero config set omero.ldap.config true

-  LDAP server URL string

   ::

       bin/omero config set omero.ldap.urls ldap://ldap.example.com:389

       .. note::
          A SSL URL above should look like this:
          ldaps://ldap.example.com:636

-  LDAP server bind DN (if required; can be empty)

   ::

       bin/omero config set omero.ldap.username cn=Manager,dc=example,dc=com

-  LDAP server bind password (if required; can be empty)

   ::

       bin/omero config set omero.ldap.password secret

-  LDAP server base search DN

   ::

       bin/omero config set omero.ldap.base dc=example,dc=com

-  The filter applied to all users; can be empty in which case any LDAP
   user is valid

   ::

       bin/omero config set omero.ldap.user_filter '(objectClass=inetOrgPerson)'

-  LDAP referral options (defaults to "ignore"; available options are
   "ignore, "follow" or "throw" as per the `JNDI referrals
   documentation <http://docs.oracle.com/javase/jndi/tutorial/ldap/referral/jndi.html>`_)

   ::

       bin/omero config set omero.ldap.referral follow

LDAP over SSL
-------------

If you are connecting to your server over **SSL**, that is, if your URL
is of the form "ldaps://ldap.example.com:636" you will need to configure
a key and trust store for Java. See the :ref:`server/security` page
for more information.

Synchronising LDAP on user login
--------------------------------

This feature allows for LDAP to be considered the authority on
user/group membership. With the following settings enabled each time a
user logs in to OMERO their LDAP groups will be read from the LDAP
server and reflected in OMERO. Enabling this will result in any bespoke
OMERO groups that have been created being removed from the user's
profile. The groups will still exist on the server but the association
between user and group will not be reflected unless such a link is made
in LDAP.

::

    <property name="omero.ldap.sync_on_login" value="true"/>

    bin/omero config set omero.ldap.sync_on_login true

.. _legacy_password_providers:

Legacy Password Providers
-------------------------

The primary component of the LDAP plugin is the LdapPasswordProvider,
which is responsible for creating users, checking their passwords, and
adding them to or removing them from groups. The default password
provider is the “chainedPasswordProvider” which first checks LDAP if
LDAP is enabled, and then checks JDBC. This can explicitly be enabled by
executing the system admin command

::

        bin/omero config set omero.security.password_provider chainedPasswordProvider

When the LDAP password provider implementation changes, previous
versions can be configured as necessary.

chainedPasswordProvider431
~~~~~~~~~~~~~~~~~~~~~~~~~~

With the 431 password provider, the user filter is only checked on first
login and not kept on subsequent logins. This allows for an OMERO admin
to change the username of a user in omero to be different than the one
kept in LDAP. To enable it, use:

::

        bin/omero config set omero.security.password_provider chainedPasswordProvider431

.. seealso::

	:ref:`server/installation`
		Installation guide for OMERO.server under UNIX-based platforms
	
	:ref:`server/security`
		Security pages for OMERO.server
	
	:ref:`developers/Omero/Server/Ldap`
		Developer documentation on extending the LDAP plugin yourself.

	If you have LDAP requirements that are not covered by the above
	configuration, please see the forum discussion `What are your LDAP
	requirements? <http://www.openmicroscopy.org/community/viewtopic.php?f=5&t=14>`_

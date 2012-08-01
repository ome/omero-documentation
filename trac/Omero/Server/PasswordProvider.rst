A `PasswordProvider </ome/wiki/PasswordProvider>`_ is an implementation
of the Java interface
`ome.security.auth.PasswordProvider </ome/browser/ome.git/components/server/src/ome/security/auth/PasswordProvider.java>`_.
Several implementations exist currently:

-  `ome.security.auth.JdbcPasswordProvider </ome/browser/ome.git/components/server/src/ome/security/auth/JdbcPasswordProvider.java>`_
   is the most common provider, and uses the "password" table for
   storing MD5 encrypted passwords per user.
-  `ome.security.auth.FilePasswordProvider </ome/browser/ome.git/components/server/src/ome/security/auth/FilePasswordProvider.java>`_
   is rarely used, but in some scenarios may be useful since it permits
   setting usernames and passwords in a plain text file.
-  `ome.security.auth.LdapPasswordProvider </ome/browser/ome.git/components/server/src/ome/security/auth/LdapPasswordProvider.java>`_
   is a highly configurable provider which provides READ-ONLY access to
   an LDAP server and can create users and groups on the fly. See
   `OmeroLdap </ome/wiki/OmeroLdap>`_ for more information.

The "chainedPasswordProvider"
(`ome.security.auth.PasswordProviders </ome/browser/ome.git/components/server/src/ome/security/auth/PasswordProviders.java>`_)
is configured for use by default in
`ome.git/etc/omero.properties </ome/browser/ome.git/etc/omero.properties>`_
under ``omero.security.password_provider``. It first checks with the
``LdapPasswordProvider`` and then falls back to the
``JdbcPasswordProvider``.

To write your own provider, you can either subclass from
`ome.security.auth.ConfigurablePasswordProvider </ome/browser/ome.git/components/server/src/ome/security/auth/ConfigurablePasswordProvider.java>`_
as the providers above do, or write your own implementation from
scratch. You will need to define your object in a Spring XML file
matching the pattern ``ome/services/db-*.xml``. See
`ExtendingOmero </ome/wiki/ExtendingOmero>`_ more for information.

Things to keep in mind
----------------------

-  All the existing implementations take care to publish a
   `LoginAttemptMessage </ome/browser/ome.git/components/server/src/ome/services/messages/LoginAttemptMessage.java>`_
   so that any `LoginAttemptListener </ome/wiki/LoginAttemptListener>`_
   implementation can properly react to failed logins. Your
   implementation should probably do the same

-  When dealing with chains of password providers, an implementation can
   safely return null from ``checkPassword`` to say "I don't know
   anything about this". This is only important if you configure your
   own chained password provider with your new implementation as one of
   the elements..

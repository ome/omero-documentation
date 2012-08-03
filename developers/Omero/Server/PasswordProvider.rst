.. _developers/Omero/Server/PasswordProvider:

Password Provider
=================

A :ref:`developers/Omero/Server/PasswordProvider` is an implementation
of the Java interface
:source:`ome.security.auth.PasswordProvider <components/server/src/ome/security/auth/PasswordProvider.java>`.
Several implementations exist currently:

-  :source:`ome.security.auth.JdbcPasswordProvider <components/server/src/ome/security/auth/JdbcPasswordProvider.java>`
   is the most common provider, and uses the "password" table for
   storing MD5 encrypted passwords per user.
-  :source:`ome.security.auth.FilePasswordProvider <components/server/src/ome/security/auth/FilePasswordProvider.java>`
   is rarely used, but in some scenarios may be useful since it permits
   setting usernames and passwords in a plain text file.
-  :source:`ome.security.auth.LdapPasswordProvider <components/server/src/ome/security/auth/LdapPasswordProvider.java>`
   is a highly configurable provider which provides READ-ONLY access to
   an LDAP server and can create users and groups on the fly. See
   :ref:`developers/Omero/Server/Ldap` for more information.

The "chainedPasswordProvider"
(:source:`ome.security.auth.PasswordProviders <components/server/src/ome/security/auth/PasswordProviders.java>`)
is configured for use by default in :source:`etc/omero.properties`
under ``omero.security.password_provider``. It first checks with the
``LdapPasswordProvider`` and then falls back to the
``JdbcPasswordProvider``.

To write your own provider, you can either subclass from
:source:`ome.security.auth.ConfigurablePasswordProvider <components/server/src/ome/security/auth/ConfigurablePasswordProvider.java>`
as the providers above do, or write your own implementation from
scratch. You will need to define your object in a Spring XML file
matching the pattern ``ome/services/db-*.xml``. See
|ExtendingOmero| more for information.

Things to keep in mind
----------------------

-  All the existing implementations take care to publish a
   :source: `LoginAttemptMessage <components/server/src/ome/services/messages/LoginAttemptMessage.java>`
   so that any `LoginAttemptListener </ome/wiki/LoginAttemptListener>`_
   implementation can properly react to failed logins. Your
   implementation should probably do the same

-  When dealing with chains of password providers, an implementation can
   safely return null from ``checkPassword`` to say "I don't know
   anything about this". This is only important if you configure your
   own chained password provider with your new implementation as one of
   the elements..

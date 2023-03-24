Password Provider
=================

A :doc:`/developers/Server/PasswordProvider` is an implementation
of the Java interface
:server_source:`ome.security.auth.PasswordProvider <src/main/java/ome/security/auth/PasswordProvider.java>`.
Several implementations exist currently:

-  :server_source:`ome.security.auth.JdbcPasswordProvider <src/main/java/ome/security/auth/JdbcPasswordProvider.java>`
   is the most common provider, and uses the "password" table for
   storing passwords hashed using MD5 and salt per user.
-  :server_source:`ome.security.auth.FilePasswordProvider <src/main/java/ome/security/auth/FilePasswordProvider.java>`
   is rarely used, but in some scenarios may be useful since it permits
   setting usernames and passwords in a plain text file.
-  :server_source:`ome.security.auth.LdapPasswordProvider <src/main/java/ome/security/auth/LdapPasswordProvider.java>`
   is a highly configurable provider which provides READ-ONLY access to
   an LDAP server and can create users and groups on the fly. See
   :doc:`/developers/Server/Ldap` for more information.

The :property:`omero.security.password_provider` property (see
:ref:`security_configuration`) defines the implementation of `PasswordProvider`
that will be used to authenticate users. Chains of password providers can be
created using
:server_source:`ome.security.auth.PasswordProviders <src/main/java/ome/security/auth/PasswordProviders.java>`.
For instance, the default server authentication uses `chainedPasswordProvider`
which first checks the ``LdapPasswordProvider`` and then falls back to the
``JdbcPasswordProvider``.

To write your own provider, you can either subclass from
:server_source:`ome.security.auth.ConfigurablePasswordProvider <src/main/java/ome/security/auth/ConfigurablePasswordProvider.java>`
as the providers above do, or write your own implementation from
scratch. You will need to define your object and optionally your
new chained password providers in a Spring XML file matching the pattern
:file:`ome/services/db-*.xml`. See |ExtendingOmero| more for information.


Things to keep in mind
----------------------

-  All the existing implementations take care to publish a
   :server_source:`LoginAttemptMessage <src/main/java/ome/services/messages/LoginAttemptMessage.java>`
   so that any :doc:`/developers/Server/LoginAttemptListener`
   implementation can properly react to failed logins. Your
   implementation should probably do the same.

-  When dealing with chains of password providers, an implementation can
   safely return null from ``checkPassword`` to say "I don't know
   anything about this". This is only important if you configure your
   own chained password provider with your new implementation as one of
   the elements.

-  Due to the service dependency order, new password providers defined in the
   Spring XML file should be configured with lazy initialization
   (`lazy-init="true"`) so that the beans are only created when needed.

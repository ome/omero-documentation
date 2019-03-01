LoginAttemptListener
====================

All the :doc:`/developers/Server/PasswordProvider` implementations
provided by default publish a
":server_source:`LoginAttemptMessage <src/main/java/ome/services/messages/LoginAttemptMessage.java>`\ "
every time they check a password value. This permits any
``org.springframework.context.ApplicationListener<LoginAttemptMessage>``
to react to the login. Only one implementation is active by default (as
of 4.2.1):
:server_source:`ome.security.auth.LoginAttemptListener <src/main/java/ome/security/auth/LoginAttemptListener.java>`
which throttles logins after a given number of failed attempts.
Configuration for this listener is available in :ref:`security_configuration`:

::

    omero.security.login_failure_throttle_count=1 # Number of failed attempts before throttling begins
    omero.security.login_failure_throttle_time=3000 # Time in milliseconds

A more sophisticated listener would lock the user's account until an
administrator intervenes. This is the goal of :ticket:`3139`.

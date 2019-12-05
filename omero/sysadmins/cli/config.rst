Server configuration
--------------------

The :program:`omero config` command is responsible for reading/writing
user-specific profiles stored under :file:`$OMERODIR/etc/grid/config.xml`. To get
the current profile, use the :program:`omero config def` command::

    $ omero config def
    default

You can then examine the current profile keys using :program:`omero config get`
and set key-value pairs using :program:`omero config set`::

    $ omero config get

    $ omero config set example "my first value"

    $ omero config get
    example=my first value

You can use the :envvar:`OMERO_CONFIG` environment variable to point at a
different profile, e.g.::

    $ OMERO_CONFIG=another omero config def
    another

    $ OMERO_CONFIG=another omero config get

    $ OMERO_CONFIG=another omero config set example "my second value"

    $ OMERO_CONFIG=another omero config get
    example=my second value

The values set via :program:`omero config set` override those compiled into the
server jars. The default values which are set can be seen in
:doc:`/sysadmins/config`. To add several values to a configuration, you can
pipe them via standard in using :program:`omero config load`. To grep for the example
LDAP configuration from
:server_source:`omero-server.properties <src/main/resources/omero-server.properties>` ::

    $ grep omero.ldap src/main/resources/omero-server.properties | OMERO_CONFIG=ldap omero config load

    $ OMERO_CONFIG=ldap omero config get
    omero.ldap.attributes=objectClass
    omero.ldap.base=ou=example,o=com
    omero.ldap.config=false
    omero.ldap.groups=
    omero.ldap.keyStore=
    omero.ldap.keyStorePassword=
    omero.ldap.new_user_group=default
    omero.ldap.password=
    omero.ldap.protocol=
    omero.ldap.trustStore=
    omero.ldap.trustStorePassword=
    omero.ldap.urls=ldap://localhost:389
    omero.ldap.username=
    omero.ldap.values=person

Each of these values can then be modified to suit your local setup. To
remove one of the key-value pairs, pass no second argument::

    $ OMERO_CONFIG=ldap omero config set omero.ldap.trustStore

    $ OMERO_CONFIG=ldap omero config set omero.ldap.trustStorePassword

    $ OMERO_CONFIG=ldap omero config set omero.ldap.keyStore

    $ OMERO_CONFIG=ldap omero config set omero.ldap.keyStorePassword

    $ OMERO_CONFIG=ldap omero config get
    omero.ldap.attributes=objectClass
    omero.ldap.base=ou=example,o=com
    omero.ldap.config=false
    omero.ldap.groups=
    omero.ldap.new_user_group=default
    omero.ldap.password=
    omero.ldap.protocol=
    omero.ldap.urls=ldap://localhost:389
    omero.ldap.username=
    omero.ldap.values=person

If you will be using a particular profile more frequently you can set it
as your default using the :program:`omero config def` command::

    $ omero config def ldap

And finally, if you would like to remove a profile, for example to wipe a
given password off of a system, use :program:`omero config drop`::

    $ omero config drop

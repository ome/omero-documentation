OMERO.server and PostgreSQL
===========================

In order to be installed, OMERO.server requires a running PostgreSQL
instance that is configured to accept connections over TCP. This
section explains how to ensure that you have the correct PostgreSQL
version and that it is installed and configured correctly.

Ensuring you have a valid PostgreSQL version
--------------------------------------------

For OMERO |current_version|, PostgreSQL version |postgresversion| or later is
recommended. Make sure you are using a
`supported version <https://www.postgresql.org/support/versioning/>`_.

You can check which version of PostgreSQL you have installed with any of
the following commands:

::

       $ createuser -V
       createuser (PostgreSQL) 9.4.1
       $ psql -V
       psql (PostgreSQL) 9.4.1
       $ createdb -V
       createdb (PostgreSQL) 9.4.1

If your existing PostgreSQL installation is an earlier version, it
is recommended that you upgrade to a more up-to-date version.  Before
upgrading, stop the OMERO server and then perform a full dump of the
database using :program:`pg_dump`. See the :ref:`server_backup`
section for further details.

If using a Linux distribution-provided PostgreSQL server, upgrading to
a newer version of the distribution will usually make a newer
version of PostgreSQL available. If the database was not migrated to
the new version automatically, restore your backup after installing,
configuring and starting the new version of the database server.
If a PostgreSQL server was not provided by your system, `EnterpriseDB
<https://www.enterprisedb.com/>`_ provide an installer.


Checking PostgreSQL port listening status
-----------------------------------------

You can check if PostgreSQL is listening on the default port
(``TCP/5432``) by running the following command:

::

    $ netstat -an | egrep '5432.*LISTEN'
    tcp        0      0 0.0.0.0:5432            0.0.0.0:*               LISTEN
    tcp        0      0 :::5432                 :::*                    LISTEN


.. note::  
    The exact output of this command will vary. The important
    thing to recognize is whether or not a process is listening on
    ``TCP/5432``.

If you cannot find a process listening on ``TCP/5432`` you will need to
find your ``postgresql.conf`` file and enable PostgreSQL's TCP listening
mode. The exact location of the ``postgresql.conf`` file varies between
installations.

It may be helpful to locate it using the package manager (``rpm``
or ``dpkg``) or by utilizing the ``find`` command. Usually, the
PostgreSQL data directory (which houses the ``postgresql.conf``
file, is located under ``/var`` or ``/usr``:

::

    $ sudo find /etc -name 'postgresql.conf'
    $ sudo find /usr -name 'postgresql.conf'
    $ sudo find /var -name 'postgresql.conf'
    /var/lib/postgresql/data/postgresql.conf

.. note:: 
    The PostgreSQL data directory is usually only readable by the
    user ``postgres`` so you will likely have to be ``root`` in order to
    find it.

Once you have found the location of the ``postgresql.conf`` file on
your particular installation, you will need to enable TCP listening.
The area of the configuration file you are concerned about should look similar
to this:

::

    #listen_addresses = 'localhost'         # what IP address(es) to listen on;
                                        # comma-separated list of addresses;
                                        # defaults to 'localhost', '*' = all
    #port = 5432
    max_connections = 100
    # note: increasing max_connections costs ~400 bytes of shared memory per
    # connection slot, plus lock space (see max_locks_per_transaction).  You
    # might also need to raise shared_buffers to support more connections.
    #superuser_reserved_connections = 2
    #unix_socket_directory = *
    #unix_socket_group = *
    #unix_socket_permissions = 0777         # octal
    #bonjour_name = *                      # defaults to the computer name


PostgreSQL HBA (host based authentication)
------------------------------------------

OMERO.server must have permission to connect to the database that has
been created in your PostgreSQL instance.  This is configured in the
*host based authentication* file, ``pg_hba.conf``.  Check the
configuration by examining the contents of ``pg_hba.conf``. It's
important that at least one line allows connections from the loopback
address (``127.0.0.1``) as follows:

::

    # TYPE  DATABASE    USER        CIDR-ADDRESS          METHOD
    # IPv4 local connections:
    host    all         all         127.0.0.1/32          md5
    # IPv6 local connections:
    host    all         all         ::1/128               md5

.. note:: 
    The other lines that are in your ``pg_hba.conf`` are important
    either for PostgreSQL internal commands to work or for existing
    applications you may have. **Do not delete them**.


Completing configuration
------------------------

After making any configuration changes to :file:`postgresql.conf` or
:file:`pg_hba.conf`, reload the server for the changes to take effect.

    $ sudo service postgresql reload

.. seealso::

    `PostgreSQL <https://www.postgresql.org/docs/current/interactive/index.html>`_ 
        Interactive documentation for the current release of PostgreSQL.

    `Connections and Authentication <https://www.postgresql.org/docs/current/interactive/runtime-config-connection.html>`_
        Section of the PostgreSQL documentation about configuring the server using `postgresql.conf`.

    `Client Authentication <https://www.postgresql.org/docs/current/interactive/client-authentication.html>`_
        Chapter of the PostgreSQL documentation about configuring client authentication with `pg_hba.conf`.

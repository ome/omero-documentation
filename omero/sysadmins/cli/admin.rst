Server administration
---------------------

Server start
^^^^^^^^^^^^

Once your database has been properly configured and your config profile
is set to use that database, you are ready to start your server using the
:program:`omero admin start` command::

    $ bin/omero admin start

This command performs the following operations in order:

#. rewrites the configuration files if :option:`omero admin start --force-rewrite` is passed or
   the server has never been started
#. checks the server status, i.e. pings the ``master`` node using the IceGrid
   administration tool
#. aborts the command if a server is running
#. rewrites the configuration files if it has not been done at step 1
#. starts the server
#. waits until the server is up

Most configuration files under :file:`etc/grid` are generated using the
templates under :file:`etc/grid/templates` and the server configuration stored
in :file:`etc/grid/config.xml`. The rewriting step updates the JVM memory
settings (see :ref:`jvm_memory_settings`) and the server ports (see
:ref:`ports_configuration`) based on the server configuration.

.. program:: omero admin start

.. option:: -h, --help

    Display the help for this subcommand.

.. option:: --foreground

    This option is particularly useful for debugging and maintenance and
    allows for starting the server up in the foreground, that is without
    creating a daemon on UNIX-like systems or service on Windows.
    During the lifetime of the server, the prompt from which it was launched
    will be blocked.

.. option:: --force-rewrite

    This option forces the server configuration files under :file:`etc/grid`
    to be rewritten before the status of the server is checked.

Server stop
^^^^^^^^^^^^

To stop a running server, you can invoke the :program:`omero admin stop`
subcommand::

    $ bin/omero admin stop

This command does the following operations in order:

#. rewrites the server configuration files if :option:`omero admin stop --force-rewrite` is
   passed
#. checks the server status, i.e. pings the ``master`` node using the IceGrid
   administration tool
#. aborts the command if no server is running
#. stops the server
#. waits until the server is down

.. program:: omero admin stop

.. option:: -h, --help

    Display the help for this subcommand.

.. option:: --force-rewrite

    This option forces the configuration files to be rewritten before the
    server status is checked. 

Server restart
^^^^^^^^^^^^^^

To stop and start the server in a single command, you can use the
:program:`omero admin restart` command::

    $ bin/omero admin restart

The ``restart`` subcommand supports the same options as :program:`omero admin start`.

Server diagnostics
^^^^^^^^^^^^^^^^^^

To debug a server or inspect the configuration, you can use the :program:`omero admin diagnostics` command::

    $ bin/omero admin diagnostics

The output of this command will report information about:

* the server prerequisites (:program:`psql`, :program:`java`)
* the server environment variables
* the server memory settings and ports
* the status of the binary repository

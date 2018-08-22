Manage sessions
---------------

The :program:`omero sessions` plugin manage user sessions stored locally on
disk.
Several sessions can be active simultaneously, but only one will be used for a
single invocation of `bin/omero`::

    $ bin/omero sessions -h

Login
^^^^^

The :program:`omero login` command is a shortcut for the
:program:`omero sessions login` subcommand which creates a connection to the
server. If no argument is specified, the interface will ask for the
connection credentials::

    $ bin/omero login
    Previously logged in to localhost:4064 as root
    Server: [localhost:4064]
    Username: [root]
    Password:

Some of the options available to the :program:`omero login` command are:

.. program:: omero login

.. option:: connection

    Pass a connection string under the form ``[USER@]SERVER[:PORT]`` to
    instantiate a connection::

        $ bin/omero login username@servername
        Password:
        $ bin/omero login username@servername:14064
        Password:

.. option:: -s SERVER, --server SERVER

    Set the name of the server to connect to::

        $ bin/omero login -s servername
        Username: [username]

.. option:: -u USER, --user USER

    Set the name of the user to connect as::

        $ bin/omero login -u username -s servername
        Password:

.. option:: -p PORT, --port PORT

    Set the port to use for connection. Default: 4064::

        $ bin/omero login -u username -s servername -p 14064
        Password:

.. option:: -g GROUP, --group GROUP

    Set the group to use for initalizing a connection::

        $ bin/omero login -u username -s servername -g my_group
        Password:

.. option:: -k KEY, --key KEY

    Use a valid session key to join an existing connection.

    This option only requires a server argument::

        $ bin/omero login servername -k 22fccb8b-d04c-49ec-9d52-116a163728ca

.. option:: -w PASSWORD, --password PASSWORD

    Set the password to use for the connection. Since 5.4.1, the password can
    be set using the :envvar:`OMERO_PASSWORD` environment variable. The variable
    will be ignored if ``-w`` or ``--password`` is used.

.. option:: --sudo ADMINUSER|GROUPOWNER

    Create a connection as another user.

    The sudo functionality is available to administrators as well as group
    owners

    ::

        $ bin/omero login --sudo root -s servername -u username -g groupname
        Password for root:
        $ bin/omero login --sudo owner -s servername -u username -g groupname
        Password for owner:

Multiple sessions
^^^^^^^^^^^^^^^^^

Stored sessions can be listed using the :program:`omero sessions list`
command::

    $ bin/omero sessions list
     Server    | User | Group           | Session                              | Active    | Started
    -----------+------+-----------------+--------------------------------------+-----------+--------------------------
     localhost | test | read-annotate-2 | 22fccb8b-d04c-49ec-9d52-116a163728ca | Logged in | Fri Nov 23 14:55:25 2012
     localhost | root | system          | 1f800a16-1dc2-407a-8a85-fb44005306be | True      | Fri Nov 23 14:55:18 2012
    (2 rows)

Session keys can then be reused to switch between stored sessions using the
:option:`omero login -k` option::

    $ bin/omero sessions login -k 22fccb8b-d04c-49ec-9d52-116a163728ca
    Server: [localhost]
    Joined session 1f800a16-1dc2-407a-8a85-fb44005306be (root@localhost:4064).
    $ bin/omero sessions list
     Server    | User | Group           | Session                              | Active    | Started
    -----------+------+-----------------+--------------------------------------+-----------+--------------------------
     localhost | test | read-annotate-2 | 22fccb8b-d04c-49ec-9d52-116a163728ca | True      | Fri Nov 23 14:55:25 2012
     localhost | root | system          | 1f800a16-1dc2-407a-8a85-fb44005306be | Logged in | Fri Nov 23 14:55:18 2012
    (2 rows)

Sessions directory
^^^^^^^^^^^^^^^^^^

By default sessions are saved locally on disk under the OMERO user directory
located at :file:`~/omero/sessions`.
The location of the current session file can be retrieved using the
:program:`omero sessions file` command::

    $ bin/omero sessions file
    /Users/ome/omero/sessions/localhost/root/aec828e1-79bf-41f3-91e6-a4ac76ff1cd5

To customize the OMERO user directory, use the :envvar:`OMERO_USERDIR`
environment variable::

    $ export OMERO_USERDIR=/tmp/omero_dir
    $ bin/omero login root@localhost:4064 -w omero
    Created session bf7b9fee-5e3f-40fa-94a6-1e23ceb43dbd (root@localhost:4064). Idle timeout: 10.0 min. Current group: system
    $ bin/omero sessions file
 /tmp/omero_dir/omero/sessions/localhost/root/bf7b9fee-5e3f-40fa-94a6-1e23ceb43dbd
    $ bin/omero logout

If you want to use a custom directory for sessions exclusively, use the
:envvar:`OMERO_SESSIONDIR` environment variable::

    $ export OMERO_SESSIONDIR=/tmp/my_sessions
    $ bin/omero login root@localhost:4064 -w omero
    Created session bf7b9fee-5e3f-40fa-94a6-1e23ceb43dbd (root@localhost:4064). Idle timeout: 10.0 min. Current group: system
    $ bin/omero sessions file
    /tmp/my_sessions/localhost/root/bf7b9fee-5e3f-40fa-94a6-1e23ceb43dbd
    $ bin/omero logout

.. note::
    The :envvar:`OMERO_SESSION_DIR` environment variable introduced in 5.1.0
    to specify a custom sessions directory is deprecated in 5.1.1 and above in
    favor of :envvar:`OMERO_SESSIONDIR`.

    If you have been using :envvar:`OMERO_SESSION_DIR` and want to upgrade
    your custom sessions directory without losing locally stored sessions:

    - either set :envvar:`OMERO_SESSIONDIR` to point at the same location as
      :file:`OMERO_SESSION_DIR/omero/sessions`
    - or move all local sessions stored under the
      :file:`OMERO_SESSION_DIR/omero/sessions` directory
      under the :file:`OMERO_SESSION_DIR` directory and
      replace :envvar:`OMERO_SESSION_DIR` by :envvar:`OMERO_SESSIONDIR`.

Switching current group
^^^^^^^^^^^^^^^^^^^^^^^

The :program:`sessions group` command can be used to switch the group of your
current session::

    $ bin/omero group list          # list your groups
    $ bin/omero sessions group 2    # switch to group by ID or Name

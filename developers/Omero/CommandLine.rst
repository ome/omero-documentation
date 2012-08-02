OMERO Command Line Interface
============================

.. contents::

Overview
--------

The ` python <http://python.org>`_-based commandline interface provides
system-adminstration and deployment tools. (User-level functionality is
planned for future releases.)

You can investigate the various commands available using the -h or
--help option:

::

    cd omero
    bin/omero -h
    usage: bin/omero [-h] [-v] [-d DEBUG] [--path PATH] [-s SERVER] [-p PORT]
                     [-g GROUP] [-u USER] [-w PASSWORD] [-k KEY]
                     <subcommand> ...

    Command-line tool for local and remote interactions with OMERO.

    Optional Arguments:
      In addition to any higher level options

      -h, --help                    show this help message and exit
      -v, --version
      -d DEBUG, --debug DEBUG       Use 'help debug' for more information
      --path PATH                   Add file or directory to plugin list. Supports globs.
      -s SERVER, --server SERVER
      -p PORT, --port PORT
      -g GROUP, --group GROUP
      -u USER, --user USER
      -w PASSWORD, --password PASSWORD
      -k KEY, --key KEY             UUID of an active session

    Subcommands:
      Use bin/omero <subcommand> -h for more information.

      <subcommand>
        admin                       Administrative tools including starting/stopping OMERO.
        config                      Commands for server configuration.
        db                          Database tools for creating scripts, setting passwords, etc.
        delete                      Delete OMERO data.
        download                    Download the given file id to the given filename
        export                      Support for exporting data in XML and TIFF formats
        group                       Group administration methods
        help                        Syntax help for all commands
        hql                         Executes an HQL statement with the given parameters.
        import                      Run the Java-based command-line importer
        load                        Load file as if it were sent on standard in.
        node                        Control icegridnode.
        perf                        Run perf_test files
        quit                        Quit application
        script                      Support for launching, uploading and otherwise managing OMERO.scripts
        server                      Start commands for server components
        sessions                    Control and create user sessions
        shell                       Starts an IPython interpreter session
        testengine                  Run the Importer TestEngine suite (devs-only)
        upload                      Upload local files to the OMERO server
        user                        Support for adding and managing users
        version                     Version number
        web                         omero web settings
        login                       Shortcut for 'sessions login'
        logout                      Shortcut for 'sessions logout'

Again, we can use -h repeatedly to get more details on each of these
sub-commands:

::

    bin/omero admin -h
    bin/omero admin start -h 

NB: The 'help' command can be used to get info on other commands or
options.

::

    bin/omero help
    bin/omero help debug       # debug is an option
    bin/omero help admin       # same as bin/omero admin -h

System Administration Commands
------------------------------

When first beginning to work with the OMERO server, the ``db``,
``config``, and ``admin`` commands will be the first you will need.

db
~~

Rather than try to provide the functionality of a RDBM tool like
``psql``, the ``db`` command helps to generate SQL scripts for building
your database. You can then use those scripts from whatever tool is most
comfortable for you.

::

    $ bin/omero db script OMERO4 0 secretpassword
    Using OMERO4 for version
    Using 0 for patch
    Using password from commandline
    Saving to /omero/OMERO4__0.sql
    $ psql omero < OMERO4__0.sql

config
~~~~~~

The ``config`` command is responsible for reading / writing
user-specific profiles. These are stored in platform-specific, protected
locations such as the registry on Windows, ``~/.java/.userPrefs`` on
Linux, or ``~/Library/Preferences`` on Mac OS X.

::

    $ bin/omero config def
    default

    $ bin/omero config get

    $ bin/omero config set example "my first value"

    $ bin/omero config get
    example=my first value

    $ OMERO_CONFIG=another bin/omero config def
    another

    $ OMERO_CONFIG=another bin/omero config get

    $ OMERO_CONFIG=another bin/omero config set example "my second value"

    $ OMERO_CONFIG=another bin/omero config get
    example=my second value

The values set via ``config`` override those compiled into the server
jars. The default values which are set can be seen in
``etc/omero.properties``. To add several values to a configuration, you
can pipe them via standard in:

::

    $ grep omero.ldap etc/omero.properties | OMERO_CONFIG=ldap bin/omero config load

    $ OMERO_CONFIG=ldap bin/omero config get
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

    $

Each of these values can then be modified to suit your local setup. To
remove on of the key-value pairs, pass no second argument:

::

    $ OMERO_CONFIG=ldap bin/omero config set omero.ldap.trustStore

    $ OMERO_CONFIG=ldap bin/omero config set omero.ldap.trustStorePassword

    $ OMERO_CONFIG=ldap bin/omero config set omero.ldap.keyStore

    $ OMERO_CONFIG=ldap bin/omero config set omero.ldap.keyStorePassword

    $ OMERO_CONFIG=ldap bin/omero config get
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

    $

if you will be using a particular profile more frequently you can set it
as your default:

::

    $ bin/omero config def ldap

And finally, if you would like to remove a profile, say to wipe a given
password off of a system, use "drop":

::

    $ bin/omero config drop

admin
~~~~~

Once your database has been properly configured and your config profile
is set to use that database, you're ready to start your server.

::

    $ bin/omero admin start

User commands
-------------

"import" is probably the first user command many will want to use.
Running the command without any arguments will produce a help listing:

::

    $ bin/omero import
    /Users/josh/omero/log
    Usage: importer-cli [OPTION]... [FILE]
    Import single files into an OMERO instance.

    Mandatory arguments:
      -s    OMERO server hostname
      -u    OMERO experimenter name (username)
      -w    OMERO experimenter password
      -k    OMERO session key (can be used in place of -u and -w)

    Optional arguments:
      -d    OMERO dataset Id to import image into
      -n    Image name to use
      -p    OMERO server port [defaults to 4063]
      -h    Display this help and exit

    ex. importer-cli -s localhost -u bart -w simpson -d 50 foo.tiff

    Report bugs to <ome-users@openmicroscopy.org.uk>

So, to upload a file image.tiff, use:

::

    $ bin/omero import -s localhost -u josh -w secret image.tiff

In future versions, session handling will be provided.

Extensions
----------

Plugins can be written and put in the ``lib/python/omero/plugins``
directory. On execution, all plugins in that directory are registered
with the `OmeroCli </ome/wiki/OmeroCli>`_. Alternatively, the "--path"
argument can be used to point to other plugin files or directories.

Thread-safety
~~~~~~~~~~~~~

The ``omero.cli.CLI`` should be considered thread-*un*\ safe. A single
connection object is accessible from all plugins via
``self.ctx.conn(args)``, and it is assumed that changes to this object
will only take place in the current thread. The cli instance itself,
however, can be passed between multiple threads, as long as only one
accesses it sequentially, possibly via locking.

--------------

See also: `OmeroCliDesign </ome/wiki/OmeroCliDesign>`_ and for other
extensions to OMERO, see `ExtendingOmero </ome/wiki/ExtendingOmero>`_.

The following should be considered a design document. A portion of the
functionality is included in the milestone:OMERO-Beta4 and later
releases, but more functionality will continually be added. If you would
like to vote for a particular function, please open a ticket.

Design plans
------------

General notes:

-  ``bin/omero`` will find its installation. Therefore, to install OMERO
   it is only necessary to unpack the bundle, and put ``bin/omero``
   somewhere on your path.
-  Any command can be produced by symlinking ``bin/omero`` to a file of
   the form "omero-command-arg1-arg2". This is useful under /etc/rc.d to
   have a startup script.
-  All commands respond to "help".

omero

com[mand]

other args [optional] <choice1\|choice2\|choice3>

Description

`[4] <#id18>`_

admin

 

Drops user into an admin console.

`[1] <#id15>`_ `[2] <#id16>`_

admin

check

Performs checks on the OMERO server. Included are: database version,
permissions on configuration (to prototect passwords), minimal check of
filesystems.

Executed before starting the server to detect possible issues.

 

admin

deploy [target1 [target2 [...]]]

Configures the grid according to the application descriptor and the
configuration files under etc.

Each optional target activates an optional section of the application
descriptor.

See OmeroGrid for more information.

 

admin

 

 

`[6] <#id19>`_

admin

unlock-lucene

At times, the Lucene full text index can become locked due to concurrent
access. This removes the lock.

`[1] <#id15>`_ `[4] <#id18>`_

admin

adduser username firstname lastname

Add a user to the OMERO system.

`[1] <#id15>`_ `[4] <#id18>`_

admin

addgroup name

 

`[8] <#id20>`_

config

 

Frontend for OmeroConfig. If Java is present, uses the prefs.java class
to define preferences for your user. If Java is not present, a config
file will be created in your home directory.

Multiple "profiles" can be defined at one time. The active profile is
chosen either by the OMERO\_CONFIG environment variable, or by the
"default" setting in your current preferences.

The default default is default.

`[3] <#id17>`_

load

[/path/to/file]

Loads a file of OmeroCli commands or from stdin if the path is missing.

`[4] <#id18>`_

login

 

Sets the username and password that will be used to connect to the
server. Before admin activities, this can be used for "sudo" like
functionality.

`[8] <#id20>`_

nodename

[nodename] <start\|stop\|status\|restart\|>\*

nodename defaults to the host name as defined by "uname -n \| perl -pe
's/^(.\*)[.].\*$/$1/'" unless OMERO\_NODE is defined.

 

q[uit]

 

 

 

search

SomeType "your google" -style +query name:here Image name:mitosis\*

The search will return a list of objects with minimal information.

 

start

 

 

 

status

 

 

`[3] <#id17>`_ `[4] <#id18>`_

submit

[/path/to/file]

Submit a file of OmeroCli commands to OmeroGrid for execution, or from
stdin if the file is missing, or drop the user into a submission shell
if stdin is missing.

 

q[uit]

 

 

 

? h[elp]

 

 

    [1]
    *(`1 <#id2>`_, `2 <#id5>`_, `3 <#id7>`_)* Requires OMERO admin
    access
    `[2] <#id3>`_
    Requires Postgres access
    [3]
    *(`1 <#id10>`_, `2 <#id13>`_)* Reads from stdin
    [4]
    *(`1 <#id1>`_, `2 <#id6>`_, `3 <#id8>`_, `4 <#id11>`_,
    `5 <#id14>`_)* Provides a command prompt when inputs are missing.
    `[6] <#id4>`_
    Should only be executed with the server stopped.
    [8]
    *(`1 <#id9>`_, `2 <#id12>`_)* Uses environment variables. See
    description.
    [9]
    Unimplemented.


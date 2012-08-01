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

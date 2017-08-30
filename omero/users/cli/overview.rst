Overview
--------

.. _cli_help:

Command line help
^^^^^^^^^^^^^^^^^

The |CLI| is divided into several commands which may themselves contain
subcommands. You can investigate the various commands available using the
``-h`` or ``--help`` option::

    $ bin/omero -h

Again, you can use ``-h`` repeatedly to get more details on each of
these sub-commands::

    $ bin/omero admin -h
    $ bin/omero admin start -h

The :program:`omero help` command can be used to get info on other commands or
options.

.. program:: omero help

.. option:: command

    Display the information on a particular command::

        $ bin/omero help admin       # same as bin/omero admin -h

    In addition to the |CLI| commands which can be listed using
    :option:`omero help --list`, :program:`omero help` can be used to retrieve information
    about the `debug` and `env` options::

        $ bin/omero help debug     # display help about debugging options
        $ bin/omero help env       # display help about environment variables

.. option:: --all

    Display the help for all available commands and options

.. option:: --recursive

    Recursively display the help of commands and/or options. This option can
    be used with either the :option:`omero help command` or the :option:`omero help --all` option::

        $ bin/omero help --all --recursive
        $ bin/omero help user --recursive

.. option:: --list

    Display a list of all available commands and subcommands


Command line workflow
^^^^^^^^^^^^^^^^^^^^^

There are three ways to use the command line tools:

#.  By explicitly logging in to the server first i.e. by creating a session
    using the :program:`omero login` command, e.g.::

        $ bin/omero login username@servername:4064
        Password:

    During login, a session is created locally on disk and will remain active
    until you logout or it times out. You can then call the desired command,
    e.g. the :program:`omero import` command::

        $ bin/omero import image.tiff

#.  By passing the session arguments directly to the desired command. Most
    commands support the same arguments as :program:`omero login`::

        $ bin/omero -s servername -u username -p 4064 import image.tiff
        Password:

    The ``--sudo <omero login --sudo>`` option is available to all
    commands accepting connection arguments. For instance to import data for
    user *username*::

        $ bin/omero import --sudo root -s servername -u username image.tiff
        Password for owner:

#.  By calling the desired command without login arguments. You will be asked
    to login::

        $ bin/omero import image.tiff
        Server: [servername]
        Username: [username]
        Password:

Once you are done with your work, you can terminate the current session if you
wish using the :program:`omero logout` command::

    $ bin/omero logout

Visit :doc:`sessions` to get a basic overview of how user sessions are managed.

.. seealso:: 

    :doc:`/sysadmins/import-scenarios`

    :doc:`/sysadmins/in-place-import`
    
    :doc:`/sysadmins/dropbox`
    
    :doc:`index`
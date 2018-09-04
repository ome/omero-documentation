Command Line Interface as an OMERO client
=========================================

The |CLI| is a set of Python_ based system-administration, deployment and
advanced user tools. Most of commands work remotely so that the |CLI| can be
used as a client against an OMERO server.

.. note:: The end of Windows support for OMERO.server means that the CLI is
    currently unsupported on this platform too. However, we intend to make
    OMERO.python installable via pip for future releases which would restore
    Windows support for the CLI.

.. toctree::
    :maxdepth: 1
    :titlesonly:

    installation
    overview
    import
    import-target
    import-bulk
    export
    sessions
    containers-annotations
    tag
    delete
    chgrp
    chown

Note that changing ownership requires elevated privileges and can only be
carried out by full administrators, restricted administrators with the correct
privileges, or group owners.
    
.. seealso::

    :doc:`/sysadmins/cli/index`
        System administrator documentation for the Command Line Interface.
        **This includes guidance for managing groups and users which can be
        done by restricted administrators with the correct privileges.**

    :doc:`/developers/cli/index`
        Developer documentation for the Command Line Interface

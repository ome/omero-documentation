Command Line Interface as an OMERO development tool
===================================================


.. toctree::
    :maxdepth: 1
    :titlesonly:

    obj
    extending

Help for any specific CLI command can be displayed using the ``-h``
argument. See :ref:`cli_help` for more information.

General notes
-------------

-  :file:`bin/omero` will find its installation. Therefore, to install OMERO
   it is only necessary to unpack the bundle, and put :file:`bin/omero`
   somewhere on your path.
-  Any command can be produced by symlinking :file:`bin/omero` to a file of
   the form "omero-command-arg1-arg2". This is useful under :file:`/etc/rc.d`
   to have a startup script.
-  All commands respond to :program:`omero help`.

.. seealso::

    :doc:`/users/cli/index`
        User documentation on the Command Line Interface

    :doc:`/sysadmins/cli/index`
        System Administrator documentation for the Command Line Interface

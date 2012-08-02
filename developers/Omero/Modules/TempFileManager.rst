`TempFileManager </ome/wiki/TempFileManager>`_
==============================================

Class to be used by |OmeroClients| and server
components to allow a uniform creation of temporary files and folders
with a best-effort guarantee of deleting the resources on exit. The
manager searches three locations in order, taking the first which allows
lockable write-access (See `#1653 </ome/ticket/1653>`_):

-  The environment property setting ``OMERO_TEMPDIR``
-  The user's home directory, for example specified in Java via
   ``System.getProperty("user.home")``
-  The system temp directory, in Java
   ``System.getProperty("java.io.tmpdir")`` and in Python
   ``tempfile.gettempdir()``

.. contents::

Creating temporary files
------------------------

For the user "ralph",

::

    from omero.util.temp_files import create_path
    path = create_path("omero",".tmp")

or

::

    import omero.util.TempFileManager
    File file = TempFileManager.create_path("omero",".tmp")

both produce a file under the directory:

::

    /tmp/omero_ralph/$PID/omero$RANDOM.tmp

where $PID is the current process id and $RANDOM is some random sequence
of alphanumeric characters.

Removing files
--------------

If ``remove_path`` is called on the return value of ``create_path``,
then the temporary resources will be cleaned up immediately. Otherwise,
when the Java or Python process exits, they will be deleted. This is
achieved in Java through ``Runtime#addShutdownHook(Thread)`` and in
Python via ``atexit.register()``.

Creating directories
--------------------

If an entire directory with a unique directory is needed, pass "true" as
the "folder" argument of the ``create_path`` method:

::

    create_path("omero", ".tmp", folder = True)

and

::

    TempFileManager.create_path("omero", ".tmp", true);

**Note:** all contents of the generated directory will be deleted.

--------------

-  See: `#1534 </ome/ticket/1534>`_

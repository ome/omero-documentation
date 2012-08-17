.. _developers/Omero/Server/FS:

OMERO.fs
========

The :ref:`developers/Omero/Server/FS` service runs somewhere within
|OmeroGrid| and is responsible for watching a
particular filesystem directory for changes. These change events are
then signaled to any observers, who can optionally begin reading the
file once updated.

One critical use of :ref:`developers/Omero/Server/FS` is watching a
directory and kicking off an automatic import. Another is allowing
system administrators to point OMERO at an existing directory without
requiring the data duplication required by a traditional import.

Working with objects
--------------------

.. program:: omero obj

The :program:`omero obj` command allows to create and update OMERO objects.
More information can be displayed using ``omero obj -h``.

A complete :doc:`/developers/Model/EveryObject` is available for reference.

Object creation
^^^^^^^^^^^^^^^

.. program:: omero obj new

The  :program:`omero obj new` subcommand allows to create new objects::

   $ omero obj new Object field=value

where `Object` is the type of object to create, e.g. `Dataset` or
`ProjectDatasetLink` and `field`/`value` is a valid key/value pair for the
type of object.
For example, the following command creates a new screen with a name and a
description::


	$ omero obj new Screen name=Screen001 description="screen description"

Object update
^^^^^^^^^^^^^

The :program:`omero obj update` subcommand allows to update existing objects::

   $ omero obj update Object:ID field=value

where `Object:ID` is the type and the ID of object to update, e.g. `Image:1`
or `PlateDatasetLink:10` and `field`/`value` is a valid key/value pair to
update for the specified object.

For example, the following command updates the existing screen of ID 2 with a
name and a description::

	$ omero obj update Screen:2 name=Screen001 description="screen description"

Piping output
^^^^^^^^^^^^^

The output of each :program:`omero obj` command is formatted as `Object:ID` so
that the CLI commands can be redirected and piped together. For example, the
following set of commands creates a dataset and a project and links them
together::

   $ dataset=$(omero obj new Dataset name=dataset-1)
   $ project=$(omero obj new Project name=project-1)
   $ omero obj new ProjectDatasetLink parent=$project child=$dataset

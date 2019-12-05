Deleting objects
----------------

The :program:`omero delete` command deletes objects. Further help is available
using the ``-h`` option::

    $ omero delete -h

This command will remove entire graphs of objects based on
the IDs of the topmost objects. The command can be modified to include the
deletion of objects that would, by default, be excluded or exclude objects
that would, by default, be included using the :option:`omero delete --include`
and :option:`omero delete --exclude` options.

Additionally, objects of the three annotation types, `FileAnnotation`,
`TagAnnotation` and `TermAnnotation` are not deleted by default when the
objects to which they are linked are deleted.

It is also possible to delete objects lower in the hierarchy by specifying
the type and ID of a topmost object and the type of the lower object. For
instance, deleting all of the images under a given project.

By default the command confirms the deletion of the target objects but
it can also provide a detailed report of all the deleted objects via an
:option:`omero delete --report` option. An :option:`omero delete --dry-run`
option can be used to report on what objects would be deleted without actually
deleting them.

Examples
^^^^^^^^

Basic delete
============

::

    $ omero delete OriginalFile:101
    $ omero delete Project:51

In the first line, the original file with ID 101 will be deleted. In the
second, the project with ID 51 will be deleted including any datasets inside
only that project and any images that are contained within deleted datasets only.
Note that any linked file, tag or term annotations will not be deleted.

Deleting multiple objects
=========================

Multiple objects can be specified with each type being followed by an ID
or a comma-separated list of IDs. The order of objects or IDs is not
significant, thus all three calls below are identical in deleting
project 51 and datasets 53 and 54.
::

    $ omero delete Project:51 Dataset:53,54
    $ omero delete Dataset:54,53 Project:51
    $ omero delete Dataset:53 Project:51 Dataset:54

To delete a number of objects with sequentially numbered IDs a hyphen can be
used to specify an ID range. This form can also be mixed with comma-separated
IDs.
::

    $ omero delete Project:51 Dataset:53-56 --force
    $ omero delete Dataset:53-56,65,101-105,201,202 --force

When deleting multiple objects in a single command, if one object cannot
be deleted then the whole command will fail and none of the specified
objects will be deleted.

The :option:`omero delete --dry-run` option can be useful as a check before
trying to delete large numbers of objects. If specifying objects with a range,
it is best to pass either :option:`omero delete --dry-run` or
:option:`omero delete --force`.

.. note::
    If no flag is passed, the command will default to
    :option:`omero delete --dry-run` and warn that this behavior is
    deprecated. Future versions will default to
    :option:`omero delete --force`.

Deleting lower level objects
============================

To delete objects below a specified top-level object the following form
of the object specifier is used.
::

    $ omero delete Project/Dataset/Image:51

Here the all of images under the project 51 would be deleted. It is not
necessary to specify intermediate objects in the hierarchy and so::

    $ omero delete Project/Image:51

would have the same effect as the call above. Links can also be deleted
and so::

$ omero delete Project/DatasetImageLink:51 Dataset/DatasetImageLink:53

would effectively orphan all images under project 51 and dataset 53 that are
not also under other datasets.

Including and excluding objects
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. program:: omero delete

.. option:: --include

    Include linked objects that would not ordinarily be deleted::

        $ omero delete Image:51 --include FileAnnotation,TagAnnotation,TermAnnotation

    As mentioned above these three annotation types are not deleted by default
    and so this call overrides that default by including any of the three
    annotation types in the delete::

         $ omero delete Image:51 --include Annotation

    This call would also delete any annotation objects linked to the image.

.. option:: --exclude

    Exclude linked objects that would ordinarily be deleted::

        $ omero delete Project:51 --exclude Dataset

    This will delete project 51 but not any datasets contained in that project.

The two options can be used together::

     $ omero delete Project/Dataset:53 --exclude Image --include FileAnnotation

This will delete any datasets under project 53, that are not otherwise
contained elsewhere, excluding any images in those datasets but including
any file annotations linked to the deleted datasets. In this case the images
that are not otherwise contained in datasets will be orphaned.

For an example on deleting tags directly see :ref:`delete_tags`.

Further options
^^^^^^^^^^^^^^^

.. program:: omero delete

.. option:: --ordered

    Delete the objects in the order specified.

    Normally all of the specified objects are grouped into a single delete
    command. However, each object can be deleted separately and in the order
    given. Thus::

        $ omero delete Dataset:53 Project:51 Dataset:54 --ordered

    would be equivalent to making three separate calls::

        $ omero delete Dataset:53
        $ omero delete Project:51
        $ omero delete Dataset:54

.. option:: --report

    Provide a detailed report of what is deleted::

        $ omero delete Project:502 --report
        ...
        omero.cmd.Delete2 Project 502... ok
        Steps: 3
        Elapsed time: 0.597 secs.
        Flags: []
        Deleted objects
        Dataset:603
        DatasetImageLink:303
        Project:503
        ProjectDatasetLink:353
        Channel:203
        Image:503
        LogicalChannel:203
        OriginalFile:460,459
        Pixels:253
        Fileset:203
        FilesetEntry:253
        FilesetJobLink:264,265,262,263,261
        IndexingJob:315
        JobOriginalFileLink:303
        MetadataImportJob:312
        PixelDataJob:313
        ThumbnailGenerationJob:314
        UploadJob:311
        StatsInfo:72

.. option:: --dry-run

    Run the command and report success or failure but do not delete the
    objects. This can be combined with the :option:`omero delete --report` to
    provide a detailed confirmation of what would be deleted before running
    the delete itself.

.. option:: --force

    Delete multiple objects in a single command. Both comma-separated lists
    and ranges of IDs using a hyphen will work::
    
        $ omero delete Project:51 Dataset:53-56,65,101-105 --force
    
    The command will fail and no objects will be deleted if any of the
    specified objects cannot be deleted.

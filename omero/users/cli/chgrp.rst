Moving objects between groups
-----------------------------

.. warning::

  Data does not need to be assigned to a group where the data owner is
  a member, and administrators may wish to change the ownership of data
  or move it between groups in several steps of a larger workflow. However,
  it is generally expected that data should end up in a group where the
  data owner is a member, so that they can view their
  data in the OMERO clients.


Who may move data
^^^^^^^^^^^^^^^^^

* a full administrator
* a :doc:`restricted administrator
  </sysadmins/restricted-admins>` with `Chgrp` privilege
* the owner of the data *if* they are a member of the target group


How to move data
^^^^^^^^^^^^^^^^

* CLI: See below
* :guide:`OMERO.web and OMERO.insight<introduction/docs/index.html>`

The :program:`omero chgrp` command moves objects between groups. Further help is
available using the ``-h`` option::

    $ omero chgrp -h

This command will move entire graphs of objects based on the
IDs of the topmost objects. The command can be modified to include the movement
of objects that would, by default, be excluded or exclude objects that would,
by default, be included using the :option:`omero chgrp --include` and
:option:`omero chgrp --exclude` options.

It is also possible to move objects lower in the hierarchy by specifying
the type and ID of a topmost object and the type of the lower object. For
instance, moving all of the images under a given project.

By default the command confirms the movement of the target objects but
it can also provide a detailed report of all the moved objects via an
:option:`omero chgrp --report` option. An :option:`omero chgrp --dry-run`
option can be used to report on what objects would be moved without actually
moving them.

Examples
^^^^^^^^

Basic move
==========

::

    $ omero chgrp 5 OriginalFile:101
    $ omero chgrp Group:5 Project:51
    $ omero chgrp ExperimenterGroup:5 Project:51
    $ omero chgrp lab_group Project:51

In the first line, the original file with ID 101 will be moved to the group
with ID 5. In the second and third, project 51 will be moved to group 5
including any datasets inside only that project and any images that are
contained within moved datasets only. If group 5 is named 'lab_group' then the
last line will have the same effect as the previous two. Note that any linked
annotations will also be moved.

Moving multiple objects
=======================

Multiple objects can be specified with each type being followed by an ID
or a comma-separated list of IDs. The order of objects or IDs is not
significant, thus all three calls below are identical in moving
project 51 and datasets 53 and 54 to group 5.
::

    $ omero chgrp 5 Project:51 Dataset:53,54
    $ omero chgrp 5 Dataset:54,53 Project:51
    $ omero chgrp 5 Dataset:53 Project:51 Dataset:54

To move a number of objects with sequentially numbered IDs a hyphen can be used
to specify an ID range. This form can also be mixed with comma-separated IDs.
::

    $ omero chgrp 5 Project:51 Dataset:53-56
    $ omero chgrp 5 Dataset:53-56,65,101-105,201,202

.. note::
    When moving multiple objects in a single command, if one object cannot
    be moved then the whole command will fail and none of the specified
    objects will be moved. The :option:`omero chgrp --dry-run` option can be 
    useful as a check before trying to move large numbers of objects.

Moving lower level objects
==========================

To move objects below a specified top-level object the following form
of the object specifier is used.
::

    $ omero chgrp 5 Project/Dataset/Image:51

Here the all of images under the project 51 would be moved. It is not
necessary to specify intermediate objects in the hierarchy and so::

    $ omero chgrp 5 Project/Image:51

would have the same effect as the call above.

Including and excluding objects
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. program:: omero chgrp

.. option:: --include

    Linked objects that would not ordinarily be moved can be included in the
    move using the ``--include`` option::

        $ omero chgrp 5 Image:51 --include Annotation

    This call would move any annotation objects linked to the image.

.. option:: --exclude

    Linked objects that would ordinarily be moved can be excluded from the
    move using the ``--exclude`` option::

        $ omero chgrp 5 Project:51 --exclude Dataset

    This will move project 51 but not any datasets contained in that project.

The two options can be used together::

     $ omero chgrp 5 Project/Dataset:53 --exclude Image --include FileAnnotation

This will move any datasets under project 53, that are not otherwise
contained elsewhere, excluding any images in those datasets but including
any file annotations linked to the moved datasets. In this case the images
that are not otherwise contained in datasets will be orphaned.

Further options
^^^^^^^^^^^^^^^

.. program:: omero chgrp

.. option:: --ordered

    Move the objects in the order specified.

    Normally all of the specified objects are grouped into a single move
    command. However, each object can be moved separately and in the order
    given. Thus::

        $ omero chgrp 5 Dataset:53 Project:51 Dataset:54 --ordered

    would be equivalent to making three separate calls::

        $ omero chgrp 5 Dataset:53
        $ omero chgrp 5 Project:51
        $ omero chgrp 5 Dataset:54

.. option:: --report

    Provide a detailed report of what is moved::

        $ omero chgrp 5 Project:502 --report

.. option:: --dry-run

    Run the command and report success or failure but does not move the
    objects. This can be combined with the :option:`omero chgrp --report` to
    provide a detailed confirmation of what would be moved before running the
    move itself.

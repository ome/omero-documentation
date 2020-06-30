Changing ownership of objects
-----------------------------

.. warning::

  Data does not need to be assigned to a group where the data owner is
  a member, and administrators may wish to change the ownership of data
  or move it between groups in several steps of a larger workflow. However,
  it is generally expected that data should end up in a group where the
  data owner is a member, so that they can view their
  data in the OMERO clients.


Who may change ownership of data
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* a full administrator
* a :doc:`restricted administrator
  </sysadmins/restricted-admins>` with `Chown` privilege
* an owner of the group that the data is in *if* the target user is a
  member of the group


How to change ownership of data
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The :program:`omero chown` command transfers objects to the ownership of a
different user. Further help is available using the ``-h``
option::

    $ omero chown -h

The :program:`omero chown` command can transfer entire graphs of objects based on
the IDs of the topmost objects. The command can be modified to include
the transfer of objects that would, by default, be excluded or exclude
objects that would, by default, be included using the
:option:`omero chown --include` and :option:`omero chown --exclude` options.

It is also possible to transfer objects lower in the hierarchy by specifying
the type and ID of a topmost object and the type of the lower object.
For instance, transferring all of the images under a given project.

All the data of a given user can be transferred using the
:program:`omero chown` command. This is useful when somebody leaves a lab to
move on to another project or institution and their previous work is to
be curated or continued by a colleague. This feature has to be
considered as advanced and might be slow and demanding of CPU resources in
cases of complex data.

By default the command confirms the transfer of the target objects but
it can also provide a detailed report of all the transferred objects via an
:option:`omero chown --report` option. An :option:`omero chown --dry-run`
option can be used to report on which objects' ownership would change without
actually transfering them.

Examples
^^^^^^^^

Basic transfer of ownership
===========================

::

    $ omero chown 5 OriginalFile:101
    $ omero chown User:5 Project:51
    $ omero chown Experimenter:5 Project:51
    $ omero chown jane Project:51

In the first line, the ownership of original file with ID 101 will be
transferred to the user with ID 5. In the second and third, the ownership
of project 51 will be transferred including any datasets
inside only that project and any images that are contained within transferred
datasets only, as long as all the mentioned objects (project, datasets and
images) are originally owned by one user. If user 5 is named 'jane' then the
last line will have the same effect as the previous two. Note that any linked
annotations will be transferred depending on the permission level of the group
in which the data and users are in.

Transferring multiple objects
=============================

Multiple objects can be specified with each type being followed by an ID
or a comma-separated list of IDs. The order of objects or IDs is not
significant, thus all three calls below are identical in transferring
ownership of project 51 and datasets 53 and 54 to user 5.
::

    $ omero chown 5 Project:51 Dataset:53,54
    $ omero chown 5 Dataset:54,53 Project:51
    $ omero chown 5 Dataset:53 Project:51 Dataset:54

To transfer a number of objects with sequentially numbered IDs a hyphen can
be used to specify an ID range. This form can also be mixed with
comma-separated IDs.
::

    $ omero chown 5 Project:51 Dataset:53-56
    $ omero chown 5 Dataset:53-56,65,101-105,201,202

.. note::
    When transferring multiple objects in a single command,
    if one object cannot be transferred then the whole command will fail
    and none of the specified objects will be transferred.
    The :option:`omero chown --dry-run` option can be useful
    as a check before trying to move large numbers of objects.

Transferring lower level objects
================================

To transfer objects below a specified top-level object the following form
of the object specifier is used.
::

    $ omero chown 5 Project/Dataset/Image:51

Here the all of images under the project 51 would be transferred. It is not
necessary to specify intermediate objects in the hierarchy and so::

    $ omero chown 5 Project/Image:51

would have the same effect as the call above.

Transferring all objects belonging to specified users
=====================================================

Note that this feature is advanced and might be potentially slow.
To transfer ownership of all objects belonging to a user or group of users
the following form of the user specifier is used.
::

    $ omero chown 10 Experimenter:1,3,7

Here ownership of all the objects belonging to users 1, 3 and 7
would be transferred to user 10.

Including and excluding objects
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. program:: omero chown

.. option:: --include

    Linked objects that would not ordinarily be transferred can be included
    in the transfer using the `--include` option::

        $ omero chown 5 Image:51 --include Annotation

    This call would move any annotation objects linked to the image.

.. option:: --exclude

    Linked objects that would ordinarily be transferred can be excluded
    from the transfer using the `--exclude` option::

        $ omero chown 5 Project:51 --exclude Dataset

    This will transfer project 51 but not any datasets contained in that project.

The two options can be used together::

     $ omero chown 5 Project/Dataset:53 --exclude Image --include FileAnnotation

This will transfer any datasets under project 53, that are not otherwise
contained elsewhere, excluding any images in those datasets but including
any file annotations linked to the moved datasets. In this case the images
that are not otherwise contained in datasets will be orphaned.

Further options
^^^^^^^^^^^^^^^

.. program:: omero chown

.. option:: --ordered

    Move the objects in the order specified.

    Normally all of the specified objects are grouped into a single transfer
    command. However, each object can be transferred separately
    and in the order given. Thus::

        $ omero chown 5 Dataset:53 Project:51 Dataset:54 --ordered

    would be equivalent to making three separate calls::

        $ omero chown 5 Dataset:53
        $ omero chown 5 Project:51
        $ omero chown 5 Dataset:54

.. option:: --report

    Provide a detailed report of what is transferred::

        $ omero chown 5 Project:502 --report

.. option:: --dry-run

    Run the command and report success or failure but does not transfer the
    objects. This can be combined with the :option:`omero chown --report` to 
    provide a detailed confirmation of what would be transferred before 
    running the move itself.

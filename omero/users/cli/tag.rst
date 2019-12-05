Manage tags
-----------

The :program:`omero tag` subcommands manage the creation, linking and listing of
tag annotations. All subcommands can be listed using the ``-h`` option::

    $ omero tag -h

Create tags
^^^^^^^^^^^

To create a new tag annotation, use the :program:`omero tag create` command::

    $ omero tag create
    Please enter a name for this tag: my_tag

To create a tag set containing two existing tags of known identifiers
``1259`` and ``1260``, use the :program:`omero tag createset` command::

	$ omero tag createset --tag 1259 1260
	Please enter a name for this tag set: my_tag_set

For both tags and tag sets, the name and an optional description can be
passed using the ``--name`` and ``--desc`` options::

	$ omero tag create --name my_tag --desc 'description of my_tag'
	$ omero tag createset --tag 1259 1260 --name my_tag_set --desc 'description of my_tag_set'

List tags
^^^^^^^^^

To list all the tags owned by the current user, use the :program:`omero tag list`
command::

    $ omero tag list
    +- 1261:'my_tag_set'
    |\
    | +- 1259:'my_tag'
    | +- 1260:'my_tag_2'
    +- 1264:'my_tag_set_2'
    |\
    | +- 1260:'my_tag_2'
    | +- 1263:'my_tag_4'

    Orphaned tags:
    > 1262:'my_tag_3'

To list all the tag sets owned by the current user, use the
:program:`omero tag listsets` command::

    $ omero tag listsets
    --------|---------------------------------------------------------------------------------------------------------
    ID      |Name
    --------|---------------------------------------------------------------------------------------------------------
    1261    |my_tag_set
    1264    |my_tag_set_2
    --------|---------------------------------------------------------------------------------------------------------

Link tags
^^^^^^^^^

Tags can be linked to objects on the server using the :program:`omero tag link`
command. The object must be specified as ``object_type:object_id``. To link
the tag of identifier ``1260`` to the Image of identifier ``1000``, use::

    $ omero tag link Image:1000 1260

.. _delete_tags:

Delete tags
^^^^^^^^^^^

Tags can be deleted using the :program:`omero delete` command. The tag or tag set
must be specified as ``TagAnnotation:tag_id``. To delete tag ``123`` use::

    $ omero delete TagAnnotation:123

By default the tags within a tag set will not be deleted with the tag set. To
delete any included tags use the :option:`omero delete --include` option::

    $ omero delete TagAnnotation:123 --include TagAnnotation

.. seealso:: :doc:`/users/cli/delete`

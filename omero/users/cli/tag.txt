Manage tags
-----------

The :omerocmd:`tag` subcommands manage the creation, linking and listing of
tag annotations. All subcommands can be listed using the :option:`-h` option::

    $ bin/omero tag -h

Create tags
^^^^^^^^^^^

To create a new tag annotation, use the :omerocmd:`tag create` command::

    $ bin/omero tag create
    Please enter a name for this tag: my_tag

To create a tag set containing two existing tags of known identifiers
``1259`` and ``1260``, use the :omerocmd:`tag createset` command::

	$ bin/omero tag createset --tag 1259 1260
	Please enter a name for this tag set: my_tag_set

For both tags and tag sets, the name and an optional description can be
passed using the :option:`--name` and :option:`--desc` options::

	$ bin/omero tag create --name my_tag --desc 'description of my_tag'
	$ bin/omero tag createset --tag 1259 1260 --name my_tag_set --desc 'description of my_tag_set'

List tags
^^^^^^^^^

To list all the tags owned by the current user, use the :omerocmd:`tag list`
command::

    $ bin/omero tag list
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
:omerocmd:`tag listsets` command::

    $ bin/omero tag listsets
    --------|---------------------------------------------------------------------------------------------------------
    ID      |Name
    --------|---------------------------------------------------------------------------------------------------------
    1261    |my_tag_set
    1264    |my_tag_set_2
    --------|---------------------------------------------------------------------------------------------------------

Link tags
^^^^^^^^^

Tags can be linked to objects on the server using the :omerocmd:`tag link`
command. The object must be specified as ``object_type:object_id``. To link
the tag of identifier ``1260`` to the Image of identifier ``1000``, use::

    $ bin/omero tag link Image:1000 1260

.. _delete_tags:

Delete tags
^^^^^^^^^^^

Tags can be deleted using the :omerocmd:`delete` command. The tag or tag set
must be specified as ``TagAnnotation:tag_id``. To delete tag ``123`` use::

    $ bin/omero delete TagAnnotation:123

By default the tags within a tag set will not be deleted with the tag set. To
delete any included tags use the :option:`--include` option::

    $ bin/omero delete TagAnnotation:123 --include TagAnnotation

.. seealso:: :doc:`/users/cli/delete`

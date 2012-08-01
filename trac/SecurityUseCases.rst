Deprecated Page

Omero Security Use Cases
========================

    It may not be entirely obvious how to begin securing your data. This
    list of examples should help get you started and explain how the
    security system works without getting into the details.

Umasks
------

    For a user wanting to protect data, the most important tool is the
    umask. It is important to keep in mind that only newly created
    objects will be influenced by the umask, and if existing data needs
    to permissons, then that will have to happen explicitly.

User wants to restrict public access for a paper
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    If public access should just hide say a particular grouping of
    images that looks promising, it would suffice to turn a
    GROUP\_PRIAVTE (rwurwu---) umask or a NOWORLD (rwur-u---) umask on
    for a single session, create a new dataset, and place all images in
    that dataset. No one not in your group would even know that that
    dataset (or the links placing the images in the dataset) existed.
    The individual images would, however, still be visible.

    If it can be seen ahead of time that an entire experiment is
    intended for publication, it may be more beneficial (and less to
    remember) to set the default umask in your client to the permissions
    mentioned above. Then all created images, datasets, and even
    annotations will be invisible to other groups.

User wants to have a private dataset
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    The same basic process can be followed to have completely private
    (not-visible to other group members) data. However, it must always
    be remember that the group leader/PI will still be able to see that
    data.

IAdmin TBD
----------

    **Note**: it doesn't make sense to discuss IAdmin in user docs. But
    basically this section should describe whatever UI sits on top of
    IAdmin, so that it's clear how to use changePermissions and
    changeGroup.

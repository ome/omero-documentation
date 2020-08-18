User/group management
---------------------

The :program:`omero user` and :program:`omero group` commands provide
functionalities to add and manage users and groups on your database.

.. seealso::

   * :doc:`/users/cli/chgrp`
   * :doc:`/users/cli/chown`

User creation
^^^^^^^^^^^^^

New users can be added to the database using the :program:`omero user add`
command::

    $ omero user add -h

During the addition of the new user, you will need to specify the first and
last name of the new user and their username as well as the groups the user
belongs to. To add John Smith identified as ``jsmith`` as a member of the group named ``test-group``,
enter::

    $ omero user add jsmith John Smith --group-name test-group

Additional parameters such as the email address, institution, middle name etc.
can be passed as optional arguments to the :program:`omero user add` command.

For managing the permissions of restricted administrators,
:doc:`OMERO.cli does provide means <light-admins>` but that functionality
is not yet offered in a friendly manner by the :program:`omero user` command.
The :guide:`Group and Users Management Guide <introduction/docs/group-user-management.html>` is
recommended for this task instead.

If you are using ldap as an authentication backend, you can create
an OMERO user account for jsmith using the :program:`omero ldap create`
command, which allows the administrator to add jsmith to an OMERO group,
before they have ever logged in to OMERO::

    $ omero ldap create jsmith


.. _ldap_setdn:

Converting non-LDAP users to LDAP authentication
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you want to take an existing (non-LDAP) user and 'upgrade' them to using
LDAP you can do so using the :program:`omero ldap setdn` command::

    $ omero ldap setdn -h

The process is also reversible so that the OMERO password for a user rather
than the LDAP password will be used. See the caveat in the setdn help output
below:

.. literalinclude:: /downloads/ldap/setdn.out


User deactivation
^^^^^^^^^^^^^^^^^

To deactivate a user, remove him/her from the system group ``user``.
Use the command :program:`omero user leavegroup` and specify the ``user`` group as the target::

    # Remove jsmith from group user
    $ omero user leavegroup user --name=jsmith

To reactivate the user, add him/her back to the system group ``user`` i.e.::

    $ omero user joingroup user --name=jsmith


User editing
^^^^^^^^^^^^

Updating the details of a user e.g. the email address can be achieved using
the :program:`omero obj update` command::

    # Determine the ID of jsmith
    $ omero user info --user-name jsmith
    # Change the email address of jsmith. Replace 123 by the ID of jsmith
    $ omero obj update Experimenter:123 email=jsmith@new_address.com


Group creation
^^^^^^^^^^^^^^

New groups can be added to the database using the :program:`omero group add`
command::

    $ omero group add -h

During the addition of the new group, you need to specify the name of the new
group::

    $ omero group add newgroup

The permissions of the group are set to `private` by default. Alternatively you
can specify the permissions using ``--perms`` or ``--type``
optional arguments::

    $ omero group add read-only-1 --perms='rwr---'
    $ omero group add read-annotate-1 --type=read-annotate

.. seealso::

    :doc:`/sysadmins/server-permissions`
        Description of the group permissions levels.

Lists of users/groups on the OMERO server can be queried using the
:program:`omero user list` and :program:`omero group list` commands::

    $ omero user list
    $ omero group list

Group membership
^^^^^^^^^^^^^^^^

Users can be added to existing groups using the :program:`omero user joingroup` or
:program:`omero group adduser` commands. Similarly, users can be removed from
existing groups using the :program:`omero user leavegroup` or
:program:`omero group removeuser` commands::

    # Add jsmith to group read-annotate-1
    $ omero group adduser jsmith --name=read-annotate-1
    # Remove jsmith from group read-annotate-1
    $ omero group removeuser jsmith --name=read-annotate-1
    # Add jsmith to group read-only-1
    $ omero user joingroup read-only-1 --name=jsmith
    # Remove jsmith from group read-only-1
    $ omero user leavegroup read-only-1 --name=jsmith

By passing the ``--as-owner`` option, these commands can also be used to manage group owners ::

    # Add jsmith to the owner list of group read-annotate-1
    $ omero group adduser jsmith --name=read-annotate-1 --as-owner
    # Remove jsmith from the owner list of group read-annotate-1
    $ omero user leavegroup read-annotate-1 --name=jsmith --as-owner

Group copy
^^^^^^^^^^

To create a copy of a group, you must first create a new group using the
:program:`omero group add` command::

    $ omero group add read-only-2 --perms='rwr---'

Then you can use the :program:`omero group copyusers` command to copy all group
members from one group to  another::

    $ omero group copyusers read-only-1 read-only-2

To copy the group owners, use the same command with the ``--as-owner``
optional argument::

    $ omero group copyusers read-only-1 read-only-2 --as-owner

Group modification
^^^^^^^^^^^^^^^^^^

To change the permissions of a group, for example to make the group ``read-annotate-1``
a read-write group, run::

    $ omero group perms --perms='rwrw--' --name='read-annotate-1'

If you want to change its name to ``read-write-1`` afterwards, run::

    $ omero obj update ExperimenterGroup:123 name='read-write-1'

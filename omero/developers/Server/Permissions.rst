OMERO permissions querying, usage and history
=============================================

Working with the OMERO |version_openmicroscopy| permissions system
------------------------------------------------------------------

Example environment
^^^^^^^^^^^^^^^^^^^

* OMERO |version_openmicroscopy| server
* IPython shell initiated by running ``omero shell --login``

Group membership
^^^^^^^^^^^^^^^^

======  =========  ===========  ============  ===============
User    private-1  read-only-1  read-write-1  read-annotate-1
======  =========  ===========  ============  ===============
user-2  Yes        Yes          No            No
user-3  No         Yes          No            Yes
======  =========  ===========  ============  ===============

Simple inserts and queries
^^^^^^^^^^^^^^^^^^^^^^^^^^

While the 'Default Group' is essentially a deprecated concept, a user must be 
logged into one to provide a default context. It is still possible to change 
this default group but it is no longer required to make queries in other 
permissions contexts.

All remote calls to an OMERO server, since well before version 4.1.x, have the 
option of taking an Ice context object. Through this object, and manipulations 
thereof, we can affect our query context. What follows is a series of examples 
exploring inserts and queries using contexts that span a single group at a 
time.

Retrieving a user's event context and group membership
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    #!python
    # Session that has already been created for user-2
    session = client.getSession()
    
    # Retrieve the services we are going to use
    admin_service = session.getAdminService()
    
    ec = admin_service.getEventContext()
    print(ec)
    groups = [admin_service.getGroup(v) for v in ec.memberOfGroups]
    for group in groups:
        print('Group name: %s' % group.name.val)


Example output:

::

    object #0 (::omero::sys::EventContext)
    {
        shareId = -1
        sessionId = 1783
        sessionUuid = 213adc46-2c5f-449b-81fc-fe24dec38b58
        userId = 10
        userName = user-2
        groupId = 9
        groupName = private-1
        isAdmin = False
        eventId = -1
        eventType = User
        memberOfGroups = 
        {
            [0] = 9
            [1] = 8
            [2] = 1
        }
        leaderOfGroups = 
        {
        }
        groupPermissions = object #1 (::omero::model::Permissions)
        {
            _restrictions = 
            {
            }
            _perm1 = -120
        }
    }
    
    Group name: private-1
    Group name: read-only-1
    Group name: user


Here you can see and validate that, when logged in as ``user-2``, we are a 
member of both the ``private-1`` and ``read-only-1`` groups. Membership of the 
``user`` group is required in order to login. This group essentially acts as a 
role, letting the OMERO security system know whether or not the user is 
active.

Inserting and querying data from specific groups
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For the purposes of this example, we will prepare a single ``Project`` in both 
the ``private-1`` and ``read-only-1`` groups and then perform various queries 
on those ``Projects``.

::

    #!python
    from omero.model import *
    from omero.rtypes import *
    from omero.sys import ParametersI
    from omero.cmd import Delete
    from omero.callbacks import CmdCallbackI
    
    # Session that has already been created for user-2
    session = client.getSession()
    
    # Project object instantiation
    private_project = ProjectI()
    private_project.name = rstring('private-1 project')
    read_only_project = ProjectI()
    read_only_project.name = rstring('read-only-1 project')
    
    # Retrieve the services we are going to use
    update_service = session.getUpdateService()
    admin_service = session.getAdminService()
    query_service = session.getQueryService()
    
    # Groups we are going to write data into
    private_group = admin_service.lookupGroup('private-1')
    read_only_group = admin_service.lookupGroup('read-only-1')
    
    # Save and return our two projects, setting the context correctly for each
    ctx = {'omero.group': str(private_group.id.val)}
    private_project = update_service.saveAndReturnObject(private_project, ctx)
    ctx = {'omero.group': str(read_only_group.id.val)}
    read_only_project = update_service.saveAndReturnObject(read_only_project, ctx)

    private_project_id = private_project.id.val
    read_only_project_id = read_only_project.id.val
    print('Created Project:%d in group private-1' % (private_project_id))
    print('Created Project:%d in group read-only-1' % (read_only_project_id))
    
    # Query for the private project we created using private-1
    # 
    # You will notice that this returns the Project as we have specified
    # the group that the Project is in within the context passed to the
    # query service.
    ctx = {'omero.group': str(private_group.id.val)}
    params = ParametersI()
    params.addId(private_project_id)
    projects = query_service.findAllByQuery(
            'select p from Project as p ' \
            'where p.id = :id', params, ctx)
    
    print('Found %d Project(s) with ID %d in group private-1' %
            (len(projects), private_project_id))
    
    # Query for the private project we created using read-only-1
    #
    # You will notice that this does not return the Project as we have **NOT**
    # specified the group that the Project is in within the context
    # passed to the query service.
    ctx = {'omero.group': str(read_only_group.id.val)}
    params = ParametersI()
    params.addId(private_project_id)
    projects = query_service.findAllByQuery(
            'select p from Project as p ' \
            'where p.id = :id', params, ctx)
    
    print('Found %d Project(s) with ID %d in group read-only-1' %
            (len(projects), private_project_id))
    
    # Use the OMERO 4.3.x introduced delete service to clean up the Projects
    # we have just created.
    handle = session.submit(Delete('/Project', private_project_id, None))
    try:
        callback = CmdCallbackI(client, handle)
        callback.loop(10, 1000)  # Loop a maximum of ten times each 1000ms
    finally:
         # Safely ensure that the Handle to the delete request is cleaned up,
         # otherwise there is the possibility of resource leaks server side that
         # will only be cleaned up periodically.
         handle.close()
    handle = session.submit(Delete('/Project', read_only_project_id, None))
    try:
        callback = CmdCallbackI(client, handle)
        callback.loop(10, 1000)  # Loop a maximum of ten times each 1000ms
    finally:
        handle.close()


Example output:

::

    Created Project:113 in group private-1
    Created Project:114 in group read-only-1
    Found 1 Project(s) with ID 113 in group private-1
    Found 0 Project(s) with ID 113 in group read-only-1


Advanced queries
^^^^^^^^^^^^^^^^

In OMERO 4.4.0, cross group querying was reintroduced. Again, we make use of 
the Ice context object. Through this object, and manipulations thereof, we can 
expand our query context to span all groups via the use of ``-1``. What 
follows is a series of example queries using contexts that span all groups.

Querying data across groups
"""""""""""""""""""""""""""

::

    #!python
    from omero.model import *
    from omero.rtypes import *
    from omero.sys import ParametersI
    from omero.cmd import Delete, DoAll
    from omero.callbacks import CmdCallbackI
    
    # Session that has already been created for user-2
    session = client.getSession()
    
    # Project object instantiation
    private_project = ProjectI()
    private_project.name = rstring('private-1 project')
    read_only_project = ProjectI()
    read_only_project.name = rstring('read-only-1 project')
    
    # Retrieve the services we are going to use
    update_service = session.getUpdateService()
    admin_service = session.getAdminService()
    query_service = session.getQueryService()
    
    # Groups we are going to write data into
    private_group = admin_service.lookupGroup('private-1')
    read_only_group = admin_service.lookupGroup('read-only-1')
    
    # Save and return our two projects, setting the context correctly for each.
    # ALL interactions with the update service where NEW objects are concerned
    # must be passed an explicit context and NOT '-1'.  Otherwise the server
    # has no idea which set of owners to assign to the object when persisted.
    ctx = {'omero.group': str(private_group.id.val)}
    private_project = update_service.saveAndReturnObject(private_project, ctx)
    ctx = {'omero.group': str(read_only_group.id.val)}
    read_only_project = update_service.saveAndReturnObject(read_only_project, ctx)
    
    private_project_id = private_project.id.val
    read_only_project_id = read_only_project.id.val
    print('Created Project:%d in group private-1' % (private_project_id))
    print('Created Project:%d in group read-only-1' % (read_only_project_id))
    
    # Query for the private project we created using private-1
    # 
    # You will notice that this returns both Projects as we have specified
    # '-1' in the context passed to the query service.
    ctx = {'omero.group': '-1'}
    params = ParametersI()
    params.addIds([private_project_id, read_only_project_id])
    projects = query_service.findAllByQuery(
            'select p from Project as p ' \
            'where p.id in (:ids)', params, ctx)
    
    print('Found %d Project(s)' % (len(projects)))
    
    # Use the OMERO 4.3.x introduced delete service to clean up the Projects
    # we have just created. The delete service uses '-1' by default for all its
    # internal queries.  We are also introducing the 'DoAll' command, which
    # allows for the aggregation of 'Delete' commands.
    delete_requests = [
        Delete('/Project', private_project_id, None),
        Delete('/Project', read_only_project_id, None)
    ]
    handle = session.submit(DoAll(delete_requests))
    try:
        callback = CmdCallbackI(client, handle)
        callback.loop(10, 1000)  # Loop a maximum of ten times each 1000ms
    finally:
        # Safely ensure that the Handle to the delete request is cleaned up,
        # otherwise there is the possibility of resource leaks server side that
        # will only be cleaned up periodically.
        handle.close()


Example output:

::

    Created Project:117 in group private-1
    Created Project:118 in group read-only-1
    Found 2 Project(s)


Querying data across users in the same group
""""""""""""""""""""""""""""""""""""""""""""

Through the use of an ``omero.sys.ParametersI`` filter, restricting a query to 
a given user is possible. For the purposes of these examples, we will assume 
that both ``user-2`` and ``user-3`` have a single project each in the 
``read-only-1`` group.

::

    #!python
    from omero.model import *
    from omero.rtypes import *
    from omero.sys import ParametersI
    
    # Session that has already been created for user-2
    session = client.getSession()
    
    # Retrieve the services we are going to use
    admin_service = session.getAdminService()
    query_service = session.getQueryService()
    
    # Groups we are going to query
    read_only_group = admin_service.lookupGroup('read-only-1')
    
    # Users we are going to query
    user_2 = admin_service.lookupExperimenter('user-2')
    user_3 = admin_service.lookupExperimenter('user-3')
    
    # Print the members of 'read-only-1'
    print('Members of "read-only-1" (experimenter_id, username): %r' %
        [(v.id.val, v.omeName.val) for v in read_only_group.linkedExperimenterList()])
    
    # Query for all projects
    ctx = {'omero.group': str(read_only_group.id.val)}
    projects = query_service.findAllByQuery(
            'select p from Project as p', None, ctx)
    print('All projects in "read-only-1" (project_id, owner_id): %r' %
        [(v.id.val, v.details.owner.id.val) for v in projects])
    
    # Query for projects owned by 'user-2'
    ctx = {'omero.group': str(read_only_group.id.val)}
    params = ParametersI()
    params.addId(user_2.id.val)
    projects = query_service.findAllByQuery(
            'select p from Project as p ' \
            'where p.details.owner.id = :id', params, ctx)
    print('Projects owned by "user-2" in "read-only-1" (project_id, owner_id): %r' %
        [(v.id.val, v.details.owner.id.val) for v in projects])
    
    # Query for projects owned by 'user-3'
    ctx = {'omero.group': str(read_only_group.id.val)}
    params = ParametersI()
    params.addId(user_3.id.val)
    projects = query_service.findAllByQuery(
            'select p from Project as p ' \
            'where p.details.owner.id = :id', params, ctx)
    print('Projects owned by "user-3" in "read-only-1" (project_id, owner_id): %r' %
        [(v.id.val, v.details.owner.id.val) for v in projects])


Example output:

::

    Members of "read-only-1" (experimenter_id, username): [(10L, 'user-2'), (9L, 'user-3')]
    All projects in "read-only-1" (project_id, owner_id): [(4L, 10L), (7L, 9L)]
    Projects owned by "user-2" in "read-only-1" (project_id, owner_id): [(4L, 10L)]
    Projects owned by "user-3" in "read-only-1" (project_id, owner_id): [(7L, 9L)]


.. _permissions object:

Utilizing the Permissions object
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Every object that is retrieved from the server via the query service, 
regardless of the context used, has a fully functional 
``omero.model.PermissionsI`` object. This object contains various methods to 
allow the caller to interrogate the operations that are possible by the 
current user on the object:

- :slicedoc_blitz:`canAnnotate() <omero/model/Permissions.html#canAnnotate>`
- :slicedoc_blitz:`canChgrp() <omero/model/Permissions.html#canChgrp>`
- :slicedoc_blitz:`canChown() <omero/model/Permissions.html#canChown>`
- :slicedoc_blitz:`canDelete() <omero/model/Permissions.html#canDelete>`
- :slicedoc_blitz:`canEdit() <omero/model/Permissions.html#canEdit>`
- :slicedoc_blitz:`canLink() <omero/model/Permissions.html#canLink>`

Troubleshooting permissions issues
----------------------------------

Data disappears after a change of the primary group of a user
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

As outlined above, changes were made so that by default queries do not span 
multiple groups and the 'Primary or Default Group' is essentially a deprecated 
concept. If you have multiple groups and you are attempting to make queries by 
switching the 'Active Group' via the ``setSecurityContext()`` method of an 
active session (``omero.cmd.SessionPrx``), those queries will be scoped only 
to that group. If you want your queries to act more like they did in 4.1.x, 
setting ``omero.group=-1`` will achieve that.

However, the reasons we made these changes have more to them than just API 
usage and the OMERO client history of only showing the data from one group at 
a time. Changing the 'Active Group' is both expensive because of the atomicity 
requirements the server enforces and can create dangerous concurrency 
situations. This is further complicated by the addition of the change group 
and delete background processes since 4.1.x. Manipulating a session's 'Primary 
or Default Group' during these tasks can have drastic effects. Changing the 
'Active Group' is forbidden if there are any stateful services 
(``omero.api.RenderingPrx`` for example) currently open.

In short, in OMERO |version_openmicroscopy| you absolutely **should not** be switching the 
'Primary or Default Group' of the user, or the 'Active Group' of a session, as 
a means to achieve cross group querying.

Listing other users' data in read-only groups
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In order to list other users' data associated with read-only 
groups of which you are a member, you can also use the context object and set 
the omero.group to -1. In addition, you can add a filter to the query to only 
select the other users' data. You can do this either by using the 
``omero.sys.ParametersI`` object's ``exp()`` method when using the 
``IContainer`` service, or by an explicit query when using ``IQuery`` service. 

Is the default group the primary group when not specifying the context?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The value of the ``groupId`` property of the ``omero.sys.EventContext`` is the 
"Active Group" for the created session. It can be modified as described above 
with the restrictions outlined. Unless the session has been created by means 
other than ``createSession()`` on an ``omero.client`` object, this will be the 
user's "Primary or Default Group." A user's 'Primary or Default Group' is the 
first group in the collection that describes the relation ``Experimenter <--> 
ExperimenterGroup``. It can be set by the ``setDefaultGroup()`` method on the 
``IAdmin`` service.

What about when importing data without specifying the context object?
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Exactly as outlined above. Import does nothing different or special. If you 
want the operating context of an import to be different from the default you 
must specify it as such.

Specifying the group context as -1 when deleting data
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There is no need to do this. Complete graphs cannot span multiple groups and 
queries are only (unless otherwise filtered) restricted at the group level and 
not at the level of the user. Furthermore, the delete service always 
internally performs all its queries in the ``omero.group=-1`` context unless 
another more explicit one is specified.

History
-------

The OMERO permissions model has had a significant overhaul from version 4.1.x 
to 4.4.x. Users and groups have existed in OMERO since well before the initial 
4.1.x releases and numerous permissions levels were possible in the 4.1.x 
series but it was largely assumed that an Experimenter belonged to a single 
Group and that the permissions of that Group were private.
 
The OMERO permissions system received its first significant update in 4.2.0 
with the introduction of multiple group support throughout the platform and 
group permissions levels. 

In a 4.1.x object graph ``Group`` containment was not enforced i.e. two linked 
objects (such as a ``Project`` and ``Dataset``) could in theory be members of 
two distinct ``Groups``. All objects continued to carry their permissions and 
those permissions were persisted in the database.

Things to note about 4.2.x permissions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Objects could not be moved between groups easily.
* It was not possible to reduce the permissions level of a group.
* The delete service (introduced in OMERO 4.2.1) was made aware of the 
  permissions system.
* 'Default Group' switching was required to make queries in different 
  permissions contexts.

.. note:: Queries span only one group at a time. Inserts and updates as other 
          users must be done by creating a session as that user.

Changes for OMERO 4.4.x
^^^^^^^^^^^^^^^^^^^^^^^

The second major OMERO permissions system innovations were performed in 4.4.0:

* Cross group querying was reintroduced.
* Change group was enabled, allowing the movement of graphs of objects between 
  groups.
* Permissions level reduction was made possible for read-annotate to read-only 
  transitions.
* A thorough user interface review resulted in the following features being made available in the UI:
   - single group browsing and user-switching (available since 4.4.0)
   - browsing data across multiple groups (available since 4.4.6 and refined in 4.4.7)
* The concept of a 'Default or Primary Group' was deprecated.

.. note:: Queries, inserts and updates span ``any`` or ``all`` groups and ``any`` user via options flags.

Changes for OMERO 5.4.x
^^^^^^^^^^^^^^^^^^^^^^^

OMERO 5.4.0 included Restricted Administrators as a new user role. See
:doc:`/sysadmins/restricted-admins` and :doc:`LightAdmins` for
more information.

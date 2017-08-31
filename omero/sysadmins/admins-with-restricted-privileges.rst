Administrators with restricted privileges
=========================================


Summary
-------

OMERO allows you to create administrators with a subset of the full
administrator privileges. This is a way to cater for the need for
more powerful users acting on behalf of all other OMERO users,
with no group membership but with access to all groups and data of
all users in OMERO. This should be achieved without creating new
full administrators in OMERO.
In the real world, these administrators with restricted privileges
(restricted admins) will typically be imaging
facility managers, image analysts, or anybody who needs to organize
users and data of others in OMERO.

Full administrators in OMERO can create new administrators with
restricted privileges using the OMERO.web interface, see the
:help:`create new users <sharing-data#admin>` section of our Help
documentation. OMERO.cli does not yet support easy management of
restrictions nor does it offer the helpful :doc:`permissions mapping
<mapping-restricted-admins>` so we do not recommend :doc:`using
OMERO.cli to adjust the restrictions <cli/light-admins>` on an
administrator.

We suggest here four setups that should cover the four mainstream
workflows. Nevertheless, you can combine the privileges
(check the checkboxes in the OMERO.web interface)
in any way you see fit. The privileges were designed in such a way
that they still bear useful functionality even when used in
isolation. For example checking the :term:`Chown` checkbox will
give the new administrator with restricted
privileges the power to transfer ownership of other users' data.
For exact server-side definitions of the privileges displayed
in OMERO.web interface see :doc:`/sysadmins/mapping-restricted-admins`.

Four suggested workflows
------------------------

=============================== ======================= ======================= ===================== ================================
Required Privileges             :term:`Data viewer`     :term:`Importer`        :term:`Analyst`       :term:`Group and Data Organizer`
------------------------------- ----------------------- ----------------------- --------------------- --------------------------------
:term:`Sudo`                                      N                     Y                      N                       N
:term:`Write Data`                                N                     N                      Y                       Y
:term:`Delete Data`                               N                     N                      N                       Y
:term:`Chgrp`                                     N                     N                      N                       Y
:term:`Chown`                                     N                     N                      Y (O)                   Y
:term:`Create and Edit Groups`                    N                     N                      N                       Y
:term:`Create and Edit Users`                     N                     N                      N                       Y
:term:`Add Users to Groups`                       N                     N                      N                       Y
:term:`Upload Scripts`                            N                     N                      Y                       N

=============================== ======================= ======================= ===================== ================================

Y
    privilege required, checkbox in OMERO.web interface is checked
N
    privilege not required, checkbox is not checked
O
    privilege optional for the workflow

.. note::
    **Restricted admins workflows in OMERO.clients** Please do not
    expect for any workflows mentioned here that all OMERO.clients
    OMERO.web, OMERO.insight, command line interface (CLI) are fully
    equipped to execute them (see details below). New features will
    be added in OMERO.clients in the 5.4.x series of OMERO releases.

.. note::
    **Group membership** All the workflows here assume that
    the administrator with restricted privileges is not a member of
    any group except the System group. This does not preclude such
    administrator from being a member of any number of groups.
    Inside the groups the restricted admin is a member of, they
    have the same privileges as other group members of that group
    additionally to their administrative privileges.

.. note::
    **Deleting privileges** :term:`Sudo` privilege includes ability
    to delete the data of the user whom the administrator
    is working on behalf of. If you want to prevent the restricted admin from
    Deleting others data entirely, do not give :term:`Delete Data`
    and do not give :term:`Sudo` privileges.

.. note::
    **Privilege escalation** The administrators with restricted privileges
    (restricted admins) are prevented from escalation of their privileges.
    Creation of a restricted admin with higher privileges than the creator,
    and creation of a full administrator, are prevented. Furthermore,
    although a restricted admin can Sudo on behalf of a full administrator,
    their privileges will not expand to the full administrator privilege set
    by this action. See also :term:`Sudo`.

.. _Workflow 1:

Workflow 1: Data viewer
-----------------------
If you do not give any explicit privileges to the administrator with
restricted privileges, this administrator still has some useful
privileges.
These include browsing and viewing all the data of all users in all
groups (including the groups where they are not members).
The administrator with restricted privileges
is also able to Download all the data in all types of groups.
Furthermore, they can view user and group information, such as usernames,
e-mail addresses, group permission levels and lists of all users
and groups. They are not able to annotate, edit or delete any of the
data or change any user or group information though. Note that any
administrator with restricted privileges described below or otherwise
created combining the privileges at will would be able to perform the
Data viewer workflow as well.

Client Details:

- OMERO.insight: is not designed to show any groups or data you are not
  a member of. The Data Viewer workflow is preferably
  executed using OMERO.web or CLI

- OMERO.web: Allows viewing and downloading the data,
  see :help:`Viewing Data <viewing-data>`.

- CLI: Allows listing all images, groups and users and downloading the data::

    # List all users on server
    $ bin/omero user list
    # List all groups on server
    $ bin/omero group list
    # List all images on server
    $ bin/omero fs images

.. _Workflow 2:

Workflow 2: Importer
--------------------
The Importer role is to import images into OMERO for other users,
i.e. in such a manner that the imported images are owned by the users
in OMERO, not by the user in the role of the Importer. The Importer role is
typically used by an imaging facility
manager who is importing data acquired by users on microscopes into OMERO.

The importer workflow can be achieved with only the :term:`Sudo`
privilege (first line in the above table). This privilege allows them
to "become" the user they are importing the data for.
The Importer role may need to reorganize
the imported data. For example, they made a mistake, Sudoed as
a wrong user in a wrong group and need to rectify the mistake using
the command line interface (CLI) client. Whilst being sudoed, the
Importer role can Delete the wrongly imported data (even without Delete
privilege given, see the Note above), logout, login and :term:`Sudo` as
the correct user and repeat the import process. In short, whilst Sudoed,
Importer role can do any action which the user they are becoming is
allowed to do. In case any more post-import cleaning and data
organizing is necessary for Importer, this might be enabled by giving
them also privilege necessary for the Data
organizers (see :ref:`Workflow 4` below).

If you have any doubts about giving the administrators with restricted
privilege the :term:`Sudo` privilege (which implicitly gives the ability
to delete other users' data), there are two workarounds which enable
import for others without :term:`Sudo`.

The first, simpler, workaround involves importing the data as Importer
into the group of the future data owner and then transferring
the ownership of the data (see details in :ref:`Workflow 3`).
The second workaround involves importing into the group of the Importer
as the importer, then moving the data into the group of the prospective
data owner and then changing the ownership of the data to the owner
(necessary tools are described in :ref:`Workflow 3`).

Client details:

- OMERO.importer or OMERO.insight: You have to be a member of the group
  you want to import to in OMERO.importer or OMERO.insight. Login as the
  administrator with restricted privileges and perform the import for
  others as described in the chapter of the Help documentation
  :help:`import for others <facility-manager#import>`.

- CLI: (see also the videos on import on the
  `OME YouTube channel
  <https://www.youtube.com/channel/UCyySB9ZzNi8aBGYqcxSrauQ>`_)::

    # Login as the Importer and sudo as the user you want to import for
    $ bin/omero --sudo Importer -u user login
    # Create new containers belonging to the user
    $ bin/omero obj new Dataset name=Dataset-of-user
    $ bin/omero obj new Project name=Project-of-user
    # Link the containers
    $ bin/omero obj new ProjectDatasetLink parent=Project:17 child=Dataset:13
    # Import into created Dataset
    $ bin/omero import ~/Desktop/CMPO1.png -T Dataset:name:Dataset-of-user

.. _Workflow 3:

Workflow 3: Analyst
-------------------
Typically, the Analyst role in OMERO is to

- read the data (always possible, see :ref:`Workflow 1`: Data viewer)
- change and save the rendering settings of the images (enabled by
  :term:`Write Data` privilege, exception is
  Private groups, where they cannot save rendering settings)
- annotate the data (enabled by :term:`Write Data` privilege, but not
  possible in Private groups)
- draw and save ROIs on other users' images (enabled by :term:`Write Data`
  privilege, but no saving in Private groups possible)
- upload and attach result files to the analyzed images (enabled by
  :term:`Write Data` privilege, except Private groups, where attaching
  is not possible)
- create Projects and Datasets for newly imported images in groups they
  are not a member of (enabled by :term:`Write Data` privilege)
- import new images resulting from image analysis into these Projects and Datasets
- link new images resulting from image analysis to existing Projects and Datasets
  of the original data owner (enabled by :term:`Write Data` privilege)
- (possibly) changing the ownership of the newly created conainers and
  contained result images to the users (enabled by :term:`Chown` privilege)
- upload, edit and delete official scripts usable by all OMERO users
  (enabled by :term:`Upload Scripts` privilege)

Client details:

- OMERO.insight or Insight-ImageJ plugin: Analyst has to be a member of the
  group where the data is located. They can draw ROIs and extract analysis
  results from the ROIs and data in any type of group. They can save ROIs
  except in Private groups. They can upload official scripts in
  OMERO.insight (any group type, Analyst does not have to be a member of
  any particular group for script upload in OMERO.insight).

- OMERO.web, OMERO.insight, Insight-ImageJ plugin: Analyst can adjust
  rendering settings and save them, upload
  attachments with results and annotate (for example tag, key-value pairs,
  rating, commenting). These actions are not permitted in Private groups
  with images belonging to others.
  See :help:`rendering <managing-data#rendering>`,
  :help:`annotating <managing-data#annotating>`,
  :help:`attaching files <managing-data#attach>`,
  :help:`attaching data <managing-data#attach>`.

- CLI: Upload of official scripts is allowed (in any group type,
  see :doc:`/developers/scripts/user-guide` and below).
  Upload of attachments with results, annotating
  (not in private group), creating containers, import of resulting images
  into groups you are not a member of (in private groups these are invisible
  for the owner of the original data, unless you transfer their ownership),
  transferring ownership of these containers (any group type),
  transferring ownership of objects
  (images, annotations, ROIs, uploaded attachments with results)
  is possible too.::

    # Upload an official script
    $ bin/omero script upload --official /PATH/TO/YOUR_SCRIPT
    # Login to the group the original data are in
    $ bin/omero -g testgroup login
    # Create new Dataset
    $ bin/omero obj new Dataset name=new-dataset
    # Import result images into the Dataset
    $ bin/omero import -T Dataset:name:new-dataset /PATH/TO/RESULT/IMAGES
    # Transfer the ownership of the Dataset and
    # of the contained images to the user with ID:55
    $ bin/omero chown 55 Dataset:112

.. _Workflow 4:

Workflow 4: Group and Data Organizer
------------------------------------
Group and Data Organizer role is for creation of new
users and groups in OMERO and allocating the users to appropriate groups.
It is also possible to change the users' information such as e-mail and
to change group permissions level. These tasks are facilitated by the
privileges :term:`Create and Edit Groups`,
:term:`Create and Edit Users` and :term:`Add Users to Groups`.

The Group and Data Organizer might also be tasked with dealing with data
owned by OMERO users who have left the institution. The Organizer can
transfer ownership of the data owned by the leaving person
(facilitated by the :term:`Chown` privilege) to another user.
In cases where the new owner of the data may not be a member of
the data group, the Organizer first moves the data
between groups (facilitated by the :term:`Chgrp` privilege), and then
transfers the ownership of the data. Always try to avoid the situation
where owner of the data is not in data group.

For moving data between groups, usage of OMERO.web is highly recommended.
The Organizer can create new containers (Projects, Datasets) on behalf of
data owner in OMERO.web conveniently as part of the Move to Group command in
OMERO.web (:help:`Move to Group <group-owner#move>`). The containers and
links of data to containers will belong to data owner. For new container
creation and linking, the :term:`Write Data` privilege is necessary.
CLI can be used for the move action as well,
see :doc:`/users/cli/chgrp`.

In case of data owner not being in the group where the data is,
the Organizer can also add the data owner to the
data group (facilitated by the :term:`Add Users to Groups` privilege),
instead of moving the data. The Organizer will transfer
the ownership of the data to the new owner only after they have added
the new data owner to the data group.

During all data manipulation steps, the Organizer needs
the :term:`Write Data`
privilege to create new Projects, Datasets or Screens
for the new owners of the
data and to link the data to those containers or to already
existing containers owned by the new owner. Since OMERO 5.4.0,
OMERO.web enables Organizers with :term:`Write Data` privilege
to create new containers belonging to other users,
see the :help:`OMERO.web in Data structure <facility-manager#data>`
section of our Help documentation.
Except the links created during
creation of new Datasets inside others' Projects in OMERO.web,
any links created by the Organizer will belong to the Organizer,
not the owner of the data. This
will be addressed in OMERO.web in the 5.4.x series. The ownership transfer
of the containers and links can be done later on the CLI. Linking of
others' data is never possible in Private groups.

After the Organizer has dealt with the data, they can remove the leaving
person from any group (included in the :term:`Add Users to Groups` privilege)
and make the user inactive (facilitated by the :term:`Create and Edit Users`
privilege).

Note that the ownership of data of a user can be trasferred either
piecemeal, i.e. specifying each Project or Dataset to transfer (using
``omero chown`` command of CLI), or all of the data of the user can be
transferred in one step. The transfer of all the data of the user in one
step has to be considered an advanced feature and might be possibly
slow in case of larger complexity of the transferred data.

Quite naturally the Group and Data Organizer can be easily split into two
separate roles, with the Group Organiser role having
:term:`Create and Edit Groups`,
:term:`Create and Edit Users`, :term:`Add Users to Groups` privileges, and
the Data Organiser role having :term:`Write Data`, :term:`Delete Data`,
:term:`Chgrp`, :term:`Chown` privileges. It is of course possible to use any
combination of these privileges as you see fit.
It is recommended to always grant :term:`Create and Edit Users` with
:term:`Add Users to Groups` so that the new restricted administrator is able
to deactivate users.

Client Details:

- OMERO.web: All the Data Organizing actions are possible, except transfer
  of ownership (possible only in CLI, will be addressed in the 5.4.x
  series). Creation of Projects, Datasets
  or Screens for other users in OMERO.web is possible since OMERO 5.4.0,
  see :help:`Data structure (OMERO.web) <facility-manager#data>`.
  All the Group and User Organizing actions are possible if all
  :term:`Create and Edit Groups`, :term:`Create and Edit Users` and
  :term:`Add Users to Groups` privileges are given. It is also reasonable
  to give :term:`Create and Edit Users` and :term:`Add Users to Groups`
  or :term:`Create and Edit Groups` and :term:`Add Users to Groups`. These
  combinations give the restricted adiminstrator good user interface
  experience in OMERO.web.

- CLI: See examples below for CLI features
  useful for Group and Data Organizing::

    # Create new user and put them into 2 groups
    $ bin/omero user add username firstname lastname group1 group2
    # Edit login name of a user with ID:55
    $ bin/omero obj update Experimenter:55 omeName=new-login-name
    # Add a user to a group named "testgroup"
    $ bin/omero group adduser --name testgroup --user-name newbieingroup
    $ bin/omero group removeuser --name testgroup --user-name thegoner
    # Make a user a group owner. Works also when the owner-to-be
    # is already a member of the group
    $ bin/omero group adduser --name group --user-name ownertobe --as-owner
    # Remove a group owner from ownership of the group. Does not remove
    # the formerowner from group, just unsets the ownership.
    $ bin/omero user leavegroup testgroup --name formerowner  --as-owner
    # Move a Dataset hierarchy to group 5 and include all annotations
    # on the Dataset and objects linked to the Dataset
    $ bin/omero chgrp 5 Dataset:51 --include Annotation
    # Transfer ownership to user 55 of the Project 112
    $ bin/omero chown 55 Project:112
    # Transfer the ownership of a Project-Dataset link. Useful in case the
    # link was created by the Organizer and links objects of others
    $ bin/omero chown 55 ProjectDatasetLink:123
    # Transfer the ownership of Dataset-Image link
    $ bin/omero chown 55 DatasetImageLink:154
    # Transfer all data of user 5 to user 11 (advanced, might be slow)
    $ bin/omero chown 11 Experimenter:5

Key
^^^

.. glossary:: :sorted:

    Sudo
        Administrator can log in as another user, with all the permissions
        of that user. When the restricted admin is working on
        behalf of a user and using Sudo, their privileges are a common least
        denominator of the privileges of the user and of the restricted
        admin. See also Note on privilege escalation,
        Note on Delete and :ref:`Workflow 2` for more details.

    Write Data
        Administrator can create data in groups of which he/she is not
        a member. Also allows annotating, adding attachments to and editing
        and linking of other users' data.
        See :ref:`Workflow 3` for more details.

    Delete Data
        Administrator can delete other users' data. See Note on Delete
        for more details. Integral part of :ref:`Workflow 4`.

    Chgrp
        Administrator can move others' data to a different Group.
        See :ref:`Workflow 4` for more details.

    Chown
        Administrator can transfer others' data to a different Owner.
        See :ref:`Workflow 4` for more details.

    Create and Edit Groups
        Administrator can create and edit groups (but not add or
        remove users). See :ref:`Workflow 4` for more details.

    Create and Edit Users
        Administrator can create and edit other users (but not add
        them to groups). See :ref:`Workflow 4` for more details.

    Add Users to Groups
        Administrator can add or remove users to groups. 
        See :ref:`Workflow 4` for more details.

    Upload Scripts
        Administrator can upload "official" OMERO.scripts to the server.
        See :ref:`Workflow 3` for more details.

    Data Viewer
        Administrator who views and downloads data of others.
        See more details in :ref:`Workflow 1`.

    Importer
        Administrator who imports images into OMERO for other users.
        The imported images are owned by the users in OMERO, not by
        the Importer. This is typically an imaging facility manager
        who is importing data acquired by users on microscopes into OMERO.
        See more details in :ref:`Workflow 2`.

    Analyst
        Administrator who performs image analysis on others' images in OMERO.
        See more details in :ref:`Workflow 3`.

    Group and Data Organizer
        Administrator who creates new users and groups in OMERO and allocates
        or removes the users to or from appropriate groups. This
        administrator also deals with data left after OMERO users which left
        the institution, or otherwise is tasked with reorganizing of others'
        data. See more details in :ref:`Workflow 4`.

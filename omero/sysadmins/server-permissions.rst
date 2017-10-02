Groups and permissions system
=============================

.. seealso:: :doc:`/developers/Server/Permissions`


Summary
-------

A user may belong to one or more groups, and the data in a group
may **at most** be shared with users in the same group on the same
OMERO server. The degree to which their data is available to other
members of the group depends on the permissions settings for that
group. Whenever a user logs on to an OMERO server, they are connected
under one of their groups. All data they import and any work that is
done is assigned to the current group, however the user can now
easily move their data into another group.

Users
-----

.. glossary::


    **Administrator**
        Your OMERO server will have one or more
        administrators. Each group can be administrated by any of your server
        administrators. The administrators control all settings for groups.

    **Group owner**
        Your group may have one or more owners. The group
        owner has some additional rights within each group compared to a
        standard group member, including the ability to add other members to
        the group.

    **Group member**
        This is the standard user.

    **Restricted Administrators**
        New in OMERO 5.4.0, these administrators can be created with a subset
        of privileges allowing trusted users to act on behalf of all other
        OMERO users for a defined set of tasks. See
        :doc:`/sysadmins/restricted-admins` for further
        information.

Groups and users must be created by the server administrator or a restricted
administrator with the correct privileges. Users can then be added by the
administrator (either a full admin or a restricted admin with the correct
privileges) or by one of the group owners
assigned by the administrator. This would typically be the PI of the
lab. The group's owners or administrators can also choose the
permission level for that group. See the :help:`Help guide for managing groups
<sharing-data.html#owner>` for more information about how to administrate them
in OMERO.

Group permission levels
-----------------------

The various permission levels are:

.. glossary::


   **Private**
      This group is the most restrictive:
      
      -  A private :term:`Group owner` can see and control who the group
         members are and can view their data.
      -  As a :term:`Group member`, you will only ever be able to see your
         own data.
      -  This can be used for general data storage, access and analysis, but
         has very limited collaboration potential other than for the
         :term:`Group owner` to see other group members' data.
      
      **Potential use cases of Private group:**
      
      -  A PI as :term:`Group owner` and
         their student, as a :term:`Group member`, can access the student's
         data. A student might use this as somewhere to store all of their
         data and from here, the PI and/or student might decide which data
         could/should be copied into a more collaborative group where
         additional members would also be able to view the data.
      -  An institutional repository type structure where data are being
         archived, but not necessarily open for general viewing.

   **Read-only**
      This group is the intermediate option that allows visibility of other
      users and their data, but minimal ability to annotate their data:
      
      -  The :term:`Group owner` can control group members as above and can
         perform some annotations on the other group members data.
      -  :term:`Group member` can see who other members are and view their
         data, but cannot annotate another members' data at all.
      
      **Potential use cases of Read-only group:**
      
      -  A scientist might move data into a read-only group when they want
         other group members to access and view their data. Their PI, as a
         group owner could then annotate and/or add Regions of Interest
         (ROIs) to their images.
      -  For an institutional repository where data are being archived and
         then available for other users in the institute to view; this could
         be standard storage of all original data, or for data that is
         included in publications.

   **Read-annotate**
      This is a more collaborative group:
      
      -  :term:`Group member` can view other members, their data and can
         make annotations on those other members' data.
      
      **Potential use cases of Read-annotate group:**
      
      -  This could be used by a group of scientists working together with
         data for a publication.

   **Read-write**
      This group essentially allows all the group members to behave as if
      they co-own all the data:
      
      -  :term:`Group member` can view, annotate, edit and **delete** all
         data; the only restriction is that they cannot move other members'
         data into another group.
      
      **Potential use cases of Read-write group:**
      
      -  A group of scientists working in a completely collaborative way,
         trusting every member of the group to have equal rights and access
         to all the data.


.. note:: Restricted administrators are designed to work independently of
    group permissions. They act as full administrators when using their subset
    of privileges, allowing them to perform actions on data belonging to other
    users even in private groups (see the permissions tables below).

.. seealso::

    :help:`Help guide for sharing data <sharing-data.html>`
     Workflow guide covering the groups and permissions system

Changing group permissions
--------------------------

It is possible for the :term:`Group owner` or server :term:`Administrator` to
change the permissions level on a group after it has been created and filled
with data, with the following limitations:

-  It is not possible to 'reduce' permissions to :term:`Private` if the group
   contains a projection made by one member from data owned by another user.
   In other circumstances, reducing permissions to private will warn of loss
   of annotations etc. as noted below, but will still be possible.
-  Only :term:`Administrator` can promote a group to :term:`Read-write`
   permissions. **Make certain all the members understand that this allows
   anyone in the group to permanently delete any of the data before performing
   this action.**

.. warning:: Please be very careful before downgrading a group's
    permission level. If a user has annotated other users' data and
    the group is downgraded, any links to annotations that are not
    permitted by the new permissions level will be lost.


Permissions on your and other users' data
-----------------------------------------

**What can you do with your data?**

All OMERO users in all groups can perform all actions on their own data.

The main actions available include, but are not limited to:

-  create projects and/or datasets
-  import data
-  delete data
-  edit names and descriptions of images
-  change rendering settings on images
-  annotate images (rate, tag, add attachments and comments)
-  de-annotate (remove annotations that you have added)
-  use Regions of Interest (ROIs) (add, import, edit, delete, save and analyze
   them)
-  run scripts
-  move data between groups, if you belong to more than one group

**What can you do with someone else's data in your group?**

Actions available for you on someone else in your group's data will
depend both on the permissions of the group you are working in, and what
sort of user you are. See the table below for a quick reference
guide to permissions available on other people's data.

Some of these policies may evolve as the permissions functionality
matures in response to user feedback. Please let us know any comments or
suggestions you have via our :community:`mailing lists or forums <>`.

Permissions tables
------------------

The following are the permissions valid for users working on data belonging to
other group members. These permissions depend on the group permissions and on
the type of the user performing the action.

**Restricted administrators act as full administrators when using their
subset of privileges. For all actions which are not covered by their
privileges subset, they act as standard group members.** For
example, a data analyst with write data privileges can edit data even in a
private group (without having to be a member of that group) but without the
delete privilege they cannot delete data belonging to another user unless that
data is in a read-write group they are a member of. All restricted
administrators can view and download any data regardless of group type and
their subset of privileges. See
:doc:`/sysadmins/restricted-admins` for further information.

|

:term:`Administrator`
^^^^^^^^^^^^^^^^^^^^^

This table covers both full server administrators and restricted
administrators with the privileges required for these actions. Restricted
administrators act as group members for any actions that are not covered by
their subset of privileges.

|

=============================== ======================= ===================== ====================== ===================
:term:`Action`                      :term:`Private`      :term:`Read-only`     :term:`Read-annotate`  :term:`Read-write`
------------------------------- ----------------------- --------------------- ---------------------- -------------------
:term:`View`                              Y                      Y                       Y              Y
:term:`Annotate`                          N                      Y                       Y              Y
:term:`Delete`                            Y                      Y                       Y              Y
:term:`Edit`                              Y                      Y                       Y              Y
:term:`Move between groups`               Y                      Y                       Y              Y
:term:`Remove annotations`                Y                      Y                       Y              Y
:term:`Mix data`                          N                      Y                       Y              Y
=============================== ======================= ===================== ====================== ===================

|

:term:`Group owner`
^^^^^^^^^^^^^^^^^^^

|

=============================== ======================= ===================== ====================== ===================
:term:`Action`                      :term:`Private`      :term:`Read-only`     :term:`Read-annotate`  :term:`Read-write`
------------------------------- ----------------------- --------------------- ---------------------- -------------------
:term:`View`                              Y                      Y                       Y              Y
:term:`Annotate`                          N                      Y                       Y              Y
:term:`Delete`                            Y                      Y                       Y              Y
:term:`Edit`                              Y                      Y                       Y              Y
:term:`Move between groups`               N                      N                       N              N
:term:`Remove annotations`                Y                      Y                       Y              Y
:term:`Mix data`                              N                      Y                       Y              Y
=============================== ======================= ===================== ====================== ===================

|

:term:`Group member`
^^^^^^^^^^^^^^^^^^^^

|

=============================== ======================= ===================== ====================== ===================
:term:`Action`                      :term:`Private`      :term:`Read-only`     :term:`Read-annotate`  :term:`Read-write`
------------------------------- ----------------------- --------------------- ---------------------- -------------------
:term:`View`                              N                      Y                       Y              Y
:term:`Annotate`                          N                      N                       Y              Y
:term:`Delete`                            N                      N                       N              Y
:term:`Edit`                              N                      N                       N              Y
:term:`Move between groups`               N                      N                       N              N
:term:`Remove annotations`                N                      N                       N              Y
:term:`Mix data`                              N                      N                       N              Y
=============================== ======================= ===================== ====================== ===================


Key
^^^


.. glossary:: :sorted:



    Action
        Action on other users' data

    View
        View other users' data such as images. View ROIs added by others.
        Draw ROIs on other users' data, but they cannot be saved.

    Annotate
        Add annotations (rating, tag, attachment, comment ROI)
        to another users' data. Also create & save ROIs (save
        ROIs that you draw on another users' data).

    Render
        Create your own rendering settings (this will not
        modify the settings of the owner).

    Delete
        Delete data such as images or ROIs.  ROIs may have been
        added by others or yourself.

    Edit
        Modify the name or description of other users'
        objects such as images.

    Move between groups
        Only the admin has the right to move other users’
        data between groups.

        .. note::
            The admin does not have to be member of the
            destination group.

    Remove annotations
        Remove annotations made by others on your data.

    Mix data
        Copy, Move or Remove other users' data to or from your Projects,
        Datasets or Screens.
        Copy, Move or Remove your or others' data to or from others' Projects,
        Datasets or Screens.

        .. note::
            You should always be able to remove
            annotations (such as tags) that you linked to
            other users' data (you own the link).  The
            link can be deleted, but the tag itself will
            not be deleted.


Issues to be aware of
---------------------

ROIs
^^^^

-  You can never edit (change text or move) other users' ROI.
-  Any ROIs added to other users' data will not affect ROIs added by
   the owner.

Tags and attachments
^^^^^^^^^^^^^^^^^^^^

-  A tag or attachment is 'owned' by the person who creates it or
   uploads it to the server.
-  The link between a tag or an attachment is 'owned' by the person who
   annotates an image with that tag or attachment i.e. makes a link
   between the tag/attachment and the image.
-  De-annotation deletes the link between the tag/attachment and image
   but does not remove/delete the tag or attachment from the system.

Scripts
^^^^^^^

-  Although all users can run scripts on other users' data, the actions
   within those scripts will be subject to the restrictions of the
   permissions detailed in the tables above.

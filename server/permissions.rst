Permissions
===========

Contents

In the 4.4 release of OMERO, the groups and permissions system has been
revamped to allow users to share data with more control. **Users can now
copy data between groups that they are a member of**.

Overview
--------

A user may belong to one or more groups, and the data in a group may now
**at most** be shared with users in the same group on the same OMERO
server. The degree to which their data is available to other members of
the group depends on the permissions settings for that group. Whenever a
user logs on to an OMERO server, he/she is connected under one of
his/her groups. All data he/she imports and any work that is done is
assigned to the current group, however now in 4.4 the User can easily
copy their data into another group.

Users
-----

-  **Administrator**: Your OMERO server will have one or more
   administrators. Each group can be administrated by any of your server
   administrators. The administrator(s) control all settings for groups.
-  **Group Owner**: Your group may have one or more owners. The group
   owner has some additional rights within each group than a standard
   group member, including the ability to add other members to the
   group(s).
-  **Group Member**: This is the standard user.

Groups and Users must be created by the server administrator. Users can
then be added by the administrator or by one of the group owners
assigned by the administrator. This would typically be the PI of the
lab. The group's owners or server administrator can also choose the
permission level for that group. See the insight and web admin movies
below for more information about groups and how to administrate them in
OMERO.

+------------------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------+
| `|image46|\ Insight Admin update in OMERO 4.4 <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-4/mov/InsightAdmin-4.4.mov>`_   | `|image47|\ Web Admin update in OMERO 4.4 <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-4/mov/WebAdmin-4.4.mov>`_   |
+------------------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------+

Group Permission Levels
-----------------------

The various permission levels are:

Private group
~~~~~~~~~~~~~

This group is the most restrictive:

-  A private group owner can see and control who the group members are
   and can view their data.
-  As a member, you will only ever be able to see your own data.
-  This can be used for general data storage, access and analysis, but
   has very limited collaboration potential other than for the group
   owner to see other group members' data.

**Potential Use-Cases:**

-  This group would be designed so that a PI as group owner and their
   student, as a group member, can access the student's data. A student
   might use this as somewhere to store all of their data and from here,
   the PI and/or student might decide which data could/should be copied
   into a more collaborative group where additional members would also
   be able to view the data.
-  For an institutional repository type structure where data are being
   archived, but not necessarily open for general viewing.

Read-only
~~~~~~~~~

This group is the intermediate option that allows visibility of other
users and their data, but minimal ability to annotate their data:

-  Read-only group owner can control group members as above and can
   perform some annotations on the other group members data.
-  Members can see who other members are and view their data, but they
   cannot annotate another users data at all.

**Potential Use-Cases:**

-  A scientist might move data into a read-only group when they want
   other group members to access and view their data. Other members can
   view, while the group owners can annotate and/or add ROIs to the
   other user's images.
-  For an institutional repository where data are being archived and
   then available for other group members in the institute to view; this
   could be standard storage of all original data, or for data that is
   included in publications.

Read-annotate
~~~~~~~~~~~~~

This is the most collaborative group:

-  Group members can view other users, their data and can make
   annotations on those other users' data.

**Potential Use-Cases:**

-  This could be used by a group of scientists working together with
   data for a publication.

+------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------+
| `|image50|\ Insight Permissions update in OMERO 4.4 <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-4/mov/InsightMultiGroups-4.4.mov>`_   | `|image51|\ Web Permissions update in OMERO 4.4 <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-4/mov/WebMultiGroups-4.4.mov>`_   |
+------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------+

Changing a Groups Permissions
-----------------------------

It is possible for the group owner or server administrator to change the
permissions level on a group after it has been created and populated
with data, with the following limitations:

-  It is not possible to 'reduce' permissions to 'Private'. Once links
   have been created in the database under Read-only or Read-annotate
   permissions, these cannot be severed. However, it is possible to
   'promote' a Private group to be a Read-only or Read-annotate group.
-  It is possible to toggle permissions of a group between the two
   collaborative Read-only and Read-annotate groups.

**Known Issue**

Please be very careful before downgrading a groups permission level. If
a User has annotated another User's data and the group is downgraded,
any links to annotations that are not permitted with the new permissions
setting will be lost.

Permissions On Your & Other Users' Data
---------------------------------------

**What Can you Do with Your Data?**

All OMERO Users in all groups can perform all actions to their own data.

The main actions available include, but are not limited to:

-  Create projects and/or datasets;
-  Import data;
-  Delete data;
-  Edit names and descriptions of images;
-  Change rendering settings on images;
-  Annotate images (rate, tag, add attachments and comment);
-  De-annotate (remove annotations that you have added);
-  Use ROIs (add, import, edit, delete, save and analyse with them);
-  Run scripts;
-  Move data between groups, if you belong to more than one group.

**What Can you Do with Someone Else's Data in Your Group?**

Actions available for you on someone else in your group's data will
depend both on the permissions of the group you are working in, and what
sort of User you are. See the two tables below for a quick reference
guide to permissions available on other people's data `sorted by the
group permissions <#table-ordered-by-group>`_ and `by user
type <#table-ordered-by-user>`_ .

Some of these policies may evolve as the permissions functionality
matures in response to user feedback. Please let us know any comments or
suggestions you have via our `mailing lists or through the
forums </site/community>`_.

Permissions Tables
------------------

The following are the permissions available to other users on other
group members data, depending on the group permissions and on your user
type. Note: No User can ever create projects or datasets, or import data
into another User's space. Note: Although all Users can run scripts on
other Users' data, the actions within those scripts will be subject to
the restrictions of the permissions detailed in these tables.

Ordered by Group Permissions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. |gm| replace::  Group member
.. |go| replace::  Group owner
.. |ad| replace::  Admin

.. |pg| replace:: Private Group
.. |ro| replace:: Read-only
.. |ra| replace:: Read-annotate

.. |Act| replace:: Action on other user's data 
.. |Vie| replace:: View data / View and draw ROIs
.. |Ann| replace:: Annotate / Create & save ROIs / Render
.. |Del| replace:: Delete / De-annotate / ROI delete
.. |Edi| replace:: Edit name
.. |Mov| replace:: Move data between groups
.. |Rem| replace:: Remove annotations made by others on your data

======= ====== ====== ====== ====== ====== ====== ====== ====== ======                                            	 
 \              |pg|                 |ro|                |ra|
------- -------------------- -------------------- --------------------
 |Act|   |gm|   |go|   |ad|   |gm|   |go|   |ad|   |gm|   |go|   |ad| 
======= ====== ====== ====== ====== ====== ====== ====== ====== ====== 
 |Vie|    N      Y      Y      Y      Y      Y      Y      Y      Y    
------- ------ ------ ------ ------ ------ ------ ------ ------ ------
 |Ann|    N      N      N      N      Y      Y      Y      Y      Y    
------- ------ ------ ------ ------ ------ ------ ------ ------ ------
 |Del|    N      Y      Y      N      Y      Y      N      Y      Y
------- ------ ------ ------ ------ ------ ------ ------ ------ ------
 |Edi|    N      N      N      N      Y      Y      N      Y      Y
------- ------ ------ ------ ------ ------ ------ ------ ------ ------
 |Mov|    N      N      Y      N      N      Y      N      N      Y
------- ------ ------ ------ ------ ------ ------ ------ ------ ------
 |Rem|    N      Y      Y      N      Y      Y      N      Y      Y
======= ====== ====== ====== ====== ====== ====== ====== ====== ======

Ordered by User Type
~~~~~~~~~~~~~~~~~~~~

======= ====== =========== ====== =========== ====== ====== ======
 \             |ad|               |go|                |gm|
------- ------------------ ------------------ --------------------
 |Act|   |pg|   |ro| /|ra|   |pg|   |ro|/|ra|   |pg|   |ro|   |ra| 
======= ====== =========== ====== =========== ====== ====== ======
 |Vie|    Y         Y        Y         Y        N      Y      Y   
------- ------ ----------- ------ ----------- ------ ------ ------
 |Ann|    N         Y        N         Y        N      N      Y    
------- ------ ----------- ------ ----------- ------ ------ ------
 |Del|    Y         Y        Y         Y        N      N      N   
------- ------ ----------- ------ ----------- ------ ------ ------
 |Edi|    N         Y        N         Y        N      N      N   
------- ------ ----------- ------ ----------- ------ ------ ------
 |Mov|    Y         Y        N         N        N      N      N   
------- ------ ----------- ------ ----------- ------ ------ ------
 |Rem|    Y         Y        Y         Y        N      N      N   
======= ====== =========== ====== =========== ====== ====== ======

Key (Actions Available)
~~~~~~~~~~~~~~~~~~~~~~~

.. |Deann-desc| replace:: Remove annotations (tag, attachment, comment) made by others. [Note that you should always be able to remove annotations (e.g. tag) that you linked to other users' data (you own the link). The link can be deleted, but the tag itself will not be deleted.]  

.. |Mov-desc| replace:: Only the admin has the right to move another user’s data between groups. NOTE: the admin does not have to be member of the destination group. 

============================= ===================================================================================
Action                        Description
============================= ===================================================================================
View data                     View ROIs added by others
View and draw ROIs            Draw ROIs on the other user's data, but they cannot be saved
----------------------------- -----------------------------------------------------------------------------------
Annotate                      Add annotations (rating, tag, attachment, comment ROI) to another user's data
Create & save ROIs            Save ROIs that you draw on another user's data
Render                        Create your own rendering settings (this will not modify the settings of the owner)
----------------------------- -----------------------------------------------------------------------------------
Delete                        Delete data e.g. image or ROI
De-annotate                   |Deann-desc|
ROI delete                    Ability to delete ROIs added by others or yourself 
----------------------------- -----------------------------------------------------------------------------------
Edit name                     Modify the name or description of someone else’s object e.g. image
----------------------------- -----------------------------------------------------------------------------------
Move data between groups      |Mov-desc|
============================= ===================================================================================


Issues to be Aware of
---------------------

ROIs
~~~~

-  You can never edit (change text or move) another user's ROI.
-  Any ROIs added to another user's data will not affect ROIs added by
   the owner.

Tags & Attachments
~~~~~~~~~~~~~~~~~~

-  A tag or attachment is 'owned' by the person who creates it or
   uploads it to the server.
-  The link between a tag or an attachment is 'owned' by the person who
   annotates an image with that tag or attachment i.e. makes a link
   between the tag/attachment and the image.
-  De-annotation deletes the link between the tag/attachment and image
   but does not remove/delete the tag or attachment from the system.

Scripts
~~~~~~~

-  Although all Users can run scripts on other Users' data, the actions
   within those scripts will be subject to the restrictions of the
   permissions detailed in the tables above.
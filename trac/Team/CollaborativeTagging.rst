20. Collaborative Tagging
~~~~~~~~~~~~~~~~~~~~~~~~~

` Permissions2.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-2/mov/Permissions2.mov>`_

-  **Prerequisite Need a 'Collaborative' group with at least 2 users.
   User1 has an image that has been tagged by User1 with their own tag.
   User 2 must be a member of 2 groups**

-  Log in to Insight as User2. Change into a different group from the
   'Collaborative' group. Log out.
-  Log back in to Insight, choosing the 'Collaborative' group at log-in
   dialog. Should log into that group.
-  Add User1 to browse...
-  Go to Tags. Browse tag -> image. Check Image owner is displayed.
-  Add tags to the image:

   -  A new tag, created by User2
   -  The tag owned by User1 that is already added by User1

-  When mousing over tags(in the right hand panel), info should show who
   owns each tag and who added it
-  User2 should be able to remove tags added by User2, regardless of who
   owns the tags
-  Filter by tags to display tags added by User2, by Others.
-  Browse Tags hierarchy and look for tags used by User2, but not owned
   by User2. Should include image tagged above.

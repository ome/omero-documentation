23. Web Admin Testing
~~~~~~~~~~~~~~~~~~~~~

-  Login

   -  Log in to the server's webadmin page as an admin (without SSL
      enabled)
   -  Log in to the server's webadmin page as an admin (with SSL
      enabled)

-  Drive Space Tab

   -  Check that drive space displays correctly
   -  if possible compare to actual drive space from the command prompt

-  One to one group test

   -  Create three groups with different privileges ('Private',
      'Collaborative read-only', 'Collaborative')
   -  Create three users and make them a member of each group
      (one-to-one)
   -  Edit one user, removing their current group and adding all other
      groups
      (` #2547 <http://trac.openmicroscopy.org.uk/omero/ticket/2547>`_)
   -  Choose one of the user and make him also as a member of rest of
      the groups
   -  Groups

      -  Add a test group, filling in all fields and setting the owner
         to yourself. Make the group 'Private'
      -  Edit the group, change the group to 'Collaborative'

   -  Scientists Tab

      -  Add a test user, filling in all fields and adding to new group
         above
      -  Select 'edit' for the test user from scientist list, confirm
         all fields are present
      -  Log into insight and webclient as the test user, confirm
         membership in above group

   -  Group (again)

      -  Edit group members, remove and add another user, save
      -  Re-enter group members, confirm test user is saved
      -  Log into insight and webclient, confirm test user group
         membership

   -  My Account

      -  Log into the test users' account in webclient and insight
      -  change password in each client, relog to confirm this works
      -  in webadmin/My Account, upload a test avatar photo to your
         profile
      -  in webclient, upload a test image, annotate the image and make
         sure your profile avatar shows up

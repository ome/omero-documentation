23.1 Insight Admin Testing
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Login

   -  Log in to Insight as as an admin (without SSL enabled)
   -  Log in to Insight as an admin (with SSL enabled)

-  New Experimenter

   -  Add a test user, filling in all fields and adding to 'default'
      group
   -  Select 'edit' for the test user from scientist list, confirm all
      fields are present
   -  Log into insight and webclient as the test user, confirm
      membership in 'default' group

-  New Group

   -  Add a test group, Make the group 'Private' (can't add users on
      creation)
   -  Edit the group, change the group to 'Collaborative'
   -  Edit group members, Copy and paste user created above from
      existing group into new group
   -  Log into insight and webclient, confirm test user group membership

-  My Account

   -  Log into the test users' account in webclient and insight
   -  change password in each client, relog to confirm this works

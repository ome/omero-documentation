19.1 Delete Permissions
~~~~~~~~~~~~~~~~~~~~~~~

For further background information please see wiki/Delete

**Prerequisites:**

-  Check that the delete option in menu is available or not depending on
   various permissions and also check using the delete key.

-  Create a rwr--- group, as a group member trying to delete another
   user's Dataset, or remove Datasets (resp. Plates) from Projects
   (resp. Screens). A user cannot delete anything that belongs to
   another user.

-  Create a rwrw-- group, as a group member trying to delete another
   user's Dataset, or remove Datasets (resp. Plates) from Projects
   (resp. Screens). A user cannot delete anything that belongs to
   another user.

-  Create a rwr--- as the group owner, delete a dataset, image, user's
   Dataset, or remove Datasets (resp. Plates) from Projects (resp.
   Screens). Make sure warning is displayed
    insight`#1672 </ome/ticket/1672>`_

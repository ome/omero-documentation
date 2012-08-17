4.2 Delete Image Dataset Project
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Prerequisite - on already created Images, Datasets, and Projects in 4
Manage and Organise.**

Delete Image - collaborative group

+-----------+-------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------+
| Insight   | Web                                                                                                               |
+===========+===================================================================================================================+====================================================================================================+
| **a.**    | In a collaborative group, one user should view an Image belonging to another user. Save rendering settings.       | In a collaborative group, one user should view an Image belonging to another user.                 |
+-----------+-------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------+
| **b.**    | The owner should try deleting the image (should work OK)  `#2963 </ome/ticket/2963>`_                             | The owner should try deleting the image                                                            |
+-----------+-------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------+
| **c.**    | Repeat the above test, with the non-owner also annotating the Image with Tag, Rating and Comment                  | Repeat the above test, with the non-owner also annotating the Image with Tag, Rating and Comment   |
+-----------+-------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------+
| **d.**    | The owner should still be able to delete the Image (NB Tag shouldn't get deleted  `#2881 </ome/ticket/2881>`_).   | The owner should still be able to delete the Image (NB Tag shouldn't get deleted                   |
+-----------+-------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------+
| **e.**    | Image owner should also be able to delete Image if another user has added ROI.  `#3010 </ome/ticket/3010>`_       | Image owner should also be able to delete Image if another user has added ROI                      |
+-----------+-------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------+

Delete Dataset  `#3009 </ome/ticket/3009>`_

+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Insight   | Web                                                                                                                                                                             |
+===========+=================================================================================================================================================================================+==============================================================================================================================================================+
| **a.**    | Create a dataset with images (images not in another dataset). Tag the images with a tag of your choice so you can find them when orphaned in Insight                            | Create a dataset with images (images not in another dataset). Tag the images with a tag of your choice so you can find them when orphaned in the Web         |
+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **b.**    | Delete the Dataset, choosing to delete contents: Check the images have been deleted (not orphans, not found under Tag in Insight                                                | Delete the Dataset, choosing to delete contents: Check the images have been deleted (not orphans, not found under Tag in the web and not in orphan images.   |
+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **c.**    | Repeat the above steps, choosing NOT to delete contents. Check that the images are orphans (find by Tag in Insight, under Orphans in web)  insight`#1656 </ome/ticket/1656>`_   | Repeat the above steps, choosing NOT to delete contents. Check that the images are orphans (find by Tag in Insight, under Orphans in web)                    |
+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **d.**    | Create a dataset that has some of it's images in another dataset, some in this dataset only (Tag images as above).                                                              | Create a dataset that has some of it's images in another dataset, some in this dataset only (Tag images as above)                                            |
+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **e.**    | Delete this dataset choosing to delete contents. Check that the images in both datasets remain in other dataset, other images deleted.  `#3031 </ome/ticket/3031>`_             | Delete this dataset choosing to delete contents. Check that the images in both datasets remain in other dataset, other images deleted.                       |
+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------+

Delete Project

-  Repeat all of the steps in 'Delete Dataset' scenario, but use
   Projects, Datasets & Images, instead of Datasets & Images. (too many
   combinations to list)

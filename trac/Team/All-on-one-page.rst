THIS PAGE IS A LIST OF INCLUDES OF OTHER PAGES
==============================================

MAKE ANY EDITS ON THE OTHER PAGES
=================================

1. `Import Project/Dataset Images </ome/wiki/TestingScenarios/ImportProjectDatasetImages>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Import Project/Dataset Images
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

` OMEROimporter.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-3-0/mov/OMEROimporter.mov>`_

-  Already installed importer
-  Add server using + button
-  Log in to server
-  Browse file formats in drop-down list (leave as 'All supported file
   types')
-  Browse "test\_images\_good/" & select a few non-screen files in a
   folder.
-  Hit + button.
-  Create new Project
-  Create new Dataset, with description
-  Choose 'full path' for image name
-  Click "Add to queue". Files should be added to queue
-  Remove the image from the queue (to make sure this feature works)
-  Re-add the image, selecting the same Project/Dataset and other
   options (to make sure this feature works)
-  Click "Import" to start the import.
-  Click "Output Text" tab. See various info - with no errors.
-  View "Debug Text" for more info.
-  If the "Import History tab is grey, skip to the final step.
-  Otherwise Click on "Import History" tab & select import from 'Today'
   on left
-  Files should be shown in the list with a green checkmark
-  Click 'Re-Import' to add files to import queue
-  Check that files have been added to import queue [and import OK]
-  Check for password change issues:

   -  Login with both importer + insight
   -  Change user password in insight
   -  Try to import something with importer.

2.\ `Import Screen/Plate/Well Images </ome/wiki/TestingScenarios/ImportScreenPlateWellImages>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2. Import Screen/Plate/Well Images
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Already installed importer
-  Add server using + button
-  Log in to server
-  Browse file formats in drop-down list (leave as 'All)
-  Browse "test\_images\_good/" & select a SPW folder.
-  Hit + button.
-  Create new Screen, with description
-  Click "Add". Files should be added to queue
-  Click "Import" to start the import.
-  Click "Output Text" tab. See various info - with no errors.
-  View "Debug Text" for more info.
-  If the "Import History tab is grey, skip to the final step.
-  Otherwise Click on "Import History" tab. Select import from 'Today'
   on left
-  Files should be shown in the list with a green checkmark
-  Click 'Re-Import' to add files to import queue
-  Check that files have been added to import queue [and import OK]

2.1 `Delete Screen/Plate/Well Images </ome/wiki/TestingScenarios/DeleteScreenPlateWellImages>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

2.1 Delete Screen/Plate/Well Images
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Prerequisite a plate with with Plate Acquisitions and screens and
plates with tags and annotations.**

Delete SPW

-  Delete a Plate.

   -  Delete a Plate with Plate Acquisitions, deleting one or more Plate
      Acquisition at once.
   -  When deleting a Plate chose to also delete tags and annotations.
   -  When deleting a Plate chose NOT to delete tags and annotations.
      Check in Insight that the tag used can be seen.

-  Delete Screen.

   -  When deleting a Screen chose to also delete tags and annotations.
      Check in insight the tags have been removed.
   -  When deleting a Screen chose NOT to delete tags and annotations.
      Check in Insight that the tag used can be seen.

2.2 `Web Screen/Plate/Well Images </ome/wiki/TestingScenarios/WebScreenPlateWellImages>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

2.2 Web Screen/Plate/Well? Images
---------------------------------

Plate with multiple acquisitions **pre-requisite HCS data already
imported tests this scenario requires images from squig:**

-  available from data\_repo/test\_images

   -  .cellworx
   -  .flex

-  available from data\_repo/test\_images\_scenarios/scenario\_2.2/

   -  .testImportPlateMultiplePlateAcquisitions1508.ome

-  Test for plate with multiple acquisitions

   -  Import the plate .testImportPlateMultiplePlateAcquisitions1508.ome
   -  select a single plate acquisition and view the plate well.
   -  Then select multiple plate acquisitions and ensure no data is
      shown in the central panel. (`#6580 </ome/ticket/6580>`_)
   -  With 3 plate acquisitions selected chose to batch annotate in the
      right hand panel.
   -  Add a comment and confirm that the comment is added to all three
      plates.
   -  Confirm the comments are viewable in insight.

-  Test for plate with multiple field per acquisition

   -  Open the cellworx plate.
   -  Open field # 4
   -  Annotate image H,H
   -  Open field # 3
   -  Annotate image F,F and check image H,H to check there is no
      annotation.

-  Metadata tests

   -  Using the cellworx image tag, attach, and comment on an image.
   -  Open insight and check the same image metadata.
   -  Choose a different image in insight and rate, tag, attach, and
      comment on an image
   -  Open the image in the web client and confirm that the annotations
      are on the image.

-  Image ID test

   -  Using the imported .cellworx image
   -  Move to field 3 and open image DD and check that the image ID in
      the URL matches the image ID in the metadata panel.

3. `Import QA System </ome/wiki/TestingScenarios/ImportQaSystem>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

3. Import QA System
~~~~~~~~~~~~~~~~~~~

-  Log in to server with importer
-  Browse to "test\_images\_bad/" directory
-  Select "mike1\_R3d.dv"
-  Hit + button.
-  Create new Project (if needed)
-  Create new Dataset (if needed)
-  Choose 'partial path' with '0 leading directories' for image name
-  Click "Add". Files should be added to queue
-  Click "Import" to start the import.
-  The file should fail and a popup message should appear.
-  View "Debug Text" for more info.
-  View the "Import Errors" tab, the error should be displayed there.
-  Click the "Send Feedback" button.
-  Enter your email address & a message.
-  Leave both checkboxes selected.

   -  variation1: select only the file not the log file
   -  variation2: do not send files

-  Click the "Send Comment" button.
-  The file should send & a popup should appear saying you were
   successful.
-  If the "Import History tab is grey, click it. A popup warning should
   appear.
-  Check your email, a QA messsage should appear, click the link
   included.
-  Your email address, error message, and file links should all be
   included on the QA webpage
-  Send a reply comment to the QA webpage, include your email address
   and a message.
-  Log into the QA system as an administrator and confirm the comment
   was received.
-  Reply to the QA message, the message should appear in your email.
-  Finally, set the QA message status to "Closed" and save.

4. `Manage and Organise </ome/wiki/TestingScenarios/ManageAndOrganise>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

4. Manage and Organise
~~~~~~~~~~~~~~~~~~~~~~

` ManagingImages.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-1/mov/ManagingImages.mov>`_
NB. Important to test browsers (IE, FF, Chrome) on Windows. See
`#4899 </ome/ticket/4899>`_.

+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| Insight   | Web                                                                                                                                                                  |
+===========+======================================================================================================================================================================+===================================================+
| **a.**    | Browse Projects and Datasets in the Tree-view                                                                                                                        | click on "Data"                                   |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **b.**    | See images under "Images" tab                                                                                                                                        | WEB: not available                                |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **c.**    | Edit the name and description of a dataset in the metadata panel on the right (click pen icon) - Save changes.                                                       |                                                   |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **d.**    | Right-click on Project. Create new Dataset                                                                                                                           | use create icon                                   |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **e.**    | Shift-click to select multiple images in a Dataset from hierarchy (left panel). Right-click - Cut                                                                    | not available `#3087 </ome/ticket/3087>`_         |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **f.**    | Right-click on new dataset - Paste images in.                                                                                                                        | use paste icon                                    |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **g.**    | Repeat previous two with Shift-clicking in center panel                                                                                                              | create ds manually. `#3086 </ome/ticket/3086>`_   |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **h.**    | Use shift-click to select multiple thumbnails. Click on icon in top tool-bar to put these images in a new dataset. New dataset should be added to current project.   |                                                   |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **i.**    | Create new project                                                                                                                                                   | create ds manually `#3086 </ome/ticket/3086>`_    |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **j.**    | Cut and paste the new dataset into this project.                                                                                                                     | broken `#3089 </ome/ticket/3089>`_                |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **k.**    | View Image metadata to confirm that the image is in dataset.                                                                                                         | not available `#3090 </ome/ticket/3090>`_         |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **l.**    | Use 4.2 for full delete Delete Image - Right click on Image                                                                                                          | use delete icon                                   |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **m.**    | Delete Project. Don't delete contents.                                                                                                                               |                                                   |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **n.**    | Dataset should become an orphan                                                                                                                                      |                                                   |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+
| **o.**    | Delete Dataset - Delete contents                                                                                                                                     |                                                   |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------+

4.1\ `Creating a New Dataset Using the Selected Images </ome/wiki/TestingScenarios/CreatingaNewDatasetUsingTheSelectedImages>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

4.1 Creating a New Dataset Using the Selected Images
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  The starting pre-conditions are a Dataset (Experiement1) with 200
   images and a set of 10 existing project and datasets populated with
   50 images each.
-  Select out 20 images from the Dataset (Experiement1).
-  Click on the icon to create a new Dataset using the selected images.
-  Choose to create a new Dataset (testdataset1) and click Create.
-  Select out another different 20 image from the original Dataset
   (Experiement1).
-  And again click on the icon to create a new Dataset using the
   selected images.
-  Now choose the existing Dataset (testdataset1) and click create.
-  Click and open the Dataset (Testdataset1) and view the images.

4.2 `Delete Image Dataset Project </ome/wiki/TestingScenarios/DeleteImageDatasetProject>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

5.\ `Cross Platform </ome/wiki/TestingScenarios/CrossPlatform>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

5. Cross Platform
~~~~~~~~~~~~~~~~~

` ConnectBrowse.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-1/mov/ConnectBrowse.mov>`_

**Prerequisites: the software must be ready for release and available
for download from the OME web site.**

-  openmicroscopy.org -> omero -> downloads
-  View downloads for All major platforms
-  Mac OSX
-  Download correct one
-  Launch Insight - log in
-  Windows - Show that Insight looks similar
-  Browse thumbnails. Zoom with slider.
-  Choose 5 images per row
-  Double-click to open a large (multi-Z/T) image
-  Scroll through Z and T.
-  Play movie by clicking > button.

6. `Image Rendering </ome/wiki/TestingScenarios/ImageRendering>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

6. Image Rendering
~~~~~~~~~~~~~~~~~~

    ` Insight1-rendering.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-0/mov/Insight1-rendering.mov>`_

+-----------+-----------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| Insight   | Web                                                       |
+===========+===========================================================+===============================================================================================+
| **a.**    | Open an Image                                             | Open an Image                                                                                 |
+-----------+-----------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **b.**    | View and edit rendering settings                          | In Edit channels link > View and edit rendering settings                                      |
+-----------+-----------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **c.**    | Turn channels on/off, adjust levels on several channels   | Turn channels on/off, adjust levels on several channels                                       |
+-----------+-----------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **d.**    | Change channel colour                                     | Change channel colour                                                                         |
+-----------+-----------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **e.**    | Close window -> Save settings -> Thumbnail updated.       | Apply settings > Save settings > Close image window                                           |
+-----------+-----------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **f.**    | Right-click on thumbnail - copy settings                  | N/A                                                                                           |
+-----------+-----------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **g.**    | Right-click on dataset - paste settings                   | N/A                                                                                           |
+-----------+-----------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **h.**    | Right-click on dataset - reset settings                   | Open an Image > In Edit channels link > reset rendering setting to original import settings   |
+-----------+-----------------------------------------------------------+-----------------------------------------------------------------------------------------------+

7. `Annotate Images </ome/wiki/TestingScenarios/AnnotateImages>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

7. Annotate Images
~~~~~~~~~~~~~~~~~~

` AnnotatingImages.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-1/mov/AnnotatingImages.mov>`_

+-----------+--------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------+
| Insight   | Web                                                                            |
+===========+================================================================================+==============================================================================================+
| **a.**    | Choose Image. Add comment in panel on right - Save                             | Choose Image > Add comment in panel on right - click button 'Add comment' to save            |
+-----------+--------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------+
| **b.**    | Select multiple images. Add comment to them. - Save and Check for each image   | Select multiple images. Add comment to them. - Save and Check for each image                 |
+-----------+--------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------+
| **c.**    | Choose Image and add a URL as a comment in the comment field. Save.            | Choose Image > Add URL as a comment in panel on right - click button 'Add comment' to save   |
+-----------+--------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------+

7.1 `Delete Annotated Images </ome/wiki/TestingScenarios/DeleteAnnotatedImages>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

7.1 Delete Annotated Images
~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Prerequisite - on already commented images (Test in response to
`#2993 </ome/ticket/2993>`_).**

+-----------+----------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------+
| Insight   | Web                                                                                                                              |
+===========+==================================================================================================================================+==================================================================================================================================+
| **a.**    | Tag an image with a new tag (only used on this image)                                                                            | Tag an image with a new tag (only used on this image)                                                                            |
+-----------+----------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------+
| **b.**    | Annotate image with local file (on this image only)                                                                              | Annotate image with local file (on this image only)                                                                              |
+-----------+----------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------+
| **c.**    | View annotations in DB. I use psql: select id, textvalue, discriminator, ns, longvalue, file from annotation order by id desc;   | View annotations in DB. I use psql: select id, textvalue, discriminator, ns, longvalue, file from annotation order by id desc;   |
+-----------+----------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------+
| **d.**    | Delete Image: Choose to Delete Annotations & Tags                                                                                | Delete Image: Choose to Delete Annotations & Tags                                                                                |
+-----------+----------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------+
| **e.**    | Check that all 3 annotations are removed from DB                                                                                 | Check that all 3 annotations are removed from DB                                                                                 |
+-----------+----------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------+
| **d.**    | Repeat the above steps, choosing NOT to delete annotations. Check DB                                                             | Repeat the above steps, choosing NOT to delete annotations. Check DB                                                             |
+-----------+----------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------+

8. `Attach </ome/wiki/TestingScenarios/Attach>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

8. Attach
~~~~~~~~~

` AttachingFiles.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-1/mov/AttachingFiles.mov>`_

+-----------+--------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| Insight   | Web                                                                                              |
+===========+==================================================================================================+============================================================================================+
| **a.**    | Select an Image. Click Attachment -> upload local document. Choose local file. E.g. pdf          | Select an Image. Click Attachment -> upload local document. Choose local file. E.g. pdf    |
+-----------+--------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| **b.**    | Select **multiple images**, Attachment -> upload local document. Choose file, E.g. xls. - Save   | Select **a dataset**, Attachment -> upload local document. Choose file, E.g. xls. - Save   |
+-----------+--------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| **c.**    | Browse individual images to check that they have files attached.                                 | Browse individual image/and dataset to check that they have files attached.                |
+-----------+--------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| **d.**    | Browse attachments tab to view files.                                                            | **Not possible on web**                                                                    |
+-----------+--------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+

8.1 `Delete Attachment </ome/wiki/TestingScenarios/DeleteAttachment>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

8.1 Delete Attachment
~~~~~~~~~~~~~~~~~~~~~

**Prerequisite using the attachments from 8 Attach.**

+-----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------+
| Insight   | Web                                                                                                                                                                           |
+===========+===============================================================================================================================================================================+==========================================================================================================+
| **a.**    | \* Delete the file in the Annotations panel on the left of Insight  `#2994 </ome/ticket/2994>`_                                                                               | Delete the file in the Annotations panel **Not possible on web**                                         |
+-----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------+
| **b.**    | Repeat where the file is attached to an Image, using the metadata panel to the right of Insight (choose Delete from drop-down list)  insight`#1652 </ome/ticket/1652>`_\ \|   | Repeat where the file is attached to an Image, using the metadata panel to the right of the Web Client   |
+-----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------+
| **c.**    | Now create a file and and have another user (collaborative group) apply it to an Image/Dataset? etc.                                                                          | Now create a file and and have another user (collaborative group) apply it to an Image/Dataset? etc.     |
+-----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------+
| **d.**    | Try to delete the file - This should fail                                                                                                                                     | Try to delete the file - The delete button should **not** be shown                                       |
+-----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------+
| **e.**    | Change to be the owner of the group, the deleting File used by others will be allowed                                                                                         | Change to be the owner of the group, the deleting File used by others will be allowed                    |
+-----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------+

9. `Tagging </ome/wiki/TestingScenarios/Tagging>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

9. Tagging
~~~~~~~~~~

` Insight2-tags.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-0/mov/Insight2-tags.mov>`_

Web changes being addressed in `#4615 </ome/ticket/4615>`_ web
pre-requirement 5 datasets defined with and 3 projects defined.

+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| Insight   | Web                                                                                            |
+===========+================================================================================================+=======================================================================================================+
| **a.**    | Open Image - view metadata panel. tag [+]                                                      | Open Image - view metadata panel. tag [+]                                                             |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **b.**    | Create new tag. Accept. See that tag is added                                                  | Create a new tag. Accept. See that tag is added                                                       |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **c.**    | Select multiple images (thumbnails).                                                           | Select multiple images, datasets, and Projects                                                        |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **d.**    | Right-click - Tag.                                                                             | Right-click - Tag.                                                                                    |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **e.**    | Choose existing tag. Add - Save.                                                               | Choose existing tag. Add - Save.                                                                      |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **f.**    | Check tag added to each image                                                                  | Check tag added to each image                                                                         |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **g.**    | Browse 'Tags' tab on left.                                                                     | Tag 5 more images with 5 different tags, tag 5 datasets with 3 tags and tag 3 projects with 3 tags.   |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **h.**    | See that new tag is there - view images                                                        | Toggle to tag view                                                                                    |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **i.**    | Create Tag Set                                                                                 | Ensure that all the tags that have been created are shown                                             |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **j.**    | Copy new tag and paste into Tag-Set                                                            |                                                                                                       |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **h.**    | Browse dataset image thumbnails and Rate (5) an image in right-hand panel.                     |                                                                                                       |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **i.**    | Filter by Rating (5 stars)                                                                     |                                                                                                       |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **j.**    | Filter by Tags (added earlier)                                                                 |                                                                                                       |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **k.**    | Filter by Tag AND Rating (filter dialog box)                                                   |                                                                                                       |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **k.**    | Remove filters to view all images.                                                             |                                                                                                       |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **l.**    | Click on 'Report' button in toolbar                                                            |                                                                                                       |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+
| **l.**    | Save xls locally. Open xls to view - should see all images in dataset, with tags as columns.   |                                                                                                       |
+-----------+------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------+

9.1 `Delete Tagging </ome/wiki/TestingScenarios/DeleteTagging>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

9.1 Delete Tagging
~~~~~~~~~~~~~~~~~~

**Prerequisite on the already tagged images from 9 Tagging.**

Delete Tag  `#2995 </ome/ticket/2995>`_
 insight`#1651 </ome/ticket/1651>`_

-  Create a Tag and use it to tag some images
-  Delete the Tag
-  Create a Tag and have another user (collaborative group) apply it to
   an Image (image can be yours or theirs)
-  Try to delete the Tag - This should fail (error message might not be
   very nice?)  insight`#1657 </ome/ticket/1657>`_
-  NB. If you are the owner of the group, the deleting Tag used by
   others will be allowed.

10. `Editor </ome/wiki/TestingScenarios/Editor>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

10. Editor
~~~~~~~~~~

` EditorNewExperiment.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-1/mov/EditorNewExperiment.mov>`_
` fix&stain.pdf <http://www.lamondlab.com/pdf/fix&stain.pdf>`_

-  Dataset: Attachment [+] -> New Experiment.
-  Edit Protocol (radio button)
-  Copy text of a Protocol and paste into the first 'step'
-  Split into several steps by separating paragraphs by new lines
-  Rename new steps
-  Highlight a couple of words in first step - Click + parameter (beside
   text) -> new text parameter
-  Edit name of the parameter by editing the blue text in line
-  Add another parameter in the same way - choose 'drop-down menu'
   parameter
-  Add some enum options to the parameter
-  Edit name of the Protocol
-  Click the 'Edit Experiment' radio button
-  Fill out the values of the parameters you created
-  Click Save: Save to server: OK (see ID)
-  Close window
-  Refresh Dataset, Expand Experiment tab in metadata panel.
-  Check that parameters and values are displayed.

10.1 `Delete Editor File </ome/wiki/TestingScenarios/DeleteEditorFile>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

10.1 Delete Editor File
~~~~~~~~~~~~~~~~~~~~~~~

**Prerequisite on the Editor files created in 10.**

-  Delete the file in the Annotations panel on the left of Insight
    `#2994 </ome/ticket/2994>`_
-  Repeat where the file is attached to an Image, using the metadata
   panel to the right of Insight (choose Delete from drop-down list)
    insight`#1652 </ome/ticket/1652>`_
-  create a file and and have another user (collaborative group) apply
   it to an Image/Dataset? etc.
-  Try to delete the file - This should fail
-  NB. If you are the owner of the group, the deleting File used by
   others will be allowed

11. `Drawing/Viewing ROIs </ome/wiki/TestingScenarios/DrawingViewingRois>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

11. Drawing/Viewing ROIs
~~~~~~~~~~~~~~~~~~~~~~~~

For insight movie, see:
` MeasurementTool-DrawingROI.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-0/mov/MeasurementTool-DrawingROI.mov>`_

+-----------+---------------------------------------------+------------------------------------------------------+
| Insight   | Web                                         |
+===========+=============================================+======================================================+
| **a.**    | Open image and measurement tool             | Currently can only see show ROIs. (see 11b. below)   |
+-----------+---------------------------------------------+------------------------------------------------------+
| **b.**    | Draw some squares, circles and lines        |                                                      |
+-----------+---------------------------------------------+------------------------------------------------------+
| **c.**    | Split the line into two                     |                                                      |
+-----------+---------------------------------------------+------------------------------------------------------+
| **d.**    | Add text to shape                           |                                                      |
+-----------+---------------------------------------------+------------------------------------------------------+
| **e.**    | Save (close image and re-open to confirm)   |                                                      |
+-----------+---------------------------------------------+------------------------------------------------------+

11.1 `Viewing ROIs in web </ome/wiki/TestingScenarios/ViewingRoisInWeb>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

11.1 Viewing ROIs in web
------------------------

-  In webclient, open the above image in image-viewer.
-  Click on "ROIs: show"
-  If the current plane has shapes on, they should be displayed
-  A table pop-up lists the ROIs. Clicking an ROI expands to show
   shapes.
-  Clicking a shape in the table moves the image viewer to that plane
   and highlights the shape.
-  Browsing to different planes in the viewer loads the shapes for each.
-  Clicking on a shape in the image viewer highlights that shape in the
   ROI table, expanding the ROI parent.
-  Click "hide" to hide the table and remove shapes from image viewer.

12. `Measuring ROIs </ome/wiki/TestingScenarios/MeasuringRois>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

12. Measuring ROIs
~~~~~~~~~~~~~~~~~~

[` http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-0/mov/MeasurementTool-Taking%20Measurments.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-0/mov/MeasurementTool-Taking%20Measurments.mov>`_
MeasurementTool?-Taking Measurments.mov]

-  Draw a couple of ellipses. Look at the 'Results' tab (x, y etc)
-  Click 'Results Wizard': Remove Length, Angle: OK. Check they're gone
   from Results
-  Click on 'Graph Pane' to see histogram of intensities
-  Draw new ROI and then move it. See histogram update each time.
-  Turn channels on off. Histogram updates.
-  Go to 'Intensity View' View parameters for ROI
-  See 'Intensity Values' for a chosen channel
-  Go to 'Intensity Results View' and click 'Add' to add a couple of
   ROIs to the results table

   -  Delete ROIs using red cross (all)

12.1 `Delete ROIs </ome/wiki/TestingScenarios/DeleteRois>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

12.1 Delete ROIs
~~~~~~~~~~~~~~~~

Delete ROI

-  Create several ROIs
-  Delete ROI.
-  Delete a single ROI using the right click mouse button.
-  Click on a ROI and open up the ROI assistant.
-  Click on the Remove ROI radio button
-  Right click and ensure the ROI is removed.
-  Create ROI on another user image (rwrw-- group):
-  make sure that the owner of the image cannot modify the ROI.
-  make sure the owner can create ROI.
-  Open a new image and add several ROI's to the image
-  Choose to Delete all ROIs using red cross.

13. `Preview Pane </ome/wiki/TestingScenarios/PreviewPane>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

13. Preview Pane
~~~~~~~~~~~~~~~~

+-----------+-----------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------+
| Insight   | Web                                                                                           |
+===========+===============================================================================================+===========================================================================================+
| **a.**    | In insight, select an imported image, then select "Preview Pane" on the far right panel       | In the Web, select an imported image, then select "Preview Pane" on the far right panel   |
+-----------+-----------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------+
| **b.**    | Make sure image information is correct (Z/T and channel information)                          | N/A                                                                                       |
+-----------+-----------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------+
| **c.**    | Scroll through all planes                                                                     | Scroll through all planes                                                                 |
+-----------+-----------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------+
| **d.**    | Check min/max, full range, reset, and undo buttons (these should adjust ranges accordingly)   | N/A                                                                                       |
+-----------+-----------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------+
| **e.**    | apply settings using the "apply to all" button                                                | N/A                                                                                       |
+-----------+-----------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------+
| **d.**    | confirm "Viewed by" works                                                                     | N/A                                                                                       |
+-----------+-----------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------+

14. `Sharing (web) </ome/wiki/TestingScenarios/Sharing>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

14. Sharing (web)
~~~~~~~~~~~~~~~~~

` ShareImages.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-1/mov/ShareImages.mov>`_

-  Add images to your basket by clicking the 'cart' icon beside several
   images
-  View the basket, remove one of the images from it
-  Click 'share' to share images in the basket
-  Type a message, choose users to share with, pick an expiry date
-  Click share -> taken to Shares page
-  Users on the share should get e-mail with link
-  Click link (login) to see share
-  Open an image
-  Turn channels on/off
-  View Split Channels

15. `Export Imagej </ome/wiki/TestingScenarios/ExportImagej>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

15. Export / ImageJ - (Insight AND web)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Updated for 4.3.2** **'Prerequisite - You must import 10 images with
the option archived original file set.**

+-----------+--------------------------------------------------------------------------+---------------------------------------------------------------------------------------+
| Insight   | Web                                                                      |
+===========+==========================================================================+=======================================================================================+
| **a.**    | Download the Original file                                               | Download the Original file - the download icon is available in the right hand panel   |
+-----------+--------------------------------------------------------------------------+---------------------------------------------------------------------------------------+
| **b.**    | Open the exported image in ImageJ - Should have basic Channel metadata   | Open the exported image in ImageJ - Should have basic Channel metadata                |
+-----------+--------------------------------------------------------------------------+---------------------------------------------------------------------------------------+
| **c.**    | Download (and install) the ImageJ OMERO plugin                           | Download (and install) the ImageJ OMERO plugin                                        |
+-----------+--------------------------------------------------------------------------+---------------------------------------------------------------------------------------+
| **d.**    | Use it to connect to the OMERO server and view an image                  | Use it to connect to the OMERO server and view an image                               |
+-----------+--------------------------------------------------------------------------+---------------------------------------------------------------------------------------+

` ExportImageJ.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-1/mov/ExportImageJ.mov>`_

15.1 `Export/ImageJ user workflow </ome/wiki/TestingScenarios/ExportImagejUserWorkflow>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

15.1 Export / ImageJ user workflow - (Insight AND web)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+-----------+------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------+
| Insight   | Web                                                                                |
+===========+====================================================================================+==========================================================================================================+
| **a.**    | Export an image as OME-tiff                                                        | Export an image as OME-tiff. This is supported via Scripts > Batch\_Image\_Export.py - Format:OME-TIFF   |
+-----------+------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------+
| **b.**    | Open the exported image in ImageJ - Should have basic Channel metadata.            | Open the exported image in ImageJ - Should have basic Channel metadata.                                  |
+-----------+------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------+
| **c.**    | Crop the image and save the cropped image as an OME-tiff.                          | Crop the image and save the cropped image as an OME-tiff.                                                |
+-----------+------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------+
| **d.**    | Re-import the newly cropped OME-tiff image back into insight and view the image.   | Re-import the newly cropped OME-tiff image and view the image in the web client .                        |
+-----------+------------------------------------------------------------------------------------+----------------------------------------------------------------------------------------------------------+

16. `Insight Import </ome/wiki/TestingScenarios/InsightImport>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

16. Insight Import
~~~~~~~~~~~~~~~~~~

[Updated for 4.3.2]

**Prerequisites: Image data from test image good**

-  Non-SPW Image Import

   -  Click on the 'import' button in the hierarchy view of insight
   -  Select a non-SPW image to import
   -  Hit the '>' button.
   -  Create new Project, with description
   -  Create new Dataset, with description
   -  Under 'options' choose 'full path+file name' for image name
   -  Ensure the 'show thumbnails' tickbox is set as the default for the
      import.
   -  Remove the image from the queue (to make sure this feature works)
   -  Re-add the image, selecting the same Project/Dataset and other
      options (to make sure this feature works)
   -  Click "Import" to start the import.
   -  Click "Import" to start the import.
   -  The import tab # 1 will open.
   -  Validate that the Number of File/Folders corresponds to the amount
      of files/folders imported.
   -  Validate that the information in the top bar of Imported to
      Dataset is correct.
   -  Confirm that the dataset label will open location of the image.
   -  Confirm the thumbnail image is shown when hovering over it.
   -  Confirm that a green tick appears on the completion of the import.
   -  In the insight data manager confirm the refresh icon is shown on
      the relevant project/dataset where the image was imported into.
   -  Confirm the image label view shows the image.

-  SPW Image Import

   -  Repeat the above process, but this time under 'options' choose
      'partial path with 0 directories'
   -  Confirm the image imported correctly

-  Folder Import

   -  Select a few folders of images
   -  Hit the '>' button.
   -  Select 'Folder as Dataset' (make sure both the 'select all' and
      'individual' select options work)
   -  cancel import by selecting imports on the right side and removing
   -  re-add folder
   -  Click 'import'
   -  Confirm all images imported correctly by browsing the dataset

-  Folder Import

   -  Select multiple folders from test\_images\_good)
   -  Click ">"
   -  Now choose an existing Project and set the Dataset to "New From
      Folder"
   -  Click "Add to the Queue"
   -  Now check that all folders imported in the queue have "Folder as
      Dataset" checked.
   -  Now click import.
   -  Confirm that the imported folders

-  Folder Import move between queues

   -  Select a folder
   -  Click ">"
   -  Now choose an existing Project and set the Dataset to "New From
      Folder" []
   -  Click "Add to the Queue"
   -  Now check that all folders imported in the queue have "Folder as
      Dataset" checked.
   -  Now click "<" to remove the folder from the queue.
   -  Now select a different folder.
   -  Click ">"
   -  Now choose an existing Project and set the Dataset to "New From
      Folder"
   -  Click "Add to the Queue"
   -  Now check that all folders imported in the queue have "Folder as
      Dataset" checked.
   -  Now click import.
   -  Confirm that the folders have been created as datasets.

-  Bug Submission

   -  Right click on a dataset and choose 'import'
   -  Select test\_images\_bad/mike1\_R3D.dv from the repo
   -  import image
   -  when image fails, click submit failures
   -  Click the "Send Feedback" button.
   -  Enter your email address & a message.
   -  Leave both check-boxes selected.

      -  variation1: select only the file not the log file
      -  variation2: do not send files

   -  Click the "Send Comment" button.
   -  The file should send & a pop-up should appear saying you were
      successful.

-  Check your email, a QA messsage should appear, click the link
   included.

   -  Your email address, error message, and file links should all be
      included on the QA webpage.
   -  Send a reply comment to the QA webpage, include your email address
      and a message.
   -  Log into the QA system as an administrator and confirm the comment
      was received.
   -  Reply to the QA message, the message should appear in your email.
   -  Finally, set the QA message status to "Closed" and save.

16.1 `Insight Import Tagging </ome/wiki/TestingScenarios/InsightImportTagging>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

16.1 Insight Import Tagging
~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Click on the 'import' button in the hierarchy view of insight
-  Select a non-SPW image to import
-  Create a new Project.
-  Create a new Dataset.
-  Browse "test\_images\_good/" & select a few non-screen files in a
   folder.
-  Click "Add to queue". The '>' button. Files should be added to queue.
-  Open the options tab and click on the add tag.
-  Create new tag. Accept. See that tag is added.
-  Select an existing tag and a tag set.
-  Save and confirm the tags added are shown next to the add tag label.
-  Click "Import" to start the import with the tags.

   -  Check tag added to each image.
   -  Browse 'Tags' tab on left.
   -  See that the new tags and tag set are there - view image.

17. `Insight-Web Comparison </ome/wiki/TestingScenarios/InsightWebComparison>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

17. Insight-Web Comparison
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  NOTE: This scenario is reflecting the usability/development work
   being conducted under `#3476 </ome/ticket/3476>`_ Web UI review.

The scenario shall be updated and used for testing the consistency work
that has taken place for a release.

-  For this test, go through the various components in insight and
   compare them to their web counterparts. Look for any glaring
   inconsistencies.

**[Backdated scenario for 4.3.0]**

The focus of the work for the 4.3 release has taken place in the right
hand and left hand panel for the web. This is where the focus for
checking for consistency should lie.

-  Rate an Image in Insight and check the rating functionality is shown
   in the web client. Note this is only a read-only action in the web
   and cannot be changed.
-  Check the consistency of several images for the layout of the channel
   labeling.
-  Annotation Display in Web
-  Check the values of lot number, serial number for Detector,
   Objective, Light-Source are displayed for an image in Insight and
   then are the same image in the web.
-  Show and hide the unset fields in the channel settings.
-  Check the contained in dataset for an image in Insight and then check
   for the same image in the web that it is the same.

OMERO 4.3
---------

18. `Client-server compatibility </ome/wiki/TestingScenarios/ClientServerCompatibility>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

18. Client-server compatibility
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Prerequisites: A working version of the previous server released.**

-  Try to log in to an older version of the server using the current
   client e.g. 4.3.1 client and 4.2.2 server
-  Test all clients

19. `Permissions </ome/wiki/TestingScenarios/Permissions>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

19. Permissions
~~~~~~~~~~~~~~~

Includes stuff from
` Permissions1.mov <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-2/mov/Permissions1.mov>`_

    **Prerequisites: Make sure User1 and User2 are a member of group
    'Private' and Owner is owner of the group**

-  Import data as User1 in group 'Private':

   -  create Project1/Dataset1 and import there Image1 and Image2
   -  Log in as User2. You should have no access to User1's data
   -  Log in as Owner. You should be able to access User1's data

-  Make sure User1 and User2 are a member of group 'Collaborative
   read-only'
-  Import data as User1 in group 'Collaborative read-only':

   -  create Project2/Dataset2 and import there Image3 and Image4
   -  Log in as User2, browse and manage User1 data. You should only be
      able to view data, no editing, annotating, attaching.

-  Make sure User1 and User2 are a member of group 'Collaborative'
-  Import data as User1 in group 'Collaborative':

   -  create Project3/Dataset3 and import there Image5 and Image6
   -  Log in as User2, browse and manage User1 data. What you can do is
      listed
      ` https://www.openmicroscopy.org.uk/site/support/omero4/server/permissions/ <https://www.openmicroscopy.org.uk/site/support/omero4/server/permissions/>`_

      -  comment Image5
      -  tag Image5 by 'permission tag'

-  All the above steps are now required to be repeated from within the
   client-importer.

   -  This is testing the same permission groups of private
      Collaborative read only, and Collaborative but importing the data
      from within the insight client-importer,

19.1 `Delete Permissions </ome/wiki/TestingScenarios/DeletePermissions>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

20. `Collaborative Tagging </ome/wiki/TestingScenarios/CollaborativeTagging>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

21. `User Script-writing </ome/wiki/TestingScenarios/UserScriptWriting>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

21. User Script-writing
~~~~~~~~~~~~~~~~~~~~~~~

-  **Scenario implemented for 4.3.0**

`OmeroPy/ScriptingServiceGuide </ome/wiki/OmeroPy/ScriptingServiceGuide>`_
- Testing Script-writing workflows

-  Follow steps on Scripting Service Guide see link above.

21.a User Script-writing
~~~~~~~~~~~~~~~~~~~~~~~~

`OmeroPy/ScriptingServiceGuide </ome/wiki/OmeroPy/ScriptingServiceGuide>`_
- Testing regular user workflow

-  Follow steps on Scripting Service Guide see link above.

21.1 `Test Export Scripts - Insight AND web </ome/wiki/TestingScenarios/TestExportScripts>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

21.1 Test Export Scripts - Insight AND web
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **Scenario implemented for 4.3.0**

**Prerequisites:images with multiple z sections**

Batch Image Export - "Default values"

-  **Prerequisite choose images with more than 1 channel**
-  In the web and Insight, select one or more images (or a dataset)
-  Click to display the available scripts icon - Run Export Scripts >
   Batch Image Export
-  Run using the default values (don't need to edit anything)
-  Activities pane should show script running, with
   Batch\_Image\_Export.zip available to download when done
-  Download and check that each image has jpeg for each channel and
   'merged' jpeg.
-  Web: Click on "Browse" option for result. Main webclient page should
   browse to where the zip is attached (Image or Dataset)

Batch Image Export - "Input values". Choose either web or Insight (or
both if you have time!)

-  Select a dataset. (The images all require z sections)
-  Choose export scripts > batch script.
-  On opening the script the dataset id should be set. (Matching the
   dataset id that has been selected in step 1)
-  Complete the following information in the script

   -  export merged images ticked
   -  Add 1 channel name
   -  Choose Z section other > specifying Z-section E.g. 3

-  set Image width to 100
-  format to JPEG
-  use default folder name Batch\_Image\_Export1

-  Click run > and on activation the actives window is presented while
   the scrip run.
-  On the completion of the script the result will be able to download
   from the actives window > click download and save the
   Batch\_Image\_Export.zip
-  Look for

   -  merged images as script should have saved rendering settings
   -  single channel images named with channel names
   -  confirm z indexes match the information above.
   -  check image sizes.
   -  check image format JPEG

21.2 `Test Figure Scripts - Insight AND web </ome/wiki/TestingScenarios/TestFigureScripts>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

21.2 Test Figure Scripts - Insight AND web
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **Scenario implemented for 4.3.0**

-  Movie Figure ROI

**Prerequisites Images with at least one rectangular ROI spanning time
(z is optional).**

Test this script on web AND Insight. Suggestion - run once with default
values on one client and again with values below on the other client.

-  Select Images from within the data manager > click to display the
   available scripts icon - and choose figure scripts > Movie ROI Figure
   .
-  Complete the following information in the script

   -  Merged channels set tp 0,1,2,3
   -  ROI zoom to 2
   -  Max Columns to 5
   -  Resize image ticked
   -  Height set to 300
   -  Width set to 300
   -  Image labels set to image name
   -  Scale bar set to 5
   -  Scale bar color set to orange
   -  ROI selection label [Not set]
   -  Algorithm set to Maximum Intensity
   -  Figure name set to Testing\_movie- ROI-Figure-test1
   -  Format to JPEG

-  Run the script
-  In the activity window click info > and click view > to see the
   script that has been run
-  In the activity window click info > and click download
-  In the activity window click view > to see the JPEG thumbnail image
-  Check the setting of the scale bar, overlay color, image name,
   channel names, match the settings as set above.
-  Refresh the DataManager and confirm the JPEG thumbnail image has been
   attached to the image annotations under attachment.

21.3 `Test Util Scripts - Insight AND web </ome/wiki/TestingScenarios/TestUtilScripts>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

21.3 Test Util Scripts - Insight AND web
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **Scenario implemented for 4.3.0**

There are 3 scripts that make up Test Util Scripts - Maybe run a couple
of times on one client and a couple of times on the other client:

-  Channel\_Offsets.py
-  Combine\_Images.py
-  Images\_From\_ROIs.py

**\* Prerequisite images**

-  test\_images\_good/lsm/2chzt.lsm
-  test\_images\_good/lsm/anusgfpzs.lsm
-  test\_images\_good/Adultmidsection.lsm

1) Channel Offsets
^^^^^^^^^^^^^^^^^^

**Prerequisite: Image with multiple z sections (multiple time points is
a bonus) and 2 or 3 channels. test\_images\_good/lsm/2chzt.lsm**

-  Select single Image in Insight.
-  Open Util Scripts > Channel Offsets - 'Image' & ID should be
   populated
-  Choose to combine 2 or more channels from the input image into the
   output image

   -  Specify various X, Y, and Z offsets as desired for each channel

-  As a test case, try to include a Channel that does not exist in input
   image (E.g. Channel 4).
-  Leave dataset name blank
-  Run the Script
-  On completion of the script, confirm it went OK and message is
   displayed with 'View' link to new Image.
-  Click on the info label and view > the text file of the script
   variables is shown > check this corresponds to the information
   entered.

If possible, repeat above choosing several Images as input with a mix of
images of different dimensions. Add a name for new dataset to put images
in. This should create a new dataset.

2) Combine Images
^^^^^^^^^^^^^^^^^

**Prerequisites: 2 or more Z-stack images in a Dataset - Each Z-stack
should have same X, Y, Z size. T and C sizes over 1 will be ignored.**

**Using images test\_images\_good/lsm/anusgfpzs.lsm &
Adultmidsection.lsm**

-  Select Datset or the images within it you want to combine.
-  Open Util Scripts > Combine Images
-  Follow the url in description to get more info on how to run the
   script.
-  Untick auto define dimensions
-  Tick manually define dimensions
-  Choose 1 Dimension to stack the planes over. E.g. Channel
-  Run the script
-  Once completed click 'View' in the activities window.
-  Check the image has combined a Z stack from each image into a
   multi-channel image.

Now repeat this again using 'Auto Define Dimensions' - TODO: Requires
test dataset of correctly named images.

3) Images from ROIs
^^^^^^^^^^^^^^^^^^^

**Prerequisites Multi-Channel, multi-Z (multi-T if possible) image(s)
with multiple rectangle ROIs through z and time. ROIs should span a
range of Z and/or T sections, including some single-Shape ROIs and some
that span the entire Z / T range Using test\_images\_good/lsm/2chzt.lsm
****

-  Select an Image(s) with ROIs in Insight - Include an image with no
   ROIs (test).
-  Open Util Scripts > Images from ROI's
-  Run the script with the default values.
-  On the completion of the script check any messages and links.
-  Refresh the data manager to view new images in a new Dataset (named
   'From\_ROIs').
-  Images should be a 'crop' of the original image with all Channels
   spanning the T, Z range of each ROI.

Now repeat this again, combining a single plane from each ROI into a
Z-stack (EM use case). This is designed to work on a single plane input
image, with each ROI having a single rectangle, but it should also work
on the multi-dimensional image(s) above. Simply repeat as above,
choosing the "Make Image Stack" option.

22. Delete Image and binary data
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **Scenario Updated for 4.3.1**

22.1 `Delete Image and binary data Linux server </ome/wiki/TestingScenarios/DeleteImageAndBinaryDataLinuxServer>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

22.1 Delete Image and binary data Linux server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **Scenario Updated for 4.3.1**

All these should behave the same in both clients.

-  Delete Image and binary data

   -  first note the Image ID and get the pixels ID, the Thumbnail ID
      and OriginalFile ID(s)
   -  E.g. psql: select \* from pixels where pixels.image=<imageId>
   -  check that these files exist under omero.data.dir (Pixels,
      Thumbnails, Files)
   -  delete the Image
   -  check that the files noted above have been deleted.

-  Delete Image and binary data

   -  first note the Image ID and get the pixels ID, the Thumbnail ID
      and OriginalFile ID(s)
   -  E.g. psql: select \* from pixels where pixels.image=<imageId>
   -  Check that these files exist under omero.data.dir (Pixels,
      Thumbnails, Files)
   -  Delete the Image.
   -  Check that the files noted above have been deleted.

-  Try to delete any remaining files using cleanse.

   -  bin/omero admin cleanse --dry-run
   -  note whether undeleted files are marked for deletion.
   -  bin/omero admin cleanse ( NOTE These last two points are optional
      under Linux)
   -  note whether undeleted files have now been deleted.

22.2 `Delete Image and binary data Mac OS server </ome/wiki/TestingScenarios/DeleteImageAndBinaryDataLinuxServer>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

22.1 Delete Image and binary data Linux server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **Scenario Updated for 4.3.1**

All these should behave the same in both clients.

-  Delete Image and binary data

   -  first note the Image ID and get the pixels ID, the Thumbnail ID
      and OriginalFile ID(s)
   -  E.g. psql: select \* from pixels where pixels.image=<imageId>
   -  check that these files exist under omero.data.dir (Pixels,
      Thumbnails, Files)
   -  delete the Image
   -  check that the files noted above have been deleted.

-  Delete Image and binary data

   -  first note the Image ID and get the pixels ID, the Thumbnail ID
      and OriginalFile ID(s)
   -  E.g. psql: select \* from pixels where pixels.image=<imageId>
   -  Check that these files exist under omero.data.dir (Pixels,
      Thumbnails, Files)
   -  Delete the Image.
   -  Check that the files noted above have been deleted.

-  Try to delete any remaining files using cleanse.

   -  bin/omero admin cleanse --dry-run
   -  note whether undeleted files are marked for deletion.
   -  bin/omero admin cleanse ( NOTE These last two points are optional
      under Linux)
   -  note whether undeleted files have now been deleted.

22.3 `Delete Image and binary data Windows server </ome/wiki/TestingScenarios/DeleteImageAndBinaryDataWindowServer>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

22.3 Delete Image and binary data Windows server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **Scenario Updated for 4.3.1**

All these should behave the same in both clients.

-  Delete Image and binary data

   -  first note the Image ID and get the pixels ID, the Thumbnail ID
      and OriginalFile ID(s)
   -  E.g. psql: select \* from pixels where pixels.image=<imageId>
   -  check that these files exist under omero.data.dir (Pixels,
      Thumbnails, Files)
   -  delete the Image
   -  check that the files noted above have been deleted.

-  Delete Image and binary data

   -  first note the Image ID and get the pixels ID, the Thumbnail ID
      and OriginalFile ID(s)
   -  E.g. psql: select \* from pixels where pixels.image=<imageId>
   -  Check that these files exist under omero.data.dir (Pixels,
      Thumbnails, Files)
   -  Delete the Image.
   -  Check that the files noted above have been deleted.

-  Try to delete any remaining files using cleanse.

   -  bin/omero admin cleanse --dry-run
   -  note whether undeleted files are marked for deletion.
   -  bin/omero admin cleanse
   -  note whether undeleted files have now been deleted.

23. `Web Admin Testing </ome/wiki/TestingScenarios/WebAdminTesting>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

23.1 `Insight Admin Testing </ome/wiki/TestingScenarios/InsightAdminTesting>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

24.OME-XML & OME-TIFF Export Testing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

24.1\ `OME-TIFF Export Testing 1 Pending </ome/wiki/TestingScenarios/OmeTiffExportTestingOne>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

24.1  OME-TIFF Export Testing (pending)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Creating Current Version File 

   -  Export an image from Insight as OME-TIFF 
   -  Validate file 
   -  Re-import and check result consistent

24.2\ `OME-XML & OME-TIFF Export Testing Pending </ome/wiki/TestingScenarios/OmeXmlOmeTiffExportTesting>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

24.2 OME-XML & OME-TIFF Export Testing (pending)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  [NOT APPLY] Create a Legacy 2003-FC OME-TIFF

   -  Export an image from Insight using legacy support mode (2003-FC)
      as OME-TIFF
   -  Validate file
   -  Re-import and check minimal preserved data is consistent

-  [NOT APPLY] Create a Legacy 2008-02 OME-TIFF

   -  Export an image from Insight using legacy support mode (2003-FC)
      as OME-TIFF
   -  Validate file
   -  Re-import and check minimal preserved data is consistent

-  [NOT APPLY] Cross-application testing

   -  Export an image from Insight using legacy support mode (2003-FC)
      as OME-TIFF

      -  Check file will import into Velocity

   -  Export an image from Insight using legacy support mode (2008-02)
      as OME-TIFF

      -  Check file will import into other application

24.3\ `OME-TIFF Export Testing 2 </ome/wiki/TestingScenarios/OmeTiffExportTestingTwo>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

24.3  OME-TIFF Export Testing ()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Creating Current Version File

   -  Export an image from Insight as OME-TIFF
   -  Manual create Legacy 2003-FC OME-TIFF file using XSLT,
      tiffcomment, and convert.

-  Creating Legacy 2003-FC Version File

   -  Manual create Legacy 2008-02 OME-TIFF file using XSLT,
      tiffcomment, and convert.
   -  Validate file.
   -  Re-import and check result consistent.

25. Big Image Upgrade Testing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[**UPDATED for 4.3.2**\ ]

-  NOTE:One of the most important (and hardest to test) scenarios for
   4.3

25.1 `Big Image Upgrade Testing Mac Server </ome/wiki/TestingScenarios/BigImageUpgradeTestingMacServer>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

25.1 Big Image Upgrade Testing Mac Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[**UPDATED for 4.3.2**\ ]

**Prerequisites: Images to use for the test from squig in the folder
test images good :**

Images to use for the test: .BMP

-  /bmp/6kx6k-grey.bmp
-  /bmp/6kx6k.bmp
-  /bmp/8kx8k-grey.bmp
-  /bmp/8kx8k.bmp

.PNG

-  /png/4kx4k.png
-  /png/8kx8k.png

TIF

-  /tif/4kx4k.tif
-  /tif/8kx8k.tif

-  Install 4.2.2 server and increase Java memory to 4096M in
   template.xml.
-  Using a 4.2.2 client of OMERO upload big images listed in the
   prerequisite images (e.g. /bmp/8kx8k.bmp ).
-  Upgrade to the newest 4.3.x server. (See
   ` http://openmicroscopy.org/site/support/omero4/server/upgrade <http://openmicroscopy.org/site/support/omero4/server/upgrade>`_,
   remember about config files).
-  Now again try to view the same big image.
-  An exception (which should be hidden from the user) is thrown which
   implies, "this image needs a pyramid created. please try again").
   Server log should show "Missing
   pyramid:/OMERO/Pixels/PIXEL\_ID\_pyramid"
-  In the background, the server generates the pyramid.
-  On clicking on the same big Image for a second time, the image will
   be viewable.

25.2 `Big Image Upgrade Testing Windows Server </ome/wiki/TestingScenarios/BigImageUpgradeTestingWindowsServer>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

25.2 Big Image Upgrade Testing Windows Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[**UPDATED for 4.3.2**\ ]

**Prerequisites: Images to use for the test from squig in the folder
test images good :**

Images to use for the test: .BMP

-  /bmp/6kx6k-grey.bmp
-  /bmp/6kx6k.bmp
-  /bmp/8kx8k-grey.bmp
-  /bmp/8kx8k.bmp

.PNG

-  /png/4kx4k.png
-  /png/8kx8k.png

TIF

-  /tif/4kx4k.tif
-  /tif/8kx8k.tif

-  Install 4.2.2 server and increase Java memory to 4096M in
   template.xml.
-  Using a 4.2.2 client of OMERO upload big images listed in the
   prerequisite images (e.g. /bmp/8kx8k.bmp ).
-  Upgrade to the newest 4.3.x server. (See
   ` http://openmicroscopy.org/site/support/omero4/server/upgrade <http://openmicroscopy.org/site/support/omero4/server/upgrade>`_,
   remember about config files).
-  Now again try to view the same big image.
-  An exception (which should be hidden from the user) is thrown which
   implies, "this image needs a pyramid created. please try again").
   Server log should show "Missing
   pyramid:/OMERO/Pixels/PIXEL\_ID\_pyramid"
-  In the background, the server generates the pyramid.
-  On clicking on the same big Image for a second time, the image will
   be viewable.

26. `Web Mobile </ome/wiki/TestingScenarios/WebMobile>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

26. Web Mobile
~~~~~~~~~~~~~~

Provisional test - Pending decision on release status

-  Go to /m/ E.g.
   ` http://gretzky.openmicroscopy.org.uk/m/ <http://gretzky.openmicroscopy.org.uk/m/>`_
-  Log in
-  Click on 'Projects' to browse Projects
-  Sort by most-recent, then by name
-  Browse to a single Project.
-  Choose a Dataset
-  View Dataset details
-  Edit Dataset name and description
-  Back to viewing thumbnails from Dataset
-  View an Image
-  Add a comment
-  Browse the users in the current group and view the data from one user

26.a `Web Mobile Image-viewer </ome/wiki/TestingScenarios/WebMobileImageViewer>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

26.a Web Mobile Image-viewer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NB: - this is optimised for iPhone. Other browsers may have artifacts of
positioning of overlays when zoomed in.

-  Browse Project -> Dataset -> Image -> Viewer
-  Image should appear zoomed out
-  Tap image to bring up Z and T sliders, Channel buttons etc.
-  Scroll incrementally (tap Z or T arrows) and jump to position (tap
   scroll bar).
-  Tap image to hide / show controls
-  Turn on/off various channels
-  Pick channel to adjust rendering settings - Adjust min/max.
-  View Z-projection on/off.
-  View image info - Hide
-  Zoom in to image. Show controls by tapping image.
-  Check scale bar looks reasonable.

27. `Publishing Options </ome/wiki/TestingScenarios/PublishingOptions>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

27. Publishing Options
~~~~~~~~~~~~~~~~~~~~~~

-  There are several options for figure creation available under the
   'Publishing Options' menu (top-right of Insight)
-  These either process a Dataset, set of Images or a single Image and
   produce a Figure of some sort.

These options are:

-  Make Movie
-  Split View Figure
-  ROI Split Figure
-  Thumbnail Figure
-  Movie Figure

-  All the above figure options should be run using the default
   settings. With

   -  A single image
   -  3 images.

-  For each script select the images, launch and 'Run and confirm the
   script produces the expected result'.

28.1 `Big Image Viewer </ome/wiki/TestingScenarios/BigImageViewer>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

28. Big Image Viewer
~~~~~~~~~~~~~~~~~~~~

**Prerequisites a collection of big images imported and standard set of
images.** NOTE: any bugs reported in this test scenario must CC both
jburel and Ola

+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| Insight                                                                  | Web                                                                                                                                              |
+==========================================================================+==================================================================================================================================================+===============================================================================================+
| **a.**                                                                   | Open an Image                                                                                                                                    | Open an Image                                                                                 |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **b.**                                                                   | View and edit rendering settings                                                                                                                 | In Edit channels link > View and edit rendering settings                                      |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **c.**                                                                   | Close window -> Save settings -> Thumbnail updated.                                                                                              | Apply settings > Save settings > Close image window                                           |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **d.**                                                                   | Right-click on thumbnail - copy settings                                                                                                         | N/A                                                                                           |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **e.**                                                                   | Right-click on dataset - paste settings                                                                                                          | N/A                                                                                           |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **f.**                                                                   | Right-click on dataset - reset settings                                                                                                          | Open an Image > In Edit channels link > reset rendering setting to original import settings   |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| The next set of points now check the specific big imager functionality   |                                                                                                                                                  |                                                                                               |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **g.**                                                                   | Check the zoom level as you move through the image and checking that the tiles are being loaded as you move, grab the image and pan through it   |                                                                                               |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **h.**                                                                   | Reset the image to the full size                                                                                                                 |                                                                                               |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **i.**                                                                   | Hide and then re-show the birds eye view                                                                                                         |                                                                                               |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **j.**                                                                   | Show the image in the full screen mode                                                                                                           |                                                                                               |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+

28.2 `Big Image Viewer 2 (ticket:6313) </ome/wiki/TestingScenarios/BigImageViewerPartTwo>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

28.2 Big Image Viewer 2
~~~~~~~~~~~~~~~~~~~~~~~

**This scenario is based on the work carried out in
`ticket:6313 </ome/ticket/6313>`_**

**Prerequisites the collection of TIFFs
(``/ome/data_repo/test_images_good/ticket_6313_scenario_28_2``) not to
be processed by the FS lite mechanism because they do not meet the size
criteria. (See `#6313 </ome/ticket/6313>`_)**

NOTE: any bugs reported in this test scenario must CC jburel, atarkowska
and cxallan

Same process as in *28.1 Big Image Viewer* except there should be no
image pyramid (instant "viewability" and no "in progress" thumbnails).
Furthermore Z and T scrolling performance should be unhindered.

+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| Insight                                                                  | Web                                                                                                                                              |
+==========================================================================+==================================================================================================================================================+===============================================================================================+
| **a.**                                                                   | Open an Image                                                                                                                                    | Open an Image                                                                                 |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **b.**                                                                   | View and edit rendering settings                                                                                                                 | In Edit channels link > View and edit rendering settings                                      |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **c.**                                                                   | Close window -> Save settings -> Thumbnail updated.                                                                                              | Apply settings > Save settings > Close image window                                           |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **d.**                                                                   | Right-click on thumbnail - copy settings                                                                                                         | N/A                                                                                           |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **e.**                                                                   | Right-click on dataset - paste settings                                                                                                          | N/A                                                                                           |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **f.**                                                                   | Right-click on dataset - reset settings                                                                                                          | Open an Image > In Edit channels link > reset rendering setting to original import settings   |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| The next set of points now check the specific big imager functionality   |                                                                                                                                                  |                                                                                               |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **g.**                                                                   | Check the zoom level as you move through the image and checking that the tiles are being loaded as you move, grab the image and pan through it   |                                                                                               |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **h.**                                                                   | Reset the image to the full size                                                                                                                 |                                                                                               |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **i.**                                                                   | Hide and then re-show the birds eye view                                                                                                         |                                                                                               |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+
| **j.**                                                                   | Show the image in the full screen mode                                                                                                           |                                                                                               |
+--------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------+

29. `LDAP testing </ome/wiki/TestingScenarios/LdapTesting>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

29. LDAP testing
~~~~~~~~~~~~~~~~

The testing is done on a local ldap server please log in to follow the
testing scenario.

-  ` https://www.openmicroscopy.org/site/team/testing/ldap <https://www.openmicroscopy.org/site/team/testing/ldap>`_

30. `CLI testing </ome/wiki/TestingScenarios/CommandLineInterfaceTesting>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

30. CLI testing
~~~~~~~~~~~~~~~

[Updated for 4.3.2]

This first scenario is for a preliminary set of CLI testing is to cover
the basic set of CLI that are used. You can investigate and see the full
range of the various commands available using the -h or --help option:

**Pre-requisites for this test:**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Run the following as root user from python dist/bin/omero to setup a new
user account and group

-  omero login -s $OMERO\_HOST -p $ROUTER -u root -w ome
-  omero group add web\_group --perms=rwrw-- \| \| echo "Web Group
   already exists?"
-  omero user add web\_user Web User web\_group --userpassword abc \| \|
   echo "Web User already exists?"
-  omero logout

-  omero config set omero.web.database\_engine 'sqlite3'
-  omero config set omero.web.server\_list ''$OMERO\_HOST'", '$ROUTER',
   "omero?'
-  omero config set omero.web.debug True
-  omero web unittest --config=$ICE\_CONFIG --test=webadmin

Confirmation of the technical setup

-  bin/omero config set omero.web.database\_engine sqlite3
-  $ bin/omero web unittest --test=webadmin --config=[Ice location]
   ice.config
-  PATH to ice.config
-  OMERO/dist/ice.config

    **Command line tests**

-  Move to

   -  cd omero
   -  bin/omero -h

-  Config test

   -  $ bin/omero config def
   -  Returns = default
   -  $ bin/omero config get
   -  Returns =
   -  $ bin/omero config set example "my first value"
   -  $ bin/omero config get
   -  Returns = example=my first value

-  **User Test**

   -  **$ bin/omero import**
   -  testing the full set of option with bin/omero user these are:

      -  add
      -  list
      -  password

-  **Web cmd test**

   -  For each test run bin/omero web with the additional command.
   -  Start - the OMERO.web server
   -  Run the command status and confirm the status of the web server
      has started.
   -  Run the command config and confirm a output config template for
      server
   -  Run the command gateway and execute the code below (See
      ` PythonClientBeginners <http://trac.openmicroscopy.org.uk/ome/wiki/PythonClientBeginners>`_
      for additional information.)

      ::

          from omero.gateway import BlitzGateway
          conn = BlitzGateway("USER", "PASSWORD", host="SERVER_YOU_WANT_TO_TEST", port=4064)
          conn.connect()
          for p in conn.listProjects(
              print p.getName()
              for dataset in p.listChildren(
                  print "  ", dataset.getName()

-  Run the command stop
-  Run the command config and confirm the status of the web server has
   stopped.

-  **Shell cmd test**

   -  Run bin/omero shell to start IPython
   -  ensure IPython starts.
   -  Once in execute the following commands ensuring they return the
      correct information.

      -  import Ice
      -  import omero
      -  omero.model.ImageI() [This command imports an image]
      -  client.sf.getAdminContext().getEventContext() [The expected
         output of this command is the return of the current login info]

-  **Group cmd test**
-  For each test run bin/omero group with the additional command.

   -  Run the command add private cmdtest
   -  Run the command list and view the current groups
   -  Run the command insert and ensure the user is added to the group

See
` http://trac.openmicroscopy.org.uk/ome/wiki/OmeroCli <http://trac.openmicroscopy.org.uk/ome/wiki/OmeroCli>`_
for further information on the range of commands.

31. DropBox? Tests
~~~~~~~~~~~~~~~~~~

31.1\ `DropBox Mac OS server </ome/wiki/TestingScenarios/DropBoxMacOsServer>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

31.1 DropBox Mac OS server
~~~~~~~~~~~~~~~~~~~~~~~~~~

**\* Prerequisites: local server - user creates a folder
DropBox/username in local binary repository.**

**\* Note: For moving the scenario forward a remote server: a
DropBox/username folder exists that the user has write access to will be
implemented.**

**\* Note: images are not imported into a dataset so the images will be
orphaned.**

-  Create a subfolder under DropBox called root.

-  Copy a single image file into DropBox/root

    Wait at least a couple of minutes Check it is imported using a
    client.

-  Create a subfolder under DropBox/root called somename

   -  Copy an image file that has a companion file (e.g. dv and log)
      into somename
   -  Wait 30 seconds
   -  Copy the companion file into somename
   -  Wait at least a couple of minutes
   -  Check it is imported using a client and that companion file is
      there.
   -  (If you initially wait more than 60 seconds the companion file
      should not be attached. Could check?)

-  Create a subfolder DropBox/root/someothername

   -  Copy the companion file into DropBox/root/someothername
   -  Wait 30 seconds
   -  Copy the associated image file into DropBox/root/someothername
   -  Wait at least a couple of minutes
   -  Check it is imported using a client and that companion file is
      there.
   -  (If you initially wait more than 60 seconds the companion file
      should not be attached. Could check?)

-  Copy a folder containing several images/companion files into
   DropBox/root

   -  Wait at least a couple of minutes
   -  Check they are all imported using a client.

-  Copy a nested folder containing a SPW files into DropBox/root

   -  Wait at least a couple of minutes.
   -  Check they it is imported using a client.

31.2\ `DropBox Windows server </ome/wiki/TestingScenarios/DropBoxWindowsServer>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

31.2 DropBox Windows server
~~~~~~~~~~~~~~~~~~~~~~~~~~~

**\* Prerequisites: local server - user creates a folder
DropBox/username in local binary repository.**

**\* Note: For moving the scenario forward a remote server: a
DropBox/username folder exists that the user has write access to will be
implemented.**

**\* Note: images are not imported into a dataset so the images will be
orphaned.**

-  Create a subfolder under DropBox called root.

-  Create a subfolder under DropBox called root.

-  Copy a single image file into DropBox/root

    Wait at least a couple of minutes Check it is imported using a
    client.

-  Create a subfolder under DropBox/root called somename

   -  Copy an image file that has a companion file (e.g. dv and log)
      into somename
   -  Wait 30 seconds
   -  Copy the companion file into somename
   -  Wait at least a couple of minutes
   -  Check it is imported using a client and that companion file is
      there.
   -  (If you initially wait more than 60 seconds the companion file
      should not be attached. Could check?)

-  Create a subfolder DropBox/root/someothername

   -  Copy the companion file into DropBox/root/someothername
   -  Wait 30 seconds
   -  Copy the associated image file into DropBox/root/someothername
   -  Wait at least a couple of minutes
   -  Check it is imported using a client and that companion file is
      there.
   -  (If you initially wait more than 60 seconds the companion file
      should not be attached. Could check?)

-  Copy a folder containing several images/companion files into
   DropBox/root

   -  Wait at least a couple of minutes
   -  Check they are all imported using a client.

-  Copy a nested folder containing a SPW files into DropBox/root

   -  Wait at least a couple of minutes.

      -  Check they it is imported using a client.

31.3\ `DropBox Linux server </ome/wiki/TestingScenarios/DropBoxLinuxServer>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

31.3 DropBox Linux server
~~~~~~~~~~~~~~~~~~~~~~~~~

**\* Prerequisites: local server - user creates a folder
DropBox/username in local binary repository.**

**\* Note: For moving the scenario forward a remote server: a
DropBox/username folder exists that the user has write access to will be
implemented.**

**\* Note: images are not imported into a dataset so the images will be
orphaned.**

-  Create a subfolder under DropBox called root.

-  Create a subfolder under DropBox called root.

-  Copy a single image file into DropBox/root

    Wait at least a couple of minutes Check it is imported using a
    client.

-  Create a subfolder under DropBox/root called somename

   -  Copy an image file that has a companion file (e.g. dv and log)
      into somename
   -  Wait 30 seconds
   -  Copy the companion file into somename
   -  Wait at least a couple of minutes
   -  Check it is imported using a client and that companion file is
      there.
   -  (If you initially wait more than 60 seconds the companion file
      should not be attached. Could check?)

-  Create a subfolder DropBox/root/someothername

   -  Copy the companion file into DropBox/root/someothername
   -  Wait 30 seconds
   -  Copy the associated image file into DropBox/root/someothername
   -  Wait at least a couple of minutes
   -  Check it is imported using a client and that companion file is
      there.
   -  (If you initially wait more than 60 seconds the companion file
      should not be attached. Could check?)

-  Copy a folder containing several images/companion files into
   DropBox/root

   -  Wait at least a couple of minutes
   -  Check they are all imported using a client.

-  Copy a nested folder containing a SPW files into DropBox/root

   -  Wait at least a couple of minutes.
   -  Check they it is imported using a client.

32\ `Omero.data.dir Files </ome/wiki/TestingScenarios/OmeroDataDirFiles>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

32 Omero.data.dir Files
-----------------------

**Prerequisite a folder set with ownership permissions and folder
without permissions set.**

-  Modify the omero.data.dir according to
   ` http://openmicroscopy.org/site/support/omero4/server/binary-repository <http://openmicroscopy.org/site/support/omero4/server/binary-repository>`_
   to a new directory you can write to.
-  Run bin/omero admin diagnostics ensuring that new omero.data.dir is
   picked up.
-  Modifiy the omero.data.dir according to
   ` http://openmicroscopy.org/site/support/omero4/server/binary-repository <http://openmicroscopy.org/site/support/omero4/server/binary-repository>`_
   to a new directory you CANNOT write to
-  Run bin/omero admin diagnostics ensuring that new omero.data.dir is
   picked up and a permissions error is displayed.
-  Check that bin/omero admin start (starting the server) produces a
   permissions error.

33\ `Omero Search </ome/wiki/TestingScenarios/OmeroSearch>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

33 Omero Search
---------------

**Prerequisite PENDING - This data needs to be pre- defined as set out
in `#5652 </ome/ticket/5652>`_**

-  Search on several terms using the ? symbol

   -  Check the correct terms are returned.

-  Search on several terms using the \* symbol

   -  Check the correct terms are returned.

**Advanced Search**

-  Search several terms within the field "At least one of the words"

   -  Check the correct terms are returned.

-  Search several terms within the field "Must contain one of the words"

   -  Check the correct terms are returned.

-  Search several terms within the field "Without the words"

   -  Check the correct terms are returned.

**Tag search**

-  Add several memormal tags to images.
-  Click load existing tags to search by
-  Confirm the tags added are searched by.

**Context search**

-  Search on

   -  Name and ensure the correct term is returned.
   -  Comments and ensure the correct term is returned.
   -  URL and ensure the correct term is returned.
   -  Description and ensure the correct term is returned
   -  Tags and ensure the correct term is returned
   -  Attachments and ensure the correct term is returned

**Date Search**

-  Set search on Created
-  Search several terms within any date

   -  Check the correct terms are returned.

-  Search several terms within last 30 days

   -  Check the correct terms are returned.

-  Search several terms within a specified date range.

   -  Check the correct terms are returned.

-  Set search on Created
-  Search several terms within any date

   -  Check the correct terms are returned.

-  Search several terms within last 60 days

   -  Check the correct terms are returned.

-  Search several terms within a specified date range.

   -  Check the correct terms are returned.

33.1\ `Omero Search-Groups </ome/wiki/TestingScenarios/OmeroSearchGroups>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

33.1 Omero Search-Groups
------------------------

**Prerequisite: The scenario requires the creation of a collaborative
read only group and a collaborative group. All these groups need to be
created with at least 3 members with datasets images with annotated
information on the dataset and images of comments, tags and rated.**

-  Log into the collaborative read only group.
-  Search on several terms using the ? symbol

   -  Check the correct terms are returned.

-  Search on several terms using the \* symbol

   -  Check the correct terms are returned.

**Advanced Search**

-  Search several terms within the field "At least one of the words"

   -  Check the correct terms are returned.

-  Search several terms within the field "Must contain one of the words"

   -  Check the correct terms are returned.

-  Search several terms within the field "Without the words"

   -  Check the correct terms are returned.

**Tag search**

-  Add several memormal tags to images.
-  Click load existing tags to search by
-  Confirm the tags added are searched by.

**Context search**

-  Search on

   -  Name and ensure the correct term is returned.
   -  Comments and ensure the correct term is returned.
   -  URL and ensure the correct term is returned.
   -  Description and ensure the correct term is returned
   -  Tags and ensure the correct term is returned
   -  Attachments and ensure the correct term is returned

**Date Search**

-  Set search on Created
-  Search several terms within any date

   -  Check the correct terms are returned.

-  Search several terms within last 30 days

   -  Check the correct terms are returned.

-  Search several terms within a specified date range.

   -  Check the correct terms are returned.

-  Set search on Created
-  Search several terms within any date

   -  Check the correct terms are returned.

-  Search several terms within last 60 days

   -  Check the correct terms are returned.

-  Search several terms within a specified date range.

   -  Check the correct terms are returned.

-  Repeat the above steps from the context of on the collaborative
   group.

33.2\ `Omero Search-Filter </ome/wiki/TestingScenarios/OmeroSearchFilter>`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

33.2 Omero Search-Filter
------------------------

**Prerequisite a dataset with images rated, comments and tags**

-  Filter on a dataset with ' \* or better'

   -  Check the correct results are returned.

-  Filter on a dataset with ' **\* or better'**

   -  Check the correct results are returned.

-  Filter on a dataset with ' ****\ \* '

   -  Check the correct results are returned.

-  Filter on a dataset for unrated

   -  Check the correct results are returned.

-  Filter on a dataset name

   -  Check the correct results are returned.

-  Filter on a tag

   -  Check the correct results are returned.

-  Filter on comments

   -  Check the correct results are returned.

-  Filter on tagged

   -  Check the correct results are returned.

-  Filter on untagged

   -  Check the correct results are returned.

-  Filter on commented

   -  Check the correct results are returned.

-  Filter on uncommented

   -  Check the correct results are returned.

-  Filter elements in workspace
-  Load tags to filter by
-  Repeat the above process under the tags section on the left hand
   panel.

34. `Web Open Astex Viewer </ome/wiki/TestingScenarios/WebOpenAstexViewer>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

34. Web: Open Astex Viewer
--------------------------

**Implemented for 4.3.2 release**

-  Choose a map from from
   ` http://emdatabank.org/recententries.html <http://emdatabank.org/recententries.html>`_

   -  Click on 'PDBe' for an entry that looks cool!
   -  Best to have a reasonably big map - over 120x120x120. See 'Map
      Information'
   -  Go to Downloads and grab the map.gz, unzip and import! (Maybe grab
      a couple while you're there?)

-  View the image in web: you should see an option for 'Volume Viewer'
   in the web metadata pane for that image
-  Open the Volume viewer. You should get Java Applet with volume
   displayed.
-  Zoom, rotate, pan.
-  Various controls

   -  Wire-frame vv solid
   -  Adjust contour level. You should see "something" for all but the
      extreme ranges.
   -  Try loading a larger map (not scaled down). This option won't
      appear if the original is below 120
   -  Try loading 'raw' data (float). This option won't appear if it's
      not a float pixel type (most are)
   -  NB - for large or complex images this step may fail.
   -  Adjust the contours again to check they are working with float
      values.

35. `Bio-Formats ImageJ Plugin </ome/wiki/TestingScenarios/BioFormatsImagejPlugin>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

35. Bio-Formats ImageJ Plugin
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Implemented for the 4.3.2 release - Pending completion**

-  Download the latest version of ImageJ
-  Download (and install) the ImageJ OMERO plugins both

   -  loci\_tools.jar

-  Select Plugins > OMERO
-  Enter in your OMERO server credentials.
-  Open Plugins > OME > Download from OMERO
   (`#6598 </ome/ticket/6598>`_)
-  Enter the server details, port, username, password, and image id.
-  Click ok
-  Select display metadata and autoscale from bio-format import options.
-  Ensure the image opens.

36. `VM Testing </ome/wiki/TestingScenarios/VirtualMachineTesting>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

36. Virtual Machine Testing
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Documentation for working with the Virtual Appliance is to be found
here:
` https://www.openmicroscopy.org.uk/site/support/omero432/getting-started/demo/virtual\_appliance <https://www.openmicroscopy.org.uk/site/support/omero432/getting-started/demo/virtual_appliance>`_
This is especially useful for instructions on setting up port forwarding
after appliance install. **You should also be aware that the OVA is
~1.1GB so if you are testing from home it might be worth downloading the
OVA from the office before heading out, (up to 2 hours if less than
200Kb/sec)**

Appliance Import Testing
------------------------

-  If you do not have VirtualBox installed then download it from
   ` http://www.virtualbox.org/wiki/Downloads <http://www.virtualbox.org/wiki/Downloads>`_
   & follow the installation instructions.
-  Download the last QA virtual appliance which should be named
   omero-vm.ova from
   :jenkins:`here <job/OMERO-trunk-virtualbox/lastSuccessfulBuild/artifact/src/docs/install/VM/omero-vm.ova>`.
-  Start VirtualBox and select File >> Import Appliance
-  Accept the defaults offered by VirtualBox and follow the on screen
   prompts until your appliance is imported. At this point there should
   be a new virtual machine located in your virtual machine library.
-  Select the omero-vm virtual machine then click the start button from
   the menu bar.
-  NB. Check port forwarding. If no port forwarding is set up then use
   the script (from here:
   ` http://www.openmicroscopy.org.uk/site/support/omero432/getting-started/demo/scripts/setup\_port\_forwarding.sh <http://www.openmicroscopy.org.uk/site/support/omero432/getting-started/demo/scripts/setup_port_forwarding.sh>`_)
   to set up port forwarding, e.g.

        $ bash setup\_port\_forwarding.sh omero-vm

-  Your VM should now boot. This completes the first phase of the VM
   testing.

The following two scenarios assume that the appliance import phase has
completed successfully.

Virtualised OMERO.server Testing (A) Using an OMERO.client
----------------------------------------------------------

-  Start your omero VM
-  Connect to your VM using OMERO.insight in your host environment
   [SERVER ADDRESS=localhost SERVER PORT=4064, USERNAME=root,
   PASSWORD=omero]
-  Import a couple of test images into your virtual OMERO.server using
   insight importer as usual.

Virtualised OMERO.server Testing (B) Using the CLI
--------------------------------------------------

-  Log into your Omero VM using SSH. In a shell run:

        $ ssh -p 2222 omero@localhost

-  Use password "omero" when prompted.
-  This should give you a shell on the VM.
-  Run the Omero diagnostics command. Assuming that OMERO.server is
   correctly installed this should work as expected for a native
   install.

        $ omero admin diagnostics

You should see in terminal

::

    ================================================================================
    OMERO Diagnostics $OMERO_Version
    ================================================================================

Then after 20 seconds

::

    Commands:   java -version                  1.6.0     (/usr/bin/java)
    Commands:   python -V                      2.6.6     (/usr/bin/python)
    Commands:   icegridnode --version          3.3.1     (/usr/bin/icegridnode)
    Commands:   icegridadmin --version         3.3.1     (/usr/bin/icegridadmin)
    Commands:   psql --version                 8.4.8     (/usr/bin/psql -- 2 others)

    Server:     icegridnode                    running
    Server:     Blitz-0                        active (pid = 982, enabled)
    Server:     DropBox                        active (pid = 1249, enabled)
    Server:     FileServer                     active (pid = 996, enabled)
    Server:     Indexer-0                      active (pid = 1002, enabled)
    Server:     MonitorServer                  active (pid = 1003, enabled)
    Server:     OMERO.Glacier2                 active (pid = 1004, enabled)
    Server:     OMERO.IceStorm                 active (pid = 1005, enabled)
    Server:     PixelData-0                    active (pid = 1006, enabled)
    Server:     Processor-0                    active (pid = 1007, enabled)
    Server:     Tables-0                       active (pid = 1010, enabled)
    Server:     TestDropBox                    inactive (enabled)

    Log dir:    /home/omero/OMERO.server/var/log exists

    Log files:  .Blitz-0.log.swp               16.0 KB      
    Log files:  Blitz-0.log                    165.0 KB      errors=6    warnings=6   
    Log files:  DropBox.log                    8.0 KB        errors=2    warnings=3   
    Log files:  FileServer.log                 1.0 KB       
    Log files:  Indexer-0.log                  66.0 KB       errors=2    warnings=1   
    Log files:  MonitorServer.log              4.0 KB        errors=0    warnings=2   
    Log files:  OMEROweb.log                   0.0 KB       
    Log files:  PixelData-0.log                17.0 KB       errors=2    warnings=0   
    Log files:  Processor-0.log                4.0 KB        errors=0    warnings=1   
    Log files:  Tables-0.log                   4.0 KB        errors=0    warnings=1   
    Log files:  TestDropBox.log                n/a
    Log files:  master.err                     2.0 KB       
    Log files:  master.out                     0.0 KB       
    Log files:  Total size                     0.29 MB

    Parsing Blitz-0.log:[line:105] => Server restarted <= 
    Parsing Blitz-0.log:[line:486] => Server restarted <= 
    Parsing Blitz-0.log:[line:684] Your postgres hostname and/or port is invalid 
    Parsing Blitz-0.log:[line:783] => Server restarted <= 
    Parsing Blitz-0.log:[line:1082] => Server restarted <= 

    Environment:OMERO_HOME=(unset)             
    Environment:OMERO_NODE=(unset)             
    Environment:OMERO_MASTER=(unset)           
    Environment:PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/lib/jvm/java-6-sun/bin:/usr/lib/jvm/java-6-sun/bin:/usr/share/Ice-3.3.1:/usr/lib/postgresql/8.4/bin:/home/omero/OMERO.server/bin 
    Environment:ICE_HOME=/usr/share/Ice-3.3.1  
    Environment:LD_LIBRARY_PATH=/usr/share/java:/usr/lib: 
    Environment:DYLD_LIBRARY_PATH=/usr/share/java:/usr/lib: 

    OMERO data dir: '/home/omero/OMERO.data'    Exists? True    Is writable? True
    OMERO.web status... [NOT STARTED]

37. `File Format Metadata Validation </ome/wiki/TestingScenarios/FileFormatMetadataValidation>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

37. File Format Metadata Validation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Prerequisites open the following metadata excel spreadsheets stored in
test images good, they are in the following folders on squig**

-  lif/Original Metadata - free edge 6.xls
-  lei/Original Metadata - 050118\_07-01-a\_ch00.xls
-  lsm/Original Metadata - 2chZT.xls
-  /sis/glen/Original Metadata - CG 3.31 10K.xls

-  Import each of the following file formats into OMERO

   -  lif/free-edge 6.lif
   -  lei/050118.lei
   -  lsm/2chZT.lsm
   -  /sis/glen/CG 3.31 10K.tif

-  Cross reference the metadata values in OMERO of each file format with
   the values shown in each of the excel spreadsheets to ensure that the
   metadata has been imported correctly.

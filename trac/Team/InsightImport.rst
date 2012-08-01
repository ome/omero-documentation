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

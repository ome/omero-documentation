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

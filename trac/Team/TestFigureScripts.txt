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

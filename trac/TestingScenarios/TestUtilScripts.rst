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

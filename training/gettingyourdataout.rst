Getting Your Data Out of OMERO 


Overview

   This page describes how to export, save, and publish your images image files stored in OMERO. 



Export to OME-TIFF
 
The OMERO.insight client allows exporting of full image stack and associated metadata to the OME-TIFF file format. This feature is available for all images on the OMERO server. In the metadata browser panel found on the right hand side, locate the export icon. This will bring up the Export dialogue box that will ask you to specify browse to a location you wish to save the image to.

(A joint screenshot showing the selection of the download and then the output of the saved image)

Export a report
By selecting a dataset, it is possible to generate a report about this dataset. This exports a summary of all the Tags on the images in this dataset, as well as image thumbnails.

(A joint screenshot showing the selection of the report and then the output to excel)


Export Thumbnails

(I would like to check/discuss this option)


Save the Image rendering settings

In the image viewer there is a  icon which allows you to save the rendering to disk as an image file. Images can be saved for the Image, Split and Projection view modes.

(A joint screenshot showing the selection of the save and then the output of the saved image files)



Publishing Options
In the metadata browser panel found on the right hand side, locate the  icon. Pressing this icon will bring up the publishing tools as shown below.

(Screenshot - showing drop down menu with the possible options and then the 4 subsequent figure outputs)

Make Movie - This creates a movie for your image. You are able to specify the Z and T ranges of frames to use. Select a scale bar to be displayed and if labels should be shown.

Split View Figure - Choose one or more images to be arranged in a split-view with one image per row. When making the image you can decide which channels should be shown as split panes and which are in the merged image.

ROI Split Figure - If a rectangle ROI has previously been defined for an image (or images), then this figure will display the ROI as a larger panel to the right of the main image, zoomed by a chosen factor. The zoomed ROI will be split into selected channels, as for the split-view figure. Images can be labeled with their name, the name of their dataset(s) or associated tags.

Thumbnail Figure - This creates a figure of thumbnails, either using the currently selected images or all the images within a dataset. The date range of the images is displayed on the figure, and it is also possible to choose a list of tags to sort the images by.
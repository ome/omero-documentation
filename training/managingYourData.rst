Managing Your Data
==================

Overview

   This page describes the OMERO.insight Client Data Manager.



The Data Manager

The OMERO.insight default view is made up of three sections: the Inspector Panel, the Working Area Panel and the Metadata Browser Panel. 



.. image:: graphx/managingyourdata_intro.png
 

The Inspector Panel

Navigating and Managing the Hierarchies
The standardised  view of the image data is in the Project, Dataset, Image hierarchy. Expanding the navigation tree allows you to see this structure. 


To create a new Project or Dataset select the icon and name the new Project or Dataset.


.. image:: graphx/managingyourdata_newproject.png







The Inspector Panel - Screens   

This will bring you a tree view to browse high content screening data in a hierarchy of screens and wells. Double clicking on the image will present the grid view of the wells, where individual images for the wells can be accessed.


(Screenshot 3: NOTE I will need permission to import Screening data in order to show this.)


Attachments
This view allows you to browse all attachments present on the OMERO system.


.. image:: graphx/managingyourdata_attachements.png





Tags   

This panel allows you to view all the tags that you have created and used in OMERO.  
A tag can belong to a parent object called a tag set. For example a typical arrangement can be: 

.. image:: graphx/managingyourdata_tags.png


(screenshot 5: a list of tags in a tag set with images shown in central panel.)


Images
This panel keeps a history of your imported images. It is possible to retrieve images based on the date that they where imported in the OMERO system.

[NOTE: There is currently no Screenshot as I am unsure if this is a piece of functionality that we 
      wish to promote given that is is scheduled to be updated.]

Search  

This panel allows you to search on the images within the OMERO system. The search term is entered in the field shown in highlighted area 1. The search field also supports multiple and single character wild card searching.
The search context allows you to search on the range of Name, Comments, URL, Description, Tags, and Attachments. This is displayed in the spotlighted area 2. The results of the search are presented in the central working area panel. Additional information about the results is shown in the highlighted area 3.
 

.. image:: graphx/managingyourdata_search.png


 



The Working Area Panel


The working area toolbar controls the various options to filter, organise, and sort images.  

.. image:: graphx/managingyourdata_workingarea.png

   
1 - Filter elements displayed in the workspace.      7 - Order images by acquisition date.
2 - Displays the filtering options.                  8 - Toggle on/off thumbnail magnification.
3 - View images as Thumbnails.                       9 - Create a new dataset with the selected images.
4 - View images in a list.                           10 - Create a tag report. 
5 - Refresh.                                         11 - Save the displayed thumbnails in excel. 
6 - Order elements by name.                          12 - Set the number of images per row. 




The Metadata Browser Panel


The metadata browser panel is made up of three tabs General, Acquisition, and Preview. 


General


The general tab contains information about your image such as:
 
 * Name 
 * Description 
 * 5 Image dimensions X,Y,Z,C,T
 * Pixel size in microns 


Additional information about the Project Dataset or Image can be added under Annotations. The Annotations that are supported are:

 * Rating
 * Tag
 * Attachment
 * Comments
 

.. image:: graphx/managingyourdata_general.png





1 - Save changes back to the server.      5 - Display the publishing options.
2 - Refresh.                              6 - Image filename.
3 - Open the image viewer.                7 - Further image information.
4 - Display the saving options.           8 - Annotations.

 


Acquisition 

The acquisition tab information provides all the acquisition information available in the original file. 
This includes information on:

 * Microscope 
 * Channels
 * Exposure times 



(NOTE:No screenshot as I will need a rich metadata image to complete this )



Preview

The preview panel displays a partial view of the image rendering settings. Within this panel the rendering 
settings for one image can be applied to all other images in the dataset by using the option apply to all. 

.. image:: graphx/managingyourdata_preview.png


(screenshot 12:highlight on toggle for channel settings, the slider for changing z,t for changing rendering and finally apply to all button)



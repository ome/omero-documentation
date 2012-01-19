How to import Data
##################

.. topic:: Overview

   This page describes how to import your data to an OMERO server.


Starting Import from OMERO.insight
----------------------------------
In order to begin the import of images into OMERO you need to click on the OMERO.insight importer icon.

..  image:: images/omero-insight-importer-iconlocation.png

 
You are then presented with the OMERO.insight Importer Window

.. image:: images/omero-insight-importfilechooser.png
   :width: 640px
   :height: 386px
   :alt: Omero.insight Importer Window


To import images with the OMERO.insight importer, the import process follows three steps of The File Selection, Location selection and Import.


The File Selection
-------------------

Use the *File Chooser* panel to browse and select the images.
 * Add the selected images to the *Files to Import* by pressing the |right| icon.
 * Single Image files can be removed from Files to Import using the |left| icon.
 * Alternatively the button |left2| can be used to remove all the image files from the import queue.


Location selection
-------------------
Select the file(s) to import by pressing the |right| icon when clicked on the location Selection window pops up as shown below.

.. image:: images/omero-insight-importer-selection.png

OMERO uses a Project/Dataset hierarchy structure and so a new Project/Dataset can be created for each import or if available an existing Project/Dataset can be selected.

The view for an existing project selection.

.. image:: images/omero-insight-importer-selection2.png
   :alt: OMERO.insight Importer New Project

Once the specific Project has been chosen the existing Datasets available are shown under the chosen Project.

.. image:: images/omero-insight-importer-selection3.png
   :alt: OMERO.insight Importer New Dataset

Alternatively a new Project and/or Dataset can be created

.. image:: images/omero-insight-importer-newdataset.png
   :width: 640px
   :height: 386px
   :alt: OMERO.insight Importer New Dataset

Once the Project/Dataset has been created the selected images will reside in the import queue panel with the details of the files/folder the size of the file and its location within the chosen Project/Dataset. 

.. image:: images/omero-insight-importfoldername2.png
   :width: 640px
   :height: 386px
   :alt: OMERO.insight Importer

New From Folder Import
----------------------------

The client importer also supports the ability for the chosen Dataset to reflect the chosen folder name.  This is demonstrated in the case below where the folder ``28-09-2001 experiment 1`` has been selected with the option ``--New From Folder--`` in the Dataset selection.

.. image:: images/omero-insight-importfoldername.png
   :width: 640px
   :height: 386px
   :alt: OMERO.insight Importer

With this selection made when added to the import queue the Dataset created now takes on the folder name. In this screenshot below, the Dataset name is ``28-09-2001 experiment 1``. The confirmation of this action is displayed in the import queue panel with the information shown in the Project/Dataset and the information set in the tick box for folder as Dataset.

.. image:: images/omero-insight-importfoldername2.png
   :width: 640px
   :height: 386px
   :alt: OMERO.insight Importer

Import
-------
When ready the image files can now be imported by clicking the import button.

.. image:: images/omero-insight-importbutton.png
   :width: 640px
   :height: 386px
   :alt: OMERO.insight Importer

On import, the *Import tab* will open as displayed below. 
The following information is presented in the *Import tab*:

  * The  number of files/folders imported.
  * The  number of cancellations if any.
  * The import start time and the duration of the import.
  * The names of any tags if any.


 
On the completion of the import, the highlighted blue link takes you to the location of your imported images in the Data Manager.

.. image:: images/omero-insight-completedimport.png
   :width: 640px
   :height: 386px

View of the imported data in the Data Manager

.. image:: images/omero-insight-completedimport2.png
   :width: 640px
   :height: 363px


The Import tab also displays the image thumbnail, double-clicking on it launches the Image Viewer.

.. image:: images/omero-insight-thumbnailimport.png
   :width: 640px
   :height: 385px

`Exercise 1`_

Options
-------
File Naming
^^^^^^^^^^^
You can decide to modify the name of the imported file
  * Select an image for importing.
  * Select the *File Naming* section allows to select the name of the imported images shown below.

.. figure:: images/omero-insight-options-panel.png
   :width: 640px
   :height: 377px

   .. 

   * Select the option of Partial Version + Files Name - This will result in a shortened version of the file name e.g. ``myImage.tiff``.
   * Select the option Full Path + Files Name = This will result in a full version of a file name e.g. ``C:ScientificImages/Images/myImage.tiff``.
   * The option directories before a file allows for a customised version i.e. the short version plus a number of leading directories e.g.   ``Images/myImage.tiff``.
   * Click on Import to Add the image the file name information can be viewed in the data manager.

`Exercise 2`_

Tagging on Import
-----------------
The OMERO.Insight supports Tagging on Import. This feature can be found through the options setting.

.. image:: images/omero-insight-importoptionspanel2.png
   :width: 640px
   :height: 377px


.. image:: images/omero-insight-importaddedtags1.png
   :width: 640px
   :height: 456px

Once the tags have been added they may be viewed and removed from the list.

.. image:: images/omero-insight-importaddedtags2.png
   :width: 640px
   :height: 259px

On the completion of import, the tags will then be shown under the annotations panel in the Right-hand panel in the Data Manager.

.. image:: images/omero-insight-importaddedtags3.png
   :width: 640px
   :height: 297px

`Exercise 3`_

Support for High Content Screening Formats
------------------------------------------

OMERO supports the reading of several High Content Screening formats which are displayed in a Screen - Plate - Well hierarchy. If you are interested in this type of data, please ask for more information 

Exercises
---------

.. _`Exercise 1`: 

**Exercise 1**
  * Try importing an image.
  * Try importing an image with the dataset with the same name as the folder it is imported from.

.. _`Exercise 2`:

**Exercise #2**
 * Try importing an image with a Partial Version + Files Name.
 * Try importing an image with a Full Path + Files Name.

.. _`Exercise 3`:

**Exercise 3**
 * Try importing an image with a tag.

.. |right| image:: images/nuvola_1rightarrow22.png
           :alt: Add Button
.. |left| image:: images/nuvola_1leftarrow22.png
          :alt: Remove Button
.. |left2| image:: images/nuvola_2leftarrow22.png
          :alt: Remove All Button
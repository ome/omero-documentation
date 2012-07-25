.. _rst_tutorial_insight-import:

Importing Images in Insight
===========================

To get the list of file formats currently supported in OMERO, go to
`LOCI bio-formats library <http://www.loci.wisc.edu/software/bio-formats>`_.

In order to begin the import of images into an OMERO server, you need to:

-  Click the OMERO.Insight importer icon.

-  You are then presented with the OMERO.Insight Importer Window

.. raw:: html

   <p>

.. raw:: html

   </p>

To import images with the OMERO.insight importer, the import process follows three steps:

.. raw:: html

   <h2>

Step 1 File Selection

.. raw:: html

   </h2>

-  Use the File Chooser panel to browse and select the images.

.. raw:: html

   <p>

.. raw:: html

   </p>

.. raw:: html

   <p>
   <ul>
   <li>

Add the selected images to the Files to Import by pressing the icon.

.. raw:: html

   </li>
   <li>

Single Image files can be removed from Files to Import using the icon.

.. raw:: html

   </li>
   <li>

Alternatively the button can be used to remove all the image files from
the import queue.

.. raw:: html

   </li>
   </ul>

   </p>

   <h2>

Step 2 Location selection

.. raw:: html

   </h2>

   <ul>
      <li> 

On the selection of the file(s) to import by pressing the icon the
Location Selection window pops up.

.. raw:: html

   </li>
      <li> 

It is at this point of the process that the destination of the import is
determined.

.. raw:: html

   </li>
      <li> 

OMERO uses a Project/Dataset hierarchy structure and so a new
Project/Dataset can be created for each import or if available an
existing Project/Dataset can be selected.

.. raw:: html

   </li>

.. raw:: html

   </ul>

.. raw:: html

   <ul>
     <li>

Existing Project Selection.

.. raw:: html

   </li>
     

.. raw:: html

   <li>

Once the specific Project has been chosen the existing Dataset's
available are shown under the chosen Project.

.. raw:: html

   <li> 

Alternatively a new Project and/or Dataset can be created

.. raw:: html

   <p>

.. raw:: html

   </p>
   </li>

   <p>

Once the Project/Dataset has been created the selected images will
reside in the import queue panel with the details of the files/folder
the size of the file and its location within the chosen Project/Dataset.

.. raw:: html

   </p>  

.. raw:: html

   <h2> 

New From Folder Import

.. raw:: html

   </h2>

   <ul>
      <li> 

The client importer also supports the ability for the chosen Dataset to
reflect the chosen folder name. This is demonstrated in the case below
where the folder 27-06-11 has been selected with the option --New From
Folder-- in the Dataset selection.

.. raw:: html

   </li>

   <p>

.. raw:: html

   </p>
   <p> 

With this selection made when added to the import queue the Dataset
created now takes on the folder name. In this screenshot below, the
Dataset name is pngstack. The confirmation of this action is displayed
in the import queue panel with the information shown in the
Project/Dataset and the information set in the tick box for folder as
Dataset.

.. raw:: html

   </p>

   <p>

.. raw:: html

   </p>

   <h2> 

Step 3 Import

.. raw:: html

   </h2> 
   <ul>
   <li> 

When ready the image files can now be imported by clicking the import
button.

.. raw:: html

   <p>

.. raw:: html

   </p>
   <li>
   <p>

On import, the Import tab will open as displayed below. The following
information is presented in the Import tab:

.. raw:: html

   <ul>
          <li> 

the number of files/folders imported

.. raw:: html

   </li>
          <li> 

when the import started and the duration of the import.

.. raw:: html

   </li>
   </ul>
   </p>
   <p>

.. raw:: html

   </p>
    <p>

On completion of the import, an hyperlink indicating the location of the
import is displayed allowing users to browse the dataset.

.. raw:: html

   </p>
    <p>

::

    <img src="images/completed-import3-client-importer.png" alt="Insight Importer"> 
     </p>

.. raw:: html

   <p>

.. raw:: html

   </p>

.. raw:: html

   <p> 
   <li> 

The import tab also displays the image thumbnail, double-clicking on it
launches the Image Viewer. If no thumbnail displayed, a View Button will
be available, just click to launch the viewer.

.. raw:: html

   </li>

   </p>
   <p>

.. raw:: html

   </p>
   <p>

.. raw:: html

   </p>
   </ul>


   <h2> 

Options

.. raw:: html

   </h2>

   <h3> 

File Naming

.. raw:: html

   </h3> 
   <ul> 
   <li> 

Select or Add a project and dataset where to import the images.

.. raw:: html

   </li>
   <li> 

The File Naming section allows to select the name of the imported images

.. raw:: html

   </li>
   <li> 

Partial Version + Files Name - This is a short version e.g. myImage.tiff

.. raw:: html

   </li>
   <li> 

Full Path + Files Name = This is a full version e.g.
C:ScientificImages/Images/myImage.tiff

.. raw:: html

   </li>
   <li> 

Directories before a file - This is a customised version i.e. the short
version plus a number of leading directories e.g. Images/myImage.tiff

.. raw:: html

   </li>
   <li> 

Click on Import to Add to Queue button.

.. raw:: html

   </li>
   </ul> 
   <h3> 

Tagging on Import

.. raw:: html

   </h3>
   <p> 

The OMERO.Insight supports Tagging on Import. This feature can be found
through
the options setting.

.. raw:: html

   </p>

.. raw:: html

   <ul> 
     

.. raw:: html

   <li> 

Once the tags have been added they may be viewed to from the list.

.. raw:: html

   </li>

.. raw:: html

   <li> 

On the completion of import, the tags will then be shown under the
annotations panel in the Right-hand panel in the Data Manager.

.. raw:: html

   </li>

.. raw:: html

   </ul>


   <h3> 

Toggle between Single Image Formats vs. Screening Formats

.. raw:: html

   </h3>
   <ul>
   <li> 

The client also now supports toggling between single - or project-based
images that typically go into 'datasets' or screen-based image sets that
typically go into 'screens'.

.. raw:: html

   </li>
   <li> 

To toggle between these two views in the importer clicking on the
Location icon will switch the view.

.. raw:: html

   </li>



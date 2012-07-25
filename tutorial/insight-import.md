Importing Images in Insight

To get the list of file formats currently supported in OMERO, go to [LOCI bio-formats library] (http://www.loci.wisc.edu/ome/formats.html).

In order to begin the import of images into an OMERO server, you need to:

 * Click the OMERO.Insight importer icon. 

 <img src="images/Insight-Importer-Icon.png" alt="Insight Importer Icon" >


 * You are then presented with the OMERO.Insight Importer Window

<p>
<img src="images/Import-window2-client-importer.png" alt="Insight Importer Window">
</p>

<br /> To import images with the OMERO.insight importer, the import process follows three steps:<br />


<h2>Step 1 File Selection</h2>

  * Use the <i>File Chooser</i> panel to browse and select the images.

<p>
<img src="images/File-chooser-panel-Client-importer.png" alt="Insight Importer Window">
</p>

<br />
<p>
<ul>
<li>Add the selected images to the <i>Files to Import</i> by pressing the <img src="images/nuvola_1rightarrow22.png" alt="Add Button"> icon.</li>
<li>Single Image files can be removed from Files to Import using the <img src="images/nuvola_1leftarrow22.png" alt="Remove Button"> icon.</li>
<li>Alternatively the button <img src="images/nuvola_2leftarrow22.png" alt="Remove All Button"> can be used to remove all the image files from the import queue.</li>
</ul>
  
</p>

<h2>Step 2 Location selection</h2>

<ul>
   <li> On the selection of the file(s) to import by pressing the  <img src="images/nuvola_1rightarrow22.png" alt="Add Button"> icon the Location Selection window pops up.  </li>
   <li> It is at this point of the process that the destination of the import is determined. </li>
   <li> OMERO uses a Project/Dataset hierarchy structure and so a new Project/Dataset can be created for each import or if available an existing Project/Dataset can be selected.</li>
<br />

<img src="images/Location-selection2-Client-importer.png" alt="Insight Importer"> 

</ul>

 <br />
 <ul>
  <li>Existing Project Selection.</li>
  <img src="images/Project-selection-client-importer.png" alt="Insight Importer New Project">  

   <br />
   <li>Once the specific Project has been chosen the existing Dataset's available are shown under the chosen Project. 
  

<img src="images/Dataset-selection2-client-importer.png" alt="Insight Importer New Dataset"> 


   <br />
   <li> Alternatively a new Project and/or Dataset can be created   
<br />

<p>
<img src="images/new-dataset-client-importer.png" alt="Insight Importer New Dataset">
</p>
</li>

<p>
Once the Project/Dataset has been created the selected images will reside in the import queue panel with the details of the files/folder the size of the file and its location within the chosen Project/Dataset.
</p>  
<br>
<img src="images/import-queue1-client-importer.png" alt="Insight Importer">
<br />

<h2> New From Folder Import </h2>

<ul>
   <li> The client importer also supports the ability for the chosen Dataset to reflect the chosen folder name.  This is demonstrated in the case below where the folder 27-06-11 has been selected with the option --New From Folder-- in the Dataset selection.</li>

<p>
<img src="images/Import-folder-folder-name-client-importer.png" alt="Insight Importer"> 
</p>
<p> With this selection made when added to the import queue the Dataset created now takes on the folder name. In this screenshot below, the Dataset name is pngstack. The confirmation of this action is displayed in the import queue panel with the information shown in the Project/Dataset and the information set in the tick box for folder as Dataset. 
</p>

<p>
<img src="images/Folder-import-client-importer.png" alt="Insight Importer"> 
</p>

<h2> Step 3 Import</h2> 
<ul>
<li> When ready the image files can now be imported by clicking the import button.
<p>
<img src="images/import-button-client importer.png" alt="Insight Importer"> 
</p>
<li>
<p>
On import, the <i>Import tab</i> will open as displayed below. The following information is presented in the <i>Import tab</i>:
    <ul>
       <li> the  number of files/folders imported</li>
       <li> when the import started and the duration of the import.</li>
</ul>
</p>
<p>
<img src="images/Ongoing-import2-client-importer.png" alt="Insight Importer"> 
  </p>
 <p>
On completion of the import, an hyperlink indicating the location of the import is displayed allowing users to browse the dataset.
 </p>
 <p>
     
    <img src="images/completed-import3-client-importer.png" alt="Insight Importer"> 
     </p>
<p>
<img src="images/link-from-import-client-importer.png" alt="Insight Importer"> 
     </p>

  <p> 
<li> The import tab also displays the image thumbnail, double-clicking on it launches the Image Viewer.  If no thumbnail displayed, a <i>View</i> Button will be available, just click to launch the viewer.
</li>
 
</p>
<p>
<img src="images/Thumbnail%20import-client-importer.png" alt="Insight Importer"> 
</p>
<p>
<img src="images/import-image-viewer-%20client-importer.png" alt="Insight Importer"> 
</p>
</ul>


<h2> Options </h2>

<h3> File Naming </h3> 
<ul> 
<li> Select or Add a project and dataset where to import the images. </li>
<li> The File Naming section allows to select the name of the imported images </li>
<li> Partial Version + Files Name - This is a short version e.g. myImage.tiff</li>
<li> Full Path + Files Name = This is a full version e.g. C:ScientificImages/Images/myImage.tiff</li>
<li> Directories before a file -  This is a customised version i.e. the short version plus a number of leading directories e.g. Images/myImage.tiff</li>
<li> Click on Import to Add to Queue button. </li>
</ul> 
<h3> Tagging on Import </h3>
<p> 
The OMERO.Insight supports Tagging on Import. This feature can be found through  
the options setting. 
</p>

  <img src="images/tag-list-client-importer.png" alt="Insight Importer">  
  <ul> 
  <br />
  <li> Once the tags have been added they may be viewed to from the list.</li>

  <img src="images/added-tags1-client-importer.png" alt="Insight Importer">  

<li> On the completion of import, the tags will then be shown under the annotations panel in the Right-hand panel in the Data Manager.</li>

<img src="images/Imported-with-tags-client-importer.png" alt="Insight Importer"> 
</ul>


<h3> Toggle between Single Image Formats vs. Screening Formats </h3>
<ul>
<li> The client also now supports toggling between single - or project-based images that typically go into 'datasets' or screen-based image sets that typically go into 'screens'.</li>
<li> To toggle between these two views in the importer clicking on the Location icon will switch the view. </li>

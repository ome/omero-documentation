Managing Data

Back to OMERO.insight, 

 * Launch the OMERO.insight application.
 * Connect to the server (see [Getting Started] (getting-started)).

Once successfully logged in, the default view of the Data Manager will pop up on screen.
The Data Manager serves as the major portal for the user into his/her data hierarchies.

<img src="images/DataManager1.png" alt="Data Manager" height="70%" width="70%">

## Create Objects ##

<img src="images/DataManagerToolBar.png" alt="Data Manager Toolbar">

To create a new Project (resp. Dataset),

 * Expand the <b>Hierarchies</b> browser
 * Click on the 
<img src="images/nuvola_filenew16.png" alt="Managing Data"> icon.

The following window will pop up on screen

<img src="images/dmCreate.png" alt="Creating Data">

After pressing the `Create` button, a new Project (resp. Dataset) `e.g. Monday Acquisition` is created in the OMERO server, and displayed in the <b><i>Inspector</i></b>

To add a new Dataset to the Project `Monday Acquisition`:

 * Select the Project, then either

   * Right-click on the selected Project. Then select <b><i>New Dataset...</i></b> from the pop-up menu.
   * Or click on the <img src="images/nuvola_filenew16.png" alt="New File Button"> icon. 

 * The `Create` dialog will pop up.
 * Once created, the new Dataset will appear under the selected Project.
 
To create:

 * Tag or Tag Set, expand the <b>Tags</b> browser and click on the <img src="images/nuvola_filenew16.png" alt="New File Button"> icon.
 * Plate,  expand the <b>Screens</b> browser and click on the <img src="images/nuvola_filenew16.png" alt="New File Button"> icon.

## Manage ##

<img src="images/DataManagerToolBar1.png" alt="Tool Bar">

Using the <b><i>Inspector</i></b>, the user can 

 * <b>Cut</b> (i.e. unlink) Datasets (resp. Images) from a Project (resp. Dataset).
 * <b>Copy or Paste</b> Datasets (resp. Images) to a Project (resp. Dataset). This is <b>NOT</b> a deep copy i.e. a link between the Dataset (resp. Image) and the Project (resp. Dataset) is created. We view the possibility as a feature. The user can add the same Dataset (resp. Image) to several Projects (resp. Datasets) and only have one Dataset (resp. Image) to handle.
 * <b>Delete</b> Project, Dataset, Image, etc.

Same options are available for Plate, Screen, Tag Set and Tag.

## Working Area ##
The Working area is built and displayed when browsing data e.g. a Plate

<img src="images/DataManagerToolBar2.png" alt="Tool Bar">

 *  <b>Browsing</b> a Project (resp. Dataset, Plate):

    * Select the Project (resp. Dataset, Plate) in the <b><i>Inspector</i></b>.
    * Click on the <img src="images/thumbnail_view16.png" alt="Thumbnail View"> icon.

 * <b>Expanding</b> a Dataset, a Tag or a time interval.


<b>Working Area tool bar explained</b>

<img src="images/workingAreaToolbar.png" alt="Working Area">

The user can then filter the displayed images.

<img src="images/filter4.png" alt="Filter">

## Handle Metadata and Edit Object ##
OMERO offers the option to handle various types of annotation.

 * Rating
 * Comments
 * Tags
 * Attachments (PDF, Word, Excel, etc.)
 
<b>How to add, view metadata</b>

 * Select the Project, Dataset, Plate, or the Image(s) in the <b><i>Inspector</i></b> or <b><i>Working Area</i></b>
 * Go to the <b><i>Metadata Browser</i></b> i.e. Right-hand side.

<img src="images/dataManagerMetadata.png" alt="Data Manager Metadata">

 * To <b>Edit</b> the image's name, click on the <img src="images/nuvola_ksig12.png" alt="Edit Name Icon"> icon next to the name.

## Managing Image Attachments ##

Attachments can be downloaded, viewed, and deleted by clicking the double arrow beside each one. Note that unlinking an attachment from an image will remove the link between the two, but will <b>NOT</b> delete the attachment from the server.

<img src="images/annotationtab.png" alt="Annotation Tab">

## View Acquisition Metadata ##

The acquisition metadata read at import is displayed in the Right-hand panel under the <b>Acquisition</b> tab.

<img src="images/acquisitionPanel.png" alt="Acquisition Panel">

## Image Preview ##

The <b>Preview</b> tab on the Right-hand panel provides a mini preview window of your image and allows you to tune some of the rendering settings without having to launch the full image viewer.

<img src="images/previewTab.png" alt="Preview Tab">

## Search ##

Full text searching. You can also use wild-cards in your search e.g. *.dv will find all files ending with '.dv'.

<img src="images/dataManagerSearch.png" alt="Data Manager Search" height="80%" width="80%">

Importing Images

To get the list of file formats currently supported in OMERO, go to [LOCI bio-formats library] (http://www.loci.wisc.edu/ome/formats.html)

In order to import images into an OMERO server, you need to:

 * Launch the OMERO.importer application.
 * Connect to the server (see [Getting Started](getting-started)).

## Images Selection ##

One of the main issues is knowing which file to click on, during the import process. Part of the problem here is that the import supports over one hundred different file formats, some of which share common file names (most notably 'tiff' images). 

In almost all of these cases, the file format includes a metadata 'head' file with a different file extension, and this should be the file you select for import. Often the importer will be able to automatically determine which file format you are importing by selecting any of the files in the same directory as this head file, but in other cases, you will have to provide the importer with a 'hint' but selecting the right file for it before importing.

Some examples of file formats with multiple files include:

<div class="alt-table">
  <table>
    <thead>
      <tr>
        <th align="left" valign="bottom" bgcolor="#FFFFFF" style="border-bottom: 1px solid" width="200">
          <b>Format</b>
        </th>
        <th align="left" valign="bottom" bgcolor="#FFFFFF" style="border-bottom: 1px solid">
          <b>Main Extension</b>
        </th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>
          Flex
        </td>
        <td>
          .mea or .res
        </td>
      </tr>
      <tr>
        <td>
          InCell 1000
        </td>
        <td>
          .xdce
        </td>
      </tr>
      <tr>
        <td>
          Metamorph
        </td>
        <td>
          .nd or .stk
        </td>
      </tr>
      <tr>
        <td>
          Zeiss Laser Scanning Microscopy
        </td>
        <td>
          .lsm
        </td>
      </tr>
    </tbody>
  </table>
</div>

## Single Image Formats vs. Screening Formats ##

The other thing worth considering during import is the 'type' of image you are importing. Single- or project-based images typically go into 'datasets', where as screen-based image sets typically go into 'screens'. If you have properly selected the main file for the format (as described above), the importer will usually only let you import the file into the appropriate 'container' type (either a dataset or screen).

The other important thing to remember is that you cannot import two files of different types from the same directory, so do not mix your screening data with your dataset data! Doing so will generate a warning message in the importer and you will need to split the two file types apart before continuing.

## Import Image ##

<img src="images/importer_fileQueue.png" alt="File Queue" height="50%" width="50%">

 * User the <b><i>File Chooser</i></b> panel to browser and select the images.
 * Add the selected images to the <b><i>Import Queue</i></b> by pressing the <img src="images/importer_add16.png" alt="Add Button"> icon.
 * The ``Import`` window pops up (see below).

<img src="images/importer2.gif" alt="Importer">

## Where and How ##

 * Select or Add a project and dataset where to import the images.
 * The <b>File Naming</b> section allows to select the name of the imported images

    * <b>short</b> version e.g. ``myImage.tiff``
    * <b>full</b> version e.g. ``C:importantWork/stuff/myImage.tiff``
    * <b>customised</b> version i.e. the short version plus a number of leading directories e.g. ``stuff/myImage.tiff``
 * Press the ``Add to Queue`` button.
 
## Import ##
Once you have finished selecting images, press the ``Import`` button. You can view the progress in the ``Status`` column of the ``Import Queue``.
Deprecated Page: See `Importing
images. <http://www.openmicroscopy.org.uk/site/support/omero4/getting-started/tutorial/importing-images>`_

How to Work with Different Importer Formats
-------------------------------------------

This guide provides detailed examples for importing specific file
formats using the UI tools, and is meant to provide direction with some
common format problems you may encounter.

Formats with Multiple Images
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

One of the main issues is knowing which file to click on, during the
import process. Part of the problem here is that the import supports
over one hundred different file formats, some of which share common file
names (most notably 'tiff' images).

In almost all of these cases, the file format includes a metadata 'head'
file with a different file extension, and this should be the file you
select for import. Often the importer will be able to automatically
determine which file format you are importing by selecting any of the
files in the same directory as this head file, but in other cases, you
will have to provide the importer with a 'hint' but selecting the right
file for it before importing.

Some examples of file formats with multiple files include:

+-----------------------------------+----------------------+
| **Format**                        | **Main Extension**   |
+===================================+======================+
| Flex                              | .mea or .res         |
+-----------------------------------+----------------------+
| InCell 1000                       | .xdce                |
+-----------------------------------+----------------------+
| Metamorph                         | .nd or .stk          |
+-----------------------------------+----------------------+
| Zeiss Laser Scanning Microscopy   | .lsm                 |
+-----------------------------------+----------------------+

Other examples exist, but in general the easiest way to tell is by
reviewing the extensions available in the file format list of the
importer and seeing which extensions are available. Generally, the ones
at the front are the format's main extensions, where as TIFF derivatives
are usually 'sub files' for the format.

--------------

`|File Format Pulldown
List| </ome/attachment/wiki/ImporterHowTo/fileformatsexample.png>`_

--------------

*This example from the importer's pull down list illustrates that the
Metamorph STK format includes a number of different file types (.stk,
.nd, .tif, .tiff). The main extensions for this format are listed first,
(in this case .stk and .nd).*

Single Image Formats vs. Screening Formats
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The other thing worth considering during import is the 'type' of image
you are importing. Single- or project-based images typically go into
'datasets', where as screen-based image sets typically go into
'screens'. If you have properly selected the main file for the format
(as described above), the importer will usually only let you import the
file into the appropriate 'container' type (either a dataset or screen).

The other important thing to remember is that you cannot import two
files of different types from the same directory, so do not mix your
screening data with your dataset data! Doing so will generate a warning
message in the importer and you will need to split the two file types
apart before continuing.

Attachments
~~~~~~~~~~~

-  `fileformatsexample.png </ome/attachment/wiki/ImporterHowTo/fileformatsexample.png>`_
   `|Download| </ome/raw-attachment/wiki/ImporterHowTo/fileformatsexample.png>`_
   (49.9 KB) - added by *bwzloranger* `22
   ago. File Format Pulldown List

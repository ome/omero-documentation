Export images
-------------

The |CLI| export command allows you to export data in XML and OME-TIFF formats
from an OMERO.server using the command line.

Overview
^^^^^^^^

Visit :doc:`overview` to get a basic overview of the |CLI|.

Installation
^^^^^^^^^^^^

Visit :doc:`installation` to install the |CLI|.

Export command
^^^^^^^^^^^^^^

Currently the export command only supports OME-TIFF, respectively XML.

.. program:: omero export

To export an image as OME-TIFF as file :file:`image.tif`, use::

    $ omero export --file image.tif Image:<id>

To export its metadata as file :file:`image.xml`, use::

    $ omero export --file image.xml --type XML Image:<id>

Some of the options available to the export command are:

.. option:: --iterate Dataset:<id>

    Iterate over an object and write individual objects to the directory
    named by --file (EXPERIMENTAL, the only supported object is Dataset:<id>)

        $ omero export --file output-dir  --iterate  Dataset:<id>


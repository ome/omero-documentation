Export images
-------------

The |CLI| export command allows you to export data in XML and TIFF formats from
an OMERO.server using the command line.

Overview
^^^^^^^^

Visit :doc:`overview` to get a basic overview of the |CLI|.

Installation
^^^^^^^^^^^^

Visit :doc:`installation` to install the |CLI|.

Export command
^^^^^^^^^^^^^^

.. program:: omero export

To export an image as ome-tiff :file:`image.tif`, use::

    $ bin/omero export --file image.tif Image:1

To export its metadata, use::

    $ bin/omero export --file image.xml --type XML Image:1

Some of the options available to the export command are:

.. option:: --iterate Dataset:<id>

    Iterate over an object and write individual objects to the directory
    named by --file (EXPERIMENTAL, the only supported object is Dataset:<id>)

        $ bin/omero export --file output-dir  --iterate  Dataset:2


.. _clients/importer:

OMERO.importer
==============

OMERO.importer is a standalone application that allows a user to
import proprietary image data files from a filesystem accessed from
the user's computer to a running OMERO Server. This tool uses a
standard file browser to help the user find and specify files for
import into the server and then uploads the files to an OMERO Server.

To learn more about OMERO.importer see the
:ref:`tutorial/import-images` section.

.. figure:: ../images/omero_importer_4_4.png
    :align: center
    :alt: OMERO.importer

    OMERO.importer

OMERO.importer uses Bio-Formats for translation of proprietary file
formats in preparation for upload to an OMERO Server.

The OMERO.importer has a detailed list of the supported `File Formats
<http://loci.wisc.edu/software/bio-formats>`_.

For hints and guidelines on importing various file formats, also check
out the :wiki:`Format Guide <ImporterHowTo>`.

There is also a command line version of the importer available since
version Beta 4.0 which you can find more information about by visiting
the :wiki:`CLI Importer page <ImporterCLI>`.

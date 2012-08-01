OMERO Import Library
====================

.. contents::

The Import Library is a re-usable framework
for building import clients. Several are provided by the OMERO team
directly:

-  [STRIKEOUT:The `standalone GUI
   importer <http://www.openmicroscopy.org/site/support/omero4/getting-started/tutorial/importing-images>`_]
   (deprecated)
-  The integrated `OmeroInsight </ome/wiki/OmeroInsight>`_ importer
-  The ` command-line
   importer <http://www.openmicroscopy.org.uk/site/support/omero4/getting-started/tutorial/command-line-import>`_

Components
----------

The primary classes which make up the
`ImportLibrary </ome/wiki/ImportLibrary>`_ are:

-  ` ImportLibrary.java <http://git.openmicroscopy.org/?p=ome.git;a=blob;f=components/blitz/src/ome/formats/importer/ImportLibrary.java;hb=master>`_,
   itself, which is the main driver
-  ` ImportCandidates.java <http://git.openmicroscopy.org/?p=ome.git;a=blob;f=components/blitz/src/ome/formats/importer/ImportCandidates.java;hb=master>`_
   which takes file paths and determines the proper files to import
-  ` ImportConfig.java <http://git.openmicroscopy.org/?p=ome.git;a=blob;f=components/blitz/src/ome/formats/importer/ImportConfig.java;hb=master>`_,
   an extensible mechanism for storing the
-  ` ImportEvent.java <http://git.openmicroscopy.org/?p=ome.git;a=blob;f=components/blitz/src/ome/formats/importer/ImportEvent.java;hb=master>`_,
   the various events raised during import to ``IObserver``\ and
   ``IObservable`` implementations
-  ` OMEROMetadataStoreClient.java <http://git.openmicroscopy.org/?p=ome.git;a=blob;f=components/blitz/src/ome/formats/OMEROMetadataStoreClient.java;hb=master>`_,
   the low-level connection to the server
-  ` OMEROWrapper.java <http://git.openmicroscopy.org/?p=ome.git;a=blob;f=components/blitz/src/ome/formats/importer/OMEROWrapper.java;hb=master>`_,
   the OMERO adapter for the Bio-Formats ``ImageReaders`` class
-  In Insight, the main entry point is the importImage method of
   ` OMEROGateway.java <http://git.openmicroscopy.org/?p=ome.git;a=blob;f=components/insight/SRC/org/openmicroscopy/shoola/env/data/OMEROGateway.java;hb=master>`_.
-  In the CLI, the main entry point is the
   ` CommandLineImporter <http://git.openmicroscopy.org/?p=ome.git;a=blob;f=components/tools/OmeroImporter/src/ome/formats/importer/cli/CommandLineImporter.java;hb=master>`_
   class.

Example
-------

The ``CommandLineImporter.java`` class shows a straight-forward import.
An ``ErrorHandler`` instance is passed both top the ImportCandidates
constructor (since errors can occur while parsing a directory) and to
the ``ImportLibrary``. This and other handlers receive ``ImportEvents``
which notify listeners of the state of the current import.

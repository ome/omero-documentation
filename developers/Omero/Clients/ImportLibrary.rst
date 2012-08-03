OMERO Import Library
====================

.. contents::

The Import Library is a re-usable framework
for building import clients. Several are provided by the OMERO team
directly:

-  [STRIKEOUT:The `standalone GUI
   importer <http://www.openmicroscopy.org/site/support/omero4/getting-started/tutorial/importing-images>`_]
   (deprecated)
-  The integrated :ref:`developers/Omero/Insight`_ importer
-  The ` command-line
   importer <http://www.openmicroscopy.org.uk/site/support/omero4/getting-started/tutorial/command-line-import>`_

Components
----------

The primary classes which make up the
`ImportLibrary </ome/wiki/ImportLibrary>`_ are:

-  :source:` ImportLibrary.java <components/blitz/src/ome/formats/importer/ImportLibrary.java>`,
   itself, which is the main driver
-  :source:` ImportCandidates.java <components/blitz/src/ome/formats/importer/ImportCandidates.java>`
   which takes file paths and determines the proper files to import
-  :source:` ImportConfig.java <components/blitz/src/ome/formats/importer/ImportConfig.java>`,
   an extensible mechanism for storing the
-  :source:` ImportEvent.java <components/blitz/src/ome/formats/importer/ImportEvent.java>`,
   the various events raised during import to ``IObserver``\ and
   ``IObservable`` implementations
-  :source:` OMEROMetadataStoreClient.java <components/blitz/src/ome/formats/OMEROMetadataStoreClient.java>`,
   the low-level connection to the server
-  :source:` OMEROWrapper.java <components/blitz/src/ome/formats/importer/OMEROWrapper.java>`,
   the OMERO adapter for the Bio-Formats ``ImageReaders`` class
-  In Insight, the main entry point is the importImage method of
   :source:` OMEROGateway.java <components/insight/SRC/org/openmicroscopy/shoola/env/data/OMEROGateway.java>`.
-  In the CLI, the main entry point is the
   :source:` CommandLineImporter <components/tools/OmeroImporter/src/ome/formats/importer/cli/CommandLineImporter.java>`
   class.

Example
-------

The ``CommandLineImporter.java`` class shows a straight-forward import.
An ``ErrorHandler`` instance is passed both top the ImportCandidates
constructor (since errors can occur while parsing a directory) and to
the ``ImportLibrary``. This and other handlers receive ``ImportEvents``
which notify listeners of the state of the current import.

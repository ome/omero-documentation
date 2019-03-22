OMERO Import Library
====================

The Import Library is a re-usable framework
for building import clients. Several are provided by the OMERO team
directly:

-  the integrated :doc:`importer </users/clients-overview>`
-  :doc:`Command Line Importer </users/cli/import>` tool

Components
----------

The primary classes which make up the Import Library are:

-  :blitz_source:`ImportLibrary.java <src/main/java/ome/formats/importer/ImportLibrary.java>`
   itself, which is the main driver
-  :blitz_source:`ImportCandidates.java <src/main/java/ome/formats/importer/ImportCandidates.java>`
   which takes file paths and determines the proper files to import
-  :blitz_source:`ImportConfig.java <src/main/java/ome/formats/importer/ImportConfig.java>`,
   an extensible mechanism for storing the properties used during import
-  :blitz_source:`ImportEvent.java <src/main/java/ome/formats/importer/ImportEvent.java>`,
   the various events raised during import to ``IObserver``\ and
   ``IObservable`` implementations
-  :blitz_source:`OMEROMetadataStoreClient.java <src/main/java/ome/formats/OMEROMetadataStoreClient.java>`,
   the low-level connection to the server
-  :blitz_source:`OMEROWrapper.java <src/main/java/ome/formats/importer/OMEROWrapper.java>`,
   the OMERO adapter for the Bio-Formats ``ImageReaders`` class
-  In OMERO.insight, the main entry point is the importImage method of
   :insight_source:`OMEROGateway.java <src/main/java/org/openmicroscopy/shoola/env/data/OMEROGateway.java>`
-  In the CLI, the main entry point is the
   :blitz_source:`CommandLineImporter <src/main/java/ome/formats/importer/cli/CommandLineImporter.java>`
   class

Earlier Import Workflow
-----------------------

Prior to OMERO 5.0, the import workflow was very much client-side.
Using the ImportLibrary a client would determine the import candidates and
then import the image. The import phase would comprise copying the pixel data
to the OMERO data directory, writing the metadata into the database, and
optionally copying the original file to the OMERO data directory for
archiving.

FS Managed Repository Import Workflow
-------------------------------------

From 5.0 the workflow has changed. The client still determines the import
candidates but the client-side import process simply uploads the original
files to the OMERO data directory and then uses the ManagedRepository service
to initiate a server-side import. On the server the import is then completed
by writing the metadata into the database. After import, pixel data is
accessed directly from the original files using Bio-Formats. This means that
data files are no longer duplicated and any nested directory structure is
preserved. It also allows OMERO to take advantage of pre-generated pyramids
available in some formats e.g. dedicated whole slide imaging formats such as
:bf_v_doc:`SVS <formats/aperio-svs-tiff.html>` (instead of generating
:model_doc:`OMERO pyramids <omero-pyramid/>`).

For full details of the import workflow see :doc:`/developers/ImportFS`.

Example
-------

The ``CommandLineImporter.java`` class shows a straightforward import.
An ``ErrorHandler`` instance is passed both to the ``ImportCandidates``
constructor (since errors can occur while parsing a directory) and to
the ``ImportLibrary``. This and other handlers receive ``ImportEvents``
which notify listeners of the state of the current import.

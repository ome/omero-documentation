Import images
-------------

The |CLI| import command allows you to import images to an OMERO.server from
the command line, and is ideally suited for anyone wanting to use a
shell-scripted or web-based front-end interface for importing. Based upon the
same set of libraries as the standard importer, the command line version
supports the same file formats and functions in much the same way. Visit
:bf_v_doc:`Supported Formats <supported-formats.html>` for a detailed list of
supported formats.

Overview
^^^^^^^^

Visit :doc:`overview` to get a basic overview of the |CLI|.

Installation
^^^^^^^^^^^^

Visit :doc:`installation` to install the |CLI|.

Import command
^^^^^^^^^^^^^^

To import a file :file:`image.tif`, use::

    $ omero import image.tif

Some of the options available to the import command are:

.. program:: omero import

.. option:: -h, --help

.. option:: -s SERVER, -p PORT, -u USERNAME, -g GROUPNAME

    To avoid prompts for servername, port, username and group, use::

        $ omero import -s SERVER -p PORT -u USER -g GROUP image.tif

.. option:: -d DATASET_ID, -r SCREEN_ID, -T TARGET, --target TARGET
    
    To import images into a Dataset::

        $ omero import image.tif -d 2
        $ omero import image.tif -T Dataset:id:2
        $ omero import image.tif -T Dataset:name:Sample01

    See :doc:`import-target` for more information on import targets.

.. option:: -n NAME, --name NAME
.. option:: -x DESCRIPTION, --description DESCRIPTION

    To change the name of an image and add a description::

        $ omero import image.tif -n "control image1" -x "PBS control"
        $ omero import image.tif --name image2 --description second_batch

.. option:: --file FILE

    File for storing the standard output from the Java process

.. option:: --errs FILE

    File for storing the standard error from the Java process

.. option:: --logprefix DIR

    Directory or file prefix for --file and --errs

.. option:: --output TYPE

    Set an alternative output style, for example::

        $ omero import --output=yaml ...


Scanning folders prior to Import
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. program:: omero import

.. option:: -f

    Display all the files that would be imported, then exit::

        $ omero import -f image.tif
        $ omero import -f images_folder

    This will output a list of all the files which would be imported in groups
    separated by "#" comments. Note that this usage does not require a running
    server to be available.

.. option:: --depth DEPTH

    Set the number of directories to scan down for files (default: 4)::

        $ omero import --depth 7 images_folder

    The above example changes the depth to 7 folders.

Bulk import configuration
^^^^^^^^^^^^^^^^^^^^^^^^^

.. program:: omero import

.. option:: --bulk YAML_FILE
    
    To import a number of images with a similar configuration::

        $ omero import --bulk bulk.yml

    See :doc:`import-bulk` for more information on bulk imports.


Managing performance of imports
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. program:: omero import

.. option:: --skip SKIP

    Specify optional step to skip during import.

    The import of very large datasets like High-Content Screening data or
    SPIM data can be time and resource consuming both at the client and at the
    server level. This option allows the disabling of some non-critical steps
    and thus faster import of such datasets. The caveat associated with its
    usage is that some elements are no longer generated at import time.
    Some of these elements, like thumbnails, will be generated at runtime
    during client access.
    Available options that can be skipped are currently:

    all
        Skip all optional steps described below
    checksum
        Skip checksum calculation on image files before and after transfer

        This option effectively sets the ``--checksum_algorithm`` to use
        a fast algorithm, ``File-Size-64``, that considers only file size, not
        the actual file contents.
    minmax
        Skip calculation of the minima and maxima pixel values

        This option will also skip the calculation of the pixels checksum.
        Recalculating minima and maxima pixel values post-import is currently
        not supported. See :ref:`minmax_limitation` for more information.

    thumbnails
        Skip generation of thumbnails

        Thumbnails will usually be generated when accessing the images
        post-import via the OMERO clients.
    upgrade
        Skip upgrade check for Bio-Formats

    Example of usage::

        $ omero import large_image --skip all
        $ omero import large_image --skip minmax

    Multiple import steps can be skipped by supplying multiple arguments::

        $ omero import large_image --skip checksum --skip minmax

.. option:: --parallel-fileset COUNT

   Number of fileset candidates to import at the same time.

   OMERO groups image files into :ref:`filesets`. By default each
   fileset is imported one after another. This option attempts import of
   COUNT filesets at once. Even for single-file filesets it typically
   makes sense to use this option in conjunction with
   :option:`--parallel-upload` so that upload of different filesets'
   files may proceed in parallel. For importing a single fileset
   containing many files this option will not help.

   This is an *experimental* option. Too high a setting for COUNT may
   crash the import client or make the OMERO server unresponsive.
   Carefully read :ref:`parallel_import` before use.

.. option:: --parallel-upload COUNT

   Number of file upload threads to run at the same time.

   By default files are uploaded one after another. Once a fileset's
   files are all on the server then it may commence subsequent import
   steps. It typically makes sense to set this to a value of at least
   the value for :option:`--parallel-fileset`. Even if filesets are not
   imported in parallel this option can greatly speed the import of a
   fileset that consists of many small files.

   This is an *experimental* option. Too high a setting for COUNT may
   crash the import client or make the OMERO server unresponsive.
   Carefully read :ref:`parallel_import` before use.


Checking performance
""""""""""""""""""""

:program:`omero fs importtime` finds out how long it took to import an
existing fileset. Once the import is complete this command can estimate
the wall-clock time taken for separate phases of the import process.
Output is limited to what could be queried from the server easily.
Specify the ID of a fileset to have its import time reported in a
human-readable format.

.. program:: omero fs importtime

.. option:: --cache

   Once import time has been determined for the specified fileset, also
   cache that information by annotating the fileset using a :doc:`map
   annotation </developers/Model/KeyValuePairs>` in the
   :literal:`openmicroscopy.org/omero/import/metrics` namespace. The
   cache will be used for future reports of that fileset's import time.

.. option:: --summary

   This report covers multiple filesets so do not provide a fileset ID.
   All data previously cached by the :option:`--cache` option is queried
   then summarized in machine-readable CSV format.


Troubleshoot and report issues
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. program:: omero import

.. option:: --debug DEBUG

    Set the debug level for the command line import output::

        $ omero import images_folder --debug WARN

.. option:: --report

    Report emails to the OME team. This flag is mandatory for the
    :option:`--upload` and :option:`--logs` arguments.

.. option:: --email EMAIL

    Set the contact email to use when reporting errors. This argument should
    be used in conjunction with the :option:`omero import --report` and :option:`omero import --upload`
    or :option:`omero import --logs` arguments.

.. option:: --upload

    Upload broken files and log file (if any) with report

    The following command would import a broken image and upload it together
    with the import log if available in case of failure::

        $ omero import broken_image --report --upload --email my.email@domain.com

.. option:: --logs

    Upload log file (if any) with report

    The following command would import a broken image and upload only the
    import log if available in case of failure::

        $ omero import broken_image --report --logs --email my.email@domain.com

Advanced import commands
^^^^^^^^^^^^^^^^^^^^^^^^

.. program:: omero import

.. option:: --java-help

    Display the help for the Java options of the import command

    Java options can be passed after ``--`` ::

       $ omero import image.tif -- --name=test --description=TestDescription

    The above command will import the image "image.tif" with the name "test" into OMERO and with the OMERO
    description property set to "TestDescription". Visit :doc:`containers-annotations` to get a basic overview of how 
    annotations can be created and linked to OMERO objects (object being an image, in this case).

.. option:: --advanced-help

    Display the advanced help for the import command, e.g.

    ::

    $ omero import -- --advanced-help

    Examples of usage,

    To upload and remove the raw file from the local file-system after a successful import into OMERO, use::

        $ omero import -- --transfer=upload_rm my_file.dv

    As an OMERO administrator, to import images for other users, use::

       $ omero login --sudo root -s servername -u username -g groupname
       $ omero import image.tif

    As an OMERO group owner, to import images for others, use::

       $ omero login --sudo owner -s servername -u username -g groupname
       $ omero import image.tif

    Some advanced import options are described in the :doc:`/sysadmins/in-place-import`
    section. Visit :doc:`sessions` to get a basic overview of how user sessions 
    are managed.

Command Line Importer
^^^^^^^^^^^^^^^^^^^^^

The |CLI| import plugin calls the
``ome.formats.importer.cli.CommandLineImporter`` Java class. The Linux
OMERO.importer also includes an :file:`importer-cli` shell script allowing
calls to the importer directly from Java. Using :file:`importer-cli`
might look like this::

    ./importer-cli -s localhost -u user -w pass image.tif

To use the ``ome.formats.importer.cli.CommandLineImporter`` class from java on
the command line you will also need to include a classpath to the required
support jars. Please inspect the ``importer-cli`` script for an example
of how to do this.

The Command Line Importer tool takes a number of mandatory and optional
arguments to run. These options will also be displayed on the command line by passing no arguments to the importer:

.. literalinclude:: /downloads/cli/help.out

.. seealso:: 
    
    :doc:`/sysadmins/import-scenarios`

    :doc:`/sysadmins/in-place-import`

    :doc:`/sysadmins/dropbox`
    
    :doc:`index`

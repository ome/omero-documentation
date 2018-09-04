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

    $ bin/omero import image.tif

Some of the options available to the import command are:

.. program:: omero import

.. option:: -h, --help

    Examples of options available to the import command,

.. option:: -s SERVER, -p PORT, -U USERNAME, -g GROUPNAME

    To avoid prompts for servername, port, username and group, use::

        $ bin/omero import -s SERVER -p PORT -u USER -g GROUP image.tif

.. option:: -d DATASET_ID, -T TARGET, --target TARGET
    
    To import images into a Dataset::

        $ bin/omero import image.tif -d 2  
        $ bin/omero import image.tif -T Dataset:id:2
        $ bin/omero import image.tif -T Dataset:name:Sample01

    See :doc:`import-target` for more information on import targets.

Scanning folders prior to Import
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. program:: omero import

.. option:: -f

    Display all the files that would be imported, then exit::

        $ bin/omero import -f image.tif
        $ bin/omero import -f images_folder

    This will output a list of all the files which would be imported in groups
    separated by "#" comments. Note that this usage does not require a running
    server to be available.

.. option:: --depth DEPTH

    Set the number of directories to scan down for files (default: 4)::

        $ bin/omero import --depth 7 images_folder

    The above example changes the depth to 7 folders.

Bulk import configuration
^^^^^^^^^^^^^^^^^^^^^^^^^

.. program:: omero import

.. option:: --bulk YAML_FILE
    
    To import a number of images with a similar configuration::

        $ bin/omero import --bulk bulk.yml

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

        $ bin/omero import large_image --skip all
        $ bin/omero import large_image --skip minmax

    Multiple import steps can be skipped by supplying multiple arguments::

        $ bin/omero import large_image --skip checksum --skip minmax

Troubleshoot and report issues
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. program:: omero import

.. option:: --debug DEBUG

    Set the debug level for the command line import output::

        $ bin/omero import images_folder --debug WARN

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

        $ bin/omero import broken_image --report --upload --email my.email@domain.com

.. option:: --logs

    Upload log file (if any) with report

    The following command would import a broken image and upload only the
    import log if available in case of failure::

        $ bin/omero import broken_image --report --logs --email my.email@domain.com

Advanced import commands
^^^^^^^^^^^^^^^^^^^^^^^^

.. program:: omero import

.. option:: --java-help

    Display the help for the Java options of the import command

    Java options can be passed after ``--`` ::

       $ bin/omero import image.tif -- --name=test --description=TestDescription

    The above command will import the image "image.tif" with the name "test" into OMERO and with the OMERO
    description property set to "TestDescription". Visit :doc:`containers-annotations` to get a basic overview of how 
    annotations can be created and linked to OMERO objects (object being an image, in this case).

.. option:: --advanced-help

    Display the advanced help for the import command, e.g.

    ::

    $ bin/omero import -- --advanced-help

    Examples of usage,

    To upload and remove the raw file from the local file-system after a successful import into OMERO, use::

        $ bin/omero import -- --transfer=upload_rm my_file.dv

    As an OMERO administrator, to import images for other users, use::

       $ bin/omero login --sudo root -s servername -u username -g groupname
       $ bin/omero import image.tif

    As an OMERO group owner, to import images for others, use::

       $ bin/omero login --sudo owner -s servername -u username -g groupname
       $ bin/omero import image.tif

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

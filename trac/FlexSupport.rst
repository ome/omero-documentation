Flex Support
============

OMERO.importer supports importing analysized Flex files from an Opera
system.

Basic configuration is done via the ``importer.ini``. Once the user has
run the Importer once, this file will be in the following location:

-  ``C:\Documents and Settings\<username>\omero\importer.ini``

The user will need to modify or add the ``[FlexReaderServerMaps]``
section of the INI file as follows:

::

    ...
    [FlexReaderServerMaps]
    CIA-1 = \\\\hostname1\\mount;\\\\archivehost1\\mount
    CIA-2 = \\\\hostname2\\mount;\\\\archivehost2\\mount

where the *key* of the INI file line is the value of the "Host" tag in
the ``.mea`` measurement XML file (here: ``<Host name="CIA-1">``) and
the value is a semicolon-separated list of *escaped* UNC path names to
the Opera workstations where the Flex files reside.

Once this resolution has been encoded in the configuration file **and**
you have restarted the importer, you will be able to select the ``.mea``
measurement XML file from the Importer user interface as the import
target.

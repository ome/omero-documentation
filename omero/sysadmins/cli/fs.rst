.. _cli_omero_fs:

Repository management
---------------------

Since 5.0.3 it is possible to list images, filesets and the repositories that
contain them. At an administrator-only level it is also possible to move
filesets. This functionality is provided by the :program:`omero fs` command.
See ::

    $ omero fs -h

Listing repositories
^^^^^^^^^^^^^^^^^^^^

The :program:`omero fs repos` subcommand lists the repositories used by OMERO. 
For example ::

    omero fs repos

     # | Id | UUID                                 | Type    | Path
    ---+----+--------------------------------------+---------+--------------------------
     0 | 1  | 83bf5c68-8236-47ff-ae3e-728674eb0103 | Managed | /OMERO/ManagedRepository
     1 | 2  | ad899754-bff0-4605-a234-acd4da178f3b | Public  | /OMERO
     2 | 3  | ScriptRepo                           | Script  | /dist/lib/scripts

The options available to this subcommand are:

.. program:: omero fs repos

.. option:: -h, --help

    Display the help for this subcommand.

.. option:: --style {plain,csv,json,sql}

    This option determines the output style, tabular `sql` being the default as
    in the previous example. The `csv` style is comma-separated values with an
    initial header row, `plain` is the same as `csv` but without the header row.
    `json` returns an array of JSON objects that can be piped to other tools.

.. option:: --managed

    This option lists only Managed repositories.

For example
::

    omero fs repos --managed --style=csv

    #,Id,UUID,Type,Path
    0,1,83bf5c68-8236-47ff-ae3e-728674eb0103,Managed,/OMERO/ManagedRepository

Listing filesets
^^^^^^^^^^^^^^^^

The :program:`omero fs sets` subcommand lists filesets by various criteria.
Filesets are bundles of original data imported into OMERO 5 and above, which
represent one or more images. For example
::

    omero fs sets

     #  | Id    | Prefix                            | Images | Files | Transfer
    ----+-------+-----------------------------------+--------+-------+----------
     0  | 79853 | user-3_9/2014-07/22/16-41-04.244/ | 1      | 1     |
     1  | 79852 | user-3_9/2014-07/22/10-44-11.235/ | 1      | 1     |
     2  | 79851 | user-3_9/2014-07/22/10-44-07.300/ | 1      | 1     |
     3  | 79813 | user-3_9/2014-07/21/14-13-02.353/ | 1      | 1     |
     4  | 79812 | user-3_9/2014-07/21/14-13-00.182/ | 1      | 1     |
     5  | 79811 | user-3_9/2014-07/21/14-12-59.212/ | 1      | 1     |
     6  | 79810 | user-3_9/2014-07/21/14-12-57.896/ | 1      | 1     |
     7  | 79809 | user-3_9/2014-07/21/14-10-22.436/ | 3      | 600   |
     ...
     24 | 79772 | user-4_5/2014-07/18/17-14-43.631/ | 1      | 1     |
    (25 rows, starting at 0 of approx. 50173)

The options available to this subcommand are:

.. program:: omero fs sets

.. option:: -h, --help

    Display the help for this subcommand.

.. option:: --style {plain,csv,json,sql}

    See :option:`omero fs repos --style`.

.. option:: --limit LIMIT

    This option specifies the maximum number of return values, the default
    is 25.

.. option:: --offset OFFSET

    This option specifies the number of entries to skip before starting the
    listing, the default, 0, is to skip no entries.

.. option:: --order {newest,oldest,prefix}

    This option determines the order of the rows returned, `newest` is the
    default.

.. option:: --without-images

    This option lists only those filesets without images, these may be corrupted
    filesets.

.. option:: --with-transfer WITH_TRANSFER [WITH_TRANSFER ...]

    This option lists only those filesets imported using the given in-place
    import methods.

.. option:: --check

    This option checks each fileset for validity by recalculating each file's
    checksum and comparing it with the checksum recorded upon import. This may
    be slow. **This option is available to administrators only.**

.. option:: --extended

    With this option more details are provided for each returned value.
    This may be slow.

For example
::

    omero fs sets --order oldest --limit 3 --offset 5 --check

     # | Id | Prefix                            | Images | Files | Transfer | Check
    ---+----+-----------------------------------+--------+-------+----------+-------
     0 | 54 | user-3_9/2014-06/09/09-24-28.037/ | 1      | 1     |          | OK
     1 | 55 | user-3_9/2014-06/09/09-24-31.354/ | 1      | 1     |          | OK
     2 | 57 | user-5_4/2014-06/09/11-01-00.557/ | 1      | 1     |          | OK
    (3 rows, starting at 5 of approx. 78415)

Listing images
^^^^^^^^^^^^^^

The :program:`omero fs images` subcommand lists imported images by various criteria.
This subcommand is useful for showing pre-FS (i.e. OMERO 4.4 and before) images
which have their original data archived with them. For example
::

    omero fs images

     #  | Image  | Name                              | FS    | # Files | Size
    ----+--------+-----------------------------------+-------+---------+----------
     0  | 102803 | kidney_TFl_1.bmp.ome.tiff         | 79853 | 1       | 435.1 KB
     1  | 102802 | 4kx4k.jpg                         | 79852 | 1       | 1.7 MB
     2  | 102801 | 2kx2k.jpg                         | 79851 | 1       | 486.3 KB
     3  | 102773 | multi-channel.ome.tif             | 79813 | 1       | 220.3 KB
     4  | 102772 | multi-channel-z-series.ome.tif    | 79812 | 1       | 1.1 MB
     5  | 102771 | multi-channel-time-series.ome.tif | 79811 | 1       | 1.5 MB
     6  | 102770 | multi-channel-4D-series.ome.tif   | 79810 | 1       | 7.4 MB
     7  | 102769 | 001_001_000_000.tif [Well B6]     | 79809 | 600     | 1.1 GB
    ...
     24 | 102732 | 00027841.png                      | 79774 | 1       | 235 B
    (25 rows, starting at 0 of approx. 117393)

The options available to this subcommand are:

.. program:: omero fs images

.. option:: -h, --help

    Display the help for this subcommand.

.. option:: --style {plain,csv,json,sql}

    See :option:`omero fs repos --style`.

.. option:: --limit LIMIT

    See :option:`omero fs sets --limit`.

.. option:: --offset OFFSET

    See :option:`omero fs sets --offset`.

.. option:: --order {newest,oldest,prefix}

    See :option:`omero fs sets --order`.

.. option:: --archived

    With this option the subcommand lists only images with archived data.

.. option:: --extended

    With this option more details are provided for each returned value.
    This may be slow.

For example
::

    omero fs images --archived --offset 16 --limit 3

     # | Image | Name                      | FS | # Files | Size
    ---+-------+---------------------------+----+---------+---------
     0 | 15481 | UMD001_ORO.svs [Series 1] |    | 1       | 12.7 MB
     1 | 15478 | biosamplefullframetif.tif |    | 1       | 32.0 MB
     2 | 10018 | 050118.lei [07-13-a]      |    | 4       | 4.8 MB
    (3 rows, starting at 16 of approx. 833)

Renaming filesets
^^^^^^^^^^^^^^^^^

The :program:`omero fs rename` subcommand moves an existing fileset, specified by its
ID, to a new location. **This subcommand is available to administrators only.**

It may be useful to rename an existing fileset after the import template
(:property:`omero.fs.repo.path`) has been changed to match the new template. By
default the files in the fileset and the accompanying import log are moved. For
example, after adding the group name and group ID to template and changing the
date format
::

    $ omero fs rename 9

    Renaming Fileset:9 to pg-0_3/user-0_2/2014-07-23/16-48-20.786/
    Moving user-0_2/2014-07/23/16-31-51.070/ to pg-0_3/user-0_2/2014-07-23/16-48-20.786/
    Moving user-0_2/2014-07/23/16-31-51.070.log to pg-0_3/user-0_2/2014-07-23/16-48-20.786.log

The ID can be given as a number or in the form `Fileset:ID`.

The options available to this subcommand are:

.. program:: omero fs rename

.. option:: -h, --help

    Display the help for this subcommand.

.. option:: --no-move

    With this option the files will be left in place to be moved later. Advice
    will be given as to which files need to be moved to complete the renaming
    process. Note that if the files are not moved then the renamed filesets will
    not be accessible until the files have been moved into the new positions.

For example
::

    $ omero fs rename Fileset:8 --no-move

    Renaming Fileset:8 to pg-0_3/user-0_2/2014-07-23/16-49-23.543/
    Done. You will now need to move these files manually:
    -----------------------------------------------------
    mv /OMERO/ManagedRepository/user-0_2/2014-07/23/16-29-14.809/ /OMERO/ManagedRepository/pg-0_3/user-0_2/2014-07-23/16-49-23.543/
    mv /OMERO/ManagedRepository/user-0_2/2014-07/23/16-29-14.809.log /OMERO/ManagedRepository/pg-0_3/user-0_2/2014-07-23/16-49-23.543.log

.. note::

  The :program:`omero fs rename` subcommand is currently disabled
  pending a bug-fix.

Detailing disk usage
^^^^^^^^^^^^^^^^^^^^

The :program:`omero fs usage` subcommand provides details of the underlying disk usage
for various types of objects. This subcommand takes optional positional arguments
of object types with ids and returns the total disk usage of the specified objects.

For example
::

    omero fs usage Image:30001,30051 Plate:1051 --report

    Total disk usage: 1064320138 bytes in 436 files
     component    | size (bytes) | files
    --------------+--------------+-------
     Thumbnail    | 582030       | 256
     Job          | 1772525      | 2
     Pixels       | 49545216     | 12
     FilesetEntry | 1011947729   | 124
     Annotation   | 472638       | 42
    (5 rows)

If no positional argument is given then the total usage for the current user across
all of that user's groups is returned.

For example
::

    omero fs usage --report

    Total disk usage: 4526436430274 bytes in 26078 files
     component    | size (bytes)  | files
    --------------+---------------+-------
     Pixels       | 14654902013   | 2961
     FilesetEntry | 4510839804505 | 8820
     Thumbnail    | 17337131      | 8110
     Job          | 265665153     | 2792
     OriginalFile | 1757277       | 109
     Annotation   | 13167582976   | 3910
    (6 rows)

If multiple objects are given and those objects contain common data then that usage
will not be counted twice. For example, if two datasets contain the same image then
the fileset for that image will not be double-counted in the total disk usage.

The options available to this subcommand are:

.. program:: omero fs usage

.. option:: -h, --help

    Display the help for this subcommand.

.. option:: --style {plain,csv,json,sql}

    See :option:`omero fs repos --style`.

.. option:: --wait WAIT

    Number of seconds to wait for the processing to complete.
    To wait indefinitely use < 0, for no wait use 0. The default
    is to wait indefinitely.

.. option:: --size_only

    Print total bytes used, in bytes, with no extra text, this is useful
    for automated scripting.

.. option:: --report

    Print detailed breakdown of disk usage by types of files.
    This option is ignored if `--size_only` is used.

.. option::  --units {K,M,G,T,P}

    Units to use for disk usage for the total size using base-2. The default is
    bytes.

.. option:: --groups

    Print size for all of the current user's groups, this includes the user's
    own data and the data of other group members visible to the user.
    This option only applies if no positional arguments are given.

For example
::

    omero fs usage --groups --size_only -C -u user-1

    4576108188820


    omero fs usage Project:1,2 Dataset:5 --units M --report

    Total disk usage: 1432 MiB in 121 files
     component  | size (bytes) | files
    ------------+--------------+-------
     Thumbnail  | 73710        | 34
     Pixels     | 1499341282   | 34
     Annotation | 3000028      | 53
    (3 rows)

Creating directories
^^^^^^^^^^^^^^^^^^^^

For directory creation in a Managed repository use :program:`omero fs mkdir`:
this creates both the directory on the underlying filesystem and the
corresponding entry in the OMERO server's database. The new directory
will be owned by the :literal:`root` user and in the :literal:`user`
group. The options available to this subcommand are:

.. program:: omero fs mkdir

.. option:: -h, --help

    Display the help for this subcommand.

.. option:: --parents

    Ensure that the whole given path exists in the Managed repository.
    Analogous to the common :command:`mkdir`'s :literal:`--parents`
    option, originally simply :literal:`-p` in IEEE Std 1003.1-2008.

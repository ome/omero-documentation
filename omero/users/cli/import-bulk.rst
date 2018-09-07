Bulk imports
============

The CLI import option ``--bulk`` specifies a configuration file that
can be used to perform a batch of imports with the same or similar
options. The file is written in a simple YAML syntax and can be named
whatever you would like. It does not need to be placed in the folder
from which the OMERO commands are run.

A minimal YAML file might look like: ::

    ---
    path: "my-files.txt"

Assuming that :file:`my-files.txt` is a list of files such as ::

    fileA
    fileB
    directoryC

this is equivalent to: ::

    $ bin/omero import -k --transfer=ln_s fileA fileB directoryC

where the files :file:`fileA` and :file:`fileB` and all the files of
:file:`directoryC` will be imported.

Bulk-only options
-----------------

Path
^^^^

The ``path`` key specifies a file from which *each individual line*
will be processed as a separate import. In the simplest case, a single
file is placed per line as above. For more complex usages, ``path``
can point to a tab-separated value (TSV) or a comma-separate value (CSV)
file where each field will be interpreted based on ``columns``.

Columns
^^^^^^^

A fairly regular requirement in importing many files is that for
each file a similar but slightly different configuration is needed.
This can be accomplished with the ``columns`` key. It specifies how
each of the separated fields of the ``path`` file should be interpreted.

For example, a :file:`bulk.yml` file specifying: ::

    ---
    path: "files.tsv"
    columns:
    - name
    - path

along with a :file:`files.tsv` of the form: ::

    import-1	fileA
    import-2	fileB

would match the two calls: ::

    $ bin/omero import --name import-1 fileA
    $ bin/omero import --name import-2 fileB

but in a single call. The same could be achieved with this CSV file: ::

    import-1,fileA
    import-2,fileB

Other options like ``target`` can also be added as a separate field: ::

    Dataset:name:training-set	import-1	fileA
    Dataset:name:training-set	import-2	fileB
    Dataset:name:test-set-001	import-3	fileC

by defining ``columns`` in your :file:`bulk.yml` as: ::

    columns:
    - target
    - name
    - path

which will create the named datasets if they do not exist.
See :doc:`import-target` for more information on import targets
and see below for more examples of options you can use.

Include
^^^^^^^

The ``include`` key specifies another bulk YAML file that should be
included in the current processing. For example, if there is a global
configuration file :file:`omero-imports.yml` that all users should use,
such as: ::

    ---
    checksum_algorithm: "File-Size-64"
    exclude: "clientpath"
    transfer: "ln_s"

then users can make use of this configuration by adding the following
line to their :file:`bulk.yml` file: ::

    include: /etc/omero-imports.yml

Dry-run
^^^^^^^

The ``dry-run`` key can either be set to ``true`` in which case
no import will occur, and only the potential actions will be
shown, or additionally it can be set to a file path of the form
``my_import_%s.sh`` where ``%s`` will be replaced by an number
and a file with the given name will be written out. Each of these
scripts can then be used independently.

Other options
-------------

Otherwise, all the regular options from the CLI are available for
configuration via ``--bulk``:

- ``checksum_algorithm`` for faster processing of large files
- ``continue`` for processing all files even if one errors
- ``exclude`` for skipping files that have already been imported
- ``parallel_fileset`` for concurrent imports
- ``parallel_upload`` for concurrent uploads
- ``target`` for placing imported images into specific containers
- ``transfer`` for alternative methods of shipping files to the server

See :doc:`import` for more information.

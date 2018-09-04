Using bulk imports
==================

The CLI import option ``--bulk`` specifies a configuration file that
can be used to perform a batch of imports with the same or similar
options. The file is written in a simple YAML syntax and can be placed
anywhere.

A simple YAML file might look like: ::

    ---
    continue: "true"
    transfer: "ln_s"
    path: "my-files.txt"

Assuming that my-files.txt is a list of files such as ::

    fileA
    fileB
    fileC

this is equivalent to: ::

    $ bin/omero import -k --transfer=ln_s fileA fileB fileC

Bulk-only options
-----------------

Path
^^^^

The ``path`` key specifies a file from which *each individual line*
will be processed as a separate import. In the simplest case, a single
file is placed per line as above. For more complex usages, ``path``
can point to a tab-separated value (TSV) file where each field will
be interpreted based on ``columns``.

Columns
^^^^^^^

A fairly regular requirement in importing many files is that for
each file a similar but slightly different configuration is needed.
This can be accomplished with the ``columns`` key. It specifies how
each of the tab-separated fields of the ``path`` file (e.g. "my-files.txt")
should be interpreted. For example, a bulk.yml file specifying:

    path: "files.tsv"
    columns:
    - name
    - path

along with a files.tsv of the form:

    import-1	fileA
    import-2	fileB

would match the two calls:

    $ bin/omero import --name import-1 fileA
    $ bin/omero import --name import-2 fileB

but in a single call. Another key that can be valuable in the ``columns``
section is ``target``: ::

    Dataset:name:training-set	fileA
    Dataset:name:training-set	fileB
    Dataset:name:test-set-001	fileC

Include
^^^^^^^

The ``include`` key specifies another bulk YAML file that should be
included in the current processing. This allows having a global
configuration file that you use in various situations: ::

    ---
    include: /etc/omero-imports.yml

Dry-run
^^^^^^^

The ``dry-run`` key can either be set to ``true`` in which case
no import will occur, and only the potential actions will be
shown, or additionally it can be set to a file path of the form
``my_import_%s.sh`` where ``%s`` will be replaced by an number
and a file with the given name will be written out. Each of these
scripts can then be used independently.

Common options
--------------

Otherwise, all the common options from the CLI are available for
configuration via ``--bulk``:

- checksum_algorithm for faster processing of large files
- continue for processing all files even if one errors
- exclude for skipping files that have already been imported
- target for placing imported images into specific containers
- transfer for alternative methods of shipping files to the server

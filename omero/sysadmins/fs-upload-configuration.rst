FS configuration options
========================

Background
----------

Users import their image files to the OMERO.fs server. The contents of
these files are kept intact by the server and the import process
preserves the files' path and name (at least within the rules of
:property:`omero.fs.repo.path_rules` below), so that OMERO.fs can become
a trusted repository for the master copy of users' data. While the
default server configuration from :doc:`config` should typically suffice,
:program:`omero config set` may be used to adjust settings related to file
uploads. These settings are explained below.

Repository location
-------------------

Several properties determine where FS-imported files are stored:

- :property:`omero.data.dir` - singleton property (i.e. once globally) which
  points to the legacy repository location for OMERO. For OMERO to run on
  multiple systems, the contents of this directory must be on a shared volume.

- :property:`omero.managed.dir` - singleton property which points to the default
  ``ManagedRepository``. In an OMERO install in which there is only one Blitz
  server, this will be the only repository. This need not be located under
  :property:`omero.data.dir` but is by default.

- ``omero.repo.dir`` (experimental) - value passed to all non-legacy, standalone
  repositories. This is not actively used, but would allow hosting
  repositories on multiple physical systems without the need for a shared
  volume. For example, after running ``bin/omero admin start`` on the main
  machine, it would be possible to launch nodes on various machines via
  ``bin/omero node start fs-B``, ``bin/omero node start fs-C``, etc. Each of
  these would pass a different ``omero.repo.dir`` value to its process.

Template path
-------------

When files are uploaded to the managed repository, a parent directory is
created to receive the upload. A multi-file image has all its files
stored in the same parent directory, though they may be in different
subdirectories of that parent to mirror the original directory
structure before upload. The :property:`omero.fs.repo.path` setting
defines the creation of that parent directory. It is this value which
makes the ``ManagedRepository`` “managed”.

Path naming constraints
^^^^^^^^^^^^^^^^^^^^^^^

There is some flexibility in how this parent directory is named. The
constraints are:

* The path components (individual directories in the path) must be
  separated by :literal:`/` characters.

* A path component separator may be written as :literal:`//` only if
  followed by at least one more path component. In this case:

  * The server ensures that the path components preceding the
    :literal:`//` are owned by the :literal:`root` user.

  * Any newly created path components following the :literal:`//` are
    **owned by the user** who owns the images.

* If no :literal:`//` is present then *all* newly created path
  components are **owned by the user** who owns the images.

* The path must be unique for each import. It is for this reason that
  the :literal:`%time%` term expands to a time with millisecond
  resolution.

* To avoid confusion with the expansion terms enumerated below, avoid
  other uses of the :literal:`%` character in path components.

In the above, ownership of path components is in the context of OMERO
users accessing the OMERO managed repository through its API. It does
not relate to operating system users' permissions for the underlying
filesystem.

Expansion terms
^^^^^^^^^^^^^^^

Special terms may be used within path components: these are replaced
with text that depends on the import.

For any directory in the template path
""""""""""""""""""""""""""""""""""""""

:literal:`%userId%`
  expands to the user's numerical ID

:literal:`%user%`
  expands to the user's name

:literal:`%institution%`
  expands to the user's institution name; this path component is wholly
  omitted if the user has no institution set

:literal:`%institution:default%`
  expands to the user's institution name, or to the supplied "default"
  if the user has no institution set; for instance,
  :literal:`%institution:State College of Florida, Manatee-Sarasota%` is
  permitted

:literal:`%groupId%`
  expands to the OMERO group's numerical ID

:literal:`%group%`
  expands to the OMERO group's name

:literal:`%perms%`
  expands to the group's six-character permissions string, for example
  :literal:`rw----` for a private group

:literal:`%year%`
  expands to the current year number, for example :literal:`2014`

:literal:`%month%`
  expands to the current month number, zero-padded, for example
  :literal:`08`

:literal:`%monthname%`
  expands to the current month name, for example :literal:`August`

:literal:`%day%`
  expands to the current day number in the month, zero-padded, for
  example :literal:`04`

:literal:`%sessionId%`
  expands to the session's numerical ID

:literal:`%session%`
  expands to the session key (UUID) of the session, for example
  :literal:`6c2dae43-cfad-48ce-af6f-025569f9e6df`

For user-owned directories only
"""""""""""""""""""""""""""""""

These expansion terms may not precede :literal:`//` in the template
path.

:literal:`%time%`
  expands to the current time, in hours, minutes, seconds, milliseconds,
  for example :literal:`13-49-07.727`

:literal:`%hash%`
  expands to an eight-digit hexadecimal hash code that is constant for
  the set of files being imported, for example :literal:`0554E3A1`

:literal:`%hash:digits%`
  expands as :literal:`%hash%`, where :literal:`digits` is a
  comma-separated list of how many digits of the hash to use in
  different subdirectories; for example, :literal:`hash-%hash:3,3,2%`
  expands to a form like :literal:`hash-123/456/78`

:literal:`%increment%`
  expands to an integer that increases consecutively so as to create the
  next new directory, for example using :literal:`inc-%increment%` with
  preexisting directories up to :literal:`inc-24` would expand to
  :literal:`inc-25`

:literal:`%increment:digits%`
  expands as :literal:`%increment%` where :literal:`digits` specifies a
  minimum length to which to zero-pad the integer, for example using
  :literal:`inc-%increment:3%` with preexisting directories up to
  :literal:`inc-024` would expand to :literal:`inc-025`

:literal:`%subdirs%`
  expands to nothing until the preceding directory has more than one
  thousand entries, in which case it expands to an integer that
  increases consecutively to similarly limit the entry count in
  subdirectories; applies recursively to extend the number of path
  components as needed, so, using :literal:`example/below-%subdirs%` in
  the path, with :literal:`example/below-000` to
  :literal:`example/below-999` all "full", three-digit subdirectories
  below those are created, such as :literal:`example/below-123/456`

:literal:`%subdirs:digits%`
  expands as :literal:`%subdirs%` where :literal:`digits` specifies to
  how many digits :literal:`%subdirs%` may expand for each path
  component: for example, :literal:`example/%subdirs:4%-below` allows
  ten thousand directory entries in :literal:`example` before creating
  :literal:`example/1234-below` and, much later,
  :literal:`example/1234-below/5678`

No more than one of :literal:`%time%`, :literal:`%subdirs%` or
:literal:`%increment%` may be used in any one path component, although
they may each be used many times in the whole path.

Legal file names
----------------

Although OMERO.fs attempts to preserve file naming, the server's
operating system or file system is likely to somehow constrain what
file names may be stored by OMERO.fs. This is of particular concern
when a user may upload from a more permissive system to a server on a
less permissive system, or when it is anticipated that the server
itself may be migrated to a less permissive system. The server never
accepts Unicode control characters in file names.

The :property:`omero.fs.repo.path_rules` setting defines the combination
of restrictions that the server must apply in accepting file uploads.
The restrictions are grouped into named sets:

:literal:`Windows required`
        prohibits names with the characters :literal:`"`,
        :literal:`*`, :literal:`/`, :literal:`:`, :literal:`<`,
        :literal:`>`, :literal:`?`, :literal:`\\`, :literal:`|`,
        names beginning with :literal:`$`, the names :literal:`AUX`,
        :literal:`CLOCK$`, :literal:`CON`, :literal:`NUL`,
        :literal:`PRN`, :literal:`COM1` to :literal:`COM9`,
        :literal:`LPT1` to :literal:`LPT9`, and anything beginning
        with one of those names followed by :literal:`.`

:literal:`Windows optional`
        prohibits names ending with :literal:`.` or a space

:literal:`UNIX required`
        prohibits names with the character :literal:`/`

:literal:`UNIX optional`
        prohibits names beginning with :literal:`.` or :literal:`-`

These rules are applied to each separate path component of the file
name on the client's system. So, for instance, an upload of a file
:literal:`/tmp/myfile.tif` from a Linux system would satisfy the
:literal:`UNIX required` restrictions because neither of the path
components :literal:`tmp` and :literal:`myfile.tif` contains a
:literal:`/` character.

Applying the "optional" restrictions does not assist OMERO.fs at all;
those restrictions are designed to ease manual maintenance of the
directory specified by the :property:`omero.managed.dir` setting, being
where the server stores users' uploaded files.

Checksum algorithm
------------------

As the client uploads each file to the server, it calculates a
checksum for the file. After the upload is complete the client reports
that checksum to the server. The server then calculates the checksum
for the corresponding file from its local filesystem and checks that
it matches what the client reported. **File integrity** is thus
**assured** because corruption during transmission or writing would be
revealed by a checksum mismatch.

There are various algorithms by which checksums may be calculated. The list of
available algorithms is given by :property:`omero.checksum.supported`. To
calculate comparable checksums the client and server use the same
algorithm. The server API permits clients to specify the algorithm,
but it is expected that they will typically accept the server default.

The number that suffixes each of the checksum algorithm names
specifies the bit width of the resulting checksum. A larger bit width
makes it less likely that different files will have the same checksum
by coincidence, but lengthens the checksum hex strings that are
reported to the user and stored in the :literal:`hash` column of the
:literal:`originalfile` table in the database.

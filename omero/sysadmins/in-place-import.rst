.. _inplace_import:

In-place import
===============

In-place import allows files which are already present on the server machine
to be imported into OMERO without the need to copy them into OMERO's ManagedRepository. This requires
users to have shell (|SSH|, etc.) access to the server machine,
and so there are a number of :ref:`limitations <limitations>`
to this implementation. Development of this feature is on-going, with
improvements planned to enable a more user-friendly experience. This
|CLI|-based stop-gap is being made available at this stage because for some
users, in-place import is essential for their use of OMERO.

This feature is designed to allow imaging facilities to import large datasets
into OMERO while keeping them safely stored in a secure location on the file system which is
read-only for users. Leaving the data in a user's file system **is very
dangerous** as they may forget they need to keep it or move to a different
institution. **Under no circumstances should in-place import be used with
temporary storage.**

.. warning::

    The instructions below should help you get started but **it is critical
    that you understand the implications of using this feature.** Please do
    not just copy commands and hope for the best.


Responsibilities
----------------

As a data management platform, OMERO assumes that it is
in control of your data in order to help prevent data loss.
It assumes that data was copied into the server and only
a server administrator or authorized OMERO user would have the
rights to do anything destructive to that data.

With in-place import, the data either resides completely
outside of OMERO or is shared with other users. This means
that the critical, possibly sole, copy of your data must
be protected outside of OMERO. **This is your responsibility for the lifetime
of the data**.


.. _limitations:

Limitations
-----------

In-place import is only available on the OMERO server system
itself. In other words, using |SSH| or similar, you will need
to shell into the server and run the command-line importer
directly. If you are uncomfortable with this, you should let someone else
handle in-place importing.

Someone wanting to perform an in-place import **MUST** have:

* a regular OMERO account
* an |OS|-account with access to :file:`bin/omero`
* read access to the location of the data
* **write** access to the :doc:`ManagedRepository
  </developers/Server/FS>`
  or one of its subdirectories

The above means that it may be useful to create a single OS
account (e.g. "import_user") which multiple users can log
into, and then use their own OMERO accounts to import data. Alternatively,
each OMERO user can be given an OS account with access rights to the data
storage as well as the managed repository.

For soft linking with :literal:`--transfer=ln_s` it has been noticed
that some plate imports run rather more slowly than usual. Other
operations may also be affected. In determining if or how to use
in-place import at your high-content screening facility, we thus
recommend time profiling with representative data, and alerting us to
any significant disappointments.

Also, there is still some data duplication when
:model_doc:`pyramids <omero-pyramid/>` are generated. We are
hoping to find a work-around for this in the future.

Do not use this procedure to create links on data inside the ManagedRepository.

.. _safety_tips:

Safety tips
-----------

Whether you chose to use the hard- or soft-linking option below,
you should take steps to secure files which are in-place imported to OMERO.
The best option is making them **read-only** for both the OMERO user and also
for the owner of the data. This means the server cannot accidentally modify
the files (e.g. if a client mixes up the file IDs and tries to write to the
wrong location) and that the files cannot be removed from the system
while OMERO is still using them. Files may not be renamed or otherwise altered
such that the OMERO server user cannot find them at the expected location.

If possible, **all the files should be added to your regular backup
process**. If the files for imported images are later removed or
corrupted, the result will probably be that while the images remain in their
projects or screens with their annotations and basic metadata, they
simply cannot be successfully viewed. However, this behavior is **not
guaranteed**, so do *not* assume that the resulting problems will not
extend further. Once the problem is noticed, replacing the original
image files from backups, in the same place with the same name, is
likely but **not guaranteed** to fully restore the images and their
associated data in OMERO.

Additional setup requirements
-----------------------------

In-place import requires additional user and group setup. As no one should be
allowed to log into the account used to install the server, to permit in-place
imports you need to create a different user account, allowing someone to log
into the server but not accidentally delete any files. Therefore, you should
set up an 'in-place' user and an 'in-place' group and configure a subset of
directories under
:doc:`ManagedRepository </developers/Server/FS>` to
let members of that group write to them. Important criteria include:

- In-place users can write to directories that are newly created for
  import so that they may link out to the original file locations.
- In-place users cannot write to directories not required for their
  imports.
- In-place users cannot corrupt or delete each other's imports.
- OMERO.server can read and delete all the imported files.

One may achieve the above with careful setting of sticky bits and choice
of umasks or use of ACLs. The best approach depends on the background of
your system administrators and the capabilities of the underlying
filesystems. The example below details how this was done for one of our
test servers in Dundee which runs with the default setting for
:property:`omero.fs.repo.path`:

::

    ### STATUS BEFORE

    [sysadmin@ome-server omero_system_user]$ umask
    0002

    [sysadmin@ome-server omero_system_user]$ ls -ltrad ManagedRepository/
    drwxrwxr-x 8 omero_system_user omero_system_user 4096 Apr 24 10:13 ManagedRepository/

    [sysadmin@ome-server omero_system_user]$ grep inplace /etc/passwd /etc/group
    /etc/passwd:inplace_user:x:501:501::/home/inplace_user:/bin/bash
    /etc/group:omero_system_user:x:500:inplace_user
    /etc/group:inplace_user:x:501:

    [sysadmin@ome-server omero_system_user]$ grep omero_system_user /etc/passwd /etc/group
    /etc/passwd:omero_system_user:x:500:500::/home/omero_system_user:/bin/bash
    /etc/group:omero_system_user:x:500:inplace_user

    [sysadmin@ome-server omero_system_user]$ sudo -u inplace_user -i
    [inplace_user@ome-server ~]$ umask
    0002


    ### SCRIPT
    chgrp inplace_user /repositories/binary-repository/ManagedRepository
    chmod g+rws /repositories/binary-repository/ManagedRepository

    chmod g+rws /repositories/binary-repository/ManagedRepository/*
    chmod g+rws /repositories/binary-repository/ManagedRepository/*/*
    chmod g+rws /repositories/binary-repository/ManagedRepository/*/*/*

    chgrp inplace_user /repositories/binary-repository/ManagedRepository/*   
    chgrp inplace_user /repositories/binary-repository/ManagedRepository/*/*
    chgrp inplace_user /repositories/binary-repository/ManagedRepository/*/*/* 

    # With the above, newly created directories should be in the inplace group
    # As long as the file is readable by omero_system_user, then it should work fine!



    ### AFTER SCRIPT

    [root@ome-server omero_system_user]# ls -ltrad ManagedRepository/
    drwxrwsr-x 8 omero_system_user inplace_user 4096 Apr 24 10:13 ManagedRepository/

    ### TEST

    # with default umask this likely has to do 
    [inplace_user@ome-server ~]$ cd /repositories/binary-repository/ManagedRepository/
    [inplace_user@ome-server ManagedRepository]$ mkdir inplace.test
    [inplace_user@ome-server ManagedRepository]$ ls -ltrad inplace.test/
    drwxrwsr-x 2 inplace_user inplace_user 4096 Apr 30 11:35 inplace.test/

    [omero_system_user@ome-server omero_system_user]$ cd /repositories/binary-repository/ManagedRepository/
    [omero_system_user@ome-server ManagedRepository]$ rmdir inplace.test/
    [omero_system_user@ome-server ManagedRepository]$


If you are controlling OMERO.server with systemd you should add ``UMask=0002`` to the ``Service`` section of your :download:`systemd service file <unix/walkthrough/omero-systemd.service>`.


Getting started
---------------

The command-line import client has a help menu which
explains the available options:

::

    $ bin/omero import --advanced-help

.. literalinclude:: /downloads/inplace/advanced-help.txt

The option for performing an in-place transfer is
``--transfer``. A new extension point, file transfers allow
a choice of which mechanism is used to get a file into OMERO.

::

    $ bin/omero import --transfer=ln_s my_file.dv

.. literalinclude:: /downloads/inplace/soft-link-example.txt

The only visible difference here is the line:

::

    ...formats.importer.cli.CommandLineImporter - Setting transfer to ln_s

Rather than uploading via the OMERO API, the
command-line importer makes a call to the system `ln` command.

Transfer options
----------------

Previously, OMERO only offered the option of uploading
via the API. Files were written in blocks via the
RawFileStore interface. With in-place import, several
options are provided out of the box as well as the ability
to use your own.

"ln_s" - soft-linking
^^^^^^^^^^^^^^^^^^^^^

The most flexible option is soft-linking. For each file,
it executes `ln -s source target` on the local file
system. This works across file system boundaries and leaves
a clear record of what file was imported:

.. literalinclude:: /downloads/inplace/soft-link-listing.txt

Here you can see in the imported file set, a soft-link which
belongs to the `omero` user, but which points to a file in
the `/home/demo` directory.

Deleting the imported images in OMERO will delete the **soft
link** but **not** the original file under `/home`. This
could come as a surprise to users, since the deletion will
effectively free no space.

.. warning:: The deletion of the original files under
    `/home` (or equivalent) **will lead to a complete loss of the data since
    no copy is held in OMERO**. Therefore, this method should only be used in
    conjunction with a properly managed and backed-up data repository. If the
    files are corrupted or deleted, there is no way to use OMERO to retrieve
    them.

"ln" - hard-linking
^^^^^^^^^^^^^^^^^^^

The safest option is hard-linking, though it cannot be used
across file systems. For each file, it executes
`ln source target`. Attempting to hard link across file
system boundaries will lead to an error:

.. literalinclude:: /downloads/inplace/hard-link-failure.txt

The safeness of this method comes from the fact that OMERO
*also* has a pointer to the data. Deletion of the original file
under `/home` would leave data in OMERO in place. Again, this
could cause a surprise as the space would not be properly freed,
but at least there cannot be an accidental loss.

.. warning:: The primary concern with this method is **modification** of
    files. If the original data is *written* by a user, unexpected results
    could follow in OMERO. See the :ref:`safety_tips` section above for ways
    around this.

If you are unclear about how hard-linking works, please see the
`Hard link <https://en.wikipedia.org/wiki/Hard_link>`_ article on
Wikipedia.

The semantics of hard-linking have changed recently on Linux systems
with the "protected hardlinks" feature, which is enabled by default
and is in use on Ubuntu 14.04, CentOS 7 and other contemporary
systems.  When you create a hard-link to a file, Linux now requires
that you are either the *owner* of the file, or that you have
*read-write permissions* to the file.  Other Unix systems, and older
Linux systems, allow a hard-link to be made if you have *search
access* to the file (i.e. you have appropriate read and execute
permissions on the directory path containing the file), but do
not check the file permissions themselves.  See the `kernel-hardening
mailing list post
<https://www.openwall.com/lists/kernel-hardening/2012/02/21/20>`__
which describes the change in more detail.  The implication for
in-place import is that the user performing the import must own or
have read-write permissions on the data files being imported in-place.

.. _inplace_import_ln_rm:

"ln_rm" - moving
^^^^^^^^^^^^^^^^

Finally, the least favored option is ``ln_rm``. It first performs
a hard-link like `ln`, but once the import is complete it attempts
to delete the original file. This is currently in testing as
an option for DropBox but is unlikely to be of use to general users.
Although this option is more limited than the ``upload_rm`` option below it
will be much faster.

"upload_rm" - uploading and deleting
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This option is not strictly an in-place option
but is detailed here for convenience. It first performs a file upload like
default import, but once the import is complete it attempts to delete the
original files. It deletes the original files **if and only if** the import
is successful.

"cp" and "cp_rm" variants
^^^^^^^^^^^^^^^^^^^^^^^^^

The `cp` and `cp_rm` commands provide the same functionality
as `ln` and `ln_rm` but perform a copy rather than a link operation. The
benefit of a copy is that it works over OS filesystem boundaries while
still providing the integrity that `ln_s` cannot. The primary downside
of a raw `cp` compared to `ln` is that there is data duplication. `cp_rm`
being very similar to `ln_rm` *usually* works around this downside, except
in the case of a failed import. Then the duplicated data will remain in
OMERO and an explicit cleanup step will need to be taken.

Your own file transfer
^^^^^^^^^^^^^^^^^^^^^^

If none of the above options work for you, it is also possible to
write your own implementation of the
`ome.formats.importer.transfers.FileTransfer` class, likely
subclassing `ome.formats.importer.transfers.AbstractFileTransfer` or
`ome.formats.importer.transfers.AbstractExecFileTransfer`.
If you do so, please let us know how we might improve either
the interface or the implementations that we provide.

Once your implementation has been compiled into a jar and
placed in the `lib/clients` directory, you can invoke it using:

::

    $ bin/omero import --transfer=example.package.ClassName ...

Related advanced options
------------------------

In addition to the ``--transfer`` option, a number of other
advanced options have been added which may be useful for either
tweaking import performance or dealing with complicated situations.
Comments and suggestions are very welcome.

Checksums
^^^^^^^^^

If you think that calculating the checksums for your large files is
consuming too much time, you might want to configure the checksum
algorithm used. This can be done with the ``--checksum_algorithm``
property. Available options are printed with the ``--advanced-help``
option and include Adler-32, CRC-32, MD5-128, Murmur3-32, Murmur3-128,
and the default SHA1-160.

DropBox
^^^^^^^

As described in the scenarios ":ref:`upload_dropbox_auto`" and
":ref:`inplace_dropbox_auto`", :doc:`DropBox </sysadmins/dropbox>` can be
configured to use any of the options described above. The configuration
property to modify is `omero.fs.importArgs`:

::

    $ bin/omero config set -- omero.fs.importArgs "--transfer=upload_rm"

This will **move** files into OMERO rather than leaving a copy in the
DropBox directory.

::

    $ bin/omero config set -- omero.fs.importArgs "--transfer=ln_rm"

This will also **move** files into OMERO rather than leaving a copy in the
DropBox directory. For this to work, the two directories will need to
be on the same file system. This option is much faster than `upload_rm`.
Please read :ref:`inplace_import_ln_rm` carefully to ensure you fully
understand the implications of using this option.

For more information on OMERO.fs, please visit :doc:`/developers/ImportFS`.

.. warning:: **Use at your own risk!**

.. seealso:: 
    
    :doc:`/sysadmins/import-scenarios`

    :doc:`/sysadmins/dropbox`

    :doc:`/developers/ImportFS`

    :doc:`/users/cli/import`

    :doc:`/users/cli/import-target`
    
    :doc:`/users/cli/index`

OMERO.dropbox
=============

DropBox was originally designed as the first stage of the file
system changes referred to as :doc:`/developers/Server/FS`. It utilizes a file
system monitor to find newly uploaded files and run a fully automatic
import on those files if possible. This release of OMERO.dropbox runs on
the same machine as the OMERO.server and watches designated areas of the
local filesystem for new or modified files. If those files are
importable, then an automatic import is initiated. OMERO.dropbox is
started automatically when the OMERO.server starts and it will run if
the prerequisites below are met.

Prerequisites
-------------

In addition to the general :doc:`system-requirements` OMERO.dropbox has
the following more specific requirements:

-   OMERO.dropbox is built on underlying OS file-notification system, and so
    is only available for specific versions of certain operating systems.
    OMERO.dropbox has been tested on the following systems:

    -   Linux with kernel 2.6.13 and higher.
    -   Mac OS 10.6 and later.

-   In addition some platforms require further Python packages to be
    available:

    -   Mac OS systems that use a macports install of Python will need to
        have FSEvents available in the :envvar:`PYTHONPATH`. This will require a
        path of the form
        ``/System/Library/Frameworks/Python.framework/Versions/3.X/Extras/lib/python/PyObjC/``
        to be added, according to the version of Python used.

-   The filesystem which OMERO.dropbox watches must be local to the given
    operating system. Watching a network-attached share (NAS) is strictly
    ***not*** supported.

Installing DropBox
------------------

From the OMERO 5.6.0 release, the library ``omero-dropbox`` supports Python 3 and
is now available on PyPI_. We recommend you use a Python virtual environment to install it. It should be installed in the same virtual environment where ``omero-py`` is installed. See :doc:`unix/server-installation`.

Activate the environment ``/opt/omero/server/venv3`` where ``omero-py`` is installed and install ``omero-dropbox``
as **root**:

.. parsed-literal::

    $ . /opt/omero/server/venv3/bin/activate
    $ pip install omero-dropbox==\ |version_dropbox|

Enable DropBox as the **omero-server system user** (``su - omero-server``)::

    $ omero admin ice server enable MonitorServer
    $ omero admin ice server enable DropBox

Using DropBox
-------------

In its default configuration the monitored area of the file system is a
``DropBox`` subdirectory of the OmeroBinaryRepository directory. The
system administrator should create ``DropBox`` and then under that a
directory for each user, using their omero username. The ownership and
permissions should be set so that a user can copy files into their
DropBox directory:

::

    /OMERO/DropBox/amy
                  /emily
                  /edgar
                  /root
                  /zak

Experimenters can add subdirectories under their named directory for
convenience. Copying or moving a file of an importable file type into a
named directory or nested subdirectory will initiate an automatic import
of that file for that user. Multi-file formats will be imported after
the last required file of a set is copied into the directory. Images and
plates will be imported into the default group of the user, with
images placed into ``Orphaned images`` unless the ``target`` option was configured (see below and :doc:`/users/cli/import-target`).

Acquisition systems can then be configured to drop a user's images into
a given DropBox.

.. note::

    -   The DropBox system is designed for image files to be copied in
        at normal acquisition rates. Copying many files en masse may
        result in files failing to import.

    -   It is also intended as a write-once system. Modifying an image
        after it has been imported may result in that modified image also
        being imported depending on the operating system and how the image
        was modified.

    -   Once directories are created within DropBox or files are copied or
        moved into DropBox they should not be moved, renamed or otherwise
        changed. Images may be imported again or already imported images may
        become unreadable.

Permissions
-----------

Changing the permissions of a directory within DropBox may result in duplicate
imports as a newly readable directory appears identical to a new directory. If
directories need to be modified it is recommended that the DropBox system is
stopped and then restarted around any changes, as below.

As the **omero-server system user**, run
::

    $ omero admin ice server disable DropBox
    $ omero admin ice server stop DropBox
    $ omero admin ice server disable MonitorServer
    $ omero admin ice server stop MonitorServer

    # make any directory changes

    $ omero admin ice server enable MonitorServer
    $ omero admin ice server enable DropBox

.. note::

    Any new files copied into DropBox during this disabled period will not
    be detected and thus not imported.


Log files
---------

The log files :file:`var/log/FileServer.log`, :file:`var/log/MonitorServer.log`
and :file:`var/log/DropBox.log` will indicate success or otherwise of start-up
of the two components.
Once running, :file:`var/log/MonitorServer.log` will log file events seen within
designated file areas and :file:`var/log/DropBox.log` will log the progress
of any file imports.

Unicode path and file names
---------------------------

If file or path names contain Unicode characters this can cause DropBox to
fail. This can be remedied by the use of a :file:`sitecustomize.py` or
:file:`usercustomize.py` file containing the following::

    import sys
    reload(sys)
    sys.setdefaultencoding('utf-8')

For more details on using customization files in Python see:
`site — Site-specific configuration hook <https://docs.python.org/2.7/library/site.html>`_.
For more discussion on this issue within OMERO see the forum post:
:forum:`Dropbox halts on certain unicode characters <viewtopic.php?f=4&t=7810#p15910>`.

.. note::
    If a customization file is used and the OMERO server is upgraded please
    ensure the file is still available to DropBox after the upgrade.

Advanced use
------------

OMERO.dropbox can be configured in several ways through
:file:`etc/grid/templates.xml`. In its default configuration, as detailed
above, it monitors the subdirectory ``DropBox`` of the OMERO data
directory for all users.

A number of the properties in :file:`templates.xml` accept a semi-colon
separated list of values. This extended configuration allows a site to
watch multiple directories, and configure each for a different user, a
different type of file, etc. Any value missing from the configuration
(e.g. ``value="1;;2"``) will be replaced by the default value.

One example alternative configuration would be to watch specific
directories for specific users.

.. note::

    Temporarily, the "importUsers" parameter is disabled, because of a bug. You can still configure the DropBox in a way which gives all the users the same Advanced configs. To achieve this, do not specify the "importUsers" parameter and always just use the "amy" or just the "zak" part of the other parameters or concatenate the "zak" parameters with "amy" parameters in the examples below.

In the example below two directories are
monitored, one for user ``amy`` and one for ``zak``:

::

    <property name="omero.fs.importUsers"  value="amy;zak"/>
    <property name="omero.fs.watchDir"  value="/home/amy/myData;/home/zak/work/data"/>

The remaining properties have been left at their default values for both
users.

To limit DropBox to import only files belonging to specific image types
the following property can be set,

::

    <property name="omero.fs.readers"  value="/home/amy/my_readers.txt;"/>

Here only the image types listed in :file:`my_readers.txt` will be imported
for the user ``amy`` while the system-wide :file:`readers.txt` will be used
for ``zak``.

For a full description of the properties see below.

Properties
^^^^^^^^^^

Each property takes the form of a single item or a semi-colon separated
list of items. Where the item is a list, values within that list should
be comma separated.

-   importUsers (temporarily disabled)

    The importUsers is either ``default`` or a list of OMERO user names. In the
    case of the value being ``default``, the same configuration is applied to
    all users and each subsequent configuration setting should be a single
    value. In the case of this value being a list of users, each subsequent
    value should be a list of the same length as the number of users. The
    default value is ``default``.

    ::

        <property name="omero.fs.importUsers"  value="default"/>


-   watchDir

    The absolute directory path of interest for each user. The default is
    empty.

    ::

        <property name="omero.fs.watchDir"  value=""/>

-   eventTypes

    For automatic import Creation and Modification events are monitored. It
    is also possible to monitor Deletion events though these are not used by
    DropBox. The default is Creation,Modification.

    ::

        <property name="omero.fs.eventTypes"  value="Creation,Modification"/>

-   pathMode

    By default existing and newly created subdirectories are monitored. It
    is possible to restrict monitoring to a single directory ("Flat"), only
    existing subdirectories ("Recurse"), or all subdirectories ("Follow").
    For DropBox to function correctly the mode should be Follow. The default
    is Follow.

    ::

        <property name="omero.fs.pathMode"  value="Follow"/>

-   whitelist

    A list of file extensions of interest. An empty list implies all file
    extensions are monitored. The default is an empty list.

    ::

        <property name="omero.fs.whitelist"  value=""/>

-   blacklist

    A list of subdirectories to ignore. Not currently supported.

    ::

        <property name="omero.fs.blacklist"  value=""/>

-   timeout

    This timeout in seconds is used by one-shot monitors. This property is
    not used by DropBox.

    ::

        property name="omero.fs.timeout"  value="0.0"/>

-   blockSize

    The number of events that should be propagated to DropBox in one go.
    Zero implies all events possible. The default is zero.

    ::

        <property name="omero.fs.blockSize"  value="0"/>

-   ignoreSysFiles

    If this is True events concerning system files, such as filenames
    beginning with a dot or default new folder names, are ignored. The exact
    events ignored will be OS-dependent. The default is True.

    ::

        <property name="omero.fs.ignoreSysFiles"  value="True"/>

-   ignoreDirEvents

    If this is True then the creation and modification of subdirectories is
    not reported to DropBox. The default is True.

    ::

        <property name="omero.fs.ignoreDirEvents"  value="True"/>

-   dirImportWait

    The time in seconds that DropBox should wait after being notified of a
    file before starting an import on that file. This allows for companion
    files or filesets to be copied. If a new file is added to a fileset
    during this wait period DropBox begins waiting again. The default is 60
    seconds.

    ::

        <property name="omero.fs.dirImportWait"  value="60"/>

-   fileBatch

    The number of files that can be copied in before processing the batch.
    In cases where there are large numbers of files in a typical file set it
    may be more efficient to set this value higher. The default is 10.

    ::

        <property name="omero.fs.fileBatch"  value="10"/>

-   throttleImport

    The time in seconds that DropBox should wait after initiating an import
    before initiating a second import. If imports are started too close
    together connection issues can arise. The default is 10 seconds.

    ::

        <property name="omero.fs.throttleImport"  value="10"/>

-   readers

    A file of readers. If this is a valid file then it is used to filter
    those events that are of interest. Only files corresponding to a reader
    in the file will be imported. The default is empty.

    ::

        <property name="omero.fs.readers"  value=""/>

-   importArgs

    A string of extra arguments supplied to the importer. This could
    include, for example, an email address to report failed imports to:
    ``--report --email test@example.com``. The default is empty. For
    details on available extra arguments see :doc:`/users/cli/import`.

    ::

        <property name="omero.fs.importArgs"  value=""/>

Example
^^^^^^^

Here is a full example of a configuration for two users:

::

    <property name="omero.fs.importUsers"     value="amy;zak"/>
    <property name="omero.fs.watchDir"        value="/home/amy/myData;/home/zak/work/data"/>
    <property name="omero.fs.eventTypes"      value="Creation,Modification;Creation,Modification"/>
    <property name="omero.fs.pathMode"        value="Follow;Follow"/>
    <property name="omero.fs.whitelist"       value=";"/>
    <property name="omero.fs.blacklist"       value=";"/>
    <property name="omero.fs.timeout"         value="0.0;0.0"/>
    <property name="omero.fs.blockSize"       value="0;0"/>
    <property name="omero.fs.ignoreSysFiles"  value="True;True"/>
    <property name="omero.fs.ignoreDirEvents" value="True;True"/>
    <property name="omero.fs.dirImportWait"   value="60;60"/>
    <property name="omero.fs.fileBatch"       value="10;10"/>
    <property name="omero.fs.throttleImport"  value="10;10"/>
    <property name="omero.fs.readers"         value="/home/amy/my_readers.txt;"/>
    <property name="omero.fs.importArgs"      value="-T \"regex:^.*/(?<Container1>.*?)\";--report --email zak@example.com"/>

.. seealso:: 

    :doc:`/users/cli/import`

    :doc:`/users/cli/import-target`

    :doc:`/sysadmins/in-place-import`

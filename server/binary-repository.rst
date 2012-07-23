.. _rst_binary-repository:

Binary Repository
=================

.. topic:: About

	The OMERO.server binary data repository is a fundamental piece of
	server-side functionality. It provides optimized and indexed storage of
	original file, pixel and thumbnail data, attachments and full text
	indexes. Its structure is based on
	`OMEIS </site/support/legacy/ome-server/system-overview/ome-image-server/>`_.

Layout
------

The repository is internally laid out as follows:

::

    /OMERO
    /OMERO/Pixels      <--- Pixel data
    /OMERO/Files       <--- Original file data
    /OMERO/Thumbnails  <--- Thumbnail data
    /OMERO/FullText    <--- Lucene full text search index

Permissions
-----------

Your repository should be owned by the same user that is starting your
OMERO.server instance. This is often either yourself (find this out by
executing ``whoami``) or a seperate ``omero`` (or similar) user who is
dedicated to running OMERO.server. For example:

::

    $ whoami
    omero
    $ ls -al /OMERO
    total 24
    drwxr-xr-x  5 omero  omero   128 Dec 12  2006 .
    drwxr-xr-x  7 root    root   160 Nov  5 15:24 ..
    drwxr-xr-x  2 omero  omero  1656 Dec 18 14:31 Files
    drwxr-xr-x 25 omero  omero 23256 Dec 10 19:06 Pixels
    drwxr-xr-x  2 omero  omero    48 Dec  8  2006 Thumbnails

Your repository is not
----------------------

-  The "database"
-  The directory where your OMERO.server binaries are
-  The directory where your OMERO.client (OMERO.insight, OMERO.editor or
   OMERO.importer) binaries are
-  Your PostgreSQL data directory
-  A place to store moldy sandwiches

Changing your repository location
---------------------------------

Your repository location can be changed from it's ``/OMERO`` or
``C:\OMERO`` default by modifying your OMERO.server configuration as
follows (remembering that Windows ``C:\`` style paths must have
backslashes escaped):

::

    cd omero-Beta4.0.0
    bin/omero config set omero.data.dir /mnt/really_big_disk/OMERO

    cd C:\omero-Beta4.0.0
    bin\omero config set omero.data.dir D:\\OMERO

The suggested procedure is to shut down your OMERO.server instance, move
your repository, change your ``omero.data.dir`` and then start the
instance back up. For example:

::

    cd omero-Beta4.0.0
    bin/omero admin stop
    mv /OMERO /mnt/really_big_disk
    bin/omero config set omero.data.dir /mnt/really_big_disk/OMERO
    bin/omero admin start

    cd C:\omero-Beta4.0.0
    bin\omero admin stop
    move C:\OMERO D:\
    bin\omero config set omero.data.dir D:\\OMERO
    bin/omero admin start

.. note::

	It is **strongly** recommended that you make all changes to
	your OMERO binary repository with the server shut down. Changing the
	``omero.data.dir`` configuration does **not** move the repository for
	you, you must do this yourself.
Server Overview
===============

The OMERO server system provides storage and processing of image data
which conforms to the `OME Specification </site/support/file-formats>`_.
It can be run on commodity hardware to provide your own storage needs,
or run site-wide to provide a large-scale collaborative environment.

.. figure:: ../images/server-arch.png/image_preview
   :align: center
   :alt: 

Administration
--------------

Though getting started with the server is relatively straight-forward,
it does require installing several software systems, and more advanced
usage including backups, integrated logins, etc. requires a
knowledgeable system administrator.

After working through the `Getting Started <../getting-started>`_
section, the following guides to administering your installation of
OMERO.server may be of interest:

-  `OMERO.server Troubleshooting <../troubleshooting>`_
-  `OMERO.server Security and Firewalls <security>`_
-  `OMERO.server LDAP <install-ldap>`_
-  `OMERO.server Backup and Restore <backup-and-restore>`_
-  `OMERO.server Binary Repository <binary-repository>`_
-  `OMERO.server and PostgreSQL <postgresql>`_

Developer Documentation
-----------------------

The server system is composed of several components, each of which runs
in a separate process but is co-ordinated centrally.

-  `OMERO.blitz <blitz>`_ - The data server provides access to metadata
   stored in a relational database as well as the binary image data on
   disk.
-  `OMERO.fs <fs>`_ - A filesystem watcher which notifes the server of
   newly uploaded or modified files.
-  `OMERO.dropbox <fs>`_ - Utilizes fs to find newly uploaded files and
   run a fully automatic import.
-  `OMERO.processor <processor>`_ - Processors provide background
   execution of Python and Matlab scripts.
-  `OMERO.renderingengine <rendering>`_ - The RenderingEngine provides
   server-side processing of raw image data for visualization on low-end
   client machines.

If you are interested in building components for the server, modifying
an existing component, or just looking for more background information,
the best starting point is the
`ServerDesign <http://trac.openmicroscopy.org.uk/omero/wiki/ServerDesign>`_
page on the server's developer trac.
Known limitations
=================

Time zone
---------

We do not recommend changing the time zone on your server. The server is
currently set to use local time and changing time zones will result in a
mismatch between the original data import times stored in the server and the
way the clients report them. A fix for this is forthcoming but will not be in
5.1.

Java issues
-----------

OpenJDK8 is supported, however some builds of some releases (such as
the current Ubuntu build of 8u40) have broken JPEG support, reported
for `OpenJDK
<http://icedtea.classpath.org/bugzilla/show_bug.cgi?id=1393>`__ and
`Ubuntu
<https://bugs.launchpad.net/ubuntu/+source/openjdk-8/+bug/1421501>`__. See
:ticket:`12612` and `this ome-users thread <http://lists.openmicroscopy.org.uk/pipermail/ome-users/2015-November/005723.html>`__
for more information. OracleJDK8 is also supported, but the earliest releases
have had problems. The latest OpenJDK8 or OracleJDK8 should work correctly (we
have checked both OpenJDK 1.8.0_45-internal and OracleJDK 1.8.0_66). OpenJDK
and OracleJDK version 7 are also supported (we have tested OracleJDK 1.7.0_80
and OpenJDK 1.7.0_85).

Ubuntu issues
-------------

Importing using desktop clients
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Under older Ubuntu installations, the 'import folder' option in the desktop
clients currently does not work.

Searching
---------

.. _limitations-openfiles:

Too many open file descriptors
------------------------------

Starting with OMERO 5, the server works directly from original files.
At times, this requires a significant number of open file handles. If
you are having problems with large or frequent imports, are seeing
"Too many open file descriptors" or similar, you may need to increase the
maximum number of open files per process.  On Linux, this may be done
by setting the `nofile` limit in :file:`/etc/security/limits.conf`,
for example::

  omero  soft  nofile  10000
  omero  hard  nofile  12000

This permits the `omero` user to have 10000 open files per process,
which may be increased up to a maximum of 12000 by the user.  The
username and limits will need adjusting for the specifics of your
installation and usage requirements.  Note that these settings take
effect only for new logins, so the server and the shell or environment
the server is started from will require restarting.  Run ``ulimit -a``
as the user running OMERO to verify that the changes have taken
effect.

Deleting datasets
-----------------

If you have a dataset containing any images which are also present in any
other datasets, you will not be able to delete it. First, you must remove
the shared images by cutting the links.

Changing group permissions
--------------------------

If a group contains a projection made by one member from data owned by another
user, you cannot make the group into a private group.

File format support
-------------------

Large images with floating-point pixel data
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:model_doc:`Pyramids <omero-pyramid/>` of image tiles are currently not
generated for images with floating-point pixel data, meaning the imported
image will be scrambled if it is over a certain size (configurable using
:property:`omero.pixeldata.max_plane_height` and
:property:`omero.pixeldata.max_plane_width` but set to 3192x3192 pixels by
default). This primarily affects the following file formats:

*  :bf_v_doc:`Gatan DM3 <formats/gatan-digital-micrograph.html>`
*  :bf_v_doc:`MRC <formats/mrc.html>`
*  :bf_v_doc:`TIFF <formats/tiff.html>`

.. _minmax_limitation:

Calculation of minima and maxima pixel values
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If images are imported with one of the :option:`omero import --skip` options
skipping calculation of the global minima and maxima pixel values, OMERO
clients will use the extrema of the pixel type range by default. Users can
adjust the minima/maxima via the rendering settings. Recalculating minima and
maxima pixel values after import is currently not supported.

Flex data in OMERO.tables
^^^^^^^^^^^^^^^^^^^^^^^^^

If you are using the advanced configuration setting ``FlexReaderServerMaps``
for importing Flex data split between multiple directories for use with
:doc:`OMERO.tables </developers/analysis>`, you should not upgrade beyond
5.0.x. Neither the 5.1 line nor OMERO 5.2 support this functionality.

LDAP
----

Enabling synchronization of LDAP on user login may override admin actions
carried out in the clients, see :ref:`synchronizing-ldap` for details.


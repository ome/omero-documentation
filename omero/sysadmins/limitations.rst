Known limitations
=================

Time zone
---------

We do not recommend changing the time zone on your server. The server is
currently set to use local time and changing time zones will result in a
mismatch between the original data import times stored in the server and the
way the clients report them.

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

Changing group permissions
--------------------------

If a group contains a projection made by one member from data owned by another
user, you cannot make the group into a private group.

File format support
-------------------

Large images
^^^^^^^^^^^^

When you import an image over a certain size, OMERO will generate a pyramid of lower resolution
images if it doesn't already exist in the file. The threshold size is configurable using
:property:`omero.pixeldata.max_plane_height` and
:property:`omero.pixeldata.max_plane_width` but set to 3192x3192 pixels by
default. However, this process can be very resource-intensive, depending on the size of the
image as well as the image format and any data compression used, for example see
:imagesc:`PixelData threads and pyramid generation issues <t/pixeldata-threads-and-pyramid-generation-issues/49794>`.

The OMERO pyramid generation process should be considered as deprecated and instead it is recommended
that users avoid these issues by converting
their data to `pyramidal OME-TIFF <https://www.openmicroscopy.org/2018/11/29/ometiffpyramid.html>`_
files before importing into OMERO. A number of suitable tools are available such as
`bioformats2raw & raw2ometiff <https://www.glencoesoftware.com/blog/2019/12/09/converting-whole-slide-images-to-OME-TIFF.html>`_,
`bfconvert <https://docs.openmicroscopy.org/latest/bio-formats/users/comlinetools/conversion.html>`_,
`Kheops <https://github.com/BIOP/ijp-kheops>`_, :pypi:`tifffile <tifffile/>`,
`aicsimageio <https://github.com/AllenCellModeling/aicsimageio>`_,
`libvips <https://github.com/libvips/libvips>`_ and `QuPath <https://qupath.github.io/>`_.

Large images with floating-point pixel data
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:model_doc:`Pyramids <omero-pyramid/>` of image tiles are currently not
generated for images with floating-point pixel data, meaning the imported
image will be scrambled if it is over the size threshold mentioned above.
This primarily affects the following file formats:

*  :bf_v_doc:`Gatan DM3 <formats/gatan-digital-micrograph.html>`
*  :bf_v_doc:`MRC <formats/mrc.html>`
*  :bf_v_doc:`TIFF <formats/tiff.html>`

This issue can be avoided by pre-generating pyramidal OME-TIFF images as
described above.

.. _ngff_limitations:

Import of OME-NGFF
^^^^^^^^^^^^^^^^^^

The import of `OME-NGFF <https://ngff.openmicroscopy.org/latest/>`_ is currently limited to the :doc:`command-line (CLI) importer </users/cli/import>` only.

Naming of OME-NGFF images in OMERO
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The default naming of the `OME-NGFF <https://ngff.openmicroscopy.org/latest/>`_ Images imported into OMERO is not intuitive at the moment. Use the ``-n NAME`` option of the :doc:`command-line (CLI) importer </users/cli/import>` to achieve explicit naming.

Depth of scanning prior to import
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The import might fail if the hierarchy of folders is exceeding the depth of scanning (default: 4). For formats using deeper hierarchy of folders such as  `OME-NGFF <https://ngff.openmicroscopy.org/latest/>`_ use :option:`omero import --depth` option to set the depth of scanning of 10 (or more if necessary).

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


CellProfiler v1 support is untested with 4.4.

Running CellProfiler with OMERO.blitz
-------------------------------------

This document shows how to run
` CellProfiler <http://www.cellprofiler.org/>`_, an open source project
to analyse and segment fluorescence microscopy images.

From the CellProfiler Website

::

    CellProfiler cell image analysis software is designed for biologists without training in 
    computer vision or programming to quantitatively measure phenotypes from thousands of 
    images automatically. 

OMERO.cellprofiler supplies the OMEROJava connector and **CellProfiler
version 1.0** modules and subfunctions to download images from
OMERO.blitz to CellProfiler and upload those images back to OMERO.blitz
as a derived image of the original image.

WARNING
-------

OMERO.cellprofiler is no longer tested (since the 4.2.x series), we will
be soon working on a new version compatible with **CellProfiler version
2.0**

Installing the OMERO.cellprofiler
---------------------------------

To install the modules required by CellProfiler, to work with
OMERO.blitz you need to download

-  download CellProfiler source from
   ` CellProfiler <http://cellprofiler.org/download.htm>`_.
-  install `wiki:OmeroMatlab </ome/wiki/OmeroMatlab>`_
-  copy the files from OMERO svn components/tools/cellprofiler

   -  ``CPsubfunctions/CPOMEROimread.m``
   -  ``Modules/OMEROLoader.m``
   -  ``Modules/UploadImages.m``
   -  ``Modules/UploadMask.m``
   -  ``Modules/PlateLoader.m``
   -  ``Modules/LoadSingleImage.m``

-  include the files in components/tools/OmeroM to your matlab path

The OMEROLoader Module
----------------------

The OMEROLoader module specifies where CellProfiler should retrieve
images from.

PlateLoader Module
------------------

The PlateLoader Module downloads all images from a plate into
CellProfiler.

SingleImageLoader Module
------------------------

The SingleImageLoader Module downloads a single images with the
specified id into CellProfiler.

OMERO Specific
~~~~~~~~~~~~~~

The OMEROLoader, PlateLoader and SingleImageLoader requires you to
specify the path to the ice.config file, the dataset id to retrieve
images from and username and password.

Image Related
~~~~~~~~~~~~~

The image is specified by the mapping between the name of the channel
and the channel index.

UploadMask Module
-----------------

The UploadMask Module will upload the segmented images to OMERO as ROI
on the original image.

OME Data Model
==============

`|An outline of the OME model based on
Image| </ome/attachment/wiki/OmeModel/model-img.png>`_

The OME Model is a specification for storing data on biological imaging.
The model includes image parameters, such as XYZ dimensions, pixels type
etc as well as extensive metadata on image acquisition, annotation,
regions of interest (ROIs) etc. This common specification is essential
for exchange of image data between different software packages.

    Figure A: The diagram shows part of the model around the Image
    object.

The OME data model is implemented as the
`OME-TIFF <http://www.openmicroscopy.org/site/support/file-formats/ome-tiff>`_
file format and is also the basis of OME software (see below). OME-TIFF
is a multi-plane tiff file that contains OME metadata in the header, in
the form of OME-XML. The OME model is specified as an `XSD
schema <http://www.openmicroscopy.org/Schemas/OME/2011-06/ome.xsd>`_,
which can be used to validate OME-XML. Read `more about
Schemas <http://www.openmicroscopy.org/site/support/file-formats/schemas>`_
or see the `full list for
download <http://www.openmicroscopy.org/Schemas/>`_.

The OME data model is at the core of other OME projects:

-  `Bio-Formats </ome/wiki/BioFormats>`_ implements the OME model
   internally, converting metadata from other formats into the OME
   model. Bio-Formats exports this data in the form of OME-TIFF files.
-  The `OMERO </ome/wiki/OmeroHome>`_ platform implements the OME data
   model as a relational database and `remote software
   objects </ome/wiki/ObjectModel>`_ in it's client-server architecture.

Working with the Model
----------------------

The OME model has an extensive coverage, specifying over 100 entities.
However, the model can be more easily understood by looking at smaller
sections individually. E.g. starting at 'Image' (see Figure A). A
collection of similar diagrams can be found
`here <http://www.openmicroscopy.org/site/support/file-formats/working-with-ome-xml/model-overview-2010-04>`_.
For more details, see the `Working with
OME-XML <http://www.openmicroscopy.org/site/support/file-formats/working-with-ome-xml>`_
page.

Attachments
~~~~~~~~~~~

-  `model-img.png </ome/attachment/wiki/OmeModel/model-img.png>`_
   `|Download| </ome/raw-attachment/wiki/OmeModel/model-img.png>`_ (45.4
   KB) - added by *wmoore* `9
   ago. An outline of the OME model based on Image

Developer introduction
======================

The OME Data Model is now decoupled from the Bio-Formats code repository and
available as a
`stand-alone ome-model GitHub repository <https://github.com/ome/ome-model>`_.

There are sample files, along with an explanation of their structure, on
the :doc:`sample-files` page.

OME Model development process
-----------------------------

The Model development process is currently being revised but we always aim to
keep the community informed of major and breaking changes in advance. See the
:devs_doc:`Contributing Developer <data-model-schema.html>` documentation for
further details on updating and publishing the schema.

Working with the OME Data Model
-------------------------------

The :doc:`Model Overview collection of diagrams <model-overview>` shows the
structure and connections between different parts of the OME Model. Generated
documentation for the :schema_doc:`current version of the entire Schema
<ome.html>` is also available.

Individual parts of the model are covered in more detail in the following
sections:

-  :doc:`Filter And FilterSet <filter-and-filterset>`
-  :doc:`Screen Plate Well <screen-plate-well>` - our HCS solution
-  :doc:`Structured Annotations <structured-annotations>`
-  :doc:`Regions of Interest (ROIs) <roi>`

Support for additional dimensions is also covered:

-  :doc:`6D, 7D and 8D Storage <6d-7d-and-8d-storage>`

Map Annotations, storing 'key-value pairs', are a type of Structured
Annotation which were introduced in the :doc:`/schemas/january-2015`. Further
information is available in the :omero_doc:`OMERO developer documentation on
Key-value pairs <developers/Model/KeyValuePairs.html>` and a
:omexml_downloads:`sample OME-XML file <mapannotation.ome.xml>` is also
available.

Legacy solutions for tiled images and Single (or Selective) Plane Illumination
Microscopy (also known as Light Sheet Microscopy) are detailed in the
following sections for reference but **both these methods have been superseded
by the above**:

-  :doc:`SPIM Initial Support <legacy/spim-initial-support>`
-  :doc:`Tiled Images <legacy/tiled-images>`

The use of IDs and Life Science Identifiers is explained in this section:

-  :doc:`id-and-lsid`

The system of units used by the model is covered in this section:

-  :doc:`ome-units`

The :doc:`Schema versions</schemas/index>` section shows the Model changes
with each release, helpful for those working with several versions of the OME
Model, for example to support the loading/saving of a variety of files.

-  The **current major release** - see :doc:`Changes For June
   2016 </schemas/june-2016>`.

For further information, see the 
:omero_doc:`OME Data Model <developers/index.html#the-ome-data-model>` section
in the OMERO developer documentation.

Working with OME-XML
--------------------

In some cases, it is useful to extract specific parameters or tweak
certain values in a dataset's OME-XML metadata block. Further guidance on
:doc:`using-ome-xml` is available, but below is a brief example of the
OMEXMLMetadata class (which implements the MetadataStore and
MetadataRetrieve interfaces) to greatly simplify OME-XML-related
development tasks.

The following program edits the "image name" metadata value for the file
given on the command line. It requires the :bf_plone:`Bio-Formats <>` and 
:doc:`OME-XML Java </ome-xml/java-library>` libraries.

:source:`EditImageName.java <components/formats-gpl/utils/EditImageName.java>`

As in the ConvertToOmeTiff.java example in :doc:`/ome-tiff/code`, we attach an 
OME-XML MetadataStore object to the reader to extract OME-XML metadata from 
the input file. We obtain the current image name (if any) by calling the
``omexmlMeta.getImageName(0)`` method. The zero indicates the Image within
the OME-XML block we are interested in; in this case, we are
asking for the name of the first Image.

After updating the name somehow (in our case, reversing the string), we
write the updated name back into the metadata structure via a call to
``omexmlMeta.setImageName(name, 0)``. Once again the zero indicates that we
wish to update the first Image.

Lastly, the
:source:`loci.formats.services.OMEXMLService <components/formats-api/src/loci/formats/services/OMEXMLService.java>`
class contains a number of useful methods for working with Bio-Formats
metadata objects (i.e. MetadataStore and MetadataRetrieve
implementations), including the getOMEXML method for easily extracting
an OME-XML string from a MetadataRetrieve object (which we utilize
above), as well as the convertMetadata method for transcoding between
metadata object implementations. You can obtain an OMEXMLService object
as follows:

::

    ServiceFactory factory = new ServiceFactory();
    OMEXMLService service = factory.getInstance(OMEXMLService.class);


Additional tools
----------------

There are two Python applications to aid working with OME-XML - 
:doc:`EnumTool`, which is designed to digest OME-XML schema and
produce meaningful output about enumerations, and :bf_doc:`XSD Fu <developers/xsd-fu.html>`,
which digests OME XML schema and produces an object oriented Java
infrastructure to ease  work with an XML DOM tree.

|

.. only:: html

    See :doc:`using-ome-xml` for further guidance on how to use OME schema
    elements in XML files.


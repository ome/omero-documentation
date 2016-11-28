Structured Annotations
======================


Structured annotations (or SAs), introduced in the 
:doc:`2008-09 schema </schemas/september-2008>`,
are a general way to extend OME-XML with additional structured
information. They can express a variety of data types and linkages, and
serve as a replacement for the Custom Attributes and Semantic Type
Definitions functionality of prior schemas.

For more information on SAs from an OMERO-centric perspective, see the
:omero_doc:`OMERO page on structured
annotations <developers/Model/StructuredAnnotations.html>`.

Map Annotations, storing 'key-value pairs', are a type of Structured
Annotation which were introduced in the :doc:`/schemas/january-2015`. Further
information is available in the :omero_doc:`OMERO developer documentation on
Key-value pairs <developers/Model/KeyValuePairs.html>` and a
:omexml_downloads:`sample OME-XML file <mapannotation.ome.xml>` is also available.

The structure of the SA used in the schema is shown below,
along with all the possible attachment points in the model.

.. figure:: /images/structured_annotation_branch.png
   :align: center
   :alt: StructuredAnnotation Model branch

   The StructuredAnnotation branch of the OME Model


.. figure:: /images/annotation_points.png
   :align: center
   :alt: Annotation Points

   All points in the OME Model that can be Annotated


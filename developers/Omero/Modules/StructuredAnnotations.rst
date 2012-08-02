Structured Annotations
======================

.. contents::

Structured annotations permit the attachment of data and metadata
outside the OMERO data model to certain types within the model. The
annotations are designed for individualized use by both sites and tools.
Annotations can be attached to multiple instances simultaneously to
quickly annotated all entities in a view. Each annotation has a "name"
which can be interpreted as a "namespace" by tools, which can filter out
all unknown namespaces. Further, to prevent users from overwriting or
editing important information, annotations are immutable, but editing
can be simulated via copy and delete.

Annotated & Annotating types
----------------------------

Each type which can be annotated implements ``ome.model.IAnnotated``.
Currently, these are:

-  ``Project``
-  ``Dataset``
-  ``Image``
-  ``Pixels``
-  ``OriginalFile``
-  ``PlaneInfo``
-  ``Roi``
-  ``Channel``
-  ``Annotation`` and all annotation subtypes in order to form
   hierarchies
-  `ScreenPlateWell </ome/wiki/ScreenPlateWell>`_: ``Screen``,
   ``ScreenAcquisition``, ``Plate``, ``Well``, ``WellSample``,
   ``Reagent``
-  ...

Annotation hierarchy
~~~~~~~~~~~~~~~~~~~~

Though they largely are all String or numeric values, a hierarchy of
annotations makes differentiating between just what interpretation
should be given to the annotation. This may eventually include
validation of the input string and/or file.

::

       Annotation (A*) ....................... Only a name field
         ListAnnotation ...................... Uses AnnotationAnnotation links to form a list of annotations
         BasicAnnotation (A*) ................ Literal or "primitive" values
           BooleanAnnotation ................. A simple true/false flag. Perhaps for hit/miss detection
           NumericAnnotation (A*) ............ Floating point and integer values
             DoubleAnnotation
             LongAnnotation
           TextAnnotation .................... A single text field
             TagAnnotation ................... Interpreted as a Web 2.0 "tag" on an object. Tags on tags form tag bundles
             QueryAnnotation ................. Possibly interpreted as a query which was used to create a dataset, for example
             XmlStringAnnotation ............. An xml snippet attached to some object
             UrlAnnotation ................... A url. This annotation may be further subclassed (LSID, HTTPS, ...)
          TypeAnnotation (A*) ................ Links some entity to another (possbily to be replaced by <any/>
            ThumbnailAnnotation .............. Attaches a thumbnail to some entity, most likely for client-use
            FileAnnotation    ................ Uses the Format field on OriginalFile to specify type

       A* = abstract

Names and Namespaces
--------------------

Since arbitrary blobs or clobs can be attached to an entity, it is
necessary for clients to have some way to differentiate what it can
parse. In many cases, the name might be a simple reminder for a user to
find the file s/he an annotation. Applications, however, will most
likely want to define a namespace, like
``http://name-of-application-provider.com/name-of-application/file-type/version``.
Queries can then be produced which search for the proper namespace or
match on a part of the name space:

::

       iQuery.findAllByQuery("select annotation from FileAnnotation where "+
        "name like 'http://name-of-application-provider.com/name-of-application/%'");

Tags will most likely begin without a namespace. As a tag gets escalated
to a common vocabulary, it might make sense to add a possibly
site-specific namespace with more well-defined semantics.

Descriptions
------------

Unlike the previous, ``ImageAnnotation`` and ``DatasetAnnotation``
types, the new structured annotations do not have a description field.
The single description field was limited for multi-user scenarios, and
can be fully replaced by ``TextAnnotations`` attached to another
annotation.

::

       FileAnnotation fileAnnotation = ...;
       TextAnnotation description = ...;
       fileAnnotation.linkAnnotation(description);

Immutability
------------

The actual content value of an annotation -- the text, long, double,
file value, etc -- is immutable. Links to and from the annotation,
however, can be modified.

Currently the namespace field of annotations is mutable. See
`#878 </ome/ticket/878>`_ for discussion.

--------------

Examples
--------

Basics
~~~~~~

::

     import ome.model.IAnnotated;
     import ome.model.annotations.FileAnnotation;
     import ome.model.annotations.TagAnnotation;
     import ome.model.core.OriginalFile;
     import ome.model.display.Roi;

     List<Annotation> list = iAnnotated.linkedAnnotationList();
     // do something with list

Attaching a tag
~~~~~~~~~~~~~~~

::

      TagAnnotation tag = new TagAnnotation();
      tag.setTextValue("interesting");
      
      Roi roi = ...; // Some region of interest
      ILink link = roi.linkAnnotation(tag);
      
      iUpdate.saveObject(link);

Attaching a file
~~~~~~~~~~~~~~~~

::

     // or attach something new
     OriginalFile myOriginalFile = new OriginalFile();
     myOriginalFile.setName("output.pdf");
     // upload PDF

     FileAnnotation annotation = new FileAnnotation();
     annotation.setName("http://example.com/myClient/analysisOutput");
     annotation.setFile(myOriginalFile);

     ILink link = iAnnotated.linkAnnotation(annotation)
     link = iUpdate.saveAndReturnObject(link);

All write changes are intended to occur through the IUpdate interface,
whereas searching should be significantly easier through ome.api.Search
than IQuery.

--------------

See also: `original proposal </ome/wiki/proposals/Attributes>`_,
`ExtendingOmero </ome/wiki/ExtendingOmero>`_

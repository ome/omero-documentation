Attaching attributes to all entities
====================================

**Josh Moore, April/2007, Updated Novemeber/2007**

Services
--------

A stateful services should be able to provide the tagging/search
functionality of `milestone:3.0-Beta3 </ome/milestone/3.0-Beta3>`_:
ome.api.Search. Search stores multiple queries and be used as an
iterator filtering and fetching entities according to user inputs. (See
attached file)

Model changes
-------------

-  To implement the search functionality, newer versions of Hibernate
   (including Hibernate Annotations and Hibernate Search) will be used.
   This requires the removal of the defaultXYZLink construct which was
   previously available. (This change was also discussed for performance
   reasons). This means that all cases of something be a "default"
   instance (images->pixels and experimenter->groups) are now replaced
   with ordered lists, with the first instance being the "default" and
   accessible via "getPrimaryXYZ". The means that there are no more
   default-setters on Pixels and ``GroupExperimenterMap``. Instead, it
   is important to either add the entities to the single-valued side
   (Image and Experimenter, respectively) or use the setPrimaryXYZ()
   methods. Also included are:

   -  Changing all queries referring to defaultPixels
   -  Overlooking all usage of ``ObjectFactory.createPixelsGraph()``
   -  ``ValidationExceptions`` of the form : "null or transient value
      ... Type.\_FieldBackRef" refer to an attempt to save a member of
      an ordered list (``Pixels``, ``GroupExperimenterMap``) rather than
      the containing object (``Image``,\ ``Experimenter``)

-  All List-based fields are now protected (accessors are protected) as
   were Set-based fields. The standard methods ``addXyz()``, etc. are
   all available as well as ``getXyz(int)``.

-  Generics: the addition of generic parameters on some methods changes
   how castings are to be handled. Now, rather than
   ``(List<Type>) collectXyz(null)``, ``collectXyz((CBlock<Type>)null)``
   should be used.

-  Details subclasses : to properly handle the different configurations
   for Details (global, regular, mutable) via annotations, it was
   necessary to subclass ome.model.internal.Details in each top-level
   type. This makes calling ``IObject.setDetails()`` much more
   complicated, and it is therefore marked as protected. Instead, use
   ``IObject.getDetails().copy(Details)``.

-  Then, ``ImageAnnotation``, ``DatasetAnnotation``, and
   ``ProjectAnnotation`` types will be removed. These are 1-many single
   string values attached to each of the named types. The new
   annotations are more flexible and can be attached to any type by
   adding ``<type id=... annotated="true">`` in the mapping file.
   Although the final model API is not finalized, the following snippet
   is roughly accurate:

::

     import ome.model.IAnnotated;
     import ome.model.core.OriginalFile;
     import ome.model.annotations.PdfAnnotation;

     List<Annotation> list = iAnnotated.linkedAnnotationList();
     // do something with list
     // or attach something new
     OriginalFile myOriginalFile = new OriginalFile();
     myOriginalFile.setName("output.pdf");
     // upload PDF
     ILink link = 
     iAnnotated.linkAnnotation(new PdfAnnotation("http://example.com/myClient/someOutput",myOriginalFile));
     link = iUpdate.saveAndReturnObject(link);

All write changes are intended to occur through the IUpdate interface,
whereas searching should be significantly easier through ome.api.Search
than IQuery.

Upgrade requirements
--------------------

To run the upgrade script, it will be necessary for a DB administrator
to execute the following ig PLPGSQL is not already available:

::

    CREATE LANGUAGE plpgsql;

After which, the provided upgrade script can be run. It will:

-  Add all new tables
-  Convert the experimenter/groupexperimentermap and image/pixels
   relationships to use arrays
-  Convert all categories/categorygroups to tags and tags of tags

Annotated & Annotating types
----------------------------

The plan is currently to attach annotations to several core types:

-  ``Project``
-  ``Dataset``
-  ``Image``
-  ``Pixels``
-  ``OriginalFile``
-  ...

and to allow the attachment of:

-  text
-  double, long, boolean
-  ``OriginalFile``
-  ``Thumbnail``\ (?)
-  ``ROI``\ (?)

Annotation hierarchy
--------------------

Though they largely are all String or numeric values, a hierarchy of
annotations is planned to make differentiating between just what
interpretation should be given to the annotation. This may include
validation of the input string and/or file to test for valid XML or
valid URLs. See `proposals/Validation </ome/wiki/proposals/Validation>`_

::

       Annotation:
          ReifiedAnnotation # more on this later
          NamedAnnotation:
             LiteralAnnotation:
                BooleanAnnotation
                NumberAnnotation:
                   FloatAnnotation
                   DoubleAnnotation
                   ...
                StringAnnotation:
                   QueryAnnotation
                   XmlStringAnnotation
                   UrlAnnotation
                      LsidAnnotation
                   ...
             BlobAnnotation:
                PdfAnnotation
                XmlBlobAnnotation
                ...
             ...

Relationship to OME
-------------------

CustomAttributes -- since it is not possible to dynamically add types to
OMERO, on importing CustomAttributes it should be possible to store the
XML itself and SemanticType definition so that on export, an equivalent
OME-XMl can be produced. The current plan is that all annotations will
be exported within a separate top-level XML container with references to
id's in the <ome/> tag.

Named versus Reified annotations
--------------------------------

Note: The use cases for reified annotations are still unclear.

Named annotations are intended to allow any external
classification/annotation system to be used within the OMERO database.
The "name" field should usually be a unique identifier like an URI/LSID
or a UUID. Obviously, one could create non-unique names of the form
``new StringAnnotation("myField","woohoo")``, but others could similarly
use that name making querying difficult.

Reified annotations come into play when analysis data, annotations, or
other third person or external information should be attached to
existing entities (like thumbnails, see
`proposals/DeleteTransaction </ome/wiki/proposals/DeleteTransaction>`_).
These are added to the mapping files under common/ and have classes and
table generated, **but** it would be possible to delete them. To make
this work, it may be necessary to add two subinterfaces of IObject:

::

Currently, we are using something more like the VMS filesystem metaphor
in which adding a file to a directory prevents the directory from being
deleted. (Discussed on the ` 2006-08-31 conference
call <http://cvs.openmicroscopy.org.uk/tiki/tiki-index.php?page=ConferenceCall%202006-08-31>`_
Rather than the either/or metaphors of unix filesystem versus the VMS
filesystem, we could include filesystem attributes as the metaphor for
things that just disappear when the file is deleted:

::

    /Classes/Images$ touch 1
    /Classes/Images$ echo owner=Expteriment/0 >> 1
    /Classes/Images$ echo group=ExperimenterGroup/0 >> 1
    # Adding those "links" to the files prevents them from being deleted
    /Classes/Images$ chattr +d 1
    /Classes/Images$ lsattr 1
    ------d---------- 1
    # This attribute exists only "within" image 1.

Note: it's possible to do something like this solely in Hibernate
(Hibernate's concept of
` components <http://www.hibernate.org/hib_docs/v3/reference/en/html/components.html>`_.
Such components, however, are associated with a db identifier, which we
would probably want to maintain for export.

Issues
------

-  Over-use of named annotations. As discussed in Paris, March/2007, it
   would be possible for users to overload the annotations and really
   the whole database, by attempting to store too much data in this
   non-formated way.

Attachments
~~~~~~~~~~~

-  `Search.java </ome/attachment/wiki/proposals/Attributes/Search.java>`_
   `|Download| </ome/raw-attachment/wiki/proposals/Attributes/Search.java>`_
   (14.9 KB) - added by *jmoore* `5
   ago.

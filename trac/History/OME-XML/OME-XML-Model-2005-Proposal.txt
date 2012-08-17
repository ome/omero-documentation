Introduction
~~~~~~~~~~~~

--------------

    We have been working with the existing data model as it exists now
    (for the most part) for more than 2 years. There are some cosmetic
    and basic additions that need to be made as well as some significant
    changes to the way we internally reference *Pixels* objects to
    support the claims that we "support multiple pixels sets per image".
    There are a couple basic class diagrams here to illustrate the new
    *PlaneInfo* and *Screening Data Model* data types. Please ask for
    clarification in the comments if needed. There are also a few items
    marked *Low Priority*. These items should be implemented if
    convenient otherwise there is no burning need to have them
    completed.

Base Data Model Changes
~~~~~~~~~~~~~~~~~~~~~~~

--------------

Repositories (ST)
^^^^^^^^^^^^^^^^^

-  Remove field "path"

   -  With the migration to the image server technology, this field is
      no longer required.

-  Remove field "is\_local"

   -  As above, the migration to the image server technology makes this
      field unneeded.

Project (Base Type)
^^^^^^^^^^^^^^^^^^^

-  Remove field "view"

   -  The field "view" is unused, non-existant in the XML specification
      and also unreferenced in the Perl documentation.

Thumbnails (ST)
^^^^^^^^^^^^^^^

-  Remove this type entirely

   -  Thumbnails are handled entirely by OMEIS which has no direct
      awareness of OME. The existence of this type creates confusion.

Pixels Related Data Model Changes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--------------

    Currently some of the OME data model does not explicitly support the
    "an image may have multiple sets of pixels" advertised feature.
    These changes are proposed to achieve this.

Images (Base Type)
^^^^^^^^^^^^^^^^^^

-  Give "pixels" field a "NOT NULL" constraint

   -  As we are making this transition away from directly relating
      metadata to an image there should be no cases where there is an
      "image" object and no corresponding default pixels.

Image Dimensions (ST)
^^^^^^^^^^^^^^^^^^^^^

-  Rename to Pixels Dimensions (Low Priority)

   -  The values in this table do not apply to an image but to a pixels
      set.

-  Remove "pixel\_size\_c" and "pixel\_size\_t"

   -  As the values in this table represent the physical size of a given
      pixel, these fields do not make sense in this context.

-  Add "pixels\_id" field

   -  Currently the linkage in this table is to an image where it should
      be to a set of pixels.

Classification (ST)
^^^^^^^^^^^^^^^^^^^

-  Add "pixels\_id" field

   -  Currently the linkage in this table is to an image where it should
      be to a set of pixels.

Image Annotation (ST)
^^^^^^^^^^^^^^^^^^^^^

-  Rename to Pixels Annotation (Low Priority)

   -  The values in this table do not apply to an image but to a pixels
      set.

-  Add "pixels\_id" field

   -  Currently the linkage in this table is to an image where it should
      be to a set of pixels.

Plane Info (New Addition)
^^^^^^^^^^^^^^^^^^^^^^^^^

    New *PlaneInfo* ST. If info available, we should have one per
    XY-Plane (i.e. sizeZ \* sizeC \* sizeT) where:

-  sizeZ is the number of z-sections of the pixels set.
-  sizeC is the number of channels.
-  sizeT is the number of time-points.

`|http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/planeInfo.PNG| <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/planeInfo.PNG>`_

Mapping Table Changes
~~~~~~~~~~~~~~~~~~~~~

--------------

    Continuing Ilya's work to make implicit data model constraints
    explicit database constraints we'd like to see the following mapping
    table changes.

Image Dataset Map
^^^^^^^^^^^^^^^^^

-  The "image\_id" / "dataset\_id" couple should be declared as a
   primary key

Project Dataset Map
^^^^^^^^^^^^^^^^^^^

-  The "project\_id" / "dataset\_id" couple should be declared as a
   primary key

Screening Data Model
~~~~~~~~~~~~~~~~~~~~

--------------

    As has been discussed at length now, we need a better data model to
    support screening. With the input of our colleagues at MIT, Dresden
    and other institutions we have come up with a new data model:

`|http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/screenDBView.PNG| <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/screenDBView.PNG>`_

5D ROIs
~~~~~~~

These are a proposed idea for capturing and assigning any defined info
about sub-regions on a Pixels:

`|http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/rois.PNG| <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/rois.PNG>`_

Operation XML with Flat Bounding Box
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    This page evaluates the "Operation XML element ROIs" use case
    expressed on the Roi5D Proposals
    `OME-XML-Model-2005-ROI5D </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D>`_
    page with respect to the Flat Bounding Box
    `OME-XML-Model-2005-Flat-Bounding-Box </ome/wiki/History/OME-XML/OME-XML-Model-2005-Flat-Bounding-Box>`_
    data model.

Representation
^^^^^^^^^^^^^^

*Arbitrary, user-specified (during acquisition) area in 2D (generally
some sort of blob), at a given Z plane*

This structure can be expressed as a 5DBoundingBox object with XY
extents corresponding to the blob's bounding box, and startZ=endZ at the
correct Z plane. Since the Operation presumably occurs at a particular
time, there would also be startT=endT for the time point when it
occurred. As for C, startC=0 and endC=numC-1 (i.e., all channels) is
probably sufficient. The 5DBoundingBox's linked Shape could be a
Rectangle in the simplest case, or a Polygon, or a BinaryMask, depending
on the blob's complexity.

(I am not completely clear on what constitutes a 2DBoundingBox or
3DBoundingBox object, so I will not comment on whether those structures
would be more appropriate.)

*Operation to which this area corresponds (e.g., a particular attempt at
photobleaching)*

This characteristic is represented by a reference within the Operation
XML element to the desired 5DBoundingBox expressed in XML.

*Potentially in the future, user-specified enumeration of these areas
across multiple Z planes*

This scenario can be handled by expanding the startZ/endZ range to
include more than one Z plane. If we eventually define 3D shapes (such
as a 3D bitmask), we can link that 3D shape to the 5DBoundingBox.

It is my understanding that we will not need to express a discontinuous
collection of Z planes. But if we did for some reason, it would be
easily handled by having the Operation reference a RegionUnion instead
of a single 5DBoundingBox. This solution would also allow the
specification of a series of 2D bitmasks (or rectangles or polys) to
define the shape instead of a single 3D shape.

Specific queries encapsulating the questions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

*For a given operation, what is the corresponding targeted area?*

This query is easy — the Operation has a Shape attribute that references
a specific 5DBoundingBox (or RegionUnion), which identifies the targeted
area.

*For a given Z plane, what operations took place?*

From the list of 5DBoundingBoxes linked from Operations, select all
5DBoundingBoxes such that the Z plane lies within the Z extents.

For RegionUnions, one more layer exists. The RegionUnions linked from
Operations must have each constituent 5DBoundingBox checked to see if
the Z plane lies within the Z extents of that bounding box. If so, the
RegionUnion qualifies.

*For a given area on a specified Z plane, are there any operation ROIs
that overlap? (probably less important)*

This query is harder. An appoximation is not too difficult: from the
operations that took place on that Z plane (see above query), select all
5DBoundingBoxes such that the given area rectangle overlaps with the
bounding box in X and Y (I can post the math for this if necessary).

If the given area is non-rectangular, or the 5DBoundingBox's linked
shape is nonrectangular, or both, the query becomes more difficult.
Different types of shapes require different cases. In the bitmask case,
checking for overlap simply entails finding a single pixel in X and Y
that is included for both the given area and the operation's bounding
box. But this test is not cheap if there are many operations to analyze.

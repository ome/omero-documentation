Operation XML with Roi5D
~~~~~~~~~~~~~~~~~~~~~~~~

    This page evaluates the "Operation XML element ROIs" use case
    expressed on the Roi5D Proposals
    `OME-XML-Model-2005-ROI5D </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D>`_
    page with respect to the Roi5D
    `OME-XML-Model-2005-ROI5D-Detail </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D-Detail>`_
    data model.

Representation
^^^^^^^^^^^^^^

*Arbitrary, user-specified (during acquisition) area in 2D (generally
some sort of blob), at a given Z plane*

This structure can be expressed as a ROI5D hierarchy with SizeC ROI4Ds
(each one corresponding to a different C value, to encompass all
channels). Since the Operation presumably occurs at a particular time,
each ROI4D would be referenced by the same ROI3D (making use of the new
many-to-many capabilities), which in turn is referenced by a single
ROI2D identifying the Z plane, that is referenced by a single ShapeArea
object that ultimately defines the 2D area. Unfortunately, Rectangle,
Square, Ellipse and Circle are not sufficient to exactly specify an
arbitrary area in 2D — we will need support for BitMasks (which are
briefly discussed on the Roi5D page).

*Operation to which this area corresponds (e.g., a particular attempt at
photobleaching)*

This characteristic is represented by a reference within the Operation
XML element to the desired Roi5D expressed in XML.\ *Potentially in the
future, user-specified enumeration of these areas across multiple Z
planes*

This scenario can be handled by specifying multiple ROI2D objects, one
for each involved Z plane, that are all linked to either the same
ShapeArea (for a cylindrical column) or different ShapeAreas (for a true
3D blob). The 3D blob would need to be discretized (sliced into 2D
planes) according to the component Z planes.

Specific queries encapsulating the questions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

*For a given operation, what is the corresponding targeted area?*

This query is easy — the Operation has a Shape attribute that references
a specific ROI5D, which identifies the targeted area.

*For a given area on a specified Z plane, are there any operation ROIs
that overlap? (probably less important)*

From the list of ROI5Ds linked from Operations, drill down into the
ROI5Ds looking for ROI2Ds with matching Z plane.

*For a given Z plane, what operations took place?*

This query is harder. An approximation is not too difficult: from the
operations that took place on that Z plane (see above query), select all
ShapeAreas such that the area's bounding rectangle overlaps with the
bounding box in X and Y (I can post the math for this if necessary).

If the given area is non-rectangular, or the ShapeArea is
nonrectangular, or both, the query becomes more difficult. Different
types of shapes require different cases. In the BitMask case, checking
for overlap simply entails finding a single pixel in X and Y that is
included for both the given area and the operation's ShapeArea. But this
test is not cheap if there are many operations to analyze.

VisBio Overlays with Roi5D
~~~~~~~~~~~~~~~~~~~~~~~~~~

    This page evaluates the "VisBio Overlays" use case expressed on the
    Roi5D Proposals
    `OME-XML-Model-2005-ROI5D </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D>`_
    page with respect to the Roi5D
    `OME-XML-Model-2005-ROI5D-Detail </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D-Detail>`_
    data model.

**Note: This page is not complete. Before continuing in this direction
we are evaluating the Unified ROI Model
`OME-XML-Model-2005-Unified-ROI </ome/wiki/History/OME-XML/OME-XML-Model-2005-Unified-ROI>`_.**

Representation
^^^^^^^^^^^^^^

    In many cases below, I refer to a "ROI5D hierarchy" rather loosely.
    More precisely, this ROI5D would include SizeC ROI4Ds (each one
    corresponding to a different C value, to encompass all channels).
    Since the glyph presumably occurs at a particular time, each ROI4D
    would be referenced by the same ROI3D (making use of the new
    many-to-many capabilities), which in turn is referenced by a single
    ROI2D identifying the Z plane, that is referenced by a single
    ShapeArea object that ultimately defines the 2D area and glyph type.

*Markers (points) — XY coordinate*

    These can be represented by a ROI5D hierarchy with associated
    rectangle ShapeArea with width and height of 0.

*Lines — pair of XY coordinates, potentially directed (for rendering
arrows)*

    These can be represented by a ROI5D hierarchy with a new kind of
    ShapeArea called Line. As long as negative width is allowed, lines
    with negative slope can be expressed.

*Ellipses ("ovals")*

    These can be represented by a ROI5D hierarchy with an ellipse
    ShapeArea.

*Rectangles ("boxes")*

    These can be represented by a ROI5D hierarchy with a rectangle
    ShapeArea.

*Text — could be either its own type, or simply a marker or box with
associated text to render at that location*

    Ideally, I would like ShapeArea to include a "Text" or "Description"
    attribute, or something like that, so that any shape can be given
    text. This scheme would allow VisBio to specify a text overlay as a
    marker (rectangle with width and height of 0) with associated text
    string. Without this augmentation, text cannot be expressed
    properly.

*Freeform selections (represented with bitmasks, and maybe also N-edged
polygons)*

    These can be represented by a ROI5D hierarchy with linked BitMask or
    Polygon. The exact nature of these types has not yet been outlined
    on the ROI5D[tiki-editpage.php?page=ROI5D ?] page.

*Assignment of color to each glyph; both "filled" and "hollow" glyphs
(rendering distinctions)*

    Ideally, I would like ShapeArea to include "Color" and "Pattern"
    attributes, or something like that, so that any shape can be
    assigned a color, and a fill pattern (hollow, solid, plaid, etc.).
    This scheme would allow VisBio to specify these overlay parameters
    for any type of overlay. Without this augmentation, color and
    pattern cannot be expressed properly. However, including them in the
    data model might be "polluting" it somewhat; I'm not sure. I am fine
    with whatever is decided as long as the model makes it possible to
    associate this information with the ROI5D.

*Groupings of these glyphs into larger structures (assignment of each
glyph to a particular group)*

    The ROI5D hierarchy makes these associations easy, as they are a
    major reason for the ROI5D structure's existence. For multiple Z
    planes, the ROI3D references multiple ROI2Ds. For multiple time
    points, the ROI4Ds reference multiple ROI3Ds. And if for some reason
    we want to limit which channels are associated with a structure, we
    eliminate some of the ROI4Ds from the ROI5D.

Specific queries encapsulating the questions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

*Which glyphs belong to a given image plane*

*Which glyphs belong to a given set of planes (typically across Z, but
potentially across any given dimension — simply a repetition of the
first question across multiple planes, but such an iteration will be
very common)?*

*To which larger structure does this glyph belong, if any?*

*Which glyphs belong to a particular group/structure?*

*Which glyphs are a particular color?*

*Which glyphs overlap a particular XY area?*

*Which glyphs contain the given substring in their text field (or which
text glyphs contain the substring)?*

*Combinations of the above queries.*

*Potentially more complex queries, but I cannot give concrete examples
until the functionality is more mature.*

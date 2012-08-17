VisBio Overlays with Flat Bounding Box
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    This page evaluates the "VisBio Overlays" use case expressed on the
    Roi5D Proposals
    `OME-XML-Model-2005-ROI5D </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D>`_
    page with respect to the Flat Bounding Box
    `OME-XML-Model-2005-Flat-Bounding-Box </ome/wiki/History/OME-XML/OME-XML-Model-2005-Flat-Bounding-Box>`_
    data model.

**Note: This page is not complete. Before continuing in this direction
we are evaluating the Unified ROI Model
`OME-XML-Model-2005-Unified-ROI </ome/wiki/History/OME-XML/OME-XML-Model-2005-Unified-ROI>`_.**

Representation
^^^^^^^^^^^^^^

*Markers (points) — XY coordinate*

*Lines — pair of XY coordinates, potentially directed (for rendering
arrows)*

*Ellipses ("ovals")*

*Rectangles ("boxes")*

*Text — could be either its own type, or simply a marker or box with
associated text to render at that location*

*Freeform selections (represented with bitmasks, and maybe also N-edged
polygons)*

*Assignment of color to each glyph; both "filled" and "hollow" glyphs
(rendering distinctions)*

*Groupings of these glyphs into larger structures (assignment of each
glyph to a particular group)*

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

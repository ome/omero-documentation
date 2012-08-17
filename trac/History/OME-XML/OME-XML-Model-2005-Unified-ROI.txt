Unified Roi Model
-----------------

**-- Ilya, Curtis, Josh**\ *'May 15, 2006\ *****

--------------

`|http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/rois\_classdia.png| <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/rois_classdia.png>`_

--------------

    The Unified ROI Model tries to combine the continuous box model of
    the `Flat Bounding
    Box </ome/wiki/History/OME-XML/OME-XML-Model-2005-Flat-Bounding-Box>`_\ (**FBB**)
    model as well as the discrete
    `ROI5D </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D-Detail>`_
    model. One benefit of this is that each model concentrates on its
    strength. For ROI5D, the addition of a bounding box may prove a
    performance optimization for some queries. FBB gains a more exact
    discrete description language for the expression of contained
    sections. Added to the model are the 8 mandala-types, representing
    all possible bounding boxes. The typing of the bounding boxes is
    useful for restricting the inputs and outputs of modules based on
    the dimensionality of the region of interest. For simple cases, it
    will be possible that a ROI be defined in either FBB or ROI5D model.
    It is our intention, however, to provide an API which provides
    isomorphic translations from one type to the other as necessary.

Currently open questions include
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Is it possible to talk about slices of an existing ROI? What's the
   best way of doing this? (Convention, a FK, a specialised type)
-  Does the proposal provide too many options for the casual user?
-  What use cases produce non-isomorphic representations?
-  Should every ROI5D have a BoundingBox?
-  A ROI5D can handle 2D continuous shapes, but not higher dimensional
   ones. Is this a problem?

Moving forward
~~~~~~~~~~~~~~

    To begin work on the unified model, a preliminary review phase is
    scheduled for the week of the 19th of May, and a brief open
    discussion period until the 26th. After that, a process similar to
    that outlined on `Roi5D
    Proposals </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D>`_
    will be followed, but with work done jointly by the various sites.
    This will include producing data matching each use case,
    implementing the model and the needed queries, and checking the
    expressivity (and lack of absurdity) in the model.

--------------

Comments / Suggestions / Brain-storming
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Possible name changes
^^^^^^^^^^^^^^^^^^^^^

-  BoundingBox --> ContinuousShape/OrthoCube (Jeremy) ContinuousROI
   (Josh)
-  Roi5D --> HierarchicalSlicesROI (Jeremy) DiscreteROI (Josh)

Proposals for a shared 5D ROI data model
----------------------------------------

-  `Proposals for a shared 5D ROI data
   model </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#_Proposals_for_a_shared_5D_ROI_data_model>`_

   -  `Introduction </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#Introduction>`_
   -  `Criteria </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#Criteria>`_
   -  `Timeline </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#Timeline>`_
   -  `Data
      models </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#Data_models>`_

      -  `5D-ROI (with many-to-many at every
         level) </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#5D_ROI_with_many_to_many_at_every_level_>`_
      -  `Flat Bounding Box
         model </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#Flat_Bounding_Box_model>`_
      -  `Unified ROI
         Model </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#_Unified_ROI_Model>`_

   -  `Use
      cases </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#Use_cases>`_

      -  `VisBio
         overlays </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#VisBio_overlays>`_
      -  `Shoola Image Browsing and
         Annotation </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#Shoola_Image_Browsing_and_Annotation>`_
      -  `Operation XML element
         ROIs </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#Operation_XML_element_ROIs>`_
      -  `Fluorescence Recovery After Photobleaching (FRAP)
         Analysis </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#Fluorescence_Recovery_After_Photobleaching_FRAP_Analysis>`_
      -  `Find Spots & Track
         Spots </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#Find_Spots_amp_Track_Spots>`_
      -  `Microtubule
         Tracking </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#Microtubule_Tracking>`_
      -  `Cross
         correlation </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#Cross_correlation>`_
      -  `Classification of Image
         regions </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D#Classification_of_Image_regions>`_

Introduction
~~~~~~~~~~~~

    At the April 2006 meeting, we decided to test several different data
    models for regions of interest to see how well they work with our
    various use cases. There are four aspects to this discussion that
    must be enumerated.

#. Possible data models to handle these cases (May 5th)
#. Each of our real use cases (not hypothetical) (May 5th)
#. Evaluation of every use case in each data model, according to the
   criteria below (expressiveness by May 12th, performance by May 19th)

Criteria
~~~~~~~~

    Once these are listed, we can evaluate how appropriate the data
    models are for each use case, and thus overall, according to the
    following criteria (in decreasing order of importance):

#. **Expressiveness** — Can it be expressed? (Can you express data? Can
   you pose queries?)
#. **Performance** — How efficient are data creation & queries?
#. **Ambiguity** — How many ways can you express the data in the model?
#. **Data duplication** — We are more concerned with data consistency
   than size. Although logic can be hidden behind an API, we want to
   minimize the difficulty of implementation because it will be
   implemented many times.
#. **Nonsensical statements** — Are there expressions in the data model
   that do not make sense? (independent of use cases)

Timeline
~~~~~~~~

    It is the responsibility of each developer to post his use cases by
    **Friday, May 5th**. These descriptions should simply be an
    explanation of the biological problem you're solving, data
    representation requirements, and which queries you require (the
    latter two in abstract terms). Also posted by **May 5th** will be
    the data models we plan to evaluate (listed below). One week later,
    by **Friday, May 12th**, every use case needs to be expressed in
    each data model, and relevant queries must be posed (in concrete
    terms specific to the data model). This evaluates expressiveness,
    the first criterion listed above. Once all possible data models and
    use cases have been posted, performance evaluation can commence, and
    will be completed by **May 19th**. All other evaluation criteria
    will also be completed by this date.Update: As of 15th, May 2006, a
    new hopefully unified model has been added to the list. Therefore,
    this timeline will have to be re-evaluated.

Data models
~~~~~~~~~~~

5D-ROI (with many-to-many at every level)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    An initial version has been available at
    `OME-XML-Model-2005-ROI5D-Detail </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D-Detail>`_.
    The exact proposal shown is being withdrawn and will soon be
    replaced by an image of the 5D-ROI with many-to-manys. The
    many-to-many case is now the only standing 5D-ROI proposal. It
    fulfills our existing (and below linked) use cases and, we think,
    the use cases brought up at the Madison Meeting]. ~ Dundee The
    **logical** model for the updated ROI5D allows for the reuse of each
    level of the 5D hierarchy, from channel, time, and z-slices to the
    individual shapes. It does not, however, support the use of ranges
    (1 to 10 by 5s) or enumerations ({1,5,7,10}) but rather represents
    the entire **union** of elements in a discrete fashion. This
    discontinuity may require more space (rows in the DB, or XML
    elements) but simplifies the interactions that we plan with the
    ROI5Ds greatly. Specifically, the user has the ability to
    "*fiddle*\ " individual planes, sections, without unduly burdonening
    the client with ROI logic, nor the server with overhead.

Flat Bounding Box model
^^^^^^^^^^^^^^^^^^^^^^^

    The heart of this model is a 5d bounding box. This bounding box is
    guaranteed to be continous in X,Y, and Z, but may be discontinuous
    across channels and timepoints. This bounding box is accompanied by
    an attribute from the "Shape" family of STs. The members of the
    shape family includes rectangles, binary masks, and 3D
    representations of surfaces. The "Shape" family is designed to be
    extended. 5D Bounding Boxes may be aggregated in a RegionUnion for
    purposes of tracking objects temporally, tracking cell lineage, etc.
    It is called "Flat" because there is little differentiation of types
    of BoundingBoxes, and the model does not allow BoundingBoxes to
    contain other BoundingBoxes. For more details and information, read
    `OME-XML-Model-2005-Flat-Bounding-Box </ome/wiki/History/OME-XML/OME-XML-Model-2005-Flat-Bounding-Box>`_

Unified ROI Model
^^^^^^^^^^^^^^^^^

    The unified ROI model attempts to combine the advantages of the two
    previous model while allowing for flexibility and performance. For
    more details and information, read
    `OME-XML-Model-2005-Unified-ROI </ome/wiki/History/OME-XML/OME-XML-Model-2005-Unified-ROI>`_

Use cases
~~~~~~~~~

    For each use case, the following points must be addressed:

-  Biological problem being solved (by May 5th)
-  Data that needs to be represented (abstract) (by May 5th)
-  Questions asked about the data (abstract) (by May 5th)
-  Representation of the use case in each data model (by May 12th)
-  Specific queries encapsulating the questions (by May 12th)

VisBio overlays
^^^^^^^^^^^^^^^

    VisBio currently allows the user to draw a variety of glyphs in 2D
    that overlay a given image plane. Any number of glyphs can be
    defined, and each glyph is tied to a specific plane. The biological
    problem being solved is general support for manual annotation, which
    has many uses: cell lineaging, migration tracking, etc. Eventually,
    VisBio will allow these glyphs to be tied together into larger
    structures, to define 3D volumes, and 4D volumes animated across
    time. Since VisBio is capable of representing dimensions beyond
    space and time, in the most general case these structures could also
    be tied together across such additional dimensions without
    restriction. These multidimensional ROIs have additional potential
    uses within VisBio, such as coring (culling pixels contained within
    a specific region) or other visualisation, manipulation or analysis
    of the pixels. For example, coring can be used to remove an
    organism's internals to more effectively study its skeletal
    structure. The naive implementation will simply allow 2D structures
    to be placed into groups, which the client takes care of rendering.
    For example, glyphs outlining a nucleus at each Z plane can be
    grouped into a 3D structure that the client can render as a blob in
    3D. In the future, it would be nice to extend the specification to
    support storage of multidimensional shapes such as computed
    interpolated surfaces (but IMO that functionality is outside the
    scope of our initial ROI data model, because any of the proposed
    models could later be extended to support such things with a minimum
    of difficulty).

**Biological problems being solved:**

-  Use of manual annotation for cell lineaging, migration tracking, and
   other feature identification.
-  Effective visualization and analysis of specific multidimensional
   structures: volume rendering/coring, region colorization, region
   analysis and statistics, etc.

**Data that needs to be represented:**

-  Markers (points) — XY coordinate
-  Lines — pair of XY coordinates, potentially directed (for rendering
   arrows)
-  Ellipses ("ovals")
-  Rectangles ("boxes")
-  Text — could be either its own type, or simply a marker or box with
   associated text to render at that location
-  Freeform selections (represented with bitmasks, and maybe also
   N-edged polygons)
-  Assignment of color to each glyph; both "filled" and "hollow" glyphs
   (rendering distinctions)
-  Groupings of these glyphs into larger structures (assignment of each
   glyph to a particular group)

**Questions asked about the data:**

-  Which glyphs belong to a given image plane?
-  Which glyphs belong to a given set of planes (typically across Z, but
   potentially across any given dimension — simply a repetition of the
   first question across multiple planes, but such an iteration will be
   very common)?
-  To which larger structure does this glyph belong, if any?
-  Which glyphs belong to a particular group/structure?
-  Which glyphs are a particular color?
-  Which glyphs overlap a particular XY area?
-  Which glyphs contain the given substring in their text field (or
   which text glyphs contain the substring)?
-  Combinations of the above queries.
-  Potentially more complex queries, but I cannot give concrete examples
   until the functionality is more mature.

**Evaluation of use cases:**

-  `VisBio Overlays with
   ROI5D </ome/wiki/History/OME-XML/OME-XML-Model-2005-VisBio-ROI5D>`_
-  `VisBio Overlays with Flat
   Bounding </ome/wiki/History/OME-XML/OME-XML-Model-2005-VisBio-Flat>`_
   Box

**Sample data:**

-  (Link was http://skyking.microscopy.wisc.edu/curtis/lineage/ sample
   overlay data for use in VisBio) (no groupings specified; VisBio does
   not yet support rendering of higher-dimensional overlays)

Shoola Image Browsing and Annotation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    Our Use Case for this was posted in Feb 2006. This is very similar
    to the VisBio Overlay above, except we envision annotations with
    "structure":

-  manually or automatically measured values
-  a type from a controlled vocabulary (similar to CG/C logic)
-  links to external resources
-  links to objects (i.e., a PDF, an xls file or other result)

**Biological problems being solved:**

-  Identification of ROIs according to user-defined criteria, either
   automatically or manually

**Data that needs to be represented:**

-  a 5D object
-  Linked to this, any specified info-- text, integers, floats, external
   links, binary objects

**Questions asked about the data:**

-  Find all ROIs with specific annotated data
-  We are still trying to understand whether a SELECT is necessary, or
   Google-like search is sufficent

Operation XML element ROIs
^^^^^^^^^^^^^^^^^^^^^^^^^^

    As specified on the
    `OME-XML-Evolution-2006-Proposal </ome/wiki/History/OME-XML/OME-XML-Evolution-2006-Proposal>`_
    page, there are plans to add an Operation OME-XML element, one of
    whose features will be the ability to specify a corresponding ROI.
    This is useful for things like photobleaching, to define the target
    area to be affected.

**Biological problems being solved:**

-  Specification of photobleaching target area during acquisition,
   within OME-XML

**Data that needs to be represented:**

-  Arbitrary, user-specified (during acquisition) area in 2D (generally
   some sort of blob), at a given Z plane
-  Operation to which this area corresponds (e.g., a particular attempt
   at photobleaching)
-  Note that this area corresponds to the *targetted* area, not the
   actually *affected* area (which for photobleaching will be more than
   simply the target Z plane, and may not correspond exactly to the
   target area in 2D, either) — the acquisition hardware has no way of
   knowing the actual biological effect of the operation
-  Potentially in the future, user-specified enumeration of these areas
   across multiple Z planes

**Questions asked about the data:**

-  For a given operation, what is the corresponding targetted area?
-  For a given area on a specified Z plane, are there any operation ROIs
   that overlap? (probably less important)
-  For a given Z plane, what operations took place? (this question is
   only tangential to the ROI model)

   -  I think it's not just tangential. Answering this question involves
      doing some joins on the relevant tables and the implementation
      will certainly affect performance. -Jeremy

**Evaluation of use cases:**

-  `Operation XML with
   ROI5D </ome/wiki/History/OME-XML/OME-XML-Model-2005-XML-ROI5D>`_
-  `Operation XML with Flat Bounding
   Box </ome/wiki/History/OME-XML/OME-XML-Model-2005-XML-Flat>`_

Fluorescence Recovery After Photobleaching (FRAP) Analysis
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    I would like an experimental biologist to go over this scenario. My
    comments in red-- Jason This technique is used with live cell
    imaging. A flourescent stain is applied to a mobile molecule.
    (Formally, a fluorophore can be introduced multiple ways: as a
    fluorescent protein fusion or as a small molecule fluorophore). Part
    of the cell is photobleached, that is, excited with a laser so the
    fluorescent molecules in that area are rapidly destroyed. The
    intensity of the bleached area is tracked across time to understand
    how the tagged molecules move into the zapped area. The rate and
    amount of fluorescence recovery in the bleached region is used to
    report on the mobiity and binding of biological molecules at
    specific sites in cells.

-  The timepoint and spatial region of the bleaching event is stored as
   a Photobleaching Operation in the Operation XML element.
-  Typically, the spatial region is fixed across time. If the spatial
   region jiggled across time, there would be no basis of establishing
   the region boundaries when Flourescence Recovery was near completion.
   (In fact, cells are alive, therefore regions do move. In some cases,
   trying to track the position of the beached region is necessary. In
   these cases, one tries to use the middle of the bleach ROI, but is
   very hard. Bad news: cells are alive, they move, and so do their
   constituents. One case where we have run into this-- FRAP of proteins
   on centromeres, during mitosis).

**Biology:**

-  Deriving a diffusion constant that can be used to predict the
   mobility of a molecule and understand its function.
-  Potentially, classifying a molecule's behaviour as free diffusion,
   constrained diffusion, or directed diffusion.

    I actually disagree with these, but the concept is roughly right.
    Calculation of diffusion constant is very hard, except in very
    specific cases. More likely, one gets the the t1/2 of recovery,
    which is used to indicate off-rate and the mobile fraction, which
    indicates what fraction of protein is mobile. Note also that there
    are many derivatives of FRAP-- FLIP, and iFRAP are the two most
    common. They are roughly similar in concept, but there are some
    important diffs:

-  in iFRAP, everything but the ROI is bleached, and loss from ROI is
   measured.
-  in FLIP, one region is repeatedly bleached and the the intensity loss
   in a DIFFERENT region is monitored.

**Data requirements:**

    Analysis Inputs:

-  Pixels
-  A spatial ROI description for a single timepoint. This spatial
   description is tied to a Photobleaching Operation. The analysis
   operates from this timepoint to the final timepoint.

    Analysis Outputs:

-  Intensity of a single channel in the region at each timepoint.
   Potentially, other measures such homogenity at each timepoint.
-  Overall rate of diffusion for the region across timepoints

**Questions posed:**

-  What is the single channel intensity of a particular ROI for a range
   of timepoints?
-  What is the intensity of complete recovery? e.g. What is the maximum
   single channel intensity of a particular ROI?
-  What timepoint does complete recovery occur at?
-  What timepoint did additional recovery become negligable? If the
   change of intensity was stored for every T(n) to T(n+1), this query
   could be searching on the delta\_Intensity table, constrained to an
   ROI, searching for delta's below a threshold, and ordering by
   timepoint.
-  What model best explains the observations?
-  What are the physical parameters for that model (e.g. diffusion
   constant) for a given image? For a range of images?
-  How much variation in the derived measurements occurs between images?

Find Spots & Track Spots
^^^^^^^^^^^^^^^^^^^^^^^^

    Find spots identifies three dimensional blobs in a single channel.
    Spatial statistics such as volume and volumetric centroid are
    measured on the 3D bounded region. Channel specific statistics such
    as total intensity and intensity centroid are measured for each
    channel on the 3D bounded region. Track spots collates 3D spots into
    trajectories. It calculates statistics such as velocity and
    direction between each sequential timepoint. Additionally, it
    calculates the average velocity of the entire trajectory. Subsequent
    analysis can be performed on these trajectories, or the segmentation
    algorithm can be followed by some other algorithm like feature-based
    image registration, or a different tracking algorithm. Currently
    only a single tracking algorithm is implemented.

**Biology:**

Many applications exist for sub-cellular multi-d particle tracking. The
attachment of meta-data to 4D XYZC as well as each 3D XYZ ROIs
per-channel (i.e. the intensity of the spot in each of the channels) was
useful in at least two applications:

-  The dynamics of Cajal bodies with regards to chromatin
-  The timing of the association of two proteins in the kinetochore by
   using a third kinetochore marker as a "mask" to define them.
-  The Cajal body study also required tracking in order to study the
   diffusion properties exhibited by these particles.

**Data requirements:**

-  Store a spatial region and accompanying statistics that are invariant
   to channels.
-  Store statistics accompanying the spatial region that are tied to
   individual channels.
-  Allow many trajectory predictions to be built from a set of spots.
   This allows for different versions of TrackSpots functionality.
-  Store secondary statistics about a trajectory such as mean squared
   displacement over delta time. e.g. How far did the spot typically
   move in 3 seconds? 5 seconds? ...
-  Store what class of diffusion a trajectory appears to have.

**Questions posed:**

-  Given a spatial region, what are the volumetric statistics? The
   statistics for each channel?
-  Given a plane, what spots are in it? What trajectories pass through
   it?
-  Given a stack, what spots are in it? What trajectories pass through
   it?
-  Given a spot, return the pixels that fall within the spot.
-  Given a trajectory, what is the centroid of each spot that make up
   the trajectory?
-  Given a large spatial region, what spots fall within it? How many
   trajectories cross the boundary? How many don't? These questions can
   be answered by analysis modules, and the results stored in the DB.
   Answering these questions with a DB query instead of a module could
   get extremely tricky, especially when the large spatial region is an
   odd shape.

Microtubule Tracking
^^^^^^^^^^^^^^^^^^^^

    This is a common analysis at UCSB. I believe they have other styles
    of micro-tubule tracking that have more explicit representation of
    tips, growth, and shortening events.

**Biology:**

Determine global microtubule growth and shortening rates over a time
sequence eliminating noise if possible. This is done by staking the time
stack of image and skipping frames to determine disjoint slice of frames
i.e. 1, 5, ... 31, identifying cross points and measuring the pixel
differences between groups of frames. In this we we determine a global
value of lengthening and shortening without the need to track individual
microtubules. We construct a time-disjoint region from the whole time
sequence.

**Data requirements:**

-  Specify an spacial region and a subset of timepoints for input to the
   analysis.
-  Record global values of lengthening and shortening for the spacial
   region and all specified timepoints.

**Questions posed:**

-  What is the pixel data for a spatial ROI given a set of
   non-continuous timepoints? (Request gathered from DB, then forwarded
   to OMEIS)
-  What are the global measures for a given ROI & timepoints?
-  What are those measures for a whole dataset?
-  How do those growth & shortening measures compare with measures based
   on a different timestep? (Remember, timestep is a user-specified
   parameter into the analysis)

Cross correlation
^^^^^^^^^^^^^^^^^

    This analysis calculates the extent of colocalization between two
    channels. We would like for it to run either on a whole image or on
    regions within an image. This algorithm operates on a single
    timepoint.

**Biology:**

Do two molecules appear together? What conditions lead to
colocalization? What is the extent of colocalization?

**Data requirements:**

-  Represent a spatial region at a given timepoint, and two channel
   indexes
-  Attach correlation statistics to the spacial region. Somehow record
   what channels the statistics were calculated on. The correlated
   channels can be stored as MEX inputs, or as the data structure the
   results are attached to. I think the ideal case is to have it as
   both, that is, the data structure describes a XYZ ROI at a single
   timepoint and two channels, and is an input to the cross correlation
   model. The output of the model is attached to this data structure.

**Questions Posed:**

-  Given a spatial region and timepoint, what is the correlation
   coefficient of channels A & B? Channels A & C?

Classification of Image regions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    The IICBU group in Baltimore needs to classify sub-regions within an
    image. This involves attaching a large number of statistics to
    arbitrary image regions. Currently, we are using 2D regions with a
    single fixed Z, timepoint, and Channel. We are actively developing
    multi-channel algorithms that will operate on 2D regions with single
    fixed Z and timepoint, and a list of Channels. In the future, we
    would like to integrate temporal texture features developed by the
    Murphy lab. At the lowest level, this would require attaching
    numeric data to an enumeration of timepoints. At a higher level,
    these statistics would be attached to a continuous range of
    timepoints. We would also like to use 3d segmentation, and operate
    on 3d regions across a range of time, and a subset of channels. So,
    the limit case is to attach information to a 3d region specified
    with a binary mask, either a range or subset of timepoints, and an
    arbitrary subset of channels.

**Biology:**

-  Do different genotypes result in differing morphologies?
-  Identify which subcellular compartments a target protein is localised
   in.
-  Identify which stage of the cell cycle a cell is currently in.
-  Characterize the stages of sarcopenia progression during normal
   ageing of a C. elegans animal.
-  .....

**Data requirements:**

-  Describe 3d spatial regions. In the future, these need the ability to
   extend across a time range.
-  Store channel-invariant statistics for a region.
-  Also, per-channel statistics.
-  Also, cross-channel statistics such as correlation.
-  In the future, store temporal statistics that compare the pixels in a
   static spacial region at two timepoints.
-  Classify these regions with the CategoryGroup framework
-  Store new pixels sets resulting from applying image filters and
   transforms to a given region. Somehow, link these new pixel sets to
   the existing region.
-  Store classification power of a given component of a "Signature
   Vector". This is basically attaching information to an endpoint in an
   analysis pathway. This part of the requirements doesn't have to be
   addressed by the ROI data model.

**Questions Posed, queries presented:**

-  What is the classification for each region?
-  What is the classification of every region in the image?
-  What is the overall classification of every image in the dataset?
-  Given a region, obtain the fourier transform of that region.
-  Collate all statistics for a given region into a "Signature Vector".
   The ordering of components in a "Signature Vector" needs to be
   synchronised across regions.

    The following question is irrelevant to the ROI discussion, but is
    part of the use case.

-  What channels were used in obtaining a classification?
-  How exactly was a given statistic calculated?

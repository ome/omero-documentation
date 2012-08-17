DRAFT proposal : Roi5D concepts
-------------------------------

**v 1.2 September 2006-05-12**

**Jean-Marie, Chris, Josh, Jason, Tony, Sheldon, Donald, Brian, Stefan**

At the April 2006 Madison meeting there was a decision to test several
different data models to see how well they work with our various use
cases. The `Roi5D
Proposals </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D>`_ page
encapsulates those data models, use cases, and performance results, and
this is one of those models.

Logical data model
~~~~~~~~~~~~~~~~~~

    The fundamental OME object is an image: a 5D-object that consists of
    pixels across the spatial dimensions, multiple channels and time. An
    image can be linked to several pixel sets.

This data model describes the concept of ROI5D. An ROI is a 5D-object
linked to a pixel set (not an image). We basically need to be able to
analyse/attach metadata to any sub-division of a given pixel set e.g.
the whole pixel set or in the extreme case to a single pixel of an
XY-plane. The 5D-ROI can be seen as a container of not necessarily
contiguous selections.

Logically, this entails defining an ROI5D which contains many links
(indexed by channel value) to ROI4D objects which in turn contain many
links (indexed by time) to ROI3D objects which again in turn link
(indexed by z-value) to ROI2D objects. The ROI2D is what is typically
referred to as a "**shape**\ ", that is, the visible selection on an
XY-Plane. This structure allows us to analyse part of the 5D-pixelSet
e.g. we can define a cylinder in a stack at a given time-point and a
given channel, and copy this volume at a different time-point and
channel. These two cylinders belong to the same 5D-ROI (See the ROI
tutorial for example and how to build an ROI5D object).

`|http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/rois.PNG| <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2005Proposal/rois.PNG>`_

-  Definition ROI5D: The top container of the ROI selection algorithm. A
   ROI5D object can be seen as a collection of ROIs across channels i.e.
   ROI4D objects.
-  Definition ROI4D: The second container of the ROI selection
   algorithm. A ROI4D can be seen as a collection of ROIs across time
   i.e. a collection of ROI3D objects.
-  Definition ROI3D: The third container of the ROI selection algorithm.
   A ROI3D can be seen as a collection of ROIs across z-sections i.e. a
   collection of ROI2D objects.
-  Definition ROI2D: The fourth container of the ROI selection
   algorithm. A ROI2D contains the areas selected on a given XY-Plane.
-  Definition ROISet: A ROISet is a container whose leaves are ROI5D
   objects. It is intended for grouping ROI5Ds together much like a
   dataset groups Images, but is immutable by design to allow for the
   attachment of analysis data. This entity will not be discussed here
   for purposes of simplification.

Points of interest
~~~~~~~~~~~~~~~~~~

    If we want to analyse a single pixel i.e. a 2D-object we still need
    to create an entire 5D-object.

The entire ROI5D hierarchy (including RoiSets) is immutable. This is
necessary because of its intended use in analysis.

We have omitted a discussion of the physical representation here. More
information after performance testing. Therefore changing an ROI5D
requires the copying of the entire structure and the possible deletion
of the old structure if possible.

Expressivity and Use Cases
~~~~~~~~~~~~~~~~~~~~~~~~~~

    For an explanation of this section, see `Roi5D
    Proposals </ome/wiki/History/OME-XML/OME-XML-Model-2005-ROI5D>`_.

We've tried to convert the biological questions into the concrete
SQL-like statements needed for ROIs. These questions are interesting,
but often they contain links to types/tables that currently don't exist
or are not part of this proposal. Hopefully, we've captured the essence
of what's needed without getting too bogged down in details.

In general, it seems that the specification of **Shapes** needs the most
work, whereas the definition of the **ROI** itself is much less
important to the use cases. Supporting BitMaks, for example, will strain
any combination of tables and links, and may should be considered
unqueriable (stored in binary form). This, however, seems to be poorly
defined by the requirements and use cases listed. Therefore, many of the
queries that relate to shapes I've left unspecified.

Similarly, several of the use cases discussed types/tables that are
outside the scope of the ROI proposal. Trajectories, classifications,
etc. can be built on top of ROIs but the implementation of those
constructs will have to be kept somewhat vague.

In all cases where a query is fully-definable, we've used what could be
refered to as "**RoiQL**\ " for listing them. See the implementation
notes at the end for more information.

Note: There are some questions inline. Sorry they're just coming now,
but the attempt to SQL-ize these operations made my lack of
understanding apparent. ~Josh.

Visbio
^^^^^^

Representation
''''''''''''''

    For this proposal, we'd suggest representations such as color, text,
    etc. to be attached to a specific Shape and not themselves be a
    Shape. Similarly, handling groupings of glyphs could be handled with
    a ShapeContainerShape. Querying this information depends entirely on
    the specification of these Shapes. Otherwise, all the listed
    representational forms are planned.

Questions
'''''''''

-  Which glyphs belong to a given image plane?

   -  select s from Shape s, Roi r where r.id = roi\_on\_plane( :c, :t,
      :z) and linked( s, r ) ;

-  Which glyphs belong to a given set of planes (typically across Z, but
   potentially across any given dimension)

   -  select s.id from Shape s, Roi r where r.id in roi\_on\_plane( :c,
      :t, ...z list... ) and linked( s, r ) ;

-  To which larger structure does this glyph belong, if any?

   -  (assuming using ID not equality)
   -  select r from Roi r, Shape s where linked (s, r);

    -- dependent on shape

-  Which glyphs contain the given substring in their text field (or
   which text glyphs contain the substring)?
-  Which glyphs are a particular color?
-  Which glyphs overlap a particular XY area?

   -  --> per image?
   -  --> possibly very difficult depending on storage of a bit mask.
      SQL is arbitrarily difficult, and multiple queries would probably
      be needed.
   -  but in general of the form: **select s from Shape s where
      my\_shape\_contains( ...something...);** The problem will be that
      the function my\_shape\_contains will have to be written for each
      Shape subtype, so your best bet is to only ask these questions for
      a single Shape type.

    -- Other

-  Which glyphs belong to a particular group/structure?

   -  --> what do you "know" about the group structure?

Discussion
''''''''''

    RoiSets might be one possible solution for Curtis'
    higher-dimensionality. This needs to be discussed.

<operation/> element
^^^^^^^^^^^^^^^^^^^^

    The questions for the <operation/> element are included in the
    VisBio questions if we make smart use of the Shape hierarchy such
    that an operation is just a labelled shape. Or on the other hand, we
    may just allow various things to attach to ROIs (otherway around)
    and then it's still queriable. As with trajectories and statistics,
    see below.

FRAP
^^^^

Questions
'''''''''

-  What is the single channel intensity of a particular ROI for a range
   of timepoints?

   -  This will be a typical query, but it's dependent on how one wants
      to link.
   -  select r.time, d.my\_intensity from MyData d, Roi r where linked(
      d,r ) and r.id = :roi and r.time in (1,2,3...);

-  What is the intensity of complete recovery? e.g. What is the maximum
   single channel intesity of a particular ROI?

   -  I'm assuming the maximum of any one plane
   -  select max(d.my\_intensity) from MyData d, Roi r where linked( d,r
      ) and r.id = :roi;

-  What timepoint does complete recovery occur at?
-  What timepoint did additional recovery become negligible? If the
   change of intensity was stored for every T(n) to T(n+1), this query
   could be searching on the delta\_Intensity table, constrained to an
   ROI, searching for delta's below a threshold, and ordering by
   timepoint.
-  What model best explains the observations?
-  What are the physical parameters for that model (e.g. diffusion
   constant) for a given image? For a range of images?
-  How much variation in the derived measurements occurs between images?

Spots
^^^^^

Representation
''''''''''''''

    As mentioned above, the spot tracking use case, though it can
    certainly use the ROI5D model, requires a number of other
    types/tables to implement the functionality. Specifically, what is
    currently the trajectory and trajectory\_entry tables in the OME2.5
    db. Where this is needed below, we try to discuss the commonalities
    without going to deep into details.

-  Store a spatial region and accompanying statistics that are invariant
   to channels.
-  Store statistics accompanying the spatial region that are tied to
   individual channels.

   -  We'll

-  Allow many trajectory predictions to be built from a set of spots.
   This allows for different versions of TrackSpots functionality.
-  Store secondary statistics about a trajectory such as mean squared
   displacement over delta time. e.g. How far did the spot typically
   move in 3 seconds? 5 seconds? ...
-  Store what class of diffusion a trajectory appears to have.

Questions
'''''''''

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

    data invariant to channels??

many trajectories from a set of spots? (more than lineage)

Microtubules
^^^^^^^^^^^^

-  What is the pixel data for a spatial ROI given a set of
   non-continuous timepoints? (Request gathered from DB, then forwarded
   to OMEIS)
-  What are the global measures for a given ROI & timepoints?
-  What are those measures for a whole dataset?
-  How do those growth & shortening measures compare with measures based
   on a different timestep? (Remember, timestep is a user-specified
   parameter into the analysis)

Cross-correlation
^^^^^^^^^^^^^^^^^

Representation:
'''''''''''''''

-  Represent a spatial region at a given timepoint, and two channel
   indexes
-  Attach correlation statistics to the spacial region. Somehow record
   what channels the statistics were calculated on....

   -  These seem like very straight-forward uses.

    Questions Posed:

-  Given a spatial region and timepoint, what is the correlation
   coefficient of channels A & B? Channels A & C?

   -  If the algorithm listed above always linked the coefficients to a
      single ROI which happens to have two channels then the query is:
   -  select coeff from Coefficients coeff, Roi r where coeff.roi = r.id
      and

Classification of Image regions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Representation
''''''''''''''

    Most of the storage requirements are certainly addressed above. Of
    interest are:

-  Also, cross-channel statistics such as correlation.

   -  This means a ROI linked to k channels? Doable. Or a table holding
      these correlations? That's external to ROI.

-  In the future, store temporal statistics that compare the pixels in a
   static spacial region at two timepoints.

   -  This would most likely be a single table with 2 roi foreign keys
      (or if N rois are wished two tables).

-  Classify these regions with the CategoryGroup framework

   -  This requires another table as well, but would be very nice
      feature. **+1**

-  Store new pixels sets resulting from applying image filters and
   transforms to a given region. Somehow, link these new pixel sets to
   the existing region.

   -  That is interesting. (**+2**) It has been assumed (by design) that
      a ROI will always point to a single PixelsSet. This should
      probably remain that way. Either the ROI could be copied, or
      another table ("created\_by") could link the two together.

Questions
'''''''''

-  What is the classification for each region?

   -  select c from ClassificationTable c, Roi r where r.id = :roi and
      c.roi = r.id;

-  What is the classification of every region in the image?

   -  select c from ClassificationTable c, Roi r where r.id in
      rois\_in\_pixset( :pixset ) and c.roi = r.id;

-  What is the overall classification of every image in the dataset?

   -  how is this determined?

-  Given a region, obtain the fourier transform of that region.

   -  Separate table. As ClassificationTable above.

-  Collate all statistics for a given region into a "Signature Vector".
   The ordering of components in a "Signature Vector" needs to be
   synchronised across regions.

   -  Explicanos, por favor.

--------------

Discussion
~~~~~~~~~~

Terminology
^^^^^^^^^^^

    In many of the use cases, the term "region" was frequently used.
    It's not always clear what was intended. Forgive any
    misrepresentations. We can adjust the examples for the localised
    definition of "region".

Binary masks
^^^^^^^^^^^^

    In general, the idea of a 3D binary masks is difficult. Would a
    collection of 2D binary masks suffice? What are the specific
    questions that need to be asked of that mask. As long as it can
    remain a blob, all is well.

Linkage
^^^^^^^

    One open question and what wasn't clear in any of the use cases is:
    is it essential to have the information about a time span, z span,
    etc. **explicit**. That form of information would be lost in this
    model. On the other hand, it also makes some forms of data mining
    queries possibly intractable, but that is neither here nor there.

Implementation Details
^^^^^^^^^^^^^^^^^^^^^^

    So that this discussion isn't completely academic, here are one
    possible implementation of the above mentioned RoiQL functions:

-  linked( s,r ) := from Roi r, Shape s, and RoiShapeMap m where r.id =
   m.roi and m.shape = s.id — traditional
-  linked( d,r ) := from Roi r, MyData d where d.roi = r.id --maybe,
   depends on what you want
-  roi\_on\_plane( c,t,z ) := from Roi r where r.time = t and r.channel
   = c and r.zed = z — nifty, eh.
-  roi\_on\_plane( [],[],[]) := from Roi r where r.time in
   (...t-list...) and r.channel in (...c-list...) and r.zed in
   (...z-list...);
-  rois\_in\_pixset( :pix ) := from Roi r where r.pixelSet = :pix;


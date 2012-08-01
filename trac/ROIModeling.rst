ROI Modeling
============

Table of Contents
^^^^^^^^^^^^^^^^^

#. `25th Jan 2010 <#a25thJan2010>`_

   #. `Current Status <#CurrentStatus>`_
   #. `N-Dimensional Data <#N-DimensionalData>`_

#. `Proposals : Storage <#Proposals:Storage>`_

   #. `Database (only) <#Databaseonly>`_
   #. `PyTable (only) <#PyTableonly>`_
   #. `Mixed Solution <#MixedSolution>`_

#. `Proposals : Measurements <#Proposals:Measurements>`_
#. `2009.01.25 notes <#a2009.01.25notes>`_
#. `2009.01.26 <#a2009.01.26>`_
#. `Extra Discussion on Storage
   2009.01.26 <#ExtraDiscussiononStorage2009.01.26>`_
#. `Use Cases <#UseCases>`_

25th Jan 2010
-------------

    There have been several different points highlighted from the
    meeting:

-  We seem to be mixing Modelling and Implementation, does the
   implementation lead the modelling in this case? As we did with ROI's
   before.
-  It is unclear what a ROI represents? Can we specify that?

Current Status
~~~~~~~~~~~~~~

-  ROI is currently a union of shapes, normally used to represent a
   geometric object, with the possibility over time.
-  ROI do not represent features/measurements, and currently not attach
   to a channel.
-  Has the use of the ROI -> Shape terms confused the modelling?

   -  The ROI5D was a way of collating shapes drawn by the user.
   -  Are we mixing up the concept of view and model, we can collapse
      the view of ROI to Shape for those ROI that only exist on a single
      plane, without changing the ROI->Shape relationship.

-  Do we want to support multiple Shape on the same plane, with the same
   ROI? (Aligning view and datamodel.)

N-Dimensional Data
~~~~~~~~~~~~~~~~~~

-  Will highlighted that the new N-Dimensional model will affect how we
   can represent ROI, and specifically link them to a particular
   dimension.

   -  Different images will have different dimensions
   -  We may want to have a particular ROI on (x,y) but independent of
      all others, Softworx for instance draws an ROI on the screen, but
      measurements change depending of Z,T.
   -  We could have a situation where we have a different ROI tables, or
      templates of tables for types of imaging.

Proposals : Storage
-------------------

    Do we still want to represent the ROI in the Database?

Database (only)
~~~~~~~~~~~~~~~

-  All ROI in one table.
-  Postgres geometry limiting, migrating to other DB (e.g. Oracle,
   PostGIS).
-  Storage of results, that are of very different types.
-  Performance of insert seems to be very poor, could be solved by
   upgrading to new Hibernate version? (unlikely, perhaps PostGIS)
-  Queryability, across all images, do we need this?

PyTable (only)
~~~~~~~~~~~~~~

-  Table per result.
-  Suits the evolution to an N-Dimensional model, would we want to have
   different table templates for imaging paradigms?
-  Scalable?
-  Queryability across images could be difficult.
-  Flexible, dimensionality, hierarchy, linking between geometry and
   measurements could be simple.
-  Performance on Binary data could be a problem.

Mixed Solution
~~~~~~~~~~~~~~

-  Current implementation has Mask in both DB and pytable.
-  Not practical to work with.

   -  One system does not link results
   -  The other merges geometry and measurements in one row.

Proposals : Measurements
------------------------

Measurements ("results") are currently linkable at the Plate, Image, and
Roi levels. Will suggested linking to Shapes without a Roi, which would
require a new link type (wouldn't save any rows in the DB) or a
many-to-zero to ``PlaneInfo``. This also changes the meaning of "ROI"
somewhat, which might should be decided first.

::

    <!-- Pseudo-pseudo XML -->
    <Image ID="i1">
      <PlaneInfo ID="pi1"/>
      <Roi ID="r1">
        <Shape ID="s1"/>
      </Roi>
    </Image>
    <Measurement>
      <Column type="Roi">
         <Row Ref="r1" Shape="s1"/>
      </Column>
    </Measurement>

    <Image ID="i1">
      <PlaneInfo ID="pi1"/>
      <Shape ID="s1" Ref="pi1"/>
    </Image>
    <Measurement>
      <Column type="Shape">
         <Row Ref="s1"/>
      </Column>
    </Measurement>

--------------

2009.01.25 notes
----------------

-  sorting it out?
-  biggest chunk of work
-  needed before link
-  storage? (db v. hdf)
-  topics: representation, relationships, what are they?

   -  at the moment, distinct from channel & features
   -  in HCS, roi==data

-  also

   -  how do we represent multple roi shapes per roi
   -  what does a roi represent cF. feature & channel

-  storage of results

   -  J-M: not being linked to channel was to be used as selection
      object
   -  now trying to use the same structure in 2 different ways

-  Donald: a geometry

   -  roi as a binding to a channel

-  usage:

   -  Josh: benefit over shape-channel links?
   -  Chris: ROI is also a grouping of geometries (concept, not used)
   -  maintain that idea? Yes.
   -  having volumes? Yes, but client issue representing multiple ROIs
   -  Chris: shapes v. rois v links

      -  back to where we attache stuff, if at roi
      -  then grouping of shapes has a particular meaning
      -  Donald: have seen people attaching differently.
      -  one row with geometry, all features, ... (for one channel)
      -  cellprofiler time series produces ROIs per time

-  shape<-->logicalchannel: seems to be screwed
-  going to similar approach for easier conversion (are we too fancy?)

   -  if everyone is storing channel on roi ...

-  Will: shape linked to plane? (2D without channel)
-  Chris: only concern is having measurement attached to multiple things
-  Jean-Marie: maybe we need another object for the measurements
-  Donald: talking about 2 things

   -  HCS each shape has a vector, mapped to chanel
   -  cF. cell-tracking, with measurements like "diffusion"
   -  will we be storing any measurements in model/db?
   -  Chris: unlikely

-  time up
-  need a specific diagram/page for ROI (get everyone involved)

   -  prepairing
   -  catch up again
   -  Andrew: it's gotten much more complex (flexible?)
   -  Jean-Marie: we won't have the universal solution
   -  Donald: current system has almost everything we need
   -  Chris: re-using ROI for 2 things (grouping & geometry)
   -  Chris: measurements
   -  10 GMT tomorrow continue

2009.01.26
----------

-  roi in softworx is 2D object
-  2D obj (template) for ROIShape
-  roi is more like a dataset

   -  never really defined what the bucket means
   -  roi with 3 roi shapes, comparing the three shapes requires new
      rois
   -  measurements on the links between two images / rois / shapes
   -  essentially, measurement on anything
   -  links can't link more than two objects
   -  make ``DatasetImageLink`` annotatable then can measure it
   -  @Adding measurement object (could optionally have template,
      parameters, etc.)

-  how are we going to do links

   -  top-level or stored on one of the objects
   -  unidirectional parent points to children
   -  linking for tiling?

      -  lots of objects which are being linked
      -  should we even be using links for tiling?
      -  similar to questions with ROIs (nailing down how it's used)

-  meaning of ROI

   -  previously they were UNION'd
   -  i.e. always a geometry
   -  flag/ns for identifying top-level
   -  ztc ==> "covers all planes"
   -  ROI on multiple image? no.
   -  organizing ROI templates?

      -  naming
      -  tagging
      -  description

-  Chris: another proposal (i.e. stupid question)

   -  solve whole roi/shape link problem by putting shape in multiple?
   -  roi with zt and along that cell-cycle

    **Decisions** cf.
    ` data-model:ticket#108 <http://www.ome-xml.org/ticket/108>`_

-  roi top-level object
-  roi.ns, roi.name, roi.description
-  shape annotated
-  ztc on shape (nullable)
-  shape.name, shape.description?
-  links TBD

Extra Discussion on Storage 2009.01.26
--------------------------------------

-  Problem with having ROIs in the db and ROI annotations, measurements
   etc in HDF, is that it's difficult to query the annotations from the
   ROI. ROI needs to link to Image, which has a linked HDF table etc. or
   ROI has another type of link to the HDF?
-  Don't need ROI geometry from Postgres (either in db or hdf)

    **Decisions**

-  Store the ROIs, shapes and their measurements in the same HDF file
-  ROIs and Shapes have name and description (as above) in the same
   table within the file
-  Use different tables for the ROIs and their measurements /
   annotations ?
-  Assume granularity to be one HDF file per Image, with aggregated
   values in a HDF file attached to Dataset or Plate
-  Idea of a 'template' to specify custom additions to an ROI HDF file
   (extra measurements, tables, attributes etc) - could by Python or
   XML?

Use Cases
---------

-  ROI on Big Images
-  HCS

   -  Write once/read many
   -  Large number of ROI/measurements, want to select subset of
      row/columns
   -  Will not interact (delete, merge) to the extent of manual ROI
   -  Will more often than not work on measurements than raw data.
   -  Can have large number of annotations per ROI

-  Manual ROI

   -  Write many/read many
   -  Small number of ROI on large images(z,t).
   -  will access need to raw Data
   -  User will want to delete, propagate, merge
   -  Will have a number of ROI annotations

      -  many could be relationships

For more info, see
`WorkPlan/RoiStorage </ome/wiki/WorkPlan/RoiStorage>`_

Deprecated Page

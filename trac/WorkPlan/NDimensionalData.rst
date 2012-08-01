Deprecated Page

N-Dimensional Data
==================

OMERO only supports 5D data formats, that is (x,y,z,t, wavelength), with
this limited dimensionality it cannot support the use cases required of
it from more recent microscopy methods, FLIM, AFM. Another disadvantage
of this structure is that OMERO does not allow for sparse data
collection. In an answer to this, we are investigating new ways of
defining this data. Below are some of the use cases the changes to the
storage mechanisms are defined below.

Use Cases
---------

Sparse Data Collection
~~~~~~~~~~~~~~~~~~~~~~

-  User only collected some channels during aquisition (for example
   Brightfield)
-  Subsampling of certain dimensions (e.g. 1ms. bursts of
   high-resolution over a given period)

Flim
~~~~

-  Each pixel is an n-bin histogram

Other modalities
~~~~~~~~~~~~~~~~

-  AFM: multiple parameters over scan lines. Needs flexible modelling of
   the parameters since they are created so frequently
-  FCM: multiple parameters per cell
-  HCS: representing entire plate in a single structure

Other issues
~~~~~~~~~~~~

-  Tiling, or "chunking", of very large dimensions. Related to / same as
   stitching represntation (is there a ticket for this?)
-  Hashing (corruption detection) and/or compression of
   various/arbitrary/specific dimensions

Affect of N-Dimensional model changes on ROI
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The new N-Dimensional model will affect how we can represent ROI, and
specifically link them to a particular dimension.

-  Different images will have different dimensions
-  We may want to have a particular ROI on (x,y) but independent of all
   others, Softworx for instance draws an ROI on the screen, but
   measurements change depending of Z,T.
-  We could have a situation where we have a different ROI tables, or
   templates of tables for types of imaging.

Possible Solutions
------------------

Below are listed some of the possible solutions that can be used to work
with N-Dimensional data, these are classed into data model changes and
server.

Data Model
~~~~~~~~~~

-  Some discussion is also on the OME-XML Trac:
   ` xml:#112 <http://www.ome-xml.org/intertrac/%23112>`_.

Serverside Changes
~~~~~~~~~~~~~~~~~~

Below are some methods discussed to implement N-Dimensional Data in the
server.

-  HDF

   -  how is it encoded? can it reflect the dimensionality
   -  will have to add some metadata describing each dimension
   -  is it fast enough?

-  Define a spec for dimensions

   -  We have to address what is the minimum set: xy(zt)

-  API

   -  Can we keep current API when working with 5D data and extend the
      current services to work with N-Dimensional explicitly.

-  Alternative Storage

   -  Another mechanism which would allow the dynamic storage of the
      extra dimensions is being investigated here `Alternative
      Storage </ome/wiki/WorkPlan/AlternativeStorageMongoDB>`_.

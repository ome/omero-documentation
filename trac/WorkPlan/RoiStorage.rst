Deprecated Page

Table of Contents
^^^^^^^^^^^^^^^^^

#. `Description <#Description>`_
#. `Usage <#Usage>`_
#. `Requirements <#Requirements>`_

   #. `Use cases <#Usecases>`_
   #. `Non-functional <#Non-functional>`_

#. `Investigation of Alternative Storage
   Mechanisms <#InvestigationofAlternativeStorageMechanisms>`_
#. `Breakdown <#Breakdown>`_

Roi Storage
===========

Description
-----------

Currently (4.1), ROIs are stored both in the DB via Hibernate and in HDF
via `OmeroTables </ome/wiki/OmeroTables>`_. It's unclear whether the
separation provides the queryability and the scalability needed for user
interactions. Which storage mechanism is chosen for the ROIS should:

-  provide quick access to 10s or 100s of thousands of ROIs on an image
   or plate basis
-  provide clear links to measurements results
-  *not* require overburdening of the ``StructuredAnnotation`` tables

Usage
-----

::

    bin/omero config set omero.roi.storage db
    bin/omero config set omero.roi.storage freeze

    iRoi = session.getRoiService()
    iRoi.findByImage( 1L )
    iRoi.saveRoi( myRoi )

Requirements
------------

Use cases
~~~~~~~~~

Some use cases which the new ROI Storage stucture hopes to solve:

-  User draws ROI in measurement tool and saves results to server.
   (**Manual**)

   -  ROI can be tagged

      -  *Do we also support tagsets?*
      -  *What's the interaction between Image tags and ROI tags? Do we
         use the same or different lists?*

   -  ROI can have measurements associated with it

      -  Geometry
      -  Intensity (mean, std dev, histogram, etc)
      -  Path of motion over T.
      -  *How are the measurements chosen? Automatically, manually?*
      -  *Do we need to provide a list of possible measurements to the
         user?*

   -  *Will the user want to differentiate between manual/hcs/external?*

      -  The user maybe, the dev yes. The interaction w/ ROI will be
         different.
      -  E.g. EM (EMAN2) has 3 types of ROI: Manual, Manual used for
         auto-picking, Auto-picked.

   -  *Will the user want to differentiate based on tags?* Yes
   -  *What modifications are permitted to the rois/measurements in the
      manual workflow?*

      -  i.e. "ROI can be untagged", "modification can be
         modified/updated/deleted/have column added",...
      -  Interaction will differ if rois have or not associated
         measurements regardless of their origin.

-  High Content Screening (**HCS**)

   -  *See also questions under "Manual"*
   -  Store externally generated ROI
   -  ROI can be tagged
   -  ROI can have measurements associated with it

      -  Geometry
      -  Intensity based (mean, std dev, histogram)
      -  Path of motion
      -  Measurements can be tagged

         -  *What are tagged measurements used for?*
         -  Do not really see the need for that

   -  In analysing the data, measurements will be selected multiple
      times with varying dimensions chosen

      -  *Assuming dimensions is equivalent to features/columns, then is
         the requirement to relate the analysis results back to the
         columns with which it was produced?*

   -  The results of analysis can be stored in table structures, and
      could be more ROI (see `#1650 </ome/ticket/1650>`_)

-  External Analysis (**External**)

   -  Store externally generated ROI

      -  Can be tagged
      -  *What formats should be supported?*

   -  Store externally generated measurements

      -  Can be tagged
      -  *What formats should be supported?*

   -  May have multiple sets of analysis performed on images

      -  Each set will generate new measurements

   -  Will wish to store other datastructures that are not directly
      related to measurements or ROI

      -  Indexing and analysing these structures
      -  *What would the format of this look like?*

-  ROIs without images (**Templates**)

   -  top-level rois should exist which can be re-used as templates

-  General questions

   -  *Are all uses of "tagged" above identical? What intefaces/methods
      should return "tagged" objects?*
   -  *Are rois always loaded one image at a time?*
   -  *How are measurements loaded? One at a time? Merged?*
   -  *Will rois be loaded based on their relationship to a template?*
   -  *Will rois be loaded based on the type of shapes they contain?
      e.g. "Only rois with masks"*
   -  **N-dimensionality**

      -  ...

Non-functional
~~~~~~~~~~~~~~

-  Performant: as an initial benchmark,

   -  an image with 10,000 (?) rois should be loadable in ...
   -  an image with 10 full-size masks (1-bit) should be loadable in ...
   -  ...

-  Deployable: optimal would be either no new installation requirement
   or the exchange of an existing requirement for a new one. New
   requirements, as a general rule, should be avoided where possible.
-  Upgradable: as has been seen in the past, the ROI structure is still
   not perfected, and therefore, will most likely change to some degree
   in upcoming releases. The data storage for ROIs should be:

   #. controlled so that unknown user data does not get lost
   #. as simple as possible

-  Transactional: where possible, the storage mechanism should be
   transactional especially when dealing with the data stored via
   Hibernate.
-  Foreign keys: where possible, the storage mechanism should minimize
   the need for soft-links (non-enforced foreign keys).
-  Extensible: if possible, allowing third parties to extend the storage
   format(\ *this would most likely require a generalized plugin
   interface*)

Investigation of Alternative Storage Mechanisms
-----------------------------------------------

    We have looked at different mechanisms for storing and querying ROI,
    these can be grouped into several categories:

-  Document Based Databases

   -  MongoDB ` MongoDB <http://www.mongodb.org/display/DOCS/Home>`_
   -  CouchDB
      ` http://couchdb.apache.org/ <http://couchdb.apache.org/>`_

-  Graph Databases

   -  Neo4J ` http://neo4j.org/ <http://neo4j.org/>`_
   -  InfoGrid ` http://infogrid.org/ <http://infogrid.org/>`_

-  BigTable implementations

   -  Cassandra
      ` http://incubator.apache.org/cassandra/ <http://incubator.apache.org/cassandra/>`_
   -  HyperTables
      ` http://www.hypertable.org/ <http://www.hypertable.org/>`_
   -  HBase
      ` http://hadoop.apache.org/hbase/ <http://hadoop.apache.org/hbase/>`_

-  Key value DB

   -  Berkeley Database
      ` http://www.oracle.com/technology/products/berkeley-db/index.html <http://www.oracle.com/technology/products/berkeley-db/index.html>`_
   -  Tokyo Cabinet
      ` http://1978th.net/tokyocabinet/ <http://1978th.net/tokyocabinet/>`_
   -  Project Voldermort
      ` http://project-voldemort.com/ <http://project-voldemort.com/>`_

-  Other

   -  Pytables
      ` http://www.pytables.org/moin/PyTables <http://www.pytables.org/moin/PyTables>`_

    The current investigation is still inprogress, it has mainly focused
    on MongoDB, Cassandra and more recently Neo4J.

    For further details of the investigation see
    `AlternativeStorage </ome/wiki/AlternativeStorage>`_.

Breakdown
---------

-  `ticket:1768 </ome/ticket/1768>`_ - Add all necessary ROI methods to
   IRoi (removing some)

   -  Iteration II (Ending Feb 18): 1 day (Josh)

-  Refactor Insight to only use IRoi
-  Finalize list of API/non-functional requirements
-  Final list of initial IRoi implementation choices
-  Define slice definition which will be used in IRoi
-  Implement IRoi-X
-  Implement IRoi-Y
-  Implement IRoi-Z
-  Write scalability tests, including large masks, many shapes, roi
   links (?)
-  Review different storage architectures

   -  MongoDB/CouchDB (Est. 4 days/Act. 4days)
   -  PyTables
   -  Hypertables/Cassandra?/HBase (Est. 3 days/ Act. 3days)

-  Further Investigation of MongoDB and ROI
   `AlternativeStorageMongoDB </ome/wiki/WorkPlan/AlternativeStorageMongoDB>`_

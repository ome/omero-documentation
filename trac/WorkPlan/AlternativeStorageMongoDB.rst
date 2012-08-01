Deprecated Page

Alternative Storage MongoDB
===========================

This page is the plan of work and tasks required to further test MongoDB
as an alternative storage mechanism for ROI.

For a reason behind our decision to choose mongo see
`AlternativeStorage </ome/wiki/AlternativeStorage>`_.

As of the presentation on Tuesday 16th February, it was decided to
create a test bed for MongoDB to see how it would perform in storing ROI
from HCS, and too see what structures could be put in place to alieviate
the difficulties described in the presentation.

Timeline
--------

-  Investigated import of CSV file from Incell data to create ROI and
   measurement in MongoDB (Est. 1 day/Act. 2 days)

   -  Time to import 110K measurements and ROI: 17 seconds. Code :
      insertData.py
   -  Searching and querying time seems fast, even on non-indexed
      fields, can be slow when searching non-indexed data for
      non-existing fields.

Usage
-----

Create a test system that can be populated with roi from an HCS dataset
and see what storage mechanisms are required to make it work for
MongoDB.

Breakdown
---------

MongoDB
~~~~~~~

-  `#1810 </ome/ticket/1810>`_ Investigate different structures which
   could be used to store different types of information (4 days)

   -  ROI
   -  Measurement
   -  Annotation
   -  Links

-  Create a test dataset from the XLS incell file and upload to MongoDB
   (1 day)

   -  Insert speed
   -  Query speed
   -  Index requirements

Omero
~~~~~

-  `#1809 </ome/ticket/1809>`_ Create a test framework, modifying
   Populateroi to upload plate data to MongoDB. (3 days)

   -  Upload a number of plates to the service
   -  We have already a MongoDB version of OMEROPojos, and a method for
      storing table data in MongoDB

-  Create a new version of the Tables API service that talks to MongoDB
   (3 days)
-  Add annotations to ROI, compare performance for different tag
   objects. (1 day)
-  Test performance of the System, measurements, tags, roi, shape
   retrieval. (1 day)

Omero.insight
~~~~~~~~~~~~~

-  insight:#1173 Have the measurement tool working against MongoDB (4
   days)

   -  Save ROI to the Database and MongoDB in tandem.

Attachments
~~~~~~~~~~~

-  `AlternativeStorage.pptx </ome/attachment/wiki/WorkPlan/AlternativeStorageMongoDB/AlternativeStorage.pptx>`_
   `|Download| </ome/raw-attachment/wiki/WorkPlan/AlternativeStorageMongoDB/AlternativeStorage.pptx>`_
   (140.1 KB) - added by *dzmacdonald* `2
   years </ome/timeline?from=2010-02-16T16%3A37%3A26Z&precision=second>`_
   ago.
-  `OmeroPopo.py </ome/attachment/wiki/WorkPlan/AlternativeStorageMongoDB/OmeroPopo.py>`_
   `|image2| </ome/raw-attachment/wiki/WorkPlan/AlternativeStorageMongoDB/OmeroPopo.py>`_
   (12.5 KB) - added by *dzmacdonald* `2
   years </ome/timeline?from=2010-02-16T16%3A57%3A56Z&precision=second>`_
   ago.
-  `TagTable.py </ome/attachment/wiki/WorkPlan/AlternativeStorageMongoDB/TagTable.py>`_
   `|image3| </ome/raw-attachment/wiki/WorkPlan/AlternativeStorageMongoDB/TagTable.py>`_
   (2.5 KB) - added by *dzmacdonald* `2
   years </ome/timeline?from=2010-02-16T16%3A58%3A03Z&precision=second>`_
   ago.
-  `uploadMask.py </ome/attachment/wiki/WorkPlan/AlternativeStorageMongoDB/uploadMask.py>`_
   `|image4| </ome/raw-attachment/wiki/WorkPlan/AlternativeStorageMongoDB/uploadMask.py>`_
   (6.3 KB) - added by *dzmacdonald* `2
   years </ome/timeline?from=2010-02-16T16%3A58%3A11Z&precision=second>`_
   ago.
-  `insertdata.py </ome/attachment/wiki/WorkPlan/AlternativeStorageMongoDB/insertdata.py>`_
   `|image5| </ome/raw-attachment/wiki/WorkPlan/AlternativeStorageMongoDB/insertdata.py>`_
   (1.3 KB) - added by *dzmacdonald* `2
   years </ome/timeline?from=2010-02-19T13%3A26%3A48Z&precision=second>`_
   ago.
-  `x1.csv </ome/attachment/wiki/WorkPlan/AlternativeStorageMongoDB/x1.csv>`_
   `|image6| </ome/raw-attachment/wiki/WorkPlan/AlternativeStorageMongoDB/x1.csv>`_
   (23.8 MB) - added by *dzmacdonald* `2
   years </ome/timeline?from=2010-02-19T13%3A46%3A55Z&precision=second>`_
   ago.

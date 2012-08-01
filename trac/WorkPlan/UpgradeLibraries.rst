Deprecated Page

Upgrade Libraries
=================

Description
-----------

A Hibernate upgrade (`#1260 </ome/ticket/1260>`_) should be examined
particularly as it applies to:

-  Saving very large object graphs
-  Querying very large object graphs (10's of thousands of objects)
-  Memory usage should be compared between the old version and new
   version
-  Model object review should happen
-  OMERO.importer saveToDb() performance should be compared

Breakdown
---------

#. `#1260 </ome/ticket/1260>`_ Upgrade libraries

   #. Hibernate 3.4 (3 days)

      -  Iteration II: 0.5 days

   #. Spring 3.0 (2 days)

      -  Iteration II: 0.5 days

   #. IPython (0.5 days)
   #. TestNG 5.6 (0.5 days)
   #. Ice 3.4 (5 days)

      -  Previously: 1.5 days

   #. Performance comparison (1 day)

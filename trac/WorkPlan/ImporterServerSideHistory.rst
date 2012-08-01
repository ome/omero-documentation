Deprecated Page

Table of Contents
^^^^^^^^^^^^^^^^^

#. `Description <#Description>`_
#. `Usage <#Usage>`_
#. `Breakdown <#Breakdown>`_

Importer: Server Side History
=============================

Description
-----------

The major importer addition for the 4.2 will be server-side history and
the replacement of the client-side history system currently in use.

Usage
-----

From a user's perspective the new server-side feature should function
similar to the existing history tab, however this feature is a step
towards storing all user preferences (in both clients) to the server,
allowing users to more easily move around to various machines and keep
their common environment.

Breakdown
---------

The main ticket for this task is `#1742 </ome/ticket/1742>`_.

#. `#1744 </ome/ticket/1744>`_ Implement history table server side (2
   Days, Actual so far 4 days)

   #. `#1475 </ome/ticket/1475>`_ Add testNG for server-side history. (1
      Day)

#. `#1746 </ome/ticket/1746>`_ Adjust existing importer UI to use new
   history system (2 Days, Actual so far 2 day)
#. Task `#1907 </ome/ticket/1907>`_ Abstract historyDB interface (est. 1
   Day)
#. Bug Fixes: `#1976 </ome/ticket/1976>`_, `#1973 </ome/ticket/1973>`_,
   `#1951 </ome/ticket/1951>`_ (est. .5 Days)

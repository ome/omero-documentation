Deprecated Page

Add support for simple FS-based directory listing to Insight
============================================================

The content of this page is now Requirement:
` http://trac.openmicroscopy.org.uk/omero/ticket/1933 <http://trac.openmicroscopy.org.uk/omero/ticket/1933>`_

The content below has been left in place temporarily until a shoola
requirement is created.

Description
-----------

Using file repository services and OMERO.fs to avoid data duplication.
As an initial step for FS/bioformats-based IO, the Repository API should
be made usable by clients.

Related to `Manage Distributed
Repositories </ome/wiki/WorkPlan/ManageDistributedRepositories>`_

Usage
-----

::

    import omero
    c = omero.client("localhost")
    s = c.createSession("root","ome")
    sr = s.sharedResources()
    rm = sr.repositories()
    print [x.name.val for x in rm.descriptions]

Timeline
--------

-  Iteration II (end 18/02/2010)

   -  Browse directory using only ``OriginalFile``
   -  Display thumbnails.
   -  Register files (single) and directories

Breakdown
---------

**OMERO.insight:**

#. [STRIKEOUT:insight:#1122] Build ``FileSystemView`` **DONE**
#. insight:#1131 Browse directories and display thumbnails. (Est. 3
   days/ Act 2.5 days)

   #. Browse directories **DONE**.
   #. Identify registered directories. **DONE** insight:r7044
   #. [STRIKEOUT:insight:#1158] Thumbnailing.
      insight:r7053-!insight:r7054 **DONE**
   #. Clean up i.e icons for directories, better image for non-supported
      files, etc. **DONE**

#. [STRIKEOUT:insight:#1136] Register file/directory (Est. 0.5 days/
   Act. 0.5 days) **DONE** insight:r7044
#. [STRIKEOUT:insight:#1153] Annotate registered file/directory **DONE**
   insight:r7045
#. [STRIKEOUT:insight:#1186] Handle images files, related to
   `#1799 </ome/ticket/1799>`_, review insight:#1131 (Est. 1 day/Act. 1
   day) **DONE** insight:r7081
#. [STRIKEOUT:insight:#1187] Review browsing directories and display
   thumbnails. (Est. 0.5 days/Act. 0.5 days) insight:r7090,
   insight:r7091 **DONE**
#. [STRIKEOUT:insight:#1188] Browse other users directory. (Est. 0.5
   days/Act. 0.5 days) **DONE** insight:r7084
#. insight:#1137 Import images using FS, client implementation. (Est. 3
   days)
#. insight:#1139 Indicate if the repository is offline. (Est. 0.5 days)

**Server-side changes:**

#. `#1752 </ome/ticket/1752>`_ Pass back all files as ``OriginalFile``
   objects. (Est. 2 days/ Act. 4 days) **DONE** r6030, r6032 and r6035
#. `#1753 </ome/ticket/1753>`_ Make ``OriginalFile.name`` be UNIQUE.
   (Est. 0.5 days)
#. ``FileServer`` providing bulk methods. **DONE** r5984
#. `#1754 </ome/ticket/1754>`_ Make thumbnails available for a
   directory's files. (Est. 4 days/ Act. 6 days) **DONE** r6077
#. `#1799 </ome/ticket/1799>`_ Pass back relevant files as Image
   objects. (Est. 5 days) r6135
#. `#1755 </ome/ticket/1755>`_ Interact with bio-formats or importer for
   rendering settings. (Est. 3 days ?)
#. `#1756 </ome/ticket/1756>`_ Create a set of relevant exceptions. (2
   days)

Commit Overview
---------------

-  r5965 and r5966 have an initial implementation.

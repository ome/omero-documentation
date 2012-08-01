Deprecated Page

Towards Publication
===================

Description
-----------

See the User story
` https://trac.openmicroscopy.org.uk/omero/ticket/1899 <https://trac.openmicroscopy.org.uk/omero/ticket/1899>`_

Need to make the Figure scripts robust enough for Preview release. Don't
intend to add any functionality to what we had at ASCB'09. Scripts to
include in 4.2 Preview Release (based on Figure types listed at
insight:#1068)

Usage
-----

Scripts need to be uploaded before they can be called by the clients.
Full testing should will involve Insight calling the scripts from the
Insight UI, but they can also be tested using Python (see below). Use
the ``uploadScript.py`` attached below.

::

    $ python uploadscript.py --host host --username username --password password --script scriptName.py

This should return a script ID on the command line, which can be used to
test the script...

Now use the other attached scripts to test the scripts. First, edit the
script parameters in the file, to choose suitable Image-IDs etc,
channels, names for images on the server. Then call the script

::

    $ python runroiScript --host host --username username --password password --script scriptID

Timeline
--------

**End of Iteration III (04/03/2010)**
 First phase of changes done, plan a meeting w/ users to get feedbacks
about the !ROIFigure script.

Breakdown
---------

#. [STRIKEOUT:insight:#1138] Demo scripts to users in the lab - fix any
   critical issues (Est. 2 days)

   -  First presentation **DONE** except for ROI script
   -  Bug fixed in scripts See
      r5987-`r5989 </ome/changeset/5989/ome.git>`_, r5996-r6000 (Act 2.5
      days so far)

#. [STRIKEOUT:insight:#1125] Need to add check all docs in scripts (Est.
   1 day / Act 1 day) **DONE**
#. [STRIKEOUT:insight:#1138] Improve UI to collect data. (Est. 3 days
   depending on feedbacks)

   -  insight:r7046-!insight:r7051 and insight:r7055 (Act. 1 day)
   -  fixing problems related to changes. insight:r7068-!insight:r7069
      (Act. 0.5 days)

Attachments
~~~~~~~~~~~

-  `uploadscript.py </ome/attachment/wiki/WorkPlan/FigureExport/uploadscript.py>`_
   `|Download| </ome/raw-attachment/wiki/WorkPlan/FigureExport/uploadscript.py>`_
   (1.2 KB) - added by *wmoore* `3
   years </ome/timeline?from=2010-01-22T08%3A49%3A44Z&precision=second>`_
   ago. Script for uploading scripts to the server
-  `runRoiscript.py </ome/attachment/wiki/WorkPlan/FigureExport/runRoiscript.py>`_
   `|image2| </ome/raw-attachment/wiki/WorkPlan/FigureExport/runRoiscript.py>`_
   (2.6 KB) - added by *wmoore* `3
   years </ome/timeline?from=2010-01-22T08%3A50%3A10Z&precision=second>`_
   ago. Script for testing the ROI figure script
-  `runThumbnailScript.py </ome/attachment/wiki/WorkPlan/FigureExport/runThumbnailScript.py>`_
   `|image3| </ome/raw-attachment/wiki/WorkPlan/FigureExport/runThumbnailScript.py>`_
   (1.9 KB) - added by *wmoore* `3
   years </ome/timeline?from=2010-01-22T08%3A50%3A25Z&precision=second>`_
   ago. Script for testing the thumbnail figure script

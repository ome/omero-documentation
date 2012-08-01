ROI
===

Description
-----------

This is a complete reworking of the ROI model as the solution we moved
to with the the September 2009 version for the schema has caused a
serious problem with the code generation. The current solution has lots
of objects having multiple paths.

Usage
-----

The new solution will store the ROI data in the OME-XML in such a way
that ``xsd-fu`` can automatically generate a sensible API.

Example:

::

    To be decided

--------------

Breakdown
---------

#. `#108 </ome/ticket/108>`_ Revamping ROI schema

   #. Decide on new structure (1 day x5)[1 day x5 so far]
   #. Update the model (2 days)[.5 day so far]
   #. Write new transforms (4 days)

#. `#67 </ome/ticket/67>`_ New ROI Documentation page (2 days)

-  `#91 </ome/ticket/91>`_ ROI Tagging
-  `#92 </ome/ticket/92>`_ ROI Naming

Deprecated Page

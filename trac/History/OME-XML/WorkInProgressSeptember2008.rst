Model for the September 2008 release
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This page is written from the point of the September 2008 schema. See
September 2008 `Schema
XSD <http://www.openmicroscopy.org/Schemas/OME/2008-09/>`_ and `Schema
Documentation <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Generated/OME-2008-09/ome.xsd.html>`_.
Download `Example
Files <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/specification/Samples/OmeFiles/2008-09>`_.
This is a *legacy* schema but this page is also valid for newer schemas.

Work In Progress
================

Model at time of discussion: September 2008 release
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This page lists a series of points discussed during meetings and not yet
implemented or in place.

Discussion 18/06/09-26/06/09
----------------------------

Entities to review or define
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  ``StructuredAnnotations``: SA.xsd reworked in line with Josh's
   sugestion
-  ``ShapeDisplayOptions``: J-M to provide entity's description to
   Andrew. (OMERO.xsd) - done
-  ``MetadataOnly`` (see ``Pixels``): Define entity. (ome.xsd) - done
-  ``NamingConvention``: Review enumeration value. Place holder for now
   . (SPW.xsd)
-  ``compression``: Review enumeration. (``BinaryFile.xsd``)
-  Model the notion of ``OriginalFile``.
-  ``Detector``: rethink the approach. Something similar to
   ``LightSource`` is probably needed.
-  ``ShapeDisplayOptions``: possible move to ROI.xsd and link to shape,
   cardinality 0..1.
-  Type in Well, needs to find a better name.

General
~~~~~~~

-  Review the documentation of the schema files. Preference given to a
   per element documentation rather than a long description at the
   beginning of an entity.
-  Add range expected for some element/attribute in the documentation.
   Constraints will be added to the element/attribute later.
-  Contact users-list before deleting the following entities:
   ``Region``, ``Thumbnail``, ``DisplayOptions``, ``RedChannel``,
   ``GreenChannel``, ``BlueChannel``, ``Projection``.
-  Define a protocol to submit changes to the model e.g. model review
   every xxx months, submit proposal yyy month(s) before, modeling group
   contacting/visiting lab etc.
-  Conversion using stylesheets.
-  Update to CA schema? Review Experiment Element
-  Move all \*Ref attributes to be elements for consistency.
-  Define Key and KeyRef constraints for all ID, Ref and Settings
   objects.

StructuredAnnotation Changes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  New structure in the form of Ann1.xml sample file.
-  Provide list of elements that can be annotated.
-  In documentation, specify which annotation to use to do something
   more fancy.

Deprecated Page

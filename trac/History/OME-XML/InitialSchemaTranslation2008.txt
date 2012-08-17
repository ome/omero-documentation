Model for the legacy 2003 FC release
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This page is written from the point of the 2003 FC schema. See 2003 FC
`Schema XSD <http://www.openmicroscopy.org/XMLschemas/>`_ and `Schema
Documentation <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Generated/OME-2003/ome.xsd.html>`_.
Download `Example Files <http://www.ome-xml.org/wiki/OmeTiffData>`_.
This is a *legacy* schema but this page is also valid for newer schemas.

Model for the September 2008 release
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This page is written from the point of the September 2008 schema. See
September 2008 `Schema
XSD <http://www.openmicroscopy.org/Schemas/OME/2008-09/>`_ and `Schema
Documentation <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Generated/OME-2008-09/ome.xsd.html>`_.
Download `Example
Files <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/specification/Samples/OmeFiles/2008-09>`_.
This is a *legacy* schema but this page is also valid for newer schemas.

Model for the September 2009 release
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This page is written from the point of the September 2009 schema. See
September 2009 `Schema
XSD <http://www.openmicroscopy.org/Schemas/OME/2009-09/>`_ and `Schema
Documentation <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Generated/OME-2009-09/ome.html>`_.
Download `Example
Files <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/specification/Samples/OmeFiles/2009-09>`_.
This is a *legacy* schema but this page is also valid for newer schemas.

    This page was used by the developers to keep track of the progress
    in our initial implementation of a XSLT file to transform between
    versions of our schema.

Transformation 2008-09 - Working Copy
=====================================

Limitations
-----------

Limitations for the following elements:

-  ``ChannelComponent``

The attribute ``ColorDomain`` is renamed to ``Color`` and its value no
longer a string but an int. This implies that only recognisable string
will be supported.
 Follow the list of strings: ``r, red, b, blue, g, green`` and also the
upper case version.

-  ``Image``

   -  The new schema only supports only **ONE** pixels set per image. If
      an image has multiple pixels set, the image will be linked to the
      pixels set whose *ID* equals the value of the *AcquiredPixels*
      attribute.
   -  Region is not converted. See question below.

-  ``LogicalChannel`` and ``ChannelComponent`` merge.

``LogicalChannel`` and ``ChannelComponent`` nodes are merged into a
``Channel`` node. A ``ChannelComponent`` node does not have an ID. If a
``LogicalChannel`` node has n ``ChannelComponent`` nodes, n ``Channel``
nodes should be created. The problem is that they will have the same ID.
 Do we only convert file if one ``ChannelComponent`` per
``LogicalChannel``?

-  ``Experimenter``

A ``DisplayName`` has been added and is required. To generate it, the
following rule is applied: If an ``OMEName`` exists, its value is
selected. If no ``OMEName``, the value of the ``Email`` element is
selected. If no ``Email``, the value of the ``FirstName`` element and
``LastName`` (if present) are combined and selected.

-  ``Shape``

There is a bug in ``ShapeID``. It has a regex of ROI not Shape in the
full LSID form.
 i.e.

::

      <xsd:simpleType name="ShapeID">
            <xsd:restriction base="LSID">
                <xsd:pattern value="(urn:lsid:([\w\-\.]+\.[\w\-\.]+)+:ROI:\S+)|(Shape:\S+)"/>
            </xsd:restriction>
        </xsd:simpleType>

Is a ``Shape`` has a Internal ID it is of the correct pattern and can be
copied unchanged. Currently if a ``Shape`` has an LSID matching the
pattern of an ``ROI`` LSID and not a ``Shape`` LSID it needs converted.
We will turn the old LSID into a new internal ID that does match the
pattern.
 We will prepend the old LSID with ``Shape:`` which will form a valid
internal ID.
 e.g. Old ``id="urn:lsid:example.org:ROI:1"`` becomes
``id="Shape:urn:lsid:example.org:ROI:1"``

-  ``MaskPixels``

The element has been removed. A ``Mask`` is now linked to a ``Pixels``.
A ``MaskPixels`` element does not have the following attribute:
``SizeZ, SizeC, SizeT`` which are required attributes of ``Pixels``. The
value will be set to ``1``.
 The dimension order will be ``XYZCT`` and the ``ID`` will look like
``Pixels:Mask:ShapeID``... Scary but not other solution.

-  ``Well``

The ``Row`` and ``Column`` attributes have been changed from ``integer``
to ``nonNegativeInteger``. If a negative value was entered, ``0`` will
be set.

-  ``ListAnnotation``

If no valid links in a ListAnnotation to other annotations it is
possible to produce invalid output. This is because the new
ListAnnotation is less expressive then the old one.

Questions
---------

-  ``Image``

   -  Do we want to convert the element Region to StructuredAnnotation?
   -  CustomAttributes conversion?

-  Change of types:

The value of some attributes e.g. ``TransmittanceRange/@Transmittance``
has been modified. In the example, from ``int`` to ``percentFraction``.
Strategy implemented:

::

    If the value < 0, 0 is set[[BR]]
    If value > 1, divided so it ends up in the interval [0, 1]

-  ``Laser``

Problem with the attribute ``RepetitionRate``, it was a boolean now it
is a float..

Implemented:
 If the value is set to ``false``, then the new value is ``0``.
 If the value is set to ``true``, then the new value is ``1``.

-  ``Polygon and Polyline``

The attribute ``points`` was optional now is required. Default
value:"0,0 1,1".

-  ``Objective``

The attribute ``LensNA`` is the only attribute with a constraint on the
possible value.

-  ``AnalysisModule``

Do we keep it or remove it?

Transformation 2003-FC - 2008-09
================================

Limitations
-----------

Limitations for the following elements:

-  ``ChannelInfo`` -> ``LogicalChannel``

The attribute ``AuxLightSourceRef`` is removed as there is not
sufficient information to create a ``MicrobeamManipulation`` for it to
move to.

-  ``ROI``

This is not mapped at present.

-  ``Pixels``

In 2003-FC the schema allows a mix of ``BinData`` and ``TiffData``. This
is a mistake it should be one or the other. In the conversion I will
look at the first child and only copy other children of the same type.

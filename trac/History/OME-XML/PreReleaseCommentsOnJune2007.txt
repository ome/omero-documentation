Model for the June 2007 release
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This page is written from the point of the June 2007 schema. See June
2007 `Schema XSD <http://www.openmicroscopy.org/Schemas/OME/2007-06/>`_
and `Schema
Documentation <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Generated/OME-2007-07/ome.xsd.html>`_.
Download `Example
Files <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/specification/Samples/>`_.
This is a *legacy* schema but this page is also valid for newer schemas.

OME-XML Comments On Release
===========================

Release 1 - 5th June 2007
-------------------------

Corrections
~~~~~~~~~~~

Secondary Emission Filter & Secondary Excitation Filter
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In LogicalChannel both should be of type FilterID and Emission is spelt
incorrectly.

Old

::

    <xsd:attribute name="SecondaryEmmisionFilter" type=" EmFilterID "/>
    <xsd:attribute name="SecondaryExcitationFilter" type=" ExFilterID "/>

New

::

    <xsd:attribute name="SecondaryEmissionFilter" type=" FilterID "/>
    <xsd:attribute name="SecondaryExcitationFilter" type=" FilterID "/>

by Andrew & Curtis

Fix Spelling Mistakes
^^^^^^^^^^^^^^^^^^^^^

-  SecondaryEmmisionFilter -> SecondaryEmissionFilter
-  Zstart -> ZStart
-  Zstop -> ZStop
-  Tstart -> TStart
-  Tstop -> TStop
-  OpticalAxisAvrg -> OpticalAxisAveraged
-  Tunable -> Tuneable
-  Repetitation Rate -> RepetitionRate
-  Amplification-Gain -> AmplificationGain

by Andrew & Chris & Curtis

Correct Copyright
^^^^^^^^^^^^^^^^^

Add "University of Wisconsin at Madison" to the list of copyright
holders. by Andrew & Kevin & Jason

Correct Filter in instrument
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Old

::

    <xsd:element name="Instrument">
    ...
            <xsd:sequence>
                <xsd:element ref="Microscope"/>
                <xsd:element ref="LightSource" maxOccurs="unbounded"/>
                <xsd:element ref="Detector" maxOccurs="unbounded"/>
                <xsd:element ref="Objective" maxOccurs="unbounded"/>
                <xsd:element ref="Filter" maxOccurs="unbounded"/>
                <xsd:element ref="OTF" maxOccurs="unbounded"/>
            </xsd:sequence>
    ...
    </xsd:element>

New

::

    <xsd:element name="Instrument">
    ...
            <xsd:sequence>
                <xsd:element ref="Microscope"/>
                <xsd:element ref="LightSource" maxOccurs="unbounded"/>
                <xsd:element ref="Detector" maxOccurs="unbounded"/>
                <xsd:element ref="Objective" maxOccurs="unbounded"/>
                <xsd:element ref="FilterSet" minOccurs="0" maxOccurs="unbounded"/>
                <xsd:element ref="OTF" maxOccurs="unbounded"/>
            </xsd:sequence>
    ...
    </xsd:element>

Proposed Changes
~~~~~~~~~~~~~~~~

Change to the regex used for IDs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The current regex is a little lax and with some help from Chris I have
come up with a new format. It is longer and does require the ID name to
occur twice which is a little ugly but this seams to be unavoidable if
they are to work as either LSIDs or internal ids.

Old - for Project

::

        (urn:lsid:)?(\S+\.\S+)+(:Project)(:\S+)

New - for Project

::

        ~np~(urn:lsid:([\w-\.]+\.[\w-\.]+)+:Project:\S+)|(Project:\S+)~/np~

Valid - Old

::

    urn:lsid:ome.wibble:Project:1123
    a.b:Project:c
    uurn:lsid:a.b:Project:c
    urn:lsid:a.ww12312541___---ww.d.d.b:Project:c
    rn:lsid:a.b:Project:c
    urn:lid:a.b:Project:c
    urn:lsid:ome.wi~%#bble:Project:1123
    ~np~^.^:Project:1234~/np~
    ...:Project:1234

Invalid - Old

::

    urn:lsid:omewibble:Project:1123
    Project:1234

Valid - New

::

    urn:lsid:ome.wibble:Project:1123
    urn:lsid:a.ww12312541___---ww.d.d.b:Project:c
    Project:1234

Invalid - New

::

    a.b:Project:c
    uurn:lsid:a.b:Project:c
    rn:lsid:a.b:Project:c
    urn:lid:a.b:Project:c
    urn:lsid:ome.wi~%#bble:Project:1123
    ~np~^.^:Project:1234~/np~
    ...:Project:1234
    urn:lsid:omewibble:Project:1123

This enforces two forms, the LSID form of
urn:lsid:[domain-name]:Project:[uniqueID] and a shorter form to be used
for internal only references Project:[uniqueID]. The uniqueID can be any
non-whitespace characters. The regex parser in XSD is slightly non
standard and assumes that the pattern is always meant to start at the
beginning of the line and finish at the end of the line, this means that
``^`` and ``$`` are not necessary. The domain-name is any standard
character (including unicode) with dash and dot. It must contain at
least one dot. by Andrew

Correct capitalisation of PixelType enumeration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Old

::

        <xsd:attribute name="PixelType" use="required">
            <xsd:simpleType>
                <xsd:restriction base="PixelTypes">
                    <xsd:enumeration value = "int8"/>
                    <xsd:enumeration value = "int16"/>
                    <xsd:enumeration value = "int32"/>
                    <xsd:enumeration value = "Uint8"/>
                    <xsd:enumeration value = "Uint16"/>
                    <xsd:enumeration value = "Uint32"/>
                    <xsd:enumeration value = "float"/>
                </xsd:restriction>
            </xsd:simpleType>

New

::

        <xsd:attribute name="PixelType" use="required">
            <xsd:simpleType>
                <xsd:restriction base="PixelTypes">
                    <xsd:enumeration value = "int8"/>
                    <xsd:enumeration value = "int16"/>
                    <xsd:enumeration value = "int32"/>
                    <xsd:enumeration value = "uint8"/>
                    <xsd:enumeration value = "uint16"/>
                    <xsd:enumeration value = "uint32"/>
                    <xsd:enumeration value = "float"/>
                </xsd:restriction>
            </xsd:simpleType>

by Chris

Add TiffData block
^^^^^^^^^^^^^^^^^^

Add support for OME-XML TIFF information

Old

::

        <xsd:element name="Pixels">
    ...
            <xsd:complexType>
                <xsd:sequence>
                    <xsd:element ref="Bin:BinData" maxOccurs="unbounded"/>
                    <xsd:element ref="Plane" minOccurs="0" maxOccurs="unbounded"/>
                </xsd:sequence>
    ...
            </xsd:complexType>
        </xsd:element>

New

::

        <xsd:element name="Pixels">
    ...
            <xsd:complexType>
                <xsd:sequence>
                    <xsd:choice maxOccurs="unbounded">
                        <xsd:element ref="Bin:BinData"/>
                        <xsd:element ref="TiffData"/>
                    </xsd:choice>
                    <xsd:element ref="Plane" minOccurs="0" maxOccurs="unbounded"/>
                </xsd:sequence>
    ...
            </xsd:complexType>
        </xsd:element>
    ...
        <xsd:element name="TiffData">
            <xsd:annotation>
                <xsd:documentation>
                </xsd:documentation>
            </xsd:annotation>
            <xsd:complexType>
                <xsd:attribute name="IFD" type="xsd:integer" default="0">
                    <xsd:annotation>
                        <xsd:documentation>
                            Gives the IFD(s) for which this element is applicable. Indexed from 0. 
                            Default is 0 (the first IFD).
                        </xsd:documentation>
                    </xsd:annotation>
                </xsd:attribute>
                <xsd:attribute name="FirstZ" type="xsd:integer" default="0">
                    <xsd:annotation>
                        <xsd:documentation>
                            Gives the Z position of the image plane at the specified IFD. Indexed from 0. 
                            Default is 0 (the first Z position).
                        </xsd:documentation>
                    </xsd:annotation>
                </xsd:attribute>
                <xsd:attribute name="FirstT" type="xsd:integer" default="0">
                    <xsd:annotation>
                        <xsd:documentation>
                            Gives the T position of the image plane at the specified IFD. Indexed from 0.
                            Default is 0 (the first T position).
                        </xsd:documentation>
                    </xsd:annotation>
                </xsd:attribute>
                <xsd:attribute name="FirstC" type="xsd:integer" default="0">
                    <xsd:annotation>
                        <xsd:documentation>
                            Gives the C position of the image plane at the specified IFD. Indexed from 0. 
                            Default is 0 (the first C position).
                        </xsd:documentation>
                    </xsd:annotation>
                </xsd:attribute>
                <xsd:attribute name="NumPlanes" type="xsd:integer">
                    <xsd:annotation>
                        <xsd:documentation>
                            Gives the number of IFDs affected. Dimension order of IFDs is given by the enclosing
                            Pixels element's DimensionOrder attribute. Default is the number of IFDs in the TIFF
                            file, unless an IFD is specified, in which case the default is 1.
                        </xsd:documentation>
                    </xsd:annotation>
                </xsd:attribute>
            </xsd:complexType>
        </xsd:element>

by Andrew

Other Information
~~~~~~~~~~~~~~~~~

Minimum OME-XML file specification
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

     <?xml version="1.0" encoding="UTF-8"?>
     <ome:OME xmlns:bf="http://www.openmicroscopy.org/XMLschemas/BinaryFile/2007-06"
      xmlns:ome="http://www.openmicroscopy.org/XMLschemas/OME/2007-06"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.openmicroscopy.org/XMLschemas/OME/2007-06 file:/Users/andrew/Work/SVN/OME/src/xml/workingcopy/ome.xsd">
         <ome:Image ID="Image:a" Name="Name92" DefaultPixels="Pixels:b">
             <ome:CreationDate>2006-05-04T18:13:51.0Z</ome:CreationDate>
             <ome:Pixels ID="Pixels:a" DimensionOrder="XYZCT" PixelType="int8" BigEndian="false" SizeX="2" SizeY="2" SizeZ="2" SizeC="2" SizeT="2">
                 <bf:BinData Compression="none" Length="12">ZGVmYXVsdA==</bf:BinData>
              </ome:Pixels>
         </ome:Image>
     </ome:OME>

This is the updated version that matches the new regex. by Andrew

Deprecated Page

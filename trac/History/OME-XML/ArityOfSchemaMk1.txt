This page should be considered deprecated. While correct it is only of historic use.
------------------------------------------------------------------------------------

Model for the February 2008 release
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This page is written from the point of the February 2008 schema. See
February 2008 `Schema
XSD <http://www.openmicroscopy.org/Schemas/OME/2008-02/>`_ and `Schema
Documentation <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Generated/OME-2008-02/ome.xsd.html>`_.
Download `Example
Files <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/specification/Samples/>`_.
This is a *legacy* schema but this page is also valid for newer schemas.

Any value marked **from bio-formats** means that at least one file
format (other than OME-XML and OME-TIFF) contains this value.

``OME:``
--------

OME:FilterSet
~~~~~~~~~~~~~

-  OME:FilterSet(base = ``FilterSpec``, type = ``FilterSet``)

   -  OME:FilterSet:ExFilterRef( ``FilterID`` ) [0:1]
   -  OME:FilterSet:EmFilterRef( ``FilterID`` ) [0:1]
   -  OME:FilterSet:OTF\_BackReference( ``OTF`` ) [0:9999]
   -  OME:FilterSet:DichroicRef( ``DichroicID`` ) [0:1]
   -  OME:FilterSet:LogicalChannel\_BackReference( ``LogicalChannel`` )
      [0:9999]
   -  OME:FilterSet:ID( ``FilterSetID`` ) [1:1]

OME:ProjectRef
~~~~~~~~~~~~~~

-  OME:ProjectRef(base = ``Reference``, type = ``ProjectRef``)

   -  OME:ProjectRef:ID( ``ProjectID`` ) [1:1]

OME:Detector
~~~~~~~~~~~~

-  OME:Detector(base = ``ManufactSpec``, type = ``Detector``) **from
   bio-formats**

   -  OME:Detector:Zoom( ``xsd:float`` ) [0:1]
   -  OME:Detector:AmplificationGain( ``xsd:float`` ) [0:1]
   -  OME:Detector:Gain( ``xsd:float`` ) [0:1] **from bio-formats**
   -  OME:Detector:Offset( ``xsd:float`` ) [0:1] **from bio-formats**
   -  OME:Detector:LogicalChannel\_BackReference( ``LogicalChannel`` )
      [0:9999]
   -  OME:Detector:Type( ``xsd:string`` ) [1:1] **from bio-formats**
   -  OME:Detector:ID( ``DetectorID`` ) [1:1] **from bio-formats**
   -  OME:Detector:Voltage( ``xsd:float`` ) [0:1] **from bio-formats**

OME:ExperimenterRef
~~~~~~~~~~~~~~~~~~~

-  OME:ExperimenterRef(base = ``Reference``, type = ``ExperimenterRef``)

   -  OME:ExperimenterRef:ID( ``ExperimenterID`` ) [1:1]

OME:MicrobeamManipulation
~~~~~~~~~~~~~~~~~~~~~~~~~

-  OME:MicrobeamManipulation(base = ``None``, type =
   ``MicrobeamManipulation``)

   -  OME:MicrobeamManipulation:ExperimenterRef( ``ExperimenterRef`` )
      [1:1]
   -  OME:MicrobeamManipulation:Type( ``xsd:string`` ) [1:1]
   -  OME:MicrobeamManipulation:ROIRef( ``ROIRef`` ) [1:99999]
   -  OME:MicrobeamManipulation:Experiment\_BackReference(
      ``Experiment`` ) [0:9999]
   -  OME:MicrobeamManipulation:LightSourceRef( ``LightSourceRef`` )
      [0:99999]
   -  OME:MicrobeamManipulation:ID( ``MicrobeamManipulationID`` ) [1:1]

OME:StageLabel
~~~~~~~~~~~~~~

-  OME:StageLabel(base = ``None``, type = ``StageLabel``)

   -  OME:StageLabel:Y( ``xsd:float`` ) [0:1]
   -  OME:StageLabel:X( ``xsd:float`` ) [0:1]
   -  OME:StageLabel:Z( ``xsd:float`` ) [0:1]
   -  OME:StageLabel:Name( ``xsd:string`` ) [1:1]

OME:Group
~~~~~~~~~

-  OME:Group(base = ``None``, type = ``Group``)

   -  OME:Group:Name( ``xsd:string`` ) [0:1]
   -  OME:Group:Image\_BackReference( ``Image`` ) [0:9999]
   -  OME:Group:Dataset\_BackReference( ``Dataset`` ) [0:9999]
   -  OME:Group:Project\_BackReference( ``Project`` ) [0:9999]
   -  OME:Group:Contact( ``Contact`` ) [0:1]
   -  OME:Group:Experimenter\_BackReference( ``Experimenter`` ) [0:9999]
   -  OME:Group:ID( ``GroupID`` ) [1:1]
   -  OME:Group:Leader( ``Leader`` ) [0:1]

OME:Leader
~~~~~~~~~~

-  OME:Leader(base = ``Reference``, type = ``Leader``)

   -  OME:Leader:ID( ``ExperimenterID`` ) [1:1]

OME:LogicalChannel
~~~~~~~~~~~~~~~~~~

-  OME:LogicalChannel(base = ``None``, type = ``LogicalChannel``) **from
   bio-formats**

   -  OME:LogicalChannel:PhotometricInterpretation( ``xsd:string`` )
      [0:1] **from bio-formats**
   -  OME:LogicalChannel:ChannelComponent( ``ChannelComponent`` )
      [1:99999]
   -  OME:LogicalChannel:PockelCellSetting( ``xsd:integer`` ) [0:1]
      **from bio-formats**
   -  OME:LogicalChannel:SecondaryExcitationFilter( ``FilterID`` ) [0:1]
   -  OME:LogicalChannel:SamplesPerPixel( ``xsd:integer`` ) [0:1] **from
      bio-formats**
   -  OME:LogicalChannel:ContrastMethod( ``xsd:string`` ) [0:1] **from
      bio-formats**
   -  OME:LogicalChannel:FilterSetRef( ``FilterSetRef`` ) [0:1]
   -  OME:LogicalChannel:SecondaryEmissionFilter( ``FilterID`` ) [0:1]
   -  OME:LogicalChannel:ID( ``LogicalChannelID`` ) [1:1] **from
      bio-formats**
   -  OME:LogicalChannel:Channels\_BackReference( ``Channels`` )
      [0:9999]
   -  OME:LogicalChannel:Fluor( ``xsd:string`` ) [0:1] **from
      bio-formats**
   -  OME:LogicalChannel:PinholeSize( ``xsd:positiveInteger`` ) [0:1]
      **from bio-formats**
   -  OME:LogicalChannel:NdFilter( ``xsd:float`` ) [0:1] **from
      bio-formats**
   -  OME:LogicalChannel:Mode( ``xsd:string`` ) [0:1] **from
      bio-formats**
   -  OME:LogicalChannel:DetectorRef( ``DetectorRef`` ) [0:1]
   -  OME:LogicalChannel:OTFRef( ``OTFRef`` ) [0:1]
   -  OME:LogicalChannel:EmWave( ``xsd:positiveInteger`` ) [0:1] **from
      bio-formats**
   -  OME:LogicalChannel:ExWave( ``xsd:positiveInteger`` ) [0:1] **from
      bio-formats**
   -  OME:LogicalChannel:LightSourceRef( ``LightSourceRef`` ) [0:1]
   -  OME:LogicalChannel:IlluminationType( ``xsd:string`` ) [0:1] **from
      bio-formats**
   -  OME:LogicalChannel:Name( ``xsd:string`` ) [0:1] **from
      bio-formats**

OME:Experiment
~~~~~~~~~~~~~~

-  OME:Experiment(base = ``None``, type = ``Experiment``)

   -  OME:Experiment:Description( ``Description`` ) [0:1]
   -  OME:Experiment:ExperimenterRef( ``ExperimenterRef`` ) [1:1]
   -  OME:Experiment:Image\_BackReference( ``Image`` ) [0:9999]
   -  OME:Experiment:ID( ``ExperimentID`` ) [1:1]
   -  OME:Experiment:Type( ``xsd:string`` ) [1:1]
   -  OME:Experiment:MicrobeamManipulationRef(
      ``MicrobeamManipulationRef`` ) [0:99999]

OME:Circle
~~~~~~~~~~

-  OME:Circle(base = ``BasicSvgShape``, type = ``Circle``)

   -  OME:Circle:cy( ``xsd:string`` ) [0:1]
   -  OME:Circle:cx( ``xsd:string`` ) [0:1]
   -  OME:Circle:r( ``xsd:string`` ) [0:1]

OME:LightSource
~~~~~~~~~~~~~~~

-  OME:LightSource(base = ``ManufactSpec``, type = ``LightSource``)

   -  OME:LightSource:Laser( ``Laser`` ) [1:1]
   -  OME:LightSource:Power( ``xsd:float`` ) [0:1]
   -  OME:LightSource:Arc( ``Arc`` ) [1:1]
   -  OME:LightSource:LogicalChannel\_BackReference( ``LogicalChannel``
      ) [0:9999]
   -  OME:LightSource:ID( ``LightSourceID`` ) [1:1]
   -  OME:LightSource:Filament( ``Filament`` ) [1:1]
   -  OME:LightSource:MicrobeamManipulation\_BackReference(
      ``MicrobeamManipulation`` ) [0:9999]

OME:LightSourceRef
~~~~~~~~~~~~~~~~~~

-  OME:LightSourceRef(base = ``Reference``, type = ``LightSourceRef``)

   -  OME:LightSourceRef:Wavelength( ``xsd:positiveInteger`` ) [0:1]
   -  OME:LightSourceRef:Attenuation( ``PercentFraction`` ) [0:1]
   -  OME:LightSourceRef:ID( ``LightSourceID`` ) [1:1]

OME:Pixels
~~~~~~~~~~

-  OME:Pixels(base = ``None``, type = ``Pixels``) **from bio-formats**

   -  OME:Pixels:SizeT( ``xsd:positiveInteger`` ) [1:1] **from
      bio-formats**
   -  OME:Pixels:DimensionOrder( ``xsd:string`` ) [1:1] **from
      bio-formats**
   -  OME:Pixels:TimeIncrement( ``xsd:float`` ) [0:1] **from
      bio-formats**
   -  OME:Pixels:PhysicalSizeY( ``xsd:float`` ) [0:1] **from
      bio-formats**
   -  OME:Pixels:PhysicalSizeX( ``xsd:float`` ) [0:1] **from
      bio-formats**
   -  OME:Pixels:PhysicalSizeZ( ``xsd:float`` ) [0:1] **from
      bio-formats**
   -  OME:Pixels:SizeX( ``xsd:positiveInteger`` ) [1:1] **from
      bio-formats**
   -  OME:Pixels:SizeY( ``xsd:positiveInteger`` ) [1:1] **from
      bio-formats**
   -  OME:Pixels:SizeZ( ``xsd:positiveInteger`` ) [1:1] **from
      bio-formats**
   -  OME:Pixels:TiffData( ``TiffData`` ) [1:1]
   -  OME:Pixels:WaveStart( ``xsd:positiveInteger`` ) [0:1] **from
      bio-formats**
   -  OME:Pixels:BigEndian( ``xsd:boolean`` ) [1:1] **from bio-formats**
   -  OME:Pixels:Plane( ``Plane`` ) [0:99999]
   -  OME:Pixels:BinData( ``xsd:string`` ) [1:1]
   -  OME:Pixels:PixelType( ``PixelTypes`` ) [1:1] **from bio-formats**
   -  OME:Pixels:WaveIncrement( ``xsd:positiveInteger`` ) [0:1] **from
      bio-formats**
   -  OME:Pixels:ID( ``PixelsID`` ) [1:1] **from bio-formats**
   -  OME:Pixels:SizeC( ``xsd:positiveInteger`` ) [1:1] **from
      bio-formats**

OME:Thumbnail
~~~~~~~~~~~~~

-  OME:Thumbnail(base = ``None``, type = ``Thumbnail``)

   -  OME:Thumbnail:MIMEtype( ``MIMEtype`` ) [1:1]
   -  OME:Thumbnail:href( ``xsd:anyURI`` ) [0:1]

OME:ROIRef
~~~~~~~~~~

-  OME:ROIRef(base = ``Reference``, type = ``ROIRef``)

   -  OME:ROIRef:ID( ``ROIID`` ) [1:1]

OME:ROI
~~~~~~~

-  OME:ROI(base = ``None``, type = ``ROI``) **from bio-formats**

   -  OME:ROI:Union( ``Union`` ) [1:1]
   -  OME:ROI:ID( ``ROIID`` ) [1:1]
   -  OME:ROI:MicrobeamManipulation\_BackReference(
      ``MicrobeamManipulation`` ) [0:9999]

OME:Polyline
~~~~~~~~~~~~

-  OME:Polyline(base = ``BasicSvgShape``, type = ``Polyline``)

   -  OME:Polyline:points( ``xsd:string`` ) [0:1]

OME:FilterSetRef
~~~~~~~~~~~~~~~~

-  OME:FilterSetRef(base = ``Reference``, type = ``FilterSetRef``)

   -  OME:FilterSetRef:ID( ``FilterSetID`` ) [1:1]

OME:Channels
~~~~~~~~~~~~

-  OME:Channels(base = ``None``, type = ``Channels``)

   -  OME:Channels:LogicalChannelRef( ``LogicalChannelRef`` ) [1:99999]

OME:OME
~~~~~~~

-  OME:OME(base = ``None``, type = ``OME``)

   -  OME:OME:Plate( ``xsd:string`` ) [0:99999]
   -  OME:OME:Group( ``Group`` ) [0:99999]
   -  OME:OME:UUID( ``UniversallyUniqueIdentifier`` ) [0:1]
   -  OME:OME:SemanticTypeDefinitions( ``xsd:string`` ) [0:1]
   -  OME:OME:Screen( ``xsd:string`` ) [0:99999]
   -  OME:OME:AnalysisModuleLibrary( ``xsd:string`` ) [0:1]
   -  OME:OME:Dataset( ``Dataset`` ) [0:99999]
   -  OME:OME:Project( ``Project`` ) [0:99999]
   -  OME:OME:Instrument( ``Instrument`` ) [0:99999]
   -  OME:OME:CustomAttributes( ``xsd:string`` ) [0:1]
   -  OME:OME:Experiment( ``Experiment`` ) [0:99999]
   -  OME:OME:Experimenter( ``Experimenter`` ) [0:99999]
   -  OME:OME:StructuredAnnotations( ``xsd:string`` ) [0:1]
   -  OME:OME:Image( ``Image`` ) [0:99999]

OME:LogicalChannelRef
~~~~~~~~~~~~~~~~~~~~~

-  OME:LogicalChannelRef(base = ``Reference``, type =
   ``LogicalChannelRef``)

   -  OME:LogicalChannelRef:ID( ``LogicalChannelID`` ) [1:1]

OME:Microscope
~~~~~~~~~~~~~~

-  OME:Microscope(base = ``ManufactSpec``, type = ``Microscope``)

   -  OME:Microscope:Type( ``xsd:string`` ) [1:1]

OME:Pump
~~~~~~~~

-  OME:Pump(base = ``Reference``, type = ``Pump``)

   -  OME:Pump:ID( ``LightSourceID`` ) [1:1]

OME:Projection
~~~~~~~~~~~~~~

-  OME:Projection(base = ``None``, type = ``Projection``)

   -  OME:Projection:ZStart( ``xsd:integer`` ) [0:1]
   -  OME:Projection:ZStop( ``xsd:integer`` ) [0:1]

OME:TiffData
~~~~~~~~~~~~

-  OME:TiffData(base = ``None``, type = ``TiffData``)

   -  OME:TiffData:UUID( ``UUID`` ) [0:1]
   -  OME:TiffData:NumPlanes( ``xsd:integer`` ) [0:1]
   -  OME:TiffData:FirstC( ``xsd:integer`` ) [0:1]
   -  OME:TiffData:IFD( ``xsd:integer`` ) [0:1]
   -  OME:TiffData:FirstZ( ``xsd:integer`` ) [0:1]
   -  OME:TiffData:FirstT( ``xsd:integer`` ) [0:1]

OME:Dataset
~~~~~~~~~~~

-  OME:Dataset(base = ``None``, type = ``Dataset``)

   -  OME:Dataset:Locked( ``xsd:boolean`` ) [0:1]
   -  OME:Dataset:Description( ``Description`` ) [0:1]
   -  OME:Dataset:ExperimenterRef( ``ExperimenterRef`` ) [0:1]
   -  OME:Dataset:ProjectRef( ``ProjectRef`` ) [0:99999]
   -  OME:Dataset:Image\_BackReference( ``Image`` ) [0:9999]
   -  OME:Dataset:GroupRef( ``GroupRef`` ) [0:1]
   -  OME:Dataset:CustomAttributes( ``xsd:string`` ) [0:1]
   -  OME:Dataset:ID( ``DatasetID`` ) [1:1]
   -  OME:Dataset:Name( ``xsd:string`` ) [1:1]

OME:Description
~~~~~~~~~~~~~~~

-  OME:Description(base = ``None``, type = ``Description``)

   -  OME:Description:lang( ``xsd:string`` ) [0:1]

OME:Objective
~~~~~~~~~~~~~

-  OME:Objective(base = ``ManufactSpec``, type = ``Objective``) **from
   bio-formats**

   -  OME:Objective:WorkingDistance( ``xsd:float`` ) [1:1] **from
      bio-formats**
   -  OME:Objective:Immersion( ``xsd:string`` ) [1:1] **from
      bio-formats**
   -  OME:Objective:Image\_BackReference( ``Image`` ) [0:9999]
   -  OME:Objective:Correction( ``xsd:string`` ) [1:1]
   -  OME:Objective:OTF\_BackReference( ``OTF`` ) [0:9999]
   -  OME:Objective:LensNA( ``xsd:float`` ) [1:1] **from bio-formats**
   -  OME:Objective:NominalMagnification( ``xsd:integer`` ) [1:1]
   -  OME:Objective:CalibratedMagnification( ``xsd:float`` ) [1:1]
      **from bio-formats**
   -  OME:Objective:ID( ``ObjectiveID`` ) [1:1]

OME:ImagingEnvironment
~~~~~~~~~~~~~~~~~~~~~~

-  OME:ImagingEnvironment(base = ``None``, type =
   ``ImagingEnvironment``) **from bio-formats**

   -  OME:ImagingEnvironment:CO2Percent( ``PercentFraction`` ) [0:1]
   -  OME:ImagingEnvironment:Temperature( ``xsd:float`` ) [0:1] **from
      bio-formats**
   -  OME:ImagingEnvironment:AirPressure( ``xsd:float`` ) [0:1]
   -  OME:ImagingEnvironment:Humidity( ``PercentFraction`` ) [0:1]

OME:ChannelSpecType
~~~~~~~~~~~~~~~~~~~

-  OME:ChannelSpecType(base = ``None``, type = ``ChannelSpecType``)

   -  OME:ChannelSpecType:ChannelNumber( ``xsd:integer`` ) [1:1]
   -  OME:ChannelSpecType:WhiteLevel( ``xsd:float`` ) [1:1]
   -  OME:ChannelSpecType:BlackLevel( ``xsd:float`` ) [1:1]
   -  OME:ChannelSpecType:Gamma( ``xsd:float`` ) [0:1]
   -  OME:ChannelSpecType:isOn( ``xsd:boolean`` ) [0:1]

OME:Mask
~~~~~~~~

-  OME:Mask(base = ``BasicSvgShape``, type = ``Mask``)

   -  OME:Mask:y( ``xsd:string`` ) [0:1]
   -  OME:Mask:x( ``xsd:string`` ) [0:1]
   -  OME:Mask:MaskPixels( ``MaskPixels`` ) [1:1]
   -  OME:Mask:width( ``xsd:string`` ) [0:1]
   -  OME:Mask:height( ``xsd:string`` ) [0:1]

OME:PlaneTiming
~~~~~~~~~~~~~~~

-  OME:PlaneTiming(base = ``None``, type = ``PlaneTiming``) **from
   bio-formats**

   -  OME:PlaneTiming:ExposureTime( ``xsd:float`` ) [1:1] **from
      bio-formats**
   -  OME:PlaneTiming:DeltaT( ``xsd:float`` ) [1:1] **from bio-formats**

OME:Region
~~~~~~~~~~

-  OME:Region(base = ``None``, type = ``Region``)

   -  OME:Region:Region( ``Region`` ) [0:99999]
   -  OME:Region:Tag( ``xsd:string`` ) [1:1]
   -  OME:Region:Name( ``xsd:string`` ) [0:1]
   -  OME:Region:CustomAttributes( ``xsd:string`` ) [0:1]
   -  OME:Region:ID( ``RegionID`` ) [1:1]

OME:ChannelComponent
~~~~~~~~~~~~~~~~~~~~

-  OME:ChannelComponent(base = ``None``, type = ``ChannelComponent``)

   -  OME:ChannelComponent:Index( ``xsd:nonNegativeInteger`` ) [1:1]
   -  OME:ChannelComponent:ColorDomain( ``xsd:string`` ) [0:1]
   -  OME:ChannelComponent:Pixels( ``PixelsID`` ) [1:1]

OME:Rect
~~~~~~~~

-  OME:Rect(base = ``BasicSvgShape``, type = ``Rect``)

   -  OME:Rect:y( ``xsd:string`` ) [0:1]
   -  OME:Rect:x( ``xsd:string`` ) [0:1]
   -  OME:Rect:width( ``xsd:string`` ) [0:1]
   -  OME:Rect:height( ``xsd:string`` ) [0:1]

OME:Contact
~~~~~~~~~~~

-  OME:Contact(base = ``Reference``, type = ``Contact``)

   -  OME:Contact:ID( ``ExperimenterID`` ) [1:1]

OME:Point
~~~~~~~~~

-  OME:Point(base = ``BasicSvgShape``, type = ``Point``)

   -  OME:Point:cy( ``xsd:string`` ) [0:1]
   -  OME:Point:cx( ``xsd:string`` ) [0:1]
   -  OME:Point:r( ``xsd:string`` ) [0:1]

OME:Reference
~~~~~~~~~~~~~

-  OME:Reference(base = ``None``, type = ``Reference``)

OME:Experimenter
~~~~~~~~~~~~~~~~

-  OME:Experimenter(base = ``None``, type = ``Experimenter``) **from
   bio-formats**

   -  OME:Experimenter:Email( ``xsd:string`` ) [1:1] **from
      bio-formats**
   -  OME:Experimenter:OMEName( ``xsd:string`` ) [1:1]
   -  OME:Experimenter:FirstName( ``xsd:string`` ) [1:1] **from
      bio-formats**
   -  OME:Experimenter:LastName( ``xsd:string`` ) [1:1] **from
      bio-formats**
   -  OME:Experimenter:Image\_BackReference( ``Image`` ) [0:9999]
   -  OME:Experimenter:GroupRef( ``GroupRef`` ) [0:99999]
   -  OME:Experimenter:ID( ``ExperimenterID`` ) [1:1] **from
      bio-formats**
   -  OME:Experimenter:Project\_BackReference( ``Project`` ) [0:9999]
   -  OME:Experimenter:Experiment\_BackReference( ``Experiment`` )
      [0:9999]
   -  OME:Experimenter:Dataset\_BackReference( ``Dataset`` ) [0:9999]
   -  OME:Experimenter:Institution( ``xsd:string`` ) [0:1] **from
      bio-formats**
   -  OME:Experimenter:MicrobeamManipulation\_BackReference(
      ``MicrobeamManipulation`` ) [0:9999]

OME:ManufactSpec
~~~~~~~~~~~~~~~~

-  OME:ManufactSpec(base = ``None``, type = ``ManufactSpec``) **from
   bio-formats**

   -  OME:ManufactSpec:Model( ``xsd:string`` ) [1:1] **from
      bio-formats**
   -  OME:ManufactSpec:SerialNumber( ``xsd:string`` ) [0:1] **from
      bio-formats**
   -  OME:ManufactSpec:Manufacturer( ``xsd:string`` ) [1:1] **from
      bio-formats**

OME:MicrobeamManipulationRef
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  OME:MicrobeamManipulationRef(base = ``Reference``, type =
   ``MicrobeamManipulationRef``)

   -  OME:MicrobeamManipulationRef:ID( ``MicrobeamManipulationID`` )
      [1:1]

OME:GroupRef
~~~~~~~~~~~~

-  OME:GroupRef(base = ``Reference``, type = ``GroupRef``)

   -  OME:GroupRef:ID( ``GroupID`` ) [1:1]

OME:FilterSpec
~~~~~~~~~~~~~~

-  OME:FilterSpec(base = ``None``, type = ``FilterSpec``)

   -  OME:FilterSpec:Model( ``xsd:string`` ) [1:1]
   -  OME:FilterSpec:LotNumber( ``xsd:string`` ) [0:1]
   -  OME:FilterSpec:Manufacturer( ``xsd:string`` ) [1:1]

OME:Image
~~~~~~~~~

-  OME:Image(base = ``None``, type = ``Image``) **from bio-formats**

   -  OME:Image:ImagingEnvironment( ``ImagingEnvironment`` ) [0:1]
   -  OME:Image:ExperimenterRef( ``ExperimenterRef`` ) [0:1]
   -  OME:Image:DefaultPixels( ``PixelsID`` ) [1:1]
   -  OME:Image:CustomAttributes( ``xsd:string`` ) [0:1]
   -  OME:Image:LogicalChannel( ``LogicalChannel`` ) [0:99999]
   -  OME:Image:Thumbnail( ``Thumbnail`` ) [0:1]
   -  OME:Image:ROI( ``ROI`` ) [0:99999]
   -  OME:Image:Description( ``Description`` ) [0:1] **from
      bio-formats**
   -  OME:Image:StageLabel( ``StageLabel`` ) [0:1]
   -  OME:Image:GroupRef( ``GroupRef`` ) [0:1]
   -  OME:Image:InstrumentRef( ``InstrumentRef`` ) [0:1] **from
      bio-formats**
   -  OME:Image:ObjectiveRef( ``ObjectiveRef`` ) [0:1]
   -  OME:Image:Pixels( ``Pixels`` ) [1:99999]
   -  OME:Image:Name( ``xsd:string`` ) [1:1] **from bio-formats**
   -  OME:Image:Region( ``Region`` ) [0:99999]
   -  OME:Image:AcquiredPixels( ``PixelsID`` ) [0:1]
   -  OME:Image:ID( ``ImageID`` ) [1:1]
   -  OME:Image:MicrobeamManipulation( ``MicrobeamManipulation`` )
      [0:99999]
   -  OME:Image:ExperimentRef( ``ExperimentRef`` ) [0:1]
   -  OME:Image:DatasetRef( ``DatasetRef`` ) [0:99999]
   -  OME:Image:CreationDate( ``xsd:dateTime`` ) [1:1] **from
      bio-formats**
   -  OME:Image:DisplayOptions( ``DisplayOptions`` ) [0:1]

OME:OTF
~~~~~~~

-  OME:OTF(base = ``None``, type = ``OTF``)

   -  OME:OTF:PixelType( ``ExtendedPixelTypes`` ) [1:1]
   -  OME:OTF:SizeX( ``xsd:positiveInteger`` ) [1:1]
   -  OME:OTF:SizeY( ``xsd:positiveInteger`` ) [1:1]
   -  OME:OTF:LogicalChannel\_BackReference( ``LogicalChannel`` )
      [0:9999]
   -  OME:OTF:FilterSetRef( ``FilterSetRef`` ) [0:1]
   -  OME:OTF:OpticalAxisAveraged( ``xsd:boolean`` ) [1:1]
   -  OME:OTF:ObjectiveRef( ``ObjectiveRef`` ) [1:1]
   -  OME:OTF:BinaryFile( ``xsd:string`` ) [1:1]
   -  OME:OTF:ID( ``OTFID`` ) [1:1]

OME:Union
~~~~~~~~~

-  OME:Union(base = ``None``, type = ``Union``)

   -  OME:Union:Shape( ``Shape`` ) [1:99999]

OME:Arc
~~~~~~~

-  OME:Arc(base = ``None``, type = ``Arc``)

   -  OME:Arc:Type( ``xsd:string`` ) [1:1]

OME:ObjectiveRef
~~~~~~~~~~~~~~~~

-  OME:ObjectiveRef(base = ``Reference``, type = ``ObjectiveRef``)

   -  OME:ObjectiveRef:RefractiveIndex( ``xsd:float`` ) [0:1]
   -  OME:ObjectiveRef:CorrectionCollar( ``xsd:float`` ) [0:1]
   -  OME:ObjectiveRef:ID( ``ObjectiveID`` ) [1:1]
   -  OME:ObjectiveRef:Medium( ``Medium`` ) [0:1]

OME:Dichroic
~~~~~~~~~~~~

-  OME:Dichroic(base = ``FilterSpec``, type = ``Dichroic``)

   -  OME:Dichroic:ID( ``DichroicID`` ) [1:1]

OME:OTFRef
~~~~~~~~~~

-  OME:OTFRef(base = ``Reference``, type = ``OTFRef``)

   -  OME:OTFRef:ID( ``OTFID`` ) [1:1]

OME:Project
~~~~~~~~~~~

-  OME:Project(base = ``None``, type = ``Project``)

   -  OME:Project:Description( ``Description`` ) [0:1]
   -  OME:Project:ExperimenterRef( ``ExperimenterRef`` ) [1:1]
   -  OME:Project:GroupRef( ``GroupRef`` ) [0:1]
   -  OME:Project:Dataset\_BackReference( ``Dataset`` ) [0:9999]
   -  OME:Project:ID( ``ProjectID`` ) [1:1]
   -  OME:Project:Name( ``xsd:string`` ) [1:1]

OME:Shape
~~~~~~~~~

-  OME:Shape(base = ``None``, type = ``Shape``)

   -  OME:Shape:Polygon( ``Polygon`` ) [1:1]
   -  OME:Shape:Point( ``Point`` ) [1:1]
   -  OME:Shape:Mask( ``Mask`` ) [1:1]
   -  OME:Shape:Ellipse( ``Ellipse`` ) [1:1]
   -  OME:Shape:Channels( ``Channels`` ) [0:1]
   -  OME:Shape:Polyline( ``Polyline`` ) [1:1]
   -  OME:Shape:theZ( ``xsd:integer`` ) [0:1]
   -  OME:Shape:Line( ``Line`` ) [1:1]
   -  OME:Shape:Circle( ``Circle`` ) [1:1]
   -  OME:Shape:theT( ``xsd:integer`` ) [0:1]
   -  OME:Shape:ID( ``ShapeID`` ) [1:1]
   -  OME:Shape:Rect( ``Rect`` ) [1:1]

OME:DisplayOptions
~~~~~~~~~~~~~~~~~~

-  OME:DisplayOptions(base = ``None``, type = ``DisplayOptions``) **from
   bio-formats**

   -  OME:DisplayOptions:ROI( ``ROI`` ) [0:99999]
   -  OME:DisplayOptions:GreenChannel( ``GreenChannel`` ) [1:1]
   -  OME:DisplayOptions:Projection( ``Projection`` ) [0:1]
   -  OME:DisplayOptions:Zoom( ``xsd:float`` ) [0:1] **from
      bio-formats**
   -  OME:DisplayOptions:BlueChannel( ``BlueChannel`` ) [1:1]
   -  OME:DisplayOptions:Display( ``xsd:string`` ) [1:1]
   -  OME:DisplayOptions:Time( ``Time`` ) [0:1]
   -  OME:DisplayOptions:RedChannel( ``RedChannel`` ) [1:1]
   -  OME:DisplayOptions:GreyChannel( ``GreyChannel`` ) [1:1]
   -  OME:DisplayOptions:ID( ``DisplayOptionsID`` ) [1:1] **from
      bio-formats**

OME:Line
~~~~~~~~

-  OME:Line(base = ``BasicSvgShape``, type = ``Line``)

   -  OME:Line:y1( ``xsd:string`` ) [0:1]
   -  OME:Line:x2( ``xsd:string`` ) [0:1]
   -  OME:Line:x1( ``xsd:string`` ) [0:1]
   -  OME:Line:y2( ``xsd:string`` ) [0:1]

OME:Filament
~~~~~~~~~~~~

-  OME:Filament(base = ``None``, type = ``Filament``)

   -  OME:Filament:Type( ``xsd:string`` ) [1:1]

OME:DatasetRef
~~~~~~~~~~~~~~

-  OME:DatasetRef(base = ``Reference``, type = ``DatasetRef``)

   -  OME:DatasetRef:ID( ``DatasetID`` ) [1:1]

OME:InstrumentRef
~~~~~~~~~~~~~~~~~

-  OME:InstrumentRef(base = ``Reference``, type = ``InstrumentRef``)

   -  OME:InstrumentRef:ID( ``InstrumentID`` ) [1:1]

OME:BasicSvgShape
~~~~~~~~~~~~~~~~~

-  OME:BasicSvgShape(base = ``None``, type = ``BasicSvgShape``)

   -  OME:BasicSvgShape:transform( ``xsd:string`` ) [0:1]

OME:UUID
~~~~~~~~

-  OME:UUID(base = ``UniversallyUniqueIdentifier``, type = ``UUID``)

   -  OME:UUID:FileName( ``xsd:string`` ) [0:1]

OME:Polygon
~~~~~~~~~~~

-  OME:Polygon(base = ``BasicSvgShape``, type = ``Polygon``)

   -  OME:Polygon:points( ``xsd:string`` ) [0:1]

OME:Filter
~~~~~~~~~~

-  OME:Filter(base = ``FilterSpec``, type = ``Filter``)

   -  OME:Filter:FilterWheel( ``xsd:string`` ) [0:1]
   -  OME:Filter:Type( ``xsd:string`` ) [0:1]
   -  OME:Filter:ID( ``FilterID`` ) [1:1]
   -  OME:Filter:TransmittanceRange( ``TransmittanceRange`` ) [1:1]

OME:ExperimentRef
~~~~~~~~~~~~~~~~~

-  OME:ExperimentRef(base = ``Reference``, type = ``ExperimentRef``)

   -  OME:ExperimentRef:ID( ``ExperimentID`` ) [1:1]

OME:TransmittanceRange
~~~~~~~~~~~~~~~~~~~~~~

-  OME:TransmittanceRange(base = ``None``, type =
   ``TransmittanceRange``)

   -  OME:TransmittanceRange:CutIn( ``xsd:integer`` ) [1:1]
   -  OME:TransmittanceRange:Transmittance( ``xsd:integer`` ) [1:1]
   -  OME:TransmittanceRange:CutOut( ``xsd:integer`` ) [1:1]
   -  OME:TransmittanceRange:CutInTolerance( ``xsd:integer`` ) [0:1]
   -  OME:TransmittanceRange:CutOutTolerance( ``xsd:integer`` ) [0:1]

OME:Plane
~~~~~~~~~

-  OME:Plane(base = ``None``, type = ``Plane``) **from bio-formats**

   -  OME:Plane:TheC( ``xsd:integer`` ) [1:1] **from bio-formats**
   -  OME:Plane:HashSHA1( ``xsd:string`` ) [1:1]
   -  OME:Plane:TheZ( ``xsd:integer`` ) [1:1] **from bio-formats**
   -  OME:Plane:PlaneTiming( ``PlaneTiming`` ) [0:1]
   -  OME:Plane:TheT( ``xsd:integer`` ) [1:1] **from bio-formats**
   -  OME:Plane:StagePosition( ``StagePosition`` ) [0:1]

OME:Ellipse
~~~~~~~~~~~

-  OME:Ellipse(base = ``BasicSvgShape``, type = ``Ellipse``)

   -  OME:Ellipse:cy( ``xsd:string`` ) [0:1]
   -  OME:Ellipse:cx( ``xsd:string`` ) [0:1]
   -  OME:Ellipse:rx( ``xsd:string`` ) [0:1]
   -  OME:Ellipse:ry( ``xsd:string`` ) [0:1]

OME:GreyChannel
~~~~~~~~~~~~~~~

-  OME:GreyChannel(base = ``ChannelSpecType``, type = ``GreyChannel``)

   -  OME:GreyChannel:ColorMap( ``xsd:string`` ) [0:1]

OME:Laser
~~~~~~~~~

-  OME:Laser(base = ``None``, type = ``Laser``) **from bio-formats**

   -  OME:Laser:PockelCell( ``xsd:boolean`` ) [0:1]
   -  OME:Laser:Tuneable( ``xsd:boolean`` ) [0:1]
   -  OME:Laser:LaserMedium( ``LaserMedia`` ) [1:1] **from bio-formats**
   -  OME:Laser:Pump( ``Pump`` ) [0:1]
   -  OME:Laser:Pulse( ``xsd:string`` ) [0:1]
   -  OME:Laser:Wavelength( ``xsd:positiveInteger`` ) [0:1] **from
      bio-formats**
   -  OME:Laser:FrequencyMultiplication( ``xsd:positiveInteger`` ) [0:1]
   -  OME:Laser:Type( ``xsd:string`` ) [1:1] **from bio-formats**
   -  OME:Laser:RepetitionRate( ``xsd:boolean`` ) [0:1]

OME:MaskPixels
~~~~~~~~~~~~~~

-  OME:MaskPixels(base = ``None``, type = ``MaskPixels``)

   -  OME:MaskPixels:ExtendedPixelType( ``ExtendedPixelTypes`` ) [1:1]
   -  OME:MaskPixels:SizeX( ``xsd:positiveInteger`` ) [1:1]
   -  OME:MaskPixels:SizeY( ``xsd:positiveInteger`` ) [1:1]
   -  OME:MaskPixels:TiffData( ``TiffData`` ) [1:1]
   -  OME:MaskPixels:BigEndian( ``xsd:boolean`` ) [1:1]
   -  OME:MaskPixels:BinData( ``xsd:string`` ) [1:1]

OME:Instrument
~~~~~~~~~~~~~~

-  OME:Instrument(base = ``None``, type = ``Instrument``)

   -  OME:Instrument:LightSource( ``LightSource`` ) [0:99999]
   -  OME:Instrument:Dichroic( ``Dichroic`` ) [0:99999]
   -  OME:Instrument:Image\_BackReference( ``Image`` ) [0:9999]
   -  OME:Instrument:OTF( ``OTF`` ) [0:99999]
   -  OME:Instrument:Filter( ``Filter`` ) [0:99999]
   -  OME:Instrument:Microscope( ``Microscope`` ) [1:1]
   -  OME:Instrument:Objective( ``Objective`` ) [0:99999]
   -  OME:Instrument:Detector( ``Detector`` ) [0:99999]
   -  OME:Instrument:ID( ``InstrumentID`` ) [1:1]
   -  OME:Instrument:FilterSet( ``FilterSet`` ) [0:99999]

OME:Time
~~~~~~~~

-  OME:Time(base = ``None``, type = ``Time``)

   -  OME:Time:TStop( ``xsd:integer`` ) [0:1]
   -  OME:Time:TStart( ``xsd:integer`` ) [0:1]

OME:StagePosition
~~~~~~~~~~~~~~~~~

-  OME:StagePosition(base = ``None``, type = ``StagePosition``) **from
   bio-formats**

   -  OME:StagePosition:PositionZ( ``xsd:float`` ) [1:1] **from
      bio-formats**
   -  OME:StagePosition:PositionX( ``xsd:float`` ) [1:1] **from
      bio-formats**
   -  OME:StagePosition:PositionY( ``xsd:float`` ) [1:1] **from
      bio-formats**

OME:DetectorRef
~~~~~~~~~~~~~~~

-  OME:DetectorRef(base = ``Reference``, type = ``DetectorRef``) **from
   bio-formats**

   -  OME:DetectorRef:Gain( ``xsd:float`` ) [0:1] **from bio-formats**
   -  OME:DetectorRef:Binning( ``Binning`` ) [0:1]
   -  OME:DetectorRef:Voltage( ``xsd:float`` ) [0:1]
   -  OME:DetectorRef:Offset( ``xsd:float`` ) [0:1] **from bio-formats**
   -  OME:DetectorRef:ID( ``DetectorID`` ) [1:1]
   -  OME:DetectorRef:ReadOutRate( ``xsd:float`` ) [0:1]

``SPW:``
--------

SPW:Screen
~~~~~~~~~~

-  SPW:Screen(base = ``None``, type = ``Screen``)

   -  SPW:Screen:Plate\_BackReference( ``Plate`` ) [0:9999]
   -  SPW:Screen:Name( ``xsd:string`` ) [1:1]
   -  SPW:Screen:ProtocolDescription( ``xsd:string`` ) [0:1]
   -  SPW:Screen:ProtocolIdentifier( ``xsd:string`` ) [0:1]
   -  SPW:Screen:Reagent( ``Reagent`` ) [0:99999]
   -  SPW:Screen:PlateRef( ``PlateRef`` ) [0:99999]
   -  SPW:Screen:ReagentSetDescription( ``xsd:string`` ) [0:1]
   -  SPW:Screen:ScreenAcquisition( ``ScreenAcquisition`` ) [0:99999]
   -  SPW:Screen:Description( ``Description`` ) [0:1]
   -  SPW:Screen:Type( ``xsd:string`` ) [0:1]
   -  SPW:Screen:ID( ``ScreenID`` ) [1:1]
   -  SPW:Screen:ReagentSetIdentifier( ``xsd:string`` ) [0:1]

SPW:PlateRef
~~~~~~~~~~~~

-  SPW:PlateRef(base = ``Reference``, type = ``PlateRef``)

   -  SPW:PlateRef:ID( ``PlateID`` ) [1:1]

SPW:Well
~~~~~~~~

-  SPW:Well(base = ``None``, type = ``Well``) **from bio-formats**

   -  SPW:Well:ExternalIdentifier( ``xsd:string`` ) [0:1]
   -  SPW:Well:Column( ``xsd:integer`` ) [0:1] **from bio-formats**
   -  SPW:Well:ExternalDescription( ``xsd:string`` ) [0:1]
   -  SPW:Well:ReagentRef( ``ReagentRef`` ) [0:1]
   -  SPW:Well:WellSample( ``WellSample`` ) [0:99999]
   -  SPW:Well:Type( ``xsd:string`` ) [0:1]
   -  SPW:Well:ID( ``WellID`` ) [1:1]
   -  SPW:Well:Row( ``xsd:integer`` ) [0:1] **from bio-formats**

SPW:Reagent
~~~~~~~~~~~

-  SPW:Reagent(base = ``None``, type = ``Reagent``)

   -  SPW:Reagent:Description( ``xsd:string`` ) [0:1]
   -  SPW:Reagent:ReagentIdentifier( ``xsd:string`` ) [0:1]
   -  SPW:Reagent:Well\_BackReference( ``Well`` ) [0:9999]
   -  SPW:Reagent:Name( ``xsd:string`` ) [0:1]
   -  SPW:Reagent:ID( ``ReagentID`` ) [1:1]

SPW:WellSample
~~~~~~~~~~~~~~

-  SPW:WellSample(base = ``None``, type = ``WellSample``) **from
   bio-formats**

   -  SPW:WellSample:Index( ``xsd:integer`` ) [0:1] **from bio-formats**
   -  SPW:WellSample:ImageRef( ``ImageRef`` ) [0:1]
   -  SPW:WellSample:Timepoint( ``xsd:integer`` ) [0:1]
   -  SPW:WellSample:PosX( ``xsd:float`` ) [0:1]
   -  SPW:WellSample:PosY( ``xsd:float`` ) [0:1]
   -  SPW:WellSample:ScreenAcquisition\_BackReference(
      ``ScreenAcquisition`` ) [0:9999]
   -  SPW:WellSample:ID( ``WellSampleID`` ) [1:1]

SPW:ReagentRef
~~~~~~~~~~~~~~

-  SPW:ReagentRef(base = ``Reference``, type = ``ReagentRef``)

   -  SPW:ReagentRef:ID( ``ReagentID`` ) [1:1]

SPW:Plate
~~~~~~~~~

-  SPW:Plate(base = ``None``, type = ``Plate``) **from bio-formats**

   -  SPW:Plate:Status( ``xsd:string`` ) [0:1]
   -  SPW:Plate:Name( ``xsd:string`` ) [1:1] **from bio-formats**
   -  SPW:Plate:ExternalIdentifier( ``xsd:string`` ) [0:1]
   -  SPW:Plate:Screen\_BackReference( ``Screen`` ) [0:9999]
   -  SPW:Plate:Well( ``Well`` ) [0:99999]
   -  SPW:Plate:ScreenRef( ``ScreenRef`` ) [0:99999]
   -  SPW:Plate:ID( ``PlateID`` ) [1:1]
   -  SPW:Plate:Description( ``xsd:string`` ) [0:1]

SPW:ImageRef
~~~~~~~~~~~~

-  SPW:ImageRef(base = ``Reference``, type = ``ImageRef``)

   -  SPW:ImageRef:ID( ``OME:ImageID`` ) [1:1]

SPW:ScreenRef
~~~~~~~~~~~~~

-  SPW:ScreenRef(base = ``Reference``, type = ``ScreenRef``)

   -  SPW:ScreenRef:ID( ``ScreenID`` ) [1:1]

SPW:WellSampleRef
~~~~~~~~~~~~~~~~~

-  SPW:WellSampleRef(base = ``Reference``, type = ``WellSampleRef``)

   -  SPW:WellSampleRef:ID( ``WellSampleID`` ) [1:1]

SPW:ScreenAcquisition
~~~~~~~~~~~~~~~~~~~~~

-  SPW:ScreenAcquisition(base = ``None``, type = ``ScreenAcquisition``)

   -  SPW:ScreenAcquisition:EndTime( ``xsd:dateTime`` ) [0:1]
   -  SPW:ScreenAcquisition:WellSampleRef( ``WellSampleRef`` ) [0:99999]
   -  SPW:ScreenAcquisition:ID( ``ScreenAcquisitionID`` ) [1:1]
   -  SPW:ScreenAcquisition:StartTime( ``xsd:dateTime`` ) [0:1]

``CA:``
-------

CA:Dataset
~~~~~~~~~~

-  CA:Dataset(base = ``None``, type = ``Dataset``)

   -  CA:Dataset:Locked( ``xsd:boolean`` ) [0:1]
   -  CA:Dataset:Name( ``xsd:string`` ) [0:1]
   -  CA:Dataset:Image\_BackReference( ``Image`` ) [0:9999]
   -  CA:Dataset:ProjectRef( ``ProjectRef`` ) [0:99999]
   -  CA:Dataset:CustomAttributes( ``CustomAttributes`` ) [0:1]
   -  CA:Dataset:Experimenter( ``OME:ExperimenterID`` ) [0:1]
   -  CA:Dataset:Group( ``OME:GroupID`` ) [0:1]
   -  CA:Dataset:ID( ``OME:DatasetID`` ) [1:1]
   -  CA:Dataset:Description( ``xsd:string`` ) [0:1]

CA:Region
~~~~~~~~~

-  CA:Region(base = ``None``, type = ``Region``)

   -  CA:Region:Region( ``Region`` ) [0:99999]
   -  CA:Region:Tag( ``xsd:string`` ) [0:1]
   -  CA:Region:ID( ``OME:RegionID`` ) [1:1]
   -  CA:Region:CustomAttributes( ``CustomAttributes`` ) [0:1]
   -  CA:Region:Name( ``xsd:string`` ) [0:1]

CA:DatasetRef
~~~~~~~~~~~~~

-  CA:DatasetRef(base = ``None``, type = ``DatasetRef``)

   -  CA:DatasetRef:ID( ``OME:DatasetID`` ) [1:1]

CA:Project
~~~~~~~~~~

-  CA:Project(base = ``None``, type = ``Project``)

   -  CA:Project:Group( ``OME:GroupID`` ) [0:1]
   -  CA:Project:Name( ``xsd:string`` ) [0:1]
   -  CA:Project:Dataset\_BackReference( ``Dataset`` ) [0:9999]
   -  CA:Project:Experimenter( ``OME:ExperimenterID`` ) [0:1]
   -  CA:Project:ID( ``OME:ProjectID`` ) [1:1]
   -  CA:Project:Description( ``xsd:string`` ) [0:1]

CA:CustomAttributes
~~~~~~~~~~~~~~~~~~~

-  CA:CustomAttributes(base = ``None``, type = ``CustomAttributes``)

CA:OME
~~~~~~

-  CA:OME(base = ``None``, type = ``OME``)

   -  CA:OME:Project( ``Project`` ) [1:1]
   -  CA:OME:Image( ``Image`` ) [1:1]
   -  CA:OME:CustomAttributes( ``CustomAttributes`` ) [1:1]
   -  CA:OME:Dataset( ``Dataset`` ) [1:1]

CA:ProjectRef
~~~~~~~~~~~~~

-  CA:ProjectRef(base = ``None``, type = ``ProjectRef``)

   -  CA:ProjectRef:ID( ``OME:ProjectID`` ) [1:1]

CA:Image
~~~~~~~~

-  CA:Image(base = ``None``, type = ``Image``)

   -  CA:Image:Group( ``OME:GroupID`` ) [0:1]
   -  CA:Image:Description( ``xsd:string`` ) [0:1]
   -  CA:Image:Region( ``Region`` ) [0:99999]
   -  CA:Image:DatasetRef( ``DatasetRef`` ) [0:99999]
   -  CA:Image:DefaultPixels( ``OME:PixelsID`` ) [0:1]
   -  CA:Image:CustomAttributes( ``CustomAttributes`` ) [0:1]
   -  CA:Image:Experimenter( ``OME:ExperimenterID`` ) [0:1]
   -  CA:Image:CreationDate( ``xsd:dateTime`` ) [0:1]
   -  CA:Image:ID( ``OME:ImageID`` ) [1:1]
   -  CA:Image:Name( ``xsd:string`` ) [0:1]

``CLI:``
--------

CLI:Index
~~~~~~~~~

-  CLI:Index(base = ``None``, type = ``Index``)

   -  CLI:Index:Input( ``Input`` ) [1:99999]

CLI:PixelsInput
~~~~~~~~~~~~~~~

-  CLI:PixelsInput(base = ``None``, type = ``PixelsInput``)

   -  CLI:PixelsInput:SubstituteWith( ``xsd:string`` ) [1:1]

CLI:Output
~~~~~~~~~~

-  CLI:Output(base = ``None``, type = ``Output``)

   -  CLI:Output:AccessBy( ``xsd:integer`` ) [1:1]
   -  CLI:Output:OutputTo( ``OutputTo`` ) [1:99999]

CLI:SizeC
~~~~~~~~~

-  CLI:SizeC(base = ``None``, type = ``SizeC``)

   -  CLI:SizeC:Location( ``xsd:string`` ) [1:1]

CLI:XYPlane
~~~~~~~~~~~

-  CLI:XYPlane(base = ``None``, type = ``XYPlane``)

   -  CLI:XYPlane:theT( ``theT`` ) [1:1]
   -  CLI:XYPlane:Return( ``xsd:string`` ) [0:1]
   -  CLI:XYPlane:Format( ``xsd:string`` ) [0:1]
   -  CLI:XYPlane:BPP( ``xsd:string`` ) [0:1]
   -  CLI:XYPlane:theZ( ``theZ`` ) [1:1]
   -  CLI:XYPlane:theW( ``theW`` ) [1:1]
   -  CLI:XYPlane:XYPlaneID( ``xsd:string`` ) [0:1]
   -  CLI:XYPlane:Pixels( ``xsd:string`` ) [1:1]

CLI:STDOUT
~~~~~~~~~~

-  CLI:STDOUT(base = ``None``, type = ``STDOUT``)

   -  CLI:STDOUT:OutputRecord( ``OutputRecord`` ) [1:99999]

CLI:PixelType
~~~~~~~~~~~~~

-  CLI:PixelType(base = ``None``, type = ``PixelType``)

   -  CLI:PixelType:Location( ``xsd:string`` ) [1:1]

CLI:BitsPerPixel
~~~~~~~~~~~~~~~~

-  CLI:BitsPerPixel(base = ``None``, type = ``BitsPerPixel``)

   -  CLI:BitsPerPixel:Location( ``xsd:string`` ) [1:1]

CLI:Repository
~~~~~~~~~~~~~~

-  CLI:Repository(base = ``None``, type = ``Repository``)

   -  CLI:Repository:Location( ``xsd:string`` ) [1:1]

CLI:STDIN
~~~~~~~~~

-  CLI:STDIN(base = ``None``, type = ``STDIN``)

   -  CLI:STDIN:InputRecord( ``InputRecord`` ) [1:99999]

CLI:OutputRecord
~~~~~~~~~~~~~~~~

-  CLI:OutputRecord(base = ``None``, type = ``OutputRecord``)

   -  CLI:OutputRecord:RepeatCount( ``xsd:positiveInteger`` ) [0:1]
   -  CLI:OutputRecord:TerminateAt( ``xsd:string`` ) [0:1]

CLI:IterateRange
~~~~~~~~~~~~~~~~

-  CLI:IterateRange(base = ``None``, type = ``IterateRange``)

   -  CLI:IterateRange:Start( ``Start`` ) [1:1]
   -  CLI:IterateRange:End( ``End`` ) [1:1]
   -  CLI:IterateRange:OutputTo( ``OutputTo`` ) [1:99999]

CLI:Start
~~~~~~~~~

-  CLI:Start(base = ``None``, type = ``Start``)

CLI:InputSubString
~~~~~~~~~~~~~~~~~~

-  CLI:InputSubString(base = ``None``, type = ``InputSubString``)

   -  CLI:InputSubString:RawText( ``xsd:string`` ) [1:1]
   -  CLI:InputSubString:Input( ``Input`` ) [1:1]
   -  CLI:InputSubString:RawImageFilePath( ``RawImageFilePath`` ) [1:1]
   -  CLI:InputSubString:XYPlane( ``XYPlane`` ) [1:1]

CLI:DelimitedRecord
~~~~~~~~~~~~~~~~~~~

-  CLI:DelimitedRecord(base = ``None``, type = ``DelimitedRecord``)

   -  CLI:DelimitedRecord:FieldDelimiter( ``xsd:string`` ) [1:1]
   -  CLI:DelimitedRecord:Input( ``Input`` ) [1:99999]
   -  CLI:DelimitedRecord:RecordDelimiter( ``xsd:string`` ) [0:1]

CLI:CustomRecord
~~~~~~~~~~~~~~~~

-  CLI:CustomRecord(base = ``None``, type = ``CustomRecord``)

   -  CLI:CustomRecord:InputSubString( ``InputSubString`` ) [1:99999]

CLI:theZ
~~~~~~~~

-  CLI:theZ(base = ``None``, type = ``theZ``)

   -  CLI:theZ:UseValue( ``UseValue`` ) [1:1]
   -  CLI:theZ:IterateRange( ``IterateRange`` ) [1:1]
   -  CLI:theZ:Match( ``Match`` ) [1:1]
   -  CLI:theZ:AutoIterate( ``AutoIterate`` ) [1:1]

CLI:Parameter
~~~~~~~~~~~~~

-  CLI:Parameter(base = ``None``, type = ``Parameter``)

   -  CLI:Parameter:InputSubString( ``InputSubString`` ) [1:99999]

CLI:TempFile
~~~~~~~~~~~~

-  CLI:TempFile(base = ``None``, type = ``TempFile``)

   -  CLI:TempFile:OutputTo( ``OutputTo`` ) [0:99999]
   -  CLI:TempFile:Repository( ``xsd:string`` ) [0:1]
   -  CLI:TempFile:FileID( ``xsd:string`` ) [0:1]

CLI:theW
~~~~~~~~

-  CLI:theW(base = ``None``, type = ``theW``)

   -  CLI:theW:UseValue( ``UseValue`` ) [1:1]
   -  CLI:theW:IterateRange( ``IterateRange`` ) [1:1]
   -  CLI:theW:Match( ``Match`` ) [1:1]
   -  CLI:theW:AutoIterate( ``AutoIterate`` ) [1:1]

CLI:PixelOutput
~~~~~~~~~~~~~~~

-  CLI:PixelOutput(base = ``None``, type = ``PixelOutput``)

   -  CLI:PixelOutput:SizeT( ``SizeT`` ) [0:1]
   -  CLI:PixelOutput:Repository( ``Repository`` ) [0:1]
   -  CLI:PixelOutput:PixelType( ``PixelType`` ) [0:1]
   -  CLI:PixelOutput:BitsPerPixel( ``BitsPerPixel`` ) [0:1]
   -  CLI:PixelOutput:SizeX( ``SizeX`` ) [0:1]
   -  CLI:PixelOutput:SizeY( ``SizeY`` ) [0:1]
   -  CLI:PixelOutput:SizeZ( ``SizeZ`` ) [0:1]
   -  CLI:PixelOutput:FormalOutput( ``xsd:string`` ) [0:1]
   -  CLI:PixelOutput:SizeC( ``SizeC`` ) [0:1]
   -  CLI:PixelOutput:Path( ``Path`` ) [0:1]
   -  CLI:PixelOutput:type( ``xsd:string`` ) [0:1]
   -  CLI:PixelOutput:UseBase( ``xsd:string`` ) [0:1]

CLI:RawImageFilePath
~~~~~~~~~~~~~~~~~~~~

-  CLI:RawImageFilePath(base = ``None``, type = ``RawImageFilePath``)

   -  CLI:RawImageFilePath:Pixels( ``xsd:string`` ) [1:1]

CLI:theT
~~~~~~~~

-  CLI:theT(base = ``None``, type = ``theT``)

   -  CLI:theT:UseValue( ``UseValue`` ) [1:1]
   -  CLI:theT:IterateRange( ``IterateRange`` ) [1:1]
   -  CLI:theT:Match( ``Match`` ) [1:1]
   -  CLI:theT:AutoIterate( ``AutoIterate`` ) [1:1]

CLI:SizeX
~~~~~~~~~

-  CLI:SizeX(base = ``None``, type = ``SizeX``)

   -  CLI:SizeX:Location( ``xsd:string`` ) [1:1]

CLI:SizeY
~~~~~~~~~

-  CLI:SizeY(base = ``None``, type = ``SizeY``)

   -  CLI:SizeY:Location( ``xsd:string`` ) [1:1]

CLI:SizeZ
~~~~~~~~~

-  CLI:SizeZ(base = ``None``, type = ``SizeZ``)

   -  CLI:SizeZ:Location( ``xsd:string`` ) [1:1]

CLI:CommandLine
~~~~~~~~~~~~~~~

-  CLI:CommandLine(base = ``None``, type = ``CommandLine``)

   -  CLI:CommandLine:Parameter( ``Parameter`` ) [0:99999]

CLI:InputRecord
~~~~~~~~~~~~~~~

-  CLI:InputRecord(base = ``None``, type = ``InputRecord``)

   -  CLI:InputRecord:Index( ``Index`` ) [1:99999]
   -  CLI:InputRecord:CustomRecord( ``CustomRecord`` ) [1:1]
   -  CLI:InputRecord:DelimitedRecord( ``DelimitedRecord`` ) [1:1]

CLI:SizeT
~~~~~~~~~

-  CLI:SizeT(base = ``None``, type = ``SizeT``)

   -  CLI:SizeT:Location( ``xsd:string`` ) [1:1]

CLI:ExecutionInstructions
~~~~~~~~~~~~~~~~~~~~~~~~~

-  CLI:ExecutionInstructions(base = ``None``, type =
   ``ExecutionInstructions``)

   -  CLI:ExecutionInstructions:CommandLine( ``CommandLine`` ) [0:1]
   -  CLI:ExecutionInstructions:STDIN( ``STDIN`` ) [0:1]
   -  CLI:ExecutionInstructions:STDOUT( ``STDOUT`` ) [0:1]
   -  CLI:ExecutionInstructions:ExecutionPoint( ``xsd:string`` ) [1:1]
   -  CLI:ExecutionInstructions:MakesNewRegion( ``xsd:boolean`` ) [0:1]

CLI:AutoIterate
~~~~~~~~~~~~~~~

-  CLI:AutoIterate(base = ``None``, type = ``AutoIterate``)

   -  CLI:AutoIterate:OutputTo( ``OutputTo`` ) [1:99999]

CLI:Path
~~~~~~~~

-  CLI:Path(base = ``None``, type = ``Path``)

   -  CLI:Path:FileID( ``xsd:string`` ) [0:1]

CLI:UseValue
~~~~~~~~~~~~

-  CLI:UseValue(base = ``None``, type = ``UseValue``)

CLI:Match
~~~~~~~~~

-  CLI:Match(base = ``None``, type = ``Match``)

   -  CLI:Match:XYPlaneID( ``xsd:string`` ) [1:1]

CLI:OutputTo
~~~~~~~~~~~~

-  CLI:OutputTo(base = ``None``, type = ``OutputTo``)

CLI:End
~~~~~~~

-  CLI:End(base = ``None``, type = ``End``)

CLI:Input
~~~~~~~~~

-  CLI:Input(base = ``None``, type = ``Input``)

   -  CLI:Input:DivideBy( ``xsd:string`` ) [0:1]
   -  CLI:Input:MultiplyBy( ``xsd:string`` ) [0:1]

CLI: Conversion Problems
~~~~~~~~~~~~~~~~~~~~~~~~

-  Error. attributeGroup CLI:OutputLocation not defined.
-  Error. attributeGroup CLI:InputLocation not defined.

``AnalysisChain:``
------------------

AnalysisChain:Link
~~~~~~~~~~~~~~~~~~

-  AnalysisChain:Link(base = ``None``, type = ``Link``)

   -  AnalysisChain:Link:FromOutputName( ``xsd:string`` ) [1:1]
   -  AnalysisChain:Link:FromNodeID( ``xsd:string`` ) [1:1]
   -  AnalysisChain:Link:ToNodeID( ``xsd:string`` ) [1:1]
   -  AnalysisChain:Link:ToInputName( ``xsd:string`` ) [1:1]

AnalysisChain:Nodes
~~~~~~~~~~~~~~~~~~~

-  AnalysisChain:Nodes(base = ``None``, type = ``Nodes``)

   -  AnalysisChain:Nodes:Node( ``Node`` ) [0:99999]

AnalysisChain:AnalysisChains
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  AnalysisChain:AnalysisChains(base = ``None``, type =
   ``AnalysisChains``)

   -  AnalysisChain:AnalysisChains:AnalysisChain( ``AnalysisChain`` )
      [0:99999]

AnalysisChain:Links
~~~~~~~~~~~~~~~~~~~

-  AnalysisChain:Links(base = ``None``, type = ``Links``)

   -  AnalysisChain:Links:Link( ``Link`` ) [0:99999]

AnalysisChain:AnalysisChain
~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  AnalysisChain:AnalysisChain(base = ``None``, type =
   ``AnalysisChain``)

   -  AnalysisChain:AnalysisChain:Nodes( ``Nodes`` ) [1:1]
   -  AnalysisChain:AnalysisChain:Locked( ``xsd:boolean`` ) [0:1]
   -  AnalysisChain:AnalysisChain:Name( ``xsd:string`` ) [1:1]
   -  AnalysisChain:AnalysisChain:Links( ``Links`` ) [1:1]

AnalysisChain:Node
~~~~~~~~~~~~~~~~~~

-  AnalysisChain:Node(base = ``None``, type = ``Node``)

   -  AnalysisChain:Node:NewRegionTag( ``xsd:string`` ) [0:1]
   -  AnalysisChain:Node:NodeID( ``xsd:string`` ) [1:1]
   -  AnalysisChain:Node:ProgramName( ``xsd:string`` ) [1:1]
   -  AnalysisChain:Node:IteratorTag( ``xsd:string`` ) [0:1]

``AnalysisModule:``
-------------------

AnalysisModule:Installed
~~~~~~~~~~~~~~~~~~~~~~~~

-  AnalysisModule:Installed(base = ``None``, type = ``Installed``)

   -  AnalysisModule:Installed:location( ``xsd:string`` ) [1:1]

AnalysisModule:LookupTable
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  AnalysisModule:LookupTable(base = ``None``, type = ``LookupTable``)

   -  AnalysisModule:LookupTable:Entry( ``Entry`` ) [1:99999]
   -  AnalysisModule:LookupTable:Name( ``xsd:string`` ) [1:1]
   -  AnalysisModule:LookupTable:Description( ``Description`` ) [0:1]

AnalysisModule:FormalOutput
~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  AnalysisModule:FormalOutput(base = ``None``, type = ``FormalOutput``)

   -  AnalysisModule:FormalOutput:Count( ``xsd:string`` ) [0:1]
   -  AnalysisModule:FormalOutput:Description( ``Description`` ) [0:1]
   -  AnalysisModule:FormalOutput:Name( ``xsd:string`` ) [1:1]
   -  AnalysisModule:FormalOutput:IBelongTo( ``xsd:string`` ) [0:1]
   -  AnalysisModule:FormalOutput:SemanticTypeName( ``xsd:string`` )
      [0:1]

AnalysisModule:AnalysisModule
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  AnalysisModule:AnalysisModule(base = ``None``, type =
   ``AnalysisModule``)

   -  AnalysisModule:AnalysisModule:Category( ``xsd:string`` ) [0:1]
   -  AnalysisModule:AnalysisModule:ModuleName( ``xsd:string`` ) [0:1]
   -  AnalysisModule:AnalysisModule:RegionIterator( ``xsd:string`` )
      [0:1]
   -  AnalysisModule:AnalysisModule:Description( ``Description`` ) [0:1]
   -  AnalysisModule:AnalysisModule:NewRegionName( ``xsd:string`` )
      [0:1]
   -  AnalysisModule:AnalysisModule:ExecutionInstructions(
      ``ExecutionInstructions`` ) [1:1]
   -  AnalysisModule:AnalysisModule:ProgramID( ``xsd:string`` ) [1:1]
   -  AnalysisModule:AnalysisModule:isStreamAlgorithm( ``xsd:boolean`` )
      [0:1]
   -  AnalysisModule:AnalysisModule:Declaration( ``Declaration`` ) [1:1]
   -  AnalysisModule:AnalysisModule:ModuleType( ``xsd:string`` ) [1:1]
   -  AnalysisModule:AnalysisModule:ID( ``AML:ModuleID`` ) [1:1]

AnalysisModule:AnalysisModuleLibrary
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  AnalysisModule:AnalysisModuleLibrary(base = ``None``, type =
   ``AnalysisModuleLibrary``)

   -  AnalysisModule:AnalysisModuleLibrary:Category( ``Category`` )
      [0:99999]
   -  AnalysisModule:AnalysisModuleLibrary:Program( ``Program`` )
      [0:99999]
   -  AnalysisModule:AnalysisModuleLibrary:AnalysisModule(
      ``AnalysisModule`` ) [1:99999]

AnalysisModule:Category
~~~~~~~~~~~~~~~~~~~~~~~

-  AnalysisModule:Category(base = ``None``, type = ``Category``)

   -  AnalysisModule:Category:Path( ``xsd:string`` ) [1:1]
   -  AnalysisModule:Category:Description( ``Description`` ) [1:1]

AnalysisModule:Entry
~~~~~~~~~~~~~~~~~~~~

-  AnalysisModule:Entry(base = ``None``, type = ``Entry``)

   -  AnalysisModule:Entry:Value( ``xsd:string`` ) [1:1]
   -  AnalysisModule:Entry:Label( ``xsd:string`` ) [0:1]

AnalysisModule:Program
~~~~~~~~~~~~~~~~~~~~~~

-  AnalysisModule:Program(base = ``None``, type = ``Program``)

   -  AnalysisModule:Program:Name( ``xsd:string`` ) [0:1]
   -  AnalysisModule:Program:InstallationFile( ``InstallationFile`` )
      [1:1]
   -  AnalysisModule:Program:InstallationScript( ``InstallationScript``
      ) [1:1]
   -  AnalysisModule:Program:Installed( ``Installed`` ) [1:1]
   -  AnalysisModule:Program:ProgramID( ``xsd:string`` ) [1:1]
   -  AnalysisModule:Program:Version( ``xsd:string`` ) [0:1]

AnalysisModule:InstallationScript
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  AnalysisModule:InstallationScript(base = ``None``, type =
   ``InstallationScript``)

   -  AnalysisModule:InstallationScript:BinaryFile( ``xsd:string`` )
      [1:1]

AnalysisModule:InstallationFile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  AnalysisModule:InstallationFile(base = ``None``, type =
   ``InstallationFile``)

   -  AnalysisModule:InstallationFile:BinaryFile( ``xsd:string`` ) [1:1]
   -  AnalysisModule:InstallationFile:Format( ``xsd:string`` ) [0:1]

AnalysisModule:FormalInput
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  AnalysisModule:FormalInput(base = ``None``, type = ``FormalInput``)

   -  AnalysisModule:FormalInput:Count( ``xsd:string`` ) [0:1]
   -  AnalysisModule:FormalInput:Description( ``Description`` ) [0:1]
   -  AnalysisModule:FormalInput:UserDefined( ``xsd:boolean`` ) [0:1]
   -  AnalysisModule:FormalInput:LookupTable( ``LookupTable`` ) [0:1]
   -  AnalysisModule:FormalInput:SemanticTypeName( ``xsd:string`` )
      [1:1]
   -  AnalysisModule:FormalInput:Name( ``xsd:string`` ) [1:1]

AnalysisModule:Declaration
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  AnalysisModule:Declaration(base = ``None``, type = ``Declaration``)

   -  AnalysisModule:Declaration:FormalInput( ``FormalInput`` )
      [0:99999]
   -  AnalysisModule:Declaration:FormalOutput( ``FormalOutput`` )
      [0:99999]

``BinaryFile:``
---------------

BinaryFile:External
~~~~~~~~~~~~~~~~~~~

-  BinaryFile:External(base = ``None``, type = ``External``)

   -  BinaryFile:External:href( ``xsd:anyURI`` ) [1:1]
   -  BinaryFile:External:Compression( ``xsd:string`` ) [0:1]
   -  BinaryFile:External:SHA1( ``Bin:Hex40`` ) [1:1]

BinaryFile:BinData
~~~~~~~~~~~~~~~~~~

-  BinaryFile:BinData(base = ``None``, type = ``BinData``)

   -  BinaryFile:BinData:Length( ``xsd:string`` ) [1:1]
   -  BinaryFile:BinData:Compression( ``xsd:string`` ) [0:1]

BinaryFile:BinaryFile
~~~~~~~~~~~~~~~~~~~~~

-  BinaryFile:BinaryFile(base = ``None``, type = ``BinaryFile``)

   -  BinaryFile:BinaryFile:FileName( ``xsd:string`` ) [1:1]
   -  BinaryFile:BinaryFile:BinData( ``BinData`` ) [1:1]
   -  BinaryFile:BinaryFile:External( ``External`` ) [1:1]
   -  BinaryFile:BinaryFile:Size( ``xsd:integer`` ) [1:1]

``DataHistory:``
----------------

DataHistory:Output
~~~~~~~~~~~~~~~~~~

-  DataHistory:Output(base = ``None``, type = ``Output``)

   -  DataHistory:Output:AttributeRef( ``AttributeRef`` ) [0:99999]
   -  DataHistory:Output:Name( ``xsd:string`` ) [1:1]

DataHistory:ExecutionHistory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  DataHistory:ExecutionHistory(base = ``None``, type =
   ``ExecutionHistory``)

   -  DataHistory:ExecutionHistory:Status( ``xsd:string`` ) [1:1]
   -  DataHistory:ExecutionHistory:AttributeCreateTime( ``xsd:string`` )
      [0:1]
   -  DataHistory:ExecutionHistory:Timestamp( ``xsd:string`` ) [1:1]
   -  DataHistory:ExecutionHistory:ErrorMessage( ``xsd:string`` ) [0:1]
   -  DataHistory:ExecutionHistory:RunTime( ``xsd:string`` ) [1:1]
   -  DataHistory:ExecutionHistory:AttributeSortTime( ``xsd:string`` )
      [0:1]

DataHistory:ModuleExecution
~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  DataHistory:ModuleExecution(base = ``None``, type =
   ``ModuleExecution``)

   -  DataHistory:ModuleExecution:ExecutionHistory( ``ExecutionHistory``
      ) [1:1]
   -  DataHistory:ModuleExecution:Dependence( ``xsd:string`` ) [1:1]
   -  DataHistory:ModuleExecution:Output( ``Output`` ) [0:99999]
   -  DataHistory:ModuleExecution:Input( ``Input`` ) [0:99999]
   -  DataHistory:ModuleExecution:ID( ``xsd:string`` ) [1:1]
   -  DataHistory:ModuleExecution:DatasetID( ``OME:DatasetID`` ) [1:1]
   -  DataHistory:ModuleExecution:ModuleID( ``OME:ModuleID`` ) [1:1]

DataHistory:Input
~~~~~~~~~~~~~~~~~

-  DataHistory:Input(base = ``None``, type = ``Input``)

   -  DataHistory:Input:ModuleExecutionID( ``xsd:string`` ) [0:1]
   -  DataHistory:Input:Name( ``xsd:string`` ) [1:1]

DataHistory:AttributeRef
~~~~~~~~~~~~~~~~~~~~~~~~

-  DataHistory:AttributeRef(base = ``None``, type = ``AttributeRef``)

   -  DataHistory:AttributeRef:ID( ``xsd:string`` ) [1:1]

DataHistory:DataHistory
~~~~~~~~~~~~~~~~~~~~~~~

-  DataHistory:DataHistory(base = ``None``, type = ``DataHistory``)

   -  DataHistory:DataHistory:ModuleExecution( ``ModuleExecution`` )
      [1:99999]

``MLI:``
--------

MLI:VectorDecoder
~~~~~~~~~~~~~~~~~

-  MLI:VectorDecoder(base = ``None``, type = ``VectorDecoder``)

   -  MLI:VectorDecoder:ID( ``xsd:string`` ) [1:1]
   -  MLI:VectorDecoder:Element( ``Element`` ) [1:99999]

MLI:FunctionInputs
~~~~~~~~~~~~~~~~~~

-  MLI:FunctionInputs(base = ``None``, type = ``FunctionInputs``)

   -  MLI:FunctionInputs:Input( ``Input`` ) [1:99999]

MLI:Scalar
~~~~~~~~~~

-  MLI:Scalar(base = ``None``, type = ``Scalar``)

   -  MLI:Scalar:InputLocation( ``xsd:string`` ) [1:1]
   -  MLI:Scalar:ConvertToDatatype( ``xsd:string`` ) [0:1]

MLI:Input
~~~~~~~~~

-  MLI:Input(base = ``None``, type = ``Input``)

   -  MLI:Input:Scalar( ``Scalar`` ) [1:1]
   -  MLI:Input:PixelsArray( ``PixelsArray`` ) [1:1]
   -  MLI:Input:ConstantScalar( ``ConstantScalar`` ) [1:1]

MLI:Element
~~~~~~~~~~~

-  MLI:Element(base = ``None``, type = ``Element``)

   -  MLI:Element:UseTemplate( ``xsd:string`` ) [0:1]
   -  MLI:Element:Index( ``xsd:string`` ) [1:1]
   -  MLI:Element:OutputLocation( ``xsd:string`` ) [1:1]
   -  MLI:Element:ID( ``xsd:string`` ) [0:1]
   -  MLI:Element:ConvertToDatatype( ``xsd:string`` ) [0:1]

MLI:Output
~~~~~~~~~~

-  MLI:Output(base = ``None``, type = ``Output``)

   -  MLI:Output:Scalar( ``Scalar`` ) [1:1]
   -  MLI:Output:Vector( ``Vector`` ) [1:1]
   -  MLI:Output:PixelsArray( ``PixelsArray`` ) [1:1]
   -  MLI:Output:Struct( ``Struct`` ) [1:1]

MLI:Vector
~~~~~~~~~~

-  MLI:Vector(base = ``None``, type = ``Vector``)

   -  MLI:Vector:DecodeWith( ``xsd:string`` ) [1:1]

MLI:ExecutionInstructions
~~~~~~~~~~~~~~~~~~~~~~~~~

-  MLI:ExecutionInstructions(base = ``None``, type =
   ``ExecutionInstructions``)

   -  MLI:ExecutionInstructions:Templates( ``Templates`` ) [0:1]
   -  MLI:ExecutionInstructions:FunctionInputs( ``FunctionInputs`` )
      [1:1]
   -  MLI:ExecutionInstructions:VectorDecoder( ``VectorDecoder`` )
      [0:99999]
   -  MLI:ExecutionInstructions:ExecutionGranularity( ``xsd:string`` )
      [1:1]
   -  MLI:ExecutionInstructions:FunctionOutputs( ``FunctionOutputs`` )
      [1:1]

MLI:FunctionOutputs
~~~~~~~~~~~~~~~~~~~

-  MLI:FunctionOutputs(base = ``None``, type = ``FunctionOutputs``)

   -  MLI:FunctionOutputs:Output( ``Output`` ) [1:99999]

MLI:PixelsArray
~~~~~~~~~~~~~~~

-  MLI:PixelsArray(base = ``None``, type = ``PixelsArray``)

   -  MLI:PixelsArray:FormalInput( ``xsd:string`` ) [1:1]
   -  MLI:PixelsArray:ID( ``xsd:string`` ) [0:1]
   -  MLI:PixelsArray:ConvertToDatatype( ``xsd:string`` ) [0:1]

MLI:Scalar
~~~~~~~~~~

-  MLI:Scalar(base = ``None``, type = ``Scalar``)

   -  MLI:Scalar:UseTemplate( ``xsd:string`` ) [0:1]
   -  MLI:Scalar:OutputLocation( ``xsd:string`` ) [1:1]
   -  MLI:Scalar:ConvertToDatatype( ``xsd:string`` ) [0:1]

MLI:PixelsArray
~~~~~~~~~~~~~~~

-  MLI:PixelsArray(base = ``None``, type = ``PixelsArray``)

   -  MLI:PixelsArray:ID( ``xsd:string`` ) [0:1]
   -  MLI:PixelsArray:FormalOutput( ``xsd:string`` ) [1:1]
   -  MLI:PixelsArray:ConvertToDatatype( ``xsd:string`` ) [0:1]

MLI:Struct
~~~~~~~~~~

-  MLI:Struct(base = ``None``, type = ``Struct``)

   -  MLI:Struct:ID( ``xsd:string`` ) [0:1]
   -  MLI:Struct:FormalOutput( ``xsd:string`` ) [1:1]

MLI:ConstantScalar
~~~~~~~~~~~~~~~~~~

-  MLI:ConstantScalar(base = ``None``, type = ``ConstantScalar``)

   -  MLI:ConstantScalar:Value( ``xsd:string`` ) [1:1]

MLI:Templates
~~~~~~~~~~~~~

-  MLI:Templates(base = ``None``, type = ``Templates``)

``SA:``
-------

SA:CommonAnnotation
~~~~~~~~~~~~~~~~~~~

-  SA:CommonAnnotation(base = ``None``, type = ``CommonAnnotation``)

   -  SA:CommonAnnotation:Link( ``Link`` ) [1:99999]
   -  SA:CommonAnnotation:Namespace( ``xsd:anyURI`` ) [1:1]
   -  SA:CommonAnnotation:ID( ``AnnotationID`` ) [1:1]

SA:Link
~~~~~~~

-  SA:Link(base = ``None``, type = ``Link``)

SA:SvgAnnotation
~~~~~~~~~~~~~~~~

-  SA:SvgAnnotation(base = ``CommonAnnotation``, type =
   ``SvgAnnotation``)

   -  SA:SvgAnnotation:stroke-linejoin( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:font-size( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:baseline-shift( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:color-rendering( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:fill-opacity( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:letter-spacing( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:word-spacing( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:stroke( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:stroke-linecap( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:stroke-width( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:font-style( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:fill( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:fill-rule( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:kerning( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:stroke-miterlimit( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:alignment-baseline( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:glyph-orientation-horizontal( ``xsd:string`` )
      [0:1]
   -  SA:SvgAnnotation:font-weight( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:opacity( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:direction( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:font-variant( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:glyph-orientation-vertical( ``xsd:string`` )
      [0:1]
   -  SA:SvgAnnotation:font-adjust( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:unicode-bidi( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:font-strech( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:dominant-baseline( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:font-family( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:rotate( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:marker-end( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:stroke-opacity( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:stroke-dashoffset( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:text-anchor( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:text-decoration( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:stroke-dasharray( ``xsd:string`` ) [0:1]
   -  SA:SvgAnnotation:color-interpolation( ``xsd:string`` ) [0:1]

SA:TextAnnotation
~~~~~~~~~~~~~~~~~

-  SA:TextAnnotation(base = ``CommonAnnotation``, type =
   ``TextAnnotation``)

   -  SA:TextAnnotation:TextType( ``xsd:string`` ) [1:1]
   -  SA:TextAnnotation:Value( ``xsd:string`` ) [1:1]

SA:StructuredAnnotations
~~~~~~~~~~~~~~~~~~~~~~~~

-  SA:StructuredAnnotations(base = ``None``, type =
   ``StructuredAnnotations``)

   -  SA:StructuredAnnotations:FileAnnotation( ``FileAnnotation`` )
      [1:1]
   -  SA:StructuredAnnotations:TextAnnotation( ``TextAnnotation`` )
      [1:1]
   -  SA:StructuredAnnotations:SvgAnnotation( ``SvgAnnotation`` ) [1:1]
   -  SA:StructuredAnnotations:LongAnnotation( ``LongAnnotation`` )
      [1:1]
   -  SA:StructuredAnnotations:DoubleAnnotation( ``DoubleAnnotation`` )
      [1:1]
   -  SA:StructuredAnnotations:ListAnnotation( ``ListAnnotation`` )
      [1:1]
   -  SA:StructuredAnnotations:BooleanAnnotation( ``BooleanAnnotation``
      ) [1:1]
   -  SA:StructuredAnnotations:TimestampAnnotation(
      ``TimestampAnnotation`` ) [1:1]

SA:LongAnnotation
~~~~~~~~~~~~~~~~~

-  SA:LongAnnotation(base = ``CommonAnnotation``, type =
   ``LongAnnotation``)

   -  SA:LongAnnotation:Value( ``xsd:long`` ) [1:1]

SA:ListAnnotation
~~~~~~~~~~~~~~~~~

-  SA:ListAnnotation(base = ``CommonAnnotation``, type =
   ``ListAnnotation``)

   -  SA:ListAnnotation:List( ``List`` ) [1:1]

SA:BooleanAnnotation
~~~~~~~~~~~~~~~~~~~~

-  SA:BooleanAnnotation(base = ``CommonAnnotation``, type =
   ``BooleanAnnotation``)

   -  SA:BooleanAnnotation:Value( ``xsd:boolean`` ) [1:1]

SA:DoubleAnnotation
~~~~~~~~~~~~~~~~~~~

-  SA:DoubleAnnotation(base = ``CommonAnnotation``, type =
   ``DoubleAnnotation``)

   -  SA:DoubleAnnotation:Value( ``xsd:double`` ) [1:1]

SA:TimestampAnnotation
~~~~~~~~~~~~~~~~~~~~~~

-  SA:TimestampAnnotation(base = ``CommonAnnotation``, type =
   ``TimestampAnnotation``)

   -  SA:TimestampAnnotation:Value( ``xsd:dateTime`` ) [1:1]

SA:List
~~~~~~~

-  SA:List(base = ``None``, type = ``List``)

   -  SA:List:Link( ``Link`` ) [1:99999]

SA:FileAnnotation
~~~~~~~~~~~~~~~~~

-  SA:FileAnnotation(base = ``CommonAnnotation``, type =
   ``FileAnnotation``)

   -  SA:FileAnnotation:MimeType( ``xsd:string`` ) [0:1]
   -  SA:FileAnnotation:ExternalFile( ``xsd:string`` ) [1:1]
   -  SA:FileAnnotation:BinData( ``BinData`` ) [1:1]
   -  SA:FileAnnotation:FileName( ``xsd:string`` ) [1:1]

``STD:``
--------

STD:Element
~~~~~~~~~~~

-  STD:Element(base = ``None``, type = ``Element``)

   -  STD:Element:Description( ``Description`` ) [0:99999]
   -  STD:Element:DataType( ``xsd:string`` ) [1:1]
   -  STD:Element:DBLocation( ``xsd:string`` ) [0:1]
   -  STD:Element:RefersTo( ``xsd:string`` ) [0:1]
   -  STD:Element:Label( ``Label`` ) [0:99999]
   -  STD:Element:Name( ``xsd:string`` ) [1:1]

STD:SemanticType
~~~~~~~~~~~~~~~~

-  STD:SemanticType(base = ``None``, type = ``SemanticType``)

   -  STD:SemanticType:Description( ``Description`` ) [0:99999]
   -  STD:SemanticType:Parent( ``xsd:string`` ) [0:1]
   -  STD:SemanticType:AppliesTo( ``xsd:string`` ) [1:1]
   -  STD:SemanticType:Element( ``Element`` ) [1:99999]
   -  STD:SemanticType:Label( ``Label`` ) [0:99999]
   -  STD:SemanticType:Name( ``xsd:string`` ) [1:1]

STD:SemanticTypeDefinitions
~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  STD:SemanticTypeDefinitions(base = ``None``, type =
   ``SemanticTypeDefinitions``)

   -  STD:SemanticTypeDefinitions:SemanticType( ``SemanticType`` )
      [1:99999]

STD:Label
~~~~~~~~~

-  STD:Label(base = ``None``, type = ``Label``)

   -  STD:Label:lang( ``xsd:string`` ) [0:1]

STD:Description
~~~~~~~~~~~~~~~

-  STD:Description(base = ``None``, type = ``Description``)

   -  STD:Description:lang( ``xsd:string`` ) [0:1]

Deprecated Page

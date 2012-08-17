NOTE: FINAL PROPOSAL (Nov-06) Reviewed May-07

Items marked as **done** have been applied to the XSD schema files and
will be in the working directory of the OME-XML svn repository. Please
address and questions to ajpatterson@…

Goal
~~~~

-  Update the specification of OME-XML, and associated software, to
   include support for new tech, while also fixing some of the things we
   have come across.
-  get a complete characterisation of the hardware, for release as
   sample files, so that someone else could reconstruct your instrument
   from the OME-XML.

Actions
~~~~~~~

-  We would like to publish some example OME-XML files describing a
   microscope, but will need feedback from other developers.
   Unfortunately, Sample.ome is full of dummy data. OME-XML file that
   describes: Bio-Rad radiance (Jason's), Zeiss meta, Olympus Fluoview,
   etc. This includes both canned hardware settings, and variable
   experimental parameters known by the acquisition software.
-  Similarly, an attempt to replicate a notebook would need to
   transcribe a physical notebook into OME-XML.
-  Would like an OME-XML website that has version numbers of the
   specification. Describes version differences. Provides sample data,
   including hardware characterisations mentioned above. Form for
   requesting additional metadata fields.
-  Look carefully at OME-XML mappings in Bio-Formats. Verify correctness
   compared to existing implementations in the wild, such as Bitplane
   and Applied Precision.
-  Move to a regular update of OME-XML. During our characterisation, we
   will undoubtedly run across additional new fields. Need policy for
   adding these in a timely manner.
-  As of Jan 2007, staff at Dundee will take initial crack at this (with
   input from all).
-  Declare a "mini-OME-XML" (see below)

Implementation plan:
~~~~~~~~~~~~~~~~~~~~

-  Specification: Dec 2006
-  Rewrite of OME-XML and associated docs at openmicroscopy.org: March
   2007
-  BioFormats Updates: March 2007
-  Example files: April 2007
-  OME XML 2.0 Validator: April 2007

-  Implementation Progress:
-  Review of Specification: May 2007
-  Rewrite of OME-XML: May 2007

A Minimum Spec:
~~~~~~~~~~~~~~~

We have been asked by many academic and commercial parties to supply a
minimum spec of what metadata should be included with an image. There
are two views on this:

-  We define some subset of OME-XML as mandatory. This presumes there
   are tools and policies to define, edit and validate these entries
   (various versions are being developed by ourselves and others, but
   none is yet available).
-  We define the absolute minimum info that is required to read a 5D
   image-- x, y, z, c, t dimensions, and datatype, but specify that this
   information must be stored as OME-XML, preferably as an
   ` OME-TIFF <http://loci.wisc.edu/ome/ome-tiff.html>`_ file. This gets
   people using OME-TIFF, which then sets the stage for tools for
   filling out image metadata.

Our strong preference is to implement the second choice, and provide
tools (for example,
` Bio-Formats <http://loci.wisc.edu/ome/formats.html>`_ ) that make it
easy to more fully fill out metadata. This minimum spec is called
**mini-OME-XML**

--------------

Proposed Updates
~~~~~~~~~~~~~~~~

Base Data Model Changes
^^^^^^^^^^^^^^^^^^^^^^^

General
'''''''

-  OME-XML could use a character count attribute ('Length') as part of
   the BinData field - **done**

This is the length of the base 64 encoded block. It allows easy skipping
to the block when parsing the file.

Repositories (ST)
'''''''''''''''''

-  Remove field "path"

   -  With the migration to the image server technology, this field is
      no longer required.

-  Remove field "is\_local"

   -  As above, the migration to the image server technology makes this
      field unneeded.

Project (Base Type)
'''''''''''''''''''

-  Remove field "view"

   -  The field "view" is unused, non-existent in the XML specification
      and also unreferenced in the Perl documentation.

Thumbnails (ST)
'''''''''''''''

-  Removing this was discussed, however is agreed to support this to
   fully support many commercial file formats ( LSM, liff, etc.).
-  We expect this to be implemented in OME-XML; however is likely that
   OMEIS will generate its own thumbnails.

--------------

Acquisition Info
^^^^^^^^^^^^^^^^

OME
'''

-  version number attribute - namespace OK, new version 2.0-RC1 (=> 2.0)
-  We will move to the standard use of namespace to show major version
   and attribute "version" (1, 2, 3, etc.) to show a minor version
   change - **done**
-  A new URI will be used for new major versions.
-  The new URI for the new version will be
   http://www.openmicroscopy.org/XMLschemas/[NameSpaceTitle]/[YearAsFourDigits]-[MonthAsTwoDigits]
   - **done** (Appropriate pages need to be added to the web site do
   ensure there is the correct information on the page that is linked
   to.)

e.g. for OME file http://www.openmicroscopy.org/XMLschemas/OME/2007-06

ChannelInfo
'''''''''''

-  Add NonLinear to IlluminationType enum. - **done**
-  Add to LogicalChannel SecondaryEmmisionFilterRef (optional) -
   **done**
-  Add to LogicalChannel SecondaryExcitationFilterRef (optional) -
   **done**
-  Add 'Other' to Mode enum. - **done**
-  Detector, add Zoom (used on confocals) as Attribute. Update the Type
   to handle EM-CCD and APD, and CMOS detectors. EM-CCD Type needs an
   Attribute, Amplification-Gain - **done**
-  Standardise name to LogicalChannel (previously ChannelInfo) -
   **done**

Laser
'''''

-  relative power vs absolute (e.g., pockel cell, taps)
-  Add PockelCell (Bool) to Laser Attributes - **done**
-  Add PockelCellSetting (integer) to LogicalChannel - **done**
-  Add RepetitionRate - **done**
-  FrequencyDoubled (boolean) replaced by FrequencyMultiplication:
   integer. default value 1. - **done**
-  Pump is a reference to a light-source, which can be one of three
   types (pump is laser)... so, should there be a separate laser entry
   \*just\* to describe the pump and its power, vs the actual laser to
   which the pump corresponds?
-  Any LightSource can be used as Pump for laser - **done**
-  Add to Experiment/Type? enum: Photobleaching - **done**
-  Remove AuxLightSource and AuxLightSourceRef - **done**

Objective
'''''''''

-  LensNA, Magnification => attribute (Delete Magnification and replace
   with NomimalMagnification:integer and CalibratedMagnification:float)
   - **done**
-  ImmersionType (attr, enum: Oil, Water, Water Dipping, Air, Multi,
   Glycerol, Other) - **done**
-  Correction (Attribute, enum: UV, plan fluor, plan apo, superfluor,
   (VioletCorrected)) (was Coating) - **done**
-  WorkingDistance (float, units: um) - **done**

ObjectiveRef
''''''''''''

-  New Attributes: ?CorrectionCollar (float), ?Medium (enum: Air, Oil,
   Water, Glycerol) , ?RefractiveIndex (float, unit-less; it is a ratio)
   - **done**

Pixels
''''''

-  TiffData Element (this is documented on the ome tiff page
   ` http://loci.wisc.edu/ome/ome-tiff-spec.html <http://loci.wisc.edu/ome/ome-tiff-spec.html>`_),
   Attributes IFD, NumPlanes, FirstZ, FirstC, FirstT

FilterSet
'''''''''

-  ManufactSpec
-  DicroicRef - element
-  EmmisionRef - element
-  ExcitationRef - element
-  Id

Filters
'''''''

-  Purpose is to support customised sets of filters. Filter element and
   LogicalChannel contains other elements useful for common filter sets
-  TransmittanceRange (arity \*) (Attr: 1CutIn, 1CutOut,
   ?CutInTolerance, ?CutOutTolerance, 1Transmittance) - **done**

   -  Transmittance: PercentFraction; CutIn, CutOut: integer, nm;
      Tolerance: integer, nm - **done**

-  LotNumber is optional - **done**
-  Add FilterWheel : string. This is not the same as a FilterSet -
   FilterWheel can be a filter slider or any other shaped holder. -
   **done**
-  multiple wheels
-  custom filters: need to know attributes of the filter (not just
   manufacturer, model & lot) — band pass, short pass, long pass, narrow
   band, cut on and cut off, possibly others

DetectorRef (Dundee) (combined with other DetectorRef from Laser above)
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

-  Add Voltage (Units: MHz) attributes to DetectorRef - **done**
-  ReadOutRate (float). The speed at which a detector can count the
   pixels. Unit MHz. This is a figure of the bytes per second that data
   can flow from the detector.- **done**
-  Binning: string. Represents the number of pixels that are combined to
   form larger pixels. It can be one out of a predefined list: 1x1, 2x2,
   4x4 or 8x8. - **done**

Image/Experiment? relationship (Dundee)
'''''''''''''''''''''''''''''''''''''''

-  First Step was to Rename Operation to MicrobeamManipulation - this
   change has also been applied to this block of this documentation -
   **done**
-  Add new Element to Image (MicrobeamManipulation),
   MicrobeamManipulation/ROI (Use existing ROI for the moment)
   (arity:?), MicrobeamManipulation/ExperimentRef (arity: 1), Move
   ChannelInfo/AuxLightSource to MicrobeamManipulation/LightSourceRef
   (arity \*) - **done**
-  Add MicrobeamManipulationID - **done**
-  Add an ID to ROI - **done**
-  Add ROI to Image - **done** (ROI is now valid in both Image and
   DisplayOptions)
-  Add ROIRef - **done**
-  Add ROIId - **done**
-  Move to new Experiment Type - **done**

   -  enumeration value="FRAP" - **done**
   -  enumeration value="Photoablation" - **done**
   -  enumeration value="Photoactivation" - **done**
   -  enumeration value="Uncaging" - **done**
   -  enumeration value="OpticalTrapping" - **done**
   -  enumeration value="Other" - **done**

-  Experiment's Type attribute gets converted to an element to allow
   more than one term to describe an experiment. - **not done** Change
   unnecessary as already a list type so more than one term can be
   included
-  ExperimentRef gets a new MicrobeamManipulationRef type that describes
   what ROI of the image was shot with a laser during the operation.-
   **not done** Change not compatible wit other changes above. Also, the
   region shot by the laser is already expressed as part of the
   MicrobeamManipulation of the Image.

Naming convention for enumerations. (Dundee)
''''''''''''''''''''''''''''''''''''''''''''

-  Usage of capital letter e.g. monochrome, Laser Scanning Confocal.
   Will prefer: Monochrome, LaserScanningConfocal.
-  Write a naming conventions: CamelCase, letters & numbers only, no
   spaces and the dash '-' is only permitted punctuation character ('e-'
   is allowed)

Plane (optional)
''''''''''''''''

-  Added to replace PlaneAcquisitionInfo which was removed - **done**
-  PixelsRef - **not done** What is this used for?
-  TheZ: int - **done**
-  TheT: int - **done**
-  TheC: int - **done**
-  New type PlaneTiming inside Plane - **done**

   -  DeltaT: float Units: Seconds since begining of expriment -
      **done**
   -  ExposureTime: float Units: Seconds - **done**

-  New type StagePosition inside Plane - **done**

   -  PositionX: float (all units in the microscope referance frame) -
      **done**
   -  PositionY: float - **done**
   -  PositionZ: float - **done**

--------------

Pixels Related Data Model Changes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 Issues:

-  Want to allow multiple Pixels in an Image to have different sizes,
   data types, etc. One example-- a 3D image is projected, and the
   result is stored as a new Pixels. Note, the Image::Pixels concept is
   not at all standard in the community (we have a hard enough time
   convincing people a 5D Image is singular!!!
-  We must distinguish between the Acquired Pixels and any Derived sets
   of Pixels. - **done**
-  Extend Pixels, to include types for PhysicalSizeX, PhysicalSizeY,
   PhysicalSizeZ, TimeIncrement, WaveStart, WaveIncrement. - **done**
-  Remove PixelSizeX, PixelSizeY, PixelSizeZ, TimeIncrement, WaveStart,
   WaveIncrement from Image. - **done**
-  Add AcquiredPixelsRef to Image (make nullable) - **done**

-  (Clarify the Image<->Pixels relation)
-  (Make Multi-Modal - but not this time)

--------------

Images (Base Type)
^^^^^^^^^^^^^^^^^^

Make "DefaultPixels" field required in Image - **done**
'''''''''''''''''''''''''''''''''''''''''''''''''''''''

-  As we will want to make a transition away from directly relating
   metadata to an image there should be no cases where there is an
   "image" object and no corresponding default pixels.

--------------

Features renaming
^^^^^^^^^^^^^^^^^

Rename **Features** as **Regions** to make consistent with other fields.
- **done** but also - **not done** in Analysis Chain, Analysis Module or
CLI as Feature used in different context.

--------------

Screening Data Model
^^^^^^^^^^^^^^^^^^^^

 As has been discussed at length now, we need a better data model to
support screening. With the input of our colleagues at MIT, Dresden and
other institutions we have come up with a new data model to support
high-content screening. Diagrams are available in ` various
formats <http://git.openmicroscopy.org/src/master/components/specification/Documentation/Diagrams/Historic/DataModel2006Proposal/>`_.
Implementation will take some work to sort out inconsistencies with
Plate and Well in current model.

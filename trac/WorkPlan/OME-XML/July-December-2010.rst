General ongoing tasks
~~~~~~~~~~~~~~~~~~~~~

-  Model changes for codegen and transforms
-  web site updates

Modes I think we have support for now
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  ExperimentType:Colocalization
-  ExperimentType:Electrophysiology
-  ExperimentType:FISH
-  ExperimentType:FRET
-  ExperimentType:Immunocytochemistry
-  ExperimentType:Immunofluorescence
-  ExperimentType:IonImaging
-  ExperimentType:Photobleaching
-  ExperimentType:Screen
-  ContrastMethod:Brightfield
-  ContrastMethod:Darkfield
-  ContrastMethod:Fluorescence
-  ContrastMethod:HoffmanModulation
-  ContrastMethod:PolarizedLight
-  ContrastMethod:Phase
-  AcquisitionMode:FluorescenceCorrelationSpectroscopy
-  AcquisitionMode:LaserScanningConfocalMicroscopy
-  AcquisitionMode:LCM
-  AcquisitionMode:MultiPhotonMicroscopy
-  AcquisitionMode:NearFieldScanningOpticalMicroscopy
-  AcquisitionMode:PALM
-  AcquisitionMode:SecondHarmonicGenerationImaging
-  AcquisitionMode:SingleMoleculeImaging
-  AcquisitionMode:SlitScanConfocal
-  AcquisitionMode:SpinningDiskConfocal
-  AcquisitionMode:STED
-  AcquisitionMode:STORM
-  AcquisitionMode:WideField

Modes we need N-Dim for
~~~~~~~~~~~~~~~~~~~~~~~

-  ExperimentType:FluorescenceLifetime
-  ExperimentType:SpectralImaging
-  AcquisitionMode:FluorescenceLifetime
-  AcquisitionMode:SpectralImaging

Modes we need other additions for
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  AcquisitionMode:SPIM - needs light path changes/additions
-  ContrastMethod:DIC - does the prism (beam splitter/combiner) need
   described or is it a characteristic of another light path object
-  ContrastMethod:ObliqueIllumination - do we need to describe the
   direction of illumination in the light path?
-  AcquisitionMode:StructuredIllumination - do we need to describe the
   detail of the illumination?

Modes I have questions about
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  ExperimentType:FP - what does this stand for?
-  ExperimentType:FourDPlus - what does this mean? is it a catch all?
-  ExperimentType:PGIDocumentation - what does this mean?
-  ExperimentType:TimeLapse - is this a catch all?
-  AcquisitionMode:FSM - how does this work?
-  AcquisitionMode:TIRF & AcquisitionMode:TotalInternalReflection - are
   these the same?

Iterations for model changes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Assume database/api/omero changes will follow on in the following
iterations.

-  July

   -  N-Dim
   -  Bob Murphy - PSLID and the Experiment Node

-  August

   -  Detectors
   -  My Holidays (might be a good time to post current progress / some
      questions to the lists)

-  September

   -  SPIM (lightpath changes)
   -  EM Changes

-  October

   -  New ROI
   -  FluorescenceLifetime/SpectralImaging/StructuredIllumination (if
      not fully covered my N-Dim)

-  November

   -  Transform Matrix (Needed for big images, derived images, tiled
      images)
   -  Schema Release

-  December

   -  ASCB

Deprecated Page

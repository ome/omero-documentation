Enum Tool
=========

Enum Tool is a Python application designed to digest OME XML schema and
produce meaningful output about enumerations.

Requirements:

-  ` Python <http://www.python.org>`_ 2.4+

Checking out the source
-----------------------

::

    svn co http://svn.openmicroscopy.org.uk/svn/specification/Xml/xsd-fu/trunk xsd-fu

Running the tool
----------------

::

    $ ./enum-tool
    Expecting single ome.xsd file path!
    Usage: ./enum-tool (-t | -x | -d <file>) [path/to/ome.xsd]
    Toolkit for working with enumerations from an OME XML Schema definition.

    Options:
      -t            Dumps all enumerations in a visual tree
      -x            Displays the XPath expressions for each enumeration
      -d file       Diffs enumeration possible values from an XPath
                configuration file. This file is expected to have two sections
                the first containing the "old" and "new" XSD files and the
                second containing the XPath mappings. (See: example.cfg)

    Examples:
      ./enum-tool -t schemas/ome.xsd
      ./enum-tool -x schemas/ome.xsd
      ./enum-tool -d example.cfg

    Report bugs to OME-Devel <ome-devel@lists.openmicroscopy.org.uk

Examining enumeration structure
-------------------------------

Enum Tool has two formats for providing information about enumerations
within OME XML schemata:

-  XPath format

   ::

       $ ./enum-tool -x tmp/ome.xsd
       /OME/Instrument/LightSource/Filament@Type
       /OME/Image/DisplayOptions/GreyChannel@ColorMap
       /OME/Experiment@Type
       /OME/Image/ChannelInfo@PhotometricInterpretation
       /OME/Image/Pixels@DimensionOrder
       /OME/Instrument/Detector@Type
       /OME/Instrument/Filter/ExFilter@Type
       ...

-  Tree/graph format

   ::

       $ ./enum-tool -t tmp/ome.xsd
       +-- OME
       +-- Image
         +-- DisplayOptions
           +-- Display(xs:string)
             +-- RGB
             +-- Grey
       +-- OME
         +-- Experiment
           +-- Type(xs:string)
             +-- FP
             +-- FRET
             +-- Time-lapse
             +-- 4-D+
       ...

Using Enum Tool to compare enumerations in schemata (an example)
----------------------------------------------------------------

Enum Tool can be used to diff or compare two schema files by XPath. This
is particularly useful when one is attempting to build XSL stylesheets
to move from one schema version to another.

::

    $ ./enum-tool -x tmp/old.xsd | sort > old
    $ ./enum-tool -x tmp/new.xsd | sort > new

Now, using a spreadsheet or other visual differencing tool we build a
mapping file, which outlines the new and old schema as well as an
enumerated list of XPath mappings between the two schema.

::

    [schemas]
    old="../../Release/2008-09/V1/ome.xsd"
    new="../../Working/ome.xsd"

    [xpaths]
    /OME/Image/MicrobeamManipulation@Type=/OME/Experiment/MicrobeamManipulation@Type
    /OME/Experiment@Type=/OME/Experiment@Type
    /OME/Image/ObjectiveRef@Medium=/OME/Image/ObjectiveSettings@Medium
    /OME/Image/LogicalChannel/DetectorRef@Binning=/OME/Image/Pixels/Channel/DetectorSettings@Binning
    /OME/Image/LogicalChannel@Mode=/OME/Image/Pixels/Channel@AcquisitionMode
    /OME/Image/LogicalChannel@ContrastMethod=/OME/Image/Pixels/Channel@ContrastMethod
    /OME/Image/LogicalChannel@IlluminationType=/OME/Image/Pixels/Channel@IlluminationType
    /OME/Image/Pixels@DimensionOrder=/OME/Image/Pixels@DimensionOrder
    /OME/Image/Pixels@PixelType=/OME/Image/Pixels@Type
    /OME/Instrument/Detector@Type=/OME/Instrument/Detector@Type
    /OME/Instrument/Filter@Type=/OME/Instrument/Filter@Type
    /OME/Instrument/LightSource/Arc@Type=/OME/Instrument/LightSource/Arc@Type
    /OME/Instrument/LightSource/Filament@Type=/OME/Instrument/LightSource/Filament@Type
    /OME/Instrument/LightSource/Laser@LaserMedium=/OME/Instrument/LightSource/Laser@LaserMedium
    /OME/Instrument/LightSource/Laser@Pulse=/OME/Instrument/LightSource/Laser@Pulse
    /OME/Instrument/LightSource/Laser@Type=/OME/Instrument/LightSource/Laser@Type
    /OME/Instrument/Microscope@Type=/OME/Instrument/Microscope@Type
    /OME/Instrument/OTF/ObjectiveRef@Medium=/OME/Instrument/OTF/ObjectiveSettings@Medium
    /OME/Instrument/OTF@PixelType=/OME/Instrument/OTF@Type
    /OME/Instrument/Objective/Correction=/OME/Instrument/Objective@Correction
    /OME/Instrument/Objective/Immersion=/OME/Instrument/Objective@Immersion

And finally, our diff:

::

    $ ./enum-tool -d example.cfg
    /OME/Instrument/Detector@Type:EM-CCD not in /OME/Instrument/Detector@Type
    /OME/Instrument/Detector@Type:Unknown not in /OME/Instrument/Detector@Type
    /OME/Instrument/LightSource/Arc@Type:Unknown not in /OME/Instrument/LightSource/Arc@Type
    /OME/Instrument/LightSource/Filament@Type:Unknown not in /OME/Instrument/LightSource/Filament@Type
    /OME/Instrument/LightSource/Laser@LaserMedium:Unknown not in /OME/Instrument/LightSource/Laser@LaserMedium
    /OME/Instrument/LightSource/Laser@Type:Unknown not in /OME/Instrument/LightSource/Laser@Type
    /OME/Instrument/Microscope@Type:Unknown not in /OME/Instrument/Microscope@Type
    /OME/Instrument/Objective/Correction:Unknown not in /OME/Instrument/Objective@Correction
    /OME/Instrument/Objective/Immersion:Unknown not in /OME/Instrument/Objective@Immersion

Special Thanks
--------------

A special thanks goes out to ` Dave
Kuhlman <http://www.rexx.com/~dkuhlman/>`_ for his fabulous work on
` generateDS <http://www.rexx.com/~dkuhlman/generateDS.html>`_ which
Enum Tool makes heavy use of internally.

--------------

See also: `XsdFu </ome/wiki/XsdFu>`_,
`http://www.openmicroscopy.org/site/support/file-formats/working-with-ome-xml/developer-information <http://www.openmicroscopy.org/site/support/file-formats/working-with-ome-xml/developer-information>`_,
` http://genshi.edgewall.org/ <http://genshi.edgewall.org/>`_,
` http://www.rexx.com/~dkuhlman/generateDS.html <http://www.rexx.com/~dkuhlman/generateDS.html>`_

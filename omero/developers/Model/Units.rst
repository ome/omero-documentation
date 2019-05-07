Units
=====

A number of properties in the OME model are physical measurements
which inherently have a unit associated with them. Earlier versions
of OME defined a default unit for the measurement. Now users, clients,
and acquisition systems can specify the unit themselves rather than
converting their internal unit to the OME default.

.. seealso::
    :model_doc:`Data Model documentation for units <developers/ome-units.html>`

Supported units
---------------

* :javadoc_model:`Electric potential <omero/model/ElectricPotentialI.html>`
* :javadoc_model:`Frequency <omero/model/FrequencyI.html>`
* :javadoc_model:`Length <omero/model/LengthI.html>`
* :javadoc_model:`Power <omero/model/PowerI.html>`
* :javadoc_model:`Pressure <omero/model/PressureI.html>`
* :javadoc_model:`Temperature <omero/model/TemperatureI.html>`
* :javadoc_model:`Time <omero/model/TimeI.html>`

Each of the supported units contain a number of values from the
International System of Units (SI) in the most common prefixes from
yotta (10^24) to yocto (10^-24). The Length unit also contains
values from the Imperial system as well as internal values which
are internal to OME: reference frame and pixel.

Unit fields
-----------

The following fields in the OMERO model have a unit type:

===================== ===================== ================== =============
Class                 Field                 Type               Default value
===================== ===================== ================== =============
Channel               EmissionWavelength    Length             nm
Channel               ExcitationWavelength  Length             nm
Channel               PinholeSize           Length             µm
Detector              Voltage               ElectricPotential  V
DetectorSettings      ReadOutRate           Frequency          MHz
DetectorSettings      Voltage               ElectricPotential  V
ImagingEnvironment    AirPressure           Pressure           mbar
ImagingEnvironment    Temperature           Temperature        °C
Laser                 RepetitionRate        Frequency          Hz
Laser                 Wavelength            Length             nm
LightSource           Power                 Power              mW
LightSourceSettings   Wavelength            Length             nm
Objective             WorkingDistance       Length             µm
Pixels                PhysicalSizeX         Length             µm
Pixels                PhysicalSizeY         Length             µm
Pixels                PhysicalSizeZ         Length             µm
Pixels                TimeIncrement         Time               s
Plane                 DeltaT                Time               s
Plane                 ExposureTime          Time               s
Plane                 PositionX             Length             reference frame
Plane                 PositionY             Length             reference frame
Plane                 PositionZ             Length             reference frame
Plate                 WellOriginX           Length             reference frame
Plate                 WellOriginY           Length             reference frame
Shape                 FontSize              Length             pt
Shape                 StrokeWidth           Length             pixel
StageLabel             X                    Length             reference frame
StageLabel             Y                    Length             reference frame
StageLabel             Z                    Length             reference frame
TransmittanceRange     CutIn                Length             nm
TransmittanceRange     CutInTolerance       Length             nm
TransmittanceRange     CutOut               Length             nm
TransmittanceRange     CutOutTolerance      Length             nm
WellSample             PositionX            Length             reference frame
WellSample             PositionY            Length             reference frame
===================== ===================== ================== =============

Units of type `reference frame` cannot be assumed comparable to units from
other properties including those with type `reference frame`.

Unit objects
------------

Each unit quantity consists of a double-precision scalar and an enumeration
which chooses one of the pre-defined values from the model. In code, uppercase
spellings of the enumerations are used, while in the schema, in OME-XML files,
and in the database, the Unicode symbol for the unit is used.

=========================== ==============================================
Language                    Representation
=========================== ==============================================
Ice                         `enum UnitsLength { MICROM, ... };`
Java and Python             `omero.model.enums.UnitsLength.MICROM`
C++                         `omero::model::enums::MICROM`
PostgreSQL                  `'µm'::unitslength`
=========================== ==============================================

Defining a unit
~~~~~~~~~~~~~~~

::

     Pixels p = ...; // Defined elsewhere
     Length l = new LengthI(2.1, UnitsLength.MICROM); // µm
     p.setPhysicalSizeX(l);
     p.setPhysicalSizeY(l);
     iUpdatePrx.saveObject(p);

The above stores a Pixels object in the database with X and Y
physical lengths of "µm".

Converting a unit
~~~~~~~~~~~~~~~~~

Often a measurement will not be in the most convenient unit for
display, e.g. 0.00001 mm. could better be expressed in microns.
In order to convert between units, pass the measurement that
you have available to a constructor of the same type, passing in
the target unit that you would like to see:

::

     Pixels p = ...; // As saved above
     Length l1 = p.getPhysicalSizeX(); // 2.1 microns
     Length l2 = new LengthI(x1, UnitsLength.NM); // As nanometers

Getting a symbol
~~~~~~~~~~~~~~~~

The enumerations used in the "units" field of each measurement
is of type `omero.model.enums.UnitsNAME` where NAME is `Length`,
`Temperature`, etc. These members of that enumeration are all
uppercased, code-safe versions of the unit name. To get the symbol
as defined in the SI specification, for example, use the
`getSymbol` method:

::

    Length l1 = ...; // As above
    l1.getSymbol(); // Returns "µm"

.. _querying-units:

Querying units
--------------

In HQL queries, the scalar and the enumeration value can be separately
retrieved.

::

     select planeInfo.exposureTime.value from PlaneInfo planeInfo ...

will retrieve just the double scalar value while

::

     select planeInfo.exposureTime.unit from PlaneInfo planeInfo ...

will retrieve a string representation of the enum which
can be used in each language to create an enum object, e.g.:

::

     UnitsTime.valueOf(unit); // Java
     getattr(UnitsTime, unit) # Python

To load the symbolic representation of the enum which is used
internally in the database and is more concise, use an HQL cast:

::

     select cast(planeInfo.exposureTime.unit as text) from PlaneInfo planeInfo ...

Returning the entire unit quantity will result in a hash map with the
various representations:

::

     select planeInfo.exposureTime from PlaneInfo planeInfo ...
     {'symbol': 's', 'unit': 'SECOND', 'value': 1.2000000476837158}


.. seealso::

    * https://en.wikipedia.org/wiki/Units_of_measurement
    * https://en.wikipedia.org/wiki/System_of_measurement
    * https://en.wikipedia.org/wiki/International_System_of_Units


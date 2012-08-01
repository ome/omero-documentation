Instrument Model Evolution
==========================

Description
-----------

These changes are the additions and modifications to the model that come
about due to the increased understand and increased reach.

Usage
-----

This will allow a more complex representation of filters and where they
fit into the light path. Detector will be extended in two phases. A set
of changes to update what we already have, followed by a major reworking
of detector to

Examples:

Filter
^^^^^^

See Filter, FilterSet and LightPath in:
` http://git.openmicroscopy.org/src/master/components/specification/Samples/OmeFiles/2010-06/6x4y1z1t1c8b-swatch-instrument.ome <http://git.openmicroscopy.org/src/master/components/specification/Samples/OmeFiles/2010-06/6x4y1z1t1c8b-swatch-instrument.ome>`_

Lightsource
^^^^^^^^^^^

See LightSource, Laser, Pump, Arc and LightSourceSettings in:
` http://git.openmicroscopy.org/src/master/components/specification/Samples/OmeFiles/2010-06/6x4y1z1t1c8b-swatch-instrument.ome <http://git.openmicroscopy.org/src/master/components/specification/Samples/OmeFiles/2010-06/6x4y1z1t1c8b-swatch-instrument.ome>`_
Note: In the end LightEmittingDiode was not extended as no common values
could be identified.

Detector: Changes
^^^^^^^^^^^^^^^^^

See Detector and DetectorSettings in:
` http://git.openmicroscopy.org/src/master/components/specification/Samples/OmeFiles/2010-06/6x4y1z1t1c8b-swatch-instrument.ome <http://git.openmicroscopy.org/src/master/components/specification/Samples/OmeFiles/2010-06/6x4y1z1t1c8b-swatch-instrument.ome>`_

Detector: New Entities
^^^^^^^^^^^^^^^^^^^^^^

::

    Example will be added when new structures have been decided

--------------

Breakdown
---------

#. Instrument Model Evolution

   #. `#63 </ome/ticket/63>`_ Filter
   #. Detector

      #. `#50 </ome/ticket/50>`_ New Entity (days)
      #. `#65 </ome/ticket/65>`_ Changes

   #. `#73 </ome/ticket/73>`_ Light Source

      #. need attributes on LightEmittingDiode

Deprecated Page

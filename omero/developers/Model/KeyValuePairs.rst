Map annotations
===============

Ongoing advancements in microscopic techniques, analysis
systems, and other areas for which OME attempts to provide
metadata exchange require a certain flexibility in the OME
model. There is a need to store instrument configuration,
script parameters, and similar for later use.

Basic text representations are too difficult to parse to be
of significant use. An XML format can be more easily parsed,
but a single format would have to be agreed upon by all
users. Therefore, it is useful to add particular extension
points to the model for which no consensus on a data format
has been reached, but where more structure than just text is
needed.

A `hash map` was the most likely candidate for this
data; however, rather than limit this to traditional
associative arrays, OME maps are defined as a
**"ordered list of key-value pairs"**. The benefit of
this representation is that configuration files which are
standard for Java ``java.util.Properties`` objects can be
represented fully in a single map. Duplicates are maintained
since there is no unique constraint on the list of pairs.

In most cases, the interpretation of the ordered list will
be such that the final value for a particular key "wins" as
if each value were placed into a hash map in order, with
duplicate values replacing previous ones.

OME-XML
-------

In the OME-XML model, these maps are represented in a compact
format. Any map field is defined by the MapPairs complex
type which consists of M elements of the form:

::

    <M K="key">value</M>

OMERO languages
---------------

In OMERO, a slightly more verbose representation of these
objects is used. Each map type consists of a list or vector
in the respective language, composed of NamedValue objects
and possibly nulls.

::

    // OMERO.java
    ImagingEnvironment environment = new ImagingEnvironmentI();
    environment.setMap(new List<NamedValue>());
    environment.getMap().add(new NamedValue("altitude", "1000m"));
    image.setImagingEnvironment(environment);

Fields
^^^^^^

The concrete fields which are present in the model are
currently:

* ExperimenterGroup.config
* GenericExcitationSource.map
* ImagingEnvironment.map
* ImportJob.versionInfo

More will be added as demand increases.

MapAnnotations
--------------

In addition to the fields above, there is also a
:doc:`structured annotation </developers/Model/StructuredAnnotations>`
which contains a key-valued pair, the ``MapAnnotation``.

::

    // OMERO.cpp
    MapAnnotation ann = new MapAnnotationI();
    ann->getMapValue().push_back(new NamedValueI("run", "5.0"));
    ann->getMapValue().push_back(new NamedValueI("run", "4.9"));
    ann->getMapValue().push_back(new NamedValueI("run", "5.1"));

This permits the flexible attachment of key-value pairs to
any of the OME types which are annotatable. Such annotations
attached to key UI elements like images and datasets will be
presented by the clients, and can be edited with the
appropriate permissions. See the section on :help:`Data Annotation
<introduction/docs/annotate.html>` in the User guides for more information.
See examples of creating MapAnnotations in :doc:`Java </developers/Java>`
and :doc:`Python </developers/Python>` pages.

Storage and queries
-------------------

Each map-based field in the OMERO model is represented by an
extra table of the form `$className_$fieldName`. For example,
MapAnnotation.mapValue becomes `annotation.mapValue`, where
the loss of "map" from the class name is due to the subclassing
of `Annotation` by `MapAnnotation`.

In general, use of the specific tables is not necessary and
it suffices to write HQL queries based on the classes and
field names themselves.

Find the value for a key
^^^^^^^^^^^^^^^^^^^^^^^^

::

    select nv.value from MapAnnotation ann
      join ann.mapValue as nv
     where nv.name = 'altitude'

Finding objects with a key
^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    select ann from MapAnnotation ann
      join ann.mapValue as nv
     where nv.name = 'altitude'

Finding objects **without** a key
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    select ann from MapAnnotation ann
     where not exists(
        from MapAnnotation m2
        join m2.mapValue as nv2
       where nv2.name like 'size%')

Finding objects with multiple values
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    select ann from MapAnnotation ann
      join ann.mapValue as nv1
      join ann.mapValue as nv2
     where nv1.name = 'date'
       and nv2.name = 'owner'

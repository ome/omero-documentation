Deprecated Page

Upgrade to 3.0-Beta3
====================

Jar changes
-----------

We are no longer using Hibernate mapping files, instead all
object-relational mappings are defined in the classes themselves via
annotations. However, to permit customization, it is now necessary to
choose the proper "model" jar. Currently, only "model-psql-VERSION.jar"
is being built. Without this jar, your code will not compile.

Also, it is necessary to add the various Hibernate jars which define the
mapping, search, and validation annotations. See
`OmeroClientLibrary </ome/wiki/OmeroClientLibrary>`_ for the updated
list.

Code changes
------------

Several code changes are necessary for working with the 3.0-Beta3 code
base.

-  To implement the search functionality, newer versions of Hibernate
   (including Hibernate Annotations and Hibernate Search) will be used.
   This requires the removal of the defaultXYZLink construct which was
   previously available. (This change was also discussed for performance
   reasons). This means that all cases of something being a "default"
   instance (images->pixels and experimenter->groups) are now replaced
   with ordered lists, with the first instance being the "default" and
   accessible via "getPrimaryXYZ". This means that there are no more
   default-setters on Pixels and ``GroupExperimenterMap``. Instead, it
   is important to either add the entities to the single-valued side
   (Image and Experimenter, respectively) or use the setPrimaryXYZ()
   methods. Also included are:

   -  Changing all queries referring to defaultPixels
   -  Overlooking all usage of ``ObjectFactory.createPixelsGraph()``
   -  ``ValidationExceptions`` of the form : "null or transient value
      ... Type.\_FieldBackRef" refer to an attempt to save a member of
      an ordered list (``Pixels``, ``GroupExperimenterMap``) rather than
      the containing object (``Image``,\ ``Experimenter``)

-  Due to the ordering of the Pixels in an Image, it is no longer
   possible to save a Pixels directly. It must always be saved via a
   loaded Image object. The same goes for all ordered lists.

-  All List-based fields are now protected (accessors are protected) as
   were Set-based fields previously. The standard methods ``addXyz()``,
   etc. are all available as well as ``getXyz(int)``, etc.

-  Generics: the addition of generic parameters on some methods changes
   how castings are to be handled. Now, rather than
   ``(List<Type>) collectXyz(null)``, ``collectXyz((CBlock<Type>)null)``
   should be used.

-  Details subclasses : to properly handle the different configurations
   for Details (global, regular, mutable) via annotations, it was
   necessary to subclass ome.model.internal.Details in each top-level
   type. This makes calling ``IObject.setDetails()`` much more
   complicated, and it is therefore marked as protected. Instead, use
   ``IObject.getDetails().copy(Details)`` or ``shallowCopy(Details)``.

-  ``ImageAnnotation``, ``DatasetAnnotation``, and ``ProjectAnnotation``
   types will be removed. These are 1-many single string values attached
   to each of the named types. The new annotations are more flexible and
   can be attached to any type by adding
   ``<type id=... annotated="true">`` in the mapping file. The upgrade
   script (see below) will convert all existing annotations.

-  ``Details.getCounts()`` has been removed, in favor of a more
   integrated counting approach. See
   `CollectionCounts </ome/wiki/CollectionCounts>`_ for more.

Upgrade script
--------------

This is the first upgrade script which uses PL/PGSQL. Therefore to run
it, a DB administrator will need to make sure that the language is
installed for your OMERO database. This can be done by executing,

::

    CREATE LANGUAGE plpgsql;

After which, the provided upgrade
(``sql/psql/OMERO3A__3/OMERO3__5.sql``) script will update your database
from it's `milestone:3.0-Beta2.3 </ome/milestone/3.0-Beta2.3>`_ state.

In addition, several other SQL scripts are provided for converting
existing ``CategoryGroups/Categoryies`` to ``Tags`` and similar.

--------------

    See also:
    `StructuredAnnotations </ome/wiki/StructuredAnnotations>`_,
    `CollectionCounts </ome/wiki/CollectionCounts>`_

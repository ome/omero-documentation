OMERO Type Language
===================

The |OmeroModel| has two general parts:
first, the long studied and well-established core model and second, the
user-specified portion. It is vital that there is a central definition
of both parts of the object model. To allow users to easily define new
types we need a simple domain specific language (or little language)
which can be mapped to Hibernate mapping files. See an example at:

-  :source:`components/model/resources/mappings/acquisition.ome.xml`

From this DSL, various artifacts can be generated: XML Schema, Java
classes, SQL for generating tables, etc. The ultimate goal is to have no
exceptions in the model.

Keywords
--------

Some words are not allowed as properties/fields of Omero types. These
include:

-  id
-  version
-  details
-  ... any SQL keyword

`ToBeDone </ome/wiki/ToBeDone>`_
================================

-  Generation from xsd-fu
-  metamodel
-  Attributes: mutable, annotated, ...
-  Additions: umasks, caching, DTD,
-  Namespaces

.. seealso:: |OmeroModel| 

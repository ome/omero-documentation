Rewriting old graph requests
============================

Migration is required
---------------------

OMERO 5.1.0 introduced a new implementation of :doc:`ObjectGraphs`
offered through the API via :javadoc:`Chgrp2
<slice2html/omero/cmd/Chgrp2.html>`, :javadoc:`Chown2
<slice2html/omero/cmd/Chown2.html>`, :javadoc:`Delete2
<slice2html/omero/cmd/Delete2.html>`, and their superclass
:javadoc:`GraphModify2 <slice2html/omero/cmd/GraphModify2.html>`. OMERO
5.1.2 added :javadoc:`Chmod2 <slice2html/omero/cmd/Chmod2.html>`. The
corresponding deprecated legacy request operations are *removed* in
OMERO 5.3. Client code must be adjusted accordingly.


Target objects
--------------

For specifying which model objects to operate on, instead of using one
request for each object, use :javadoc:`GraphModify2
<slice2html/omero/cmd/GraphModify2.html>`'s ``targetObjects`` which
allows specification of multiple model object classes, each with an
unordered list of IDs, all in a single request. To specify a type, no
longer use ``/``-delimited paths, but instead just the class name, e.g.
``Image`` instead of ``/Image``. To achieve a root-anchored subgraph
operation use :javadoc:`SkipHead <slice2html/omero/cmd/SkipHead.html>`
to wrap your request: for instance, for ``/Image/Pixels/RenderingDef``,
set the ``SkipHead`` request's ``targetObjects`` to the image(s), and
set ``startFrom`` to ``RenderingDef``.


Translating options
-------------------

:javadoc:`GraphModify2 <slice2html/omero/cmd/GraphModify2.html>` offers
``childOptions``, an ordered list of :javadoc:`ChildOption
<slice2html/omero/cmd/graphs/ChildOption.html>` instances, each of which
allows its applicability to annotations to be limited by namespace. Some
examples:

- To move a dataset with all its images, removing those images from
  other datasets where necessary, use ``Chgrp2`` with a
  ``ChildOption``'s ``includeType`` set to ``Image``.

- To delete a dataset without deleting any images at all from it, use
  ``Delete2`` with a ``ChildOption``'s ``excludeType`` set to ``Image``.

- To delete annotations except for the tags that are in a specific
  namespace, use ``Delete2`` with a ``ChildOption``'s ``excludeType``
  set to ``TagAnnotation`` and ``includeNs`` set to that namespace.


Examples in Python
------------------

Move images
^^^^^^^^^^^

.. code-block:: python

  chgrps = DoAll()
  chgrps.requests = [Chgrp(type="/Image", id=n, grp=5) for n in [1,2,3]]
  sf.submit(chgrps)

used in OMERO 5.0 should now be written as,

.. code-block:: python

  chgrp = Chgrp2(targetObjects={'Image': [1,2,3]}, groupId=5)
  sf.submit(chgrp)


Delete plate, but not annotations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: python

  keepAnn = {"/Annotation": "KEEP"}
  delete = Delete(type="/Plate", id=8, options=keepAnn)
  sf.submit(delete)

used in OMERO 5.0 should now be written as,

.. code-block:: python

  keepAnn = [ChildOption(excludeType=['Annotation'])]
  delete = Delete2(targetObjects={'Plate': [8]}, childOptions=keepAnn)
  sf.submit(delete)


Delete an image's rendering settings
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: python

  delete = Delete(type="/Image/Pixels/RenderingDef", id=6)
  sf.submit(delete)

used in OMERO 5.0 should now be written as,

.. code-block:: python

  anchor = {'Image': [6]}
  targets = ['RenderingDef']
  delete = SkipHead(targetObjects=anchor, startFrom=targets,
                    request=Delete2())
  sf.submit(delete)


Java request factory
--------------------

A utility class :blitz_source:`Requests.java
<src/main/java/omero/gateway/util/Requests.java>`
provides convenient instantiation of graph requests. This class allows
the requests from the above Python examples to be created by,

.. code-block:: java

  // move images
  Chgrp2 example1 = Requests.chgrp().target("Image").id(1L,2L,3L)
      .toGroup(5L).build();

  // delete plate, but not annotations
  ChildOption childOption = Requests.option()
      .excludeType("Annotation").build();
  Delete2 example2 = Requests.delete().target("Plate").id(8L)
      .option(childOption).build();

  // delete an image's rendering settings
  SkipHead example3 = Requests.skipHead().target("Image").id(6L)
      .startFrom("RenderingDef").request(Delete2.class).build();

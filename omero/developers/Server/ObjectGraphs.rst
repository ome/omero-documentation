Model graph operations
======================

.. topic:: Overview

  When the OMERO server acts on its model objects it must determine the
  impact on related objects. For instance, deleting an image may entail
  deleting users' rendering settings for that image, also the links to
  any datasets that the image is in. Understanding the details of the
  implementation substantially assists in debugging or creating server
  operations that act on the directed graph of model objects.

Motivation
----------

The OMERO model objects are interlinked. Plates may have wells whose
samples come from multiple runs. Both datasets and well samples may have
images, but in different ways. Datasets, wells, images, among others,
may all be annotated. Images themselves are not simple: for example,
they may be in a fileset, they may have ROIs drawn on them, they may
share an instrument with the projection of that image. All these
entities are separate objects that can be thought of as forming the
nodes (vertices) of a directed graph of relationships.

Various operations supported by the OMERO server, most commonly moving
objects to a different group, or deleting them, may implicitly include
many related objects. For example, if one deletes a fileset, one also
deletes the images from that fileset, and even the comments on those
images. This section describes how the graph of model objects is
traversed and how the target set of related objects is determined.

This technical detail is important to understand if one wishes to,

* adjust the set of related model objects that are included in
  operations

* change the types of :doc:`../Model` model objects or the permissible
  links among them

* fix bugs in the related request objects defined in :blitz_source:`Graphs.ice
  <src/main/slice/omero/cmd/Graphs.ice>` that may be
  submitted to :doc:`Sessions` for execution.


Approach
--------

Graph node states and transitions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In determining which model objects to process, and how, each
corresponding graph node is in one of these states:

==========  ===========  ===========  ===============
adjective   rule format  Action enum  Orphan enum
==========  ===========  ===========  ===============
irrelevant  ``[E]{i}``   ``EXCLUDE``  ``IRRELEVANT``
relevant    ``[E]{r}``   ``EXCLUDE``  ``RELEVANT``
orphaned    ``[E]{o}``   ``EXCLUDE``  ``IS_LAST``
attached    ``[E]{a}``   ``EXCLUDE``  ``IS_NOT_LAST``
to delete   ``[D]``      ``DELETE``   n/a
to include  ``[I]``      ``INCLUDE``  n/a
outside     ``[O]``      ``OUTSIDE``  n/a
==========  ===========  ===========  ===============

"enum" refers to the enumerations defined in :server_source:`GraphPolicy.java
<src/main/java/ome/services/graphs/GraphPolicy.java>`. Note also
that, as for the introduction to :doc:`../Modules/Delete`, "links" are
simply edges in the graph, distinct from the classes implementing
:model_source:`ILink.java <src/main/java/ome/model/ILink.java>` which
themselves have several links, not least to their parent and child
objects.

When traversal begins, the target objects are to be *included* (e.g.,
for :slicedoc_blitz:`Chgrp2 <omero/cmd/Chgrp2.html>`) or *deleted*
(e.g., for :slicedoc_blitz:`Delete2 <omero/cmd/Delete2.html>`) and
other objects are *irrelevant*.

A list of transition rules is associated with the requested operation.
Each of the target objects is examined in turn and the rules matched
against the state of that object and of those directly linked to it in
either direction. If a rule matches, it may either abort the operation
with an error condition or, more usually, change the state of any of the
objects it matches. Changed objects are themselves queued for
examination and rule matching. The traversal is complete when all queued
objects have been examined with no further transition rule matches.
Rules that can abort the operation are checked only after the other
rules have completed processing. :server_source:`GraphTraversal.java
<src/main/java/ome/services/graphs/GraphTraversal.java>`'s
``planOperation`` method is at the heart of this matching process.


Further graph node states
^^^^^^^^^^^^^^^^^^^^^^^^^

Usual behavior is for *orphaned* objects related to the target objects
to be included in the operation, but not the otherwise-*attached*
objects, the non-orphans who have *excluded* parents that are to be
neither deleted nor included. The related children that may be orphans
are exactly those identified as being *relevant*. Transition rules match
these against excluded parents to discover if the relevant objects do
have any qualifying parents, changing them to be attached objects. If no
further rules match and some objects remain as relevant, then they are
automatically changed to orphans and examined for further rule matches.
After that processing completes, attached objects are changed back to
being relevant to confirm that excluded qualifying parents still exist
to change them to being attached: this is necessary in case, after an
object was considered attached, other rules changed all those qualifying
parents from being excluded so that the object is now an orphan.

Objects that are changed to be *outside* are effectively rendered
invisible, outside consideration in the execution phase. In the
execution of an operation the graph traversal code removes links between
included and excluded objects, but it allows links to remain between
outside objects and other objects. Outside objects typically implement
:model_source:`IGlobal.java <src/main/java/ome/model/IGlobal.java>` and
have no owner or group.

An additional aspect of objects' state is if permissions are to be
checked for them. For instance, typically I may move only my own objects
to a different group, but if another user tags my image with my tag,
then I may still move my image and tag to a different group, also moving
that link even though it is not my own object: in that case, permissions
checking is disabled for that ``ImageAnnotationLink``. All objects
initially have permissions checking enabled, but the consequence of a
rule may be to disable permissions checking, and if an object with
permissions checking disabled matches a further rule, the objects
changed by that rule also have permissions checking disabled.


Configuration
-------------

Defining the model graph transition rules
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To reduce its complexity, :server_source:`GraphTraversal.java
<src/main/java/ome/services/graphs/GraphTraversal.java>` does
not include specific detail of how to traverse the graph of
:doc:`../Model` model objects. Instead, subclasses of
:server_source:`GraphPolicy.java
<src/main/java/ome/services/graphs/GraphPolicy.java>` guide the
traversal of the model object graph, configured by
:blitz_source:`blitz-graph-rules.xml
<src/main/resources/ome/services/blitz-graph-rules.xml>` which
names and defines the lists of transition rules. The named lists of
rules are associated with request object classes by the definition of
the ``graphRequestFactory`` bean in
:blitz_source:`blitz-servantDefinitions.xml
<src/main/resources/ome/services/blitz-servantDefinitions.xml>`,
which also specifies which model object properties may never be set to
``null`` in executing any requested operation.

:blitz_source:`blitz-graph-rules.xml
<src/main/resources/ome/services/blitz-graph-rules.xml>` begins
with a comment that provides a key to the notation used for transition
rules. The rules name and match model objects based on the state of the
graph nodes, the types of the corresponding objects, the permissions the
user has on those objects, and the names of the properties linking the
objects. To illustrate this, the following sections briefly describe
some different kinds of rule from the ``deleteRules`` list.


Propagating deletion
^^^^^^^^^^^^^^^^^^^^

.. code-block:: xml

  p:matches="L:ILink.parent = [D], L.child = C:[E]{o}/d"
  p:changes="C:[D]"

If an ``ILink``'s parent (e.g., a dataset) is to be deleted, and its
child (e.g., an image) is orphaned and deletable by the user, then
delete the child also.

.. code-block:: xml

  p:matches="PlateAcquisition[D].wellSample = WS:WellSample[E]"
  p:changes="WS:[D]"

If a plate acquisition (run) is to be deleted, also delete its well
samples (fields).

.. code-block:: xml

  p:matches="Fileset[D] = I:Image[E].fileset"
  p:changes="I:[D]"

If a fileset is to be deleted, then also delete its images.

.. code-block:: xml

  p:matches="T:Thumbnail[E].pixels =/!o [D]"
  p:changes="T:[D]/n"

If the pixels of a thumbnail are to be deleted, and are owned by a
different user, then delete the thumbnail regardless of permissions on
it.


Curtailing deletion
^^^^^^^^^^^^^^^^^^^

.. code-block:: xml

  p:matches="Well[D].plate = C:[E]{!a}"
  p:changes="C:{a}"

If a well is to be deleted but its plate is excluded and not attached,
regard the plate as attached.

.. code-block:: xml

  p:matches="C:Channel[E]{r}.pixels = Pixels[E]{i}"
  p:changes="C:{a}"

If an irrelevant pixels object has a relevant channel, then regard the
channel as attached.

.. code-block:: xml

  p:matches="Pixels[D].relatedTo = P:[E]{!a}"
  p:changes="P:{a}"

If a pixels object is to be deleted, regard any related, excluded pixels
objects as attached. Because the pixels of an image are related to the
pixels of a projection of that image, this rule prevents the deletion of
an image from causing inadvertent deletion of the image's projections.

.. code-block:: xml

  p:matches="L:ILink[!D].parent = [E]/d, L.child = C:[E]{r}"
  p:changes="C:{a}"

If an ``ILink`` that is not to be deleted itself has a deletable,
excluded parent and a relevant child, regard that child as attached.


Other kinds of transition rule
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: xml

  p:matches="E:IEnum[E]"
  p:changes="E:[O]"

Regard excluded ``IEnum`` objects as being outside the operation. (Rules
do not need to match on links among multiple objects.)

.. code-block:: xml

  p:matches="F:Fileset[!D].images = [D], F.images = [!D]"
  p:error="may not split {F}"

Throw an error if a fileset that is not to be deleted includes an image
that is to be deleted and an image that is not to be deleted.

In reviewing the ``chgrpRules`` list, one sees conditions that require
matching ``$to_private`` or ``!$to_private``. A request, in this case
:blitz_source:`Chgrp2I.java
<src/main/java/omero/cmd/graphs/Chgrp2I.java>`, may set arbitrary
conditions upon which rules may be predicated. The ``to_private``
condition, or its absence, is used to cause different behavior when the
objects are being moved into a private group.


Logging
-------

Changing the log level
^^^^^^^^^^^^^^^^^^^^^^

It is informative to observe the sequence of rule applications as the
graph is traversed and decisions about model objects are made. To do so
requires configuring :doc:`../logging` for the server, specifically
:source:`etc/logback.xml`. To activate graph traversal debug logging,
adjust the ends of the lines,

.. code-block:: xml

  <logger name="omero.cmd.graphs" level="INFO"/>
  <logger name="ome.services.graphs" level="INFO"/>

such that they instead read,

.. code-block:: xml

  <logger name="omero.cmd.graphs" level="DEBUG"/>
  <logger name="ome.services.graphs" level="DEBUG"/>

The resulting extra information in :file:`var/log/Blitz-0.log` is of
particular assistance in debugging: it pinpoints the rule applications
that caused incorrect determinations of what action to take with model
objects. Note that a ``*`` suffix on a model object referenced in the
logs indicates that permissions are not to be checked for it.


Expanding the reports of transition rule matches
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In the previous section, it can be seen that model objects that match
rule conditions may be named. For example, in,

.. code-block:: xml

  p:matches="Fileset[D] = I:Image[E].fileset"
  p:changes="I:[D]"

the image is named ``I``. When a rule matches, the debug logging reports
which model object matched each name. If it remains unclear why a rule
matched, further objects may be named. For example, changing the first
line to name the fileset,

.. code-block:: xml

  p:matches="F:Fileset[D] = I:Image[E].fileset"

would also report in the log which fileset matched the rule.


Encouragement
-------------

On first reading, the above may feel daunting. If model object graph
traversal is not working as desired, thus requires adjustment, review of
debug logs from :file:`var/log/Blitz-0.log` typically pinpoints the
cause and a minor adjustment to :blitz_source:`blitz-graph-rules.xml
<src/main/resources/ome/services/blitz-graph-rules.xml>` often
suffices as the fix, with integration tests providing reassurance that
the adjustment was acceptable. Sometimes it can take time and thought to
devise that fix, but one can expect small changes to suffice to fix most
bugs. In getting this new graph traversal implementation to initially
pass integration testing, no test failures required a substantial
rethink of the basic approach and :server_source:`GraphTraversal.java
<src/main/java/ome/services/graphs/GraphTraversal.java>` itself
did not require a significant rewrite.

The actual lists of transition rules arose in part as a way to achieve
the desired behavior and are not yet as simple and comprehensive as they
could be. While they necessarily reflect the inherent complexity of the
object model of :doc:`../Model`, there is potential for reviewing the
rule lists and, perhaps with some additional marker interfaces, making
them more succinct and regular. Incremental movements toward this goal
are worth pursuing.


Options
-------

Every one of the request object classes introduced in the new
implementation of graph traversal is a derived class of
:slicedoc_blitz:`GraphModify2 <omero/cmd/GraphModify2.html>` and
inherits data members that configure its operation. Each request may
define additional data members for options specific to it, for instance
:slicedoc_blitz:`Chgrp2 <omero/cmd/Chgrp2.html>` requires the ID of
the target group to be specified. The data members offered by all of the
new requests are,

``targetObjects``
  specifies which model objects the operation is to target

``childOptions``
  specifies types of model objects (and, for annotations, namespaces)
  that should always or never be included in the operation (i.e. always
  considered to be orphans, or attached, regardless of excluded parents)

``dryRun``
  specifies if the request is to determine which model objects would be
  included in and deleted by the operation, without actually executing
  the operation.


SkipHead
--------

The :slicedoc_blitz:`SkipHead <omero/cmd/SkipHead.html>` request
allows specification of the target objects with reference to a common
parent. It wraps an inner ``request`` data member that starts acting
only after graph traversal reaches types listed in ``startFrom``. For
example, to target the images of a specific plate, give the plate in
``targetObjects`` and name ``Image`` in ``startFrom``.

This feature is achieved by running the initial request with ``dryRun``
set to ``true`` and the graph traversal policy modified so as to not
examine included nodes of types listed in ``startFrom``. A subsequent
request then runs, targeting the ``startFrom`` model objects that were
included in the first request.

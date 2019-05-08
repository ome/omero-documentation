Graph requests
==============

.. topic:: Overview

  The Blitz API offers several requests that are subclasses of
  :slicedoc_blitz:`GraphQuery <omero/cmd/GraphQuery.html>`. These
  may be submitted to the server for asynchronous processing of linked
  graphs of :doc:`OMERO model objects <../Model/EveryObject>`. This
  section gives a brief overview of the graph requests and their
  purpose. Follow the links to see more details.


Querying the model object graph
-------------------------------

:slicedoc_blitz:`GraphQuery <omero/cmd/GraphQuery.html>` (base class)
  The parent of the requests below, it includes a ``targetObjects``
  property that specifies from which model objects to start processing.
  The :slicedoc_blitz:`LegalGraphTargets
  <omero/cmd/LegalGraphTargets.html>` request can be used to
  determine which types of model object may be targeted.

:slicedoc_blitz:`DiskUsage2 <omero/cmd/DiskUsage2.html>`
  Report on the disk usage of the target objects and their contents by
  type, user and group. Includes a ``targetClasses`` property to allow
  specifying every visible instance of a type.

:slicedoc_blitz:`FindParents <omero/cmd/FindParents.html>`
  Find the parents of the target objects, both direct and indirect.
  ``typesOfParents`` specifies the types of parents to report.
  ``stopBefore`` specifies types of model object to avoid in traversing
  the linked graph upward: those subgraphs are ignored unless otherwise
  reachable.

:slicedoc_blitz:`FindChildren <omero/cmd/FindChildren.html>`
  Find the children of the target objects, both direct and indirect.
  ``typesOfChildren`` specifies the types of children to report.
  ``stopBefore`` specifies types of model object to avoid in traversing
  the linked graph downward: those subgraphs are ignored unless
  otherwise reachable.


Changing the model object graph
-------------------------------

:slicedoc_blitz:`GraphModify2 <omero/cmd/GraphModify2.html>` (base class)
  The parent of the requests below, it includes a ``targetObjects``
  property that specifies from which model objects to start processing.
  The :slicedoc_blitz:`LegalGraphTargets
  <omero/cmd/LegalGraphTargets.html>` request can be used to
  determine which types of model object may be targeted.

  The ``childOptions`` property lists how to process the contents of
  targeted objects.

  Because these requests change the data stored by the server, a
  ``dryRun`` property is provided that enables attempting to obtain the
  same response or error without actually making any changes.

:slicedoc_blitz:`ChildOption <omero/cmd/graphs/ChildOption.html>`
  By default if a 'child' object is contained by a 'parent' targeted
  object then it is processed along with its parent if it is not also
  contained by another parent object that is not targeted. Use requests'
  ``childOptions`` property to specify that children should be processed
  or not regardless of other parents.

  The ``includeType`` and ``excludeType`` properties specify for which
  types of children to override the behavior. For children that are
  annotations, the ``includeNs`` and ``excludeNs`` properties use the
  annotation namespace to limit the applicability of the override.

:slicedoc_blitz:`Chgrp2 <omero/cmd/Chgrp2.html>`
  Change the group ID of the targeted objects and their contents. The
  objects are moved to the group specified by the ``groupId`` property.

:slicedoc_blitz:`Chown2 <omero/cmd/Chown2.html>`
  Change the user ID of the targeted objects and their contents. The
  objects are given to the user specified by the ``userId`` property.

:slicedoc_blitz:`Chmod2 <omero/cmd/Chmod2.html>`
  Change the permissions for the targeted objects which must be groups.
  The ``permissions`` property specifies the new group type.

:slicedoc_blitz:`Delete2 <omero/cmd/Delete2.html>`
  Delete the targeted objects and their contents. For original file
  instances the underlying file in the server's binary repository may
  be deleted also.

:slicedoc_blitz:`Duplicate <omero/cmd/Duplicate.html>`
  Duplicate a subgraph from the model object graph, starting from the
  targeted objects and recursing to their contents. The
  ``typesToDuplicate``, ``typesToReference``, ``typesToIgnore``
  properties offer control over where in the graph traversal to stop
  duplicating and with what in the original graph to link the duplicate
  subgraph.

:slicedoc_blitz:`SkipHead <omero/cmd/SkipHead.html>`
  Defer processing to start only at specific contents of the targeted
  objects. The ``startFrom`` property specifies the types of object to
  actually target with the processing and the ``request`` property,
  which may be any of the other requests from this section, specifies
  what to do to those objects once identified.


Command-line interface
----------------------

OMERO's :doc:`command-line interface client </users/cli/index>` includes
``chgrp``, ``chown``, ``delete`` plugins that construct the
corresponding ``Chgrp2``, ``Chown2``, ``Delete2`` requests.
Additionally, the ``group`` plugin offers the ``Chmod2`` request and the
``fs`` plugin offers the ``DiskUsage2`` request.


Request builders for Java
-------------------------

The Java gateway includes the :java_gateway_source:`Requests.java
<src/main/java/omero/gateway/util/Requests.java>` class which
offers Java developers a set of builders that use method-chaining to
allow convenient construction of new instances of the above requests.

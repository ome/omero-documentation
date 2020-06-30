Java classes for model graph operations
=======================================

This description of the roles played by server-side Java classes assumes
familiarity with the :doc:`ObjectGraphs` machinery of OMERO.server.


Navigating the graph
--------------------

When OMERO.server starts up the :javadoc_server:`GraphPathBean
<ome/services/graphs/GraphPathBean.html>` reflects upon the object model
and collates information about classes, subclasses, properties and their
value types. This is what :javadoc_server:`GraphPathReport
<ome/services/graphs/GraphPathReport.html>` uses to generate the
:doc:`../Model/EveryObject`.


Traversing and acting
---------------------

OMERO.server's :javadoc_server:`GraphTraversal
<ome/services/graphs/GraphTraversal.html>` is at the core of all graph
operations,

* querying the database to establish the model graph,
  with the help of ``GraphPathBean``
* applying the graph operation's policy rules and changing the graph
  node states
* acting on the model objects according to the final state of the graph.

``GraphTraversal``'s :javadoc_server:`Processor
<ome/services/graphs/GraphTraversal.Processor.html>` interface is
implemented by specific graph requests to act on the selected model
objects. ``GraphTraversal`` implements its :javadoc_server:`PlanExecutor
<ome/services/graphs/GraphTraversal.PlanExecutor.html>` interface with
code that calls those ``Processor`` methods: it provides that
``PlanExecutor`` implementation back to requests so that they can
control exactly if or when to act via their ``Processor``
implementation.

:javadoc_server:`ModelObjectSequencer
<ome/services/graphs/ModelObjectSequencer.html>` ensures that objects
are acted upon in the proper order. For example, in deleting
``OriginalFile`` instances, a directory's contents are deleted before
their containing directory is deleted.

In OMERO.blitz, :javadoc_blitz:`BaseGraphTraversalProcessor
<omero/cmd/graphs/BaseGraphTraversalProcessor.html>` offers a useful
base class for implementing ``Processor`` and
:javadoc_blitz:`NullGraphTraversalProcessor
<omero/cmd/graphs/NullGraphTraversalProcessor.html>` has no effects at
all. Several graph requests define their own ``InternalProcessor``
class.


Policy rules for node transitions
---------------------------------

``GraphTraversal`` manages the traversal of the model graph but it is
instances of OMERO.server's :javadoc_server:`GraphPolicy
<ome/services/graphs/GraphPolicy.html>` that decide how the graph's
nodes are to change state during traversal. The class is instantiated by
the static ``parseRules`` method of :javadoc_server:`GraphPolicyRule
<ome/services/graphs/GraphPolicyRule.html>` which provides a
``GraphPolicy`` based on parsing a sequence of ``GraphPolicyRule``
instances. Each of those rules describes in textual form how it matches
graph fragments and what to do in the event of a match.

OMERO.blitz's :javadoc_blitz:`BaseGraphPolicyAdjuster
<omero/cmd/graphs/BaseGraphPolicyAdjuster.html>` provides convenient
hooks for adjusting how an existing ``GraphPolicy`` transitions nodes.
Classes that do such adjustment include,

:javadoc_blitz:`ChildOptionsPolicy <omero/cmd/graphs/ChildOptionsPolicy.html>`
    marks certain nodes as ``IS_LAST`` or ``IS_NOT_LAST`` once they are
    ``RELEVANT``

:javadoc_blitz:`SkipHeadPolicy <omero/cmd/graphs/SkipHeadPolicy.html>`
    #. in skipping the head, prevents traversal beyond certain node
       types
    #. in processing the remaining graph, preserves permissions
       overrides established in the first phase

:javadoc_blitz:`SkipTailPolicy <omero/cmd/graphs/SkipTailPolicy.html>`
    prevents traversal beyond certain node types

OMERO.server provides the :javadoc_server:`GraphPolicyRulePredicate
<ome/services/graphs/GraphPolicyRulePredicate.html>` interface which is
used for the ``;`` suffix notation in rule matches. For example,
:javadoc_server:`GroupPredicate <ome/services/graphs/GroupPredicate.html>` can
match ``group=system`` and :javadoc_server:`PermissionsPredicate
<ome/services/graphs/PermissionsPredicate.html>` can match
``perms=r?ra??``.


OMERO.blitz graph requests
--------------------------

The :doc:`GraphRequests` of OMERO.blitz benefit from helper classes.
:javadoc_blitz:`GraphRequestFactory
<omero/cmd/graphs/GraphRequestFactory.html>` instantiates the graph
request implementations and provides them means to create a
context-aware :javadoc_blitz:`GraphHelper
<omero/cmd/graphs/GraphHelper.html>`. This helper includes the code that
is common to many of the graph requests. Helper methods not requiring
any context are instead collected in the stateless :javadoc_blitz:`GraphUtil
<omero/cmd/graphs/GraphUtil.html>`.

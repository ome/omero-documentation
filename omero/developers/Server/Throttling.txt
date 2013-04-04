OMERO throttling
================

Throttling consists of reducing the total number of resources that one
user or group can consume at a given time. The throttling service is a
new component of :doc:`/developers/server-blitz` which should ensure a more fair usage.

For example, each blitz server has a pre-defined maximum number of
server threads. Any calls beyond this number must wait on a currently
executing call to finish. Before throttling, a single user could consume
all the available threads and all other users would have to wait.

With throttling, all invocations are placed on configurable on a
**queue** which is worked on my any number of configurable **slots**.
Each site can configure the number and type of slots based on which
**throttling strategy** has been chosen.

Planning
--------

Planned for milestone:3.0-Beta4, the infrastructure for throttling was
committed to milestone :milestone:`3.0-Beta3.1` with
the in-thread strategy, which uses the calling thread for execution.
This provides the same semantics as the current blitz server.

Other strategies include:

-  a per-session strategy
-  a per-user strategy
-  a per-group strategy

each of which allows the session, user, or group a fair slice of
execution, but no more. Within each strategy, the order of operation is
guaranteed not to change once the execution reaches the server. However,
there is nothing the server can do to prevent re-ordering if two calls
are made by the client simultaneously.

More advanced strategies are possible based on total consumed resources
over some window, or even a service-level agreement (SLA) or Quality of
Service (QoS)-style planning. All strategies must guarantee a proper
method ordering.

It is also intended that the throttling service provide limits to memory
usage, database hits within a single transaction, and total execution
time.

Terminology
-----------

-  **Slots** - are the number of available executions that a
   single session, user, or group can perform simultaneously on a
   **single** machine. (If the server is clustered, there will be the
   given number of slots per hosts)
-  **Hard** and **soft** limits - hard limits throw an
   ``OverUsageException`` and require some form of compensation on the
   clients. Soft limits, on the other hand, simply slow down, or
   throttle, execution to give other operations a chance to succeed.
-  **Strictness** - when a strategy is configured as strict, then once a
   session, user, or group has reached its limits, the hard or soft
   limit will be enforced even if no one else is using the server. A
   non-strict policy will "borrow" someone else's slot for the duration
   of one execution.

.. seealso:: :doc:`/developers/Server/ScalingOmero`

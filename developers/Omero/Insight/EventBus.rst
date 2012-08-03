.. _developers/Omero/Insight/EventBus:

Event Bus
---------

Interactions among agents are event-driven. Agents communicate by using
a shared event bus provided by the container. The event bus is an event
propagation mechanism loosely based on the
` Publisher-Subscriber <http://en.wikipedia.org/wiki/Publish/subscribe>`_
pattern and can be regarded as a time-ordered event queue - if event A
is posted on the bus before event B, then event A is also delivered
before event B.

Events are fired by creating an instance of a subclass of ``AgentEvent``
and by posting it on the event bus. Agents interested in receiving
notification of ``AgentEvent`` occurrences implement the
``AgentEventListener`` interface and register with the event bus. This
interface has a callback method, ``eventFired``, that the event bus
invokes in order to dispatch an event. A listener typically registers
interest only for some given events - by specifying a list of
``AgentEvent`` subclasses when registering with the event bus. The event
bus will then take care of event de-multiplexing - an event is
eventually dispatched to a listener only if the listener registered for
that kind of event.

Structure
~~~~~~~~~

`|image1| </ome/attachment/wiki/OmeroInsightEventBus/eventBus.png>`_

``EventBus``

-  Defines how client classes access the event bus service.
-  A client object (subscriber) makes/cancels a subscription by calling
   ``register()``/``remove()``.
-  A client object (publisher) fires an event by calling
   ``postEvent()``.

``AgentEvent``

-  Ancestor of all classes that represent events.
-  Source field is meant to be a reference to the publisher that fired
   the event.
-  An event is "published" by adding its class to the events package
   within the agents package.

``AgentEventListener``

-  Represents a subscriber to the event bus.
-  Defines a callback method, ``eventFired``, that the event bus invokes
   in order to dispatch an event.

``EventBusListener``

-  Concrete implementation of the event bus.
-  Maintains a de-multiplex table to keep track of what events have to
   be dispatched to which subscribers.

In Action
~~~~~~~~~

-  When a subscriber invokes the register or remove method, the
   de-multiplex table is updated accordingly and then the event bus
   returns to idle.
-  When a publisher invokes ``postEvent()``, the event bus enters into
   its dispatching loop and delivers the event to all subscribers in the
   event notification list.
-  Time-ordered event queue - if event A is posted on the bus before
   event B, then event A is also delivered before event B.
-  Dispatching loop runs within same thread that runs the agents
   (*Swing* dispatching thread).

`|image2| </ome/attachment/wiki/OmeroInsightEventBus/eventDispatching.png>`_

Event
-----

Structure
~~~~~~~~~

We devise two common categories of events:

-  Events that serve as a notification of state change. Usually events
   posted by agent to notify other agents of a change in its internal
   state.
-  Events that represent invocation requests and completion of
   asynchronous operations between agents and some services.

In the first category fall those events that an agent posts on the event
bus to notify other agents of a change in its internal state. Events in
the second category are meant to support asynchronous communication
between agents and internal engine. The ``AgentEvent`` class, which
represents the generic event type, is sub-classed in order to create a
hierarchy that represents the above categories. Thus, on one hand we
have an abstract ``StateChangeEvent`` class from which agents derive
concrete classes to represent state change notifications. On the other
hand, the ``RequestEvent`` and ``ResponseEvent`` abstract classes are
sub-classed by the container in order to define, respectively, how to
request the asynchronous execution of an operation and how to represent
its completion. We use the Asynchronous Completion Token pattern to
dispatch processing actions in response to the completion of
asynchronous operations.

`|image3| </ome/attachment/wiki/OmeroInsightEventBus/events.png>`_

``AgentEvent``

-  Ancestor of all classes that represent events.
-  Source field is meant to be a reference to the publisher that fired
   the event.
-  An event is "published" by adding its class to the events package
   within the agents package.

``StateChangeEvent``

-  Ancestor of all classes that represent state change notifications.
-  Its state field can be used to carry all state-change information.

``RequestEvent``

-  Abstractly represents a request to execute an asynchronous operation.
-  A concrete subclass encapsulates the actual request.
-  Knows how and which processing action to dispatch upon completion of
   the asynchronous operation.

``CompletionHandler``

-  Represents a processing action.
-  Allows for all processing action to be treated uniformly.

``ResponseEvent``

-  Abstractly represents the completion of an asynchronous operation.
-  A concrete subclass encapsulates the result of the operation, if any.
-  Knows the ``RequestEvent`` object that originated it.
-  Knows how to activate the de-multiplexing of a completion event to
   the processing action.

In Action
~~~~~~~~~

Follow a concrete example:

::

    //Somewhere in the Data Manager
    //Request to View an image

    EventRequest req = new ViewImage((ImageData) image, null)
    //Request the execution of the view call.
    eventBus.postEvent(req);  


    //Somewhere in the Viewer Agent
    public void eventFired(AgentEvent e)
    {
        if (e instanceof ViewImage) handleViewImage((ViewImage) e);
    }

A concrete ``RequestEvent`` encapsulates a request to execute an
asynchronous operation. Asynchrony involves a separation in space and
time between invocation and processing of the result of an operation: we
request the execution of the operation at some point in time within a
given call stack (say in ``methodX`` we make a new request and we post
it on the event bus). Then, at a later point in time and within another
call stack (``eventFired`` method), we receive a notification that the
execution has completed and we have to handle this completion event -
which mainly boils down to doing something with the result, if any, of
the operation. Recall that the ``ResponseEvent`` class is used for
representing a completion event and a concrete subclass carries the
result of the operation, if any. After the operation has completed, a
concrete ``ResponseEvent`` is put on the event bus so that the object
which initially made the request (often an agent, but, in this context,
we will refer to it as the initiator, which is obviously required to
implement the ``AgentEventListener`` interface and register with the
event bus) can be notified that execution has completed and possibly
handle the result. Thus, at some point in time the initiator’s
eventFired method is called passing in the response object.

Now the initiator has to find out which processing action has to be
dispatched to handle the response. Moreover, the processing action often
needs to know about the original invocation context - unfortunately, we
cannot relinquish the original call stack (``methodX`` is gone). The
solution is to require that a response be linked to the original request
and that the initiator link a request to a completion handler (which
encapsulates the processing action) before posting it on the event bus
(this explains the fancy arrangement of the ``RequestEvent``,
``ResponseEvent`` and ``CompletionHandler``).

This way de-multiplexing matters are made very easy for the initiator.
Upon reception of a completion event notification, all what the
initiator has to do is to ask the response object to start the
de-multiplexing process - by calling the complete method. This method
calls ``handleCompletion()`` on the original request, passing in the
response object. In turn, ``handleCompletion()`` calls the handle method
on its completion handler, passing in both the request and the response.
The right processing action has been dispatched to handle the response.
Also, notice that the completion handler is linked to the request in the
original invocation context, which makes it possible to provide the
handler with all the needed information from the invocation context.
Moreover, both the original request and the corresponding response are
made available to the completion handler. This is enough to provide the
completion handler with a suitable execution context - all the needed
information from the original call stack is now available to the
processing action.

Attachments
~~~~~~~~~~~

-  `eventBus.png </ome/attachment/wiki/OmeroInsightEventBus/eventBus.png>`_
   `|Download| </ome/raw-attachment/wiki/OmeroInsightEventBus/eventBus.png>`_
   (17.9 KB) - added by *bwzloranger* `18
   ago.
-  `eventDispatching.png </ome/attachment/wiki/OmeroInsightEventBus/eventDispatching.png>`_
   `|image5| </ome/raw-attachment/wiki/OmeroInsightEventBus/eventDispatching.png>`_
   (18.5 KB) - added by *bwzloranger* `18
   ago.
-  `events.png </ome/attachment/wiki/OmeroInsightEventBus/events.png>`_
   `|image6| </ome/raw-attachment/wiki/OmeroInsightEventBus/events.png>`_
   (19.3 KB) - added by *bwzloranger* `18
   ago.

OMERO rendering engine
======================

Description
-----------

The rendering component provides for the efficient rendering of raw
pixels based on per-user display settings. A user can change settings
and see them take effect in real time. Changes can also be persisted to
the database and then viewed from another machine or even client.

Server-port
-----------

The rendering engine has been ported to also now sit on the server-side,
though equally usable from any Java setting.

Optimizations
-------------

Here we have a listing of the various rendering engine optimizations
that have taken place over time:

-  Packed Integers (:ticket:`449`)
-  Region Based Rendering (:ticket:`450`)
-  Removal of RGB Rendering Model (:ticket:`452`)

Compression
-----------

With r1744 and r1748, the rendering engine now supports compression.
(:ticket:`6`)

Design
------

The following diagrams describe the original design of the Rendering
Engine. Designed initially for the client-side, much of this information
needs to be updated. Textual explanations are included as notes in each
diagram.


.. figure:: /images/server-rendering-engine1.png
   :align: center
   :alt: Server Rendering Engine (1)

.. figure:: /images/server-rendering-engine2.png
   :align: center
   :alt: Server Rendering Engine (2)

.. figure:: /images/server-rendering-engine3.png
   :align: center
   :alt: Server Rendering Engine (3)

.. figure:: /images/server-rendering-engine4.png
   :align: center
   :alt: Server Rendering Engine (4)

.. figure:: /images/server-rendering-engine5.png
   :align: center
   :alt: Server Rendering Engine (5)

.. figure:: /images/server-rendering-engine6.png
   :align: center
   :alt: Server Rendering Engine (6)

.. figure:: /images/server-rendering-engine7.png
   :align: center
   :alt: Server Rendering Engine (7)

.. figure:: /images/server-rendering-engine8.png
   :align: center
   :alt: Server Rendering Engine (8)

.. figure:: /images/server-rendering-engine9.png
   :align: center
   :alt: Server Rendering Engine (9)

.. figure:: /images/server-rendering-engine10.png
   :align: center
   :alt: Server Rendering Engine (10)

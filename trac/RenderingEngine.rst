OMERO Rendering Engine
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

-  Packed Integers (`#449 </ome/ticket/449>`_)
-  Region Based Rendering (`#450 </ome/ticket/450>`_)
-  Removal of RGB Rendering Model (`#452 </ome/ticket/452>`_)

Compression
-----------

With r1744 and r1748, the rendering engine now supports compression.
(`#6 </ome/ticket/6>`_)

Design
------

The following diagrams describe the original design of the Rendering
Engine. Designed initially for the client-side, much of this information
needs to be updated. Textual explanations are included as notes in each
diagram.

`|image1| </ome/attachment/wiki/RenderingEngine/23.png>`_

`|image2| </ome/attachment/wiki/RenderingEngine/24.png>`_

`|image3| </ome/attachment/wiki/RenderingEngine/25.png>`_

`|image4| </ome/attachment/wiki/RenderingEngine/26.png>`_

`|image5| </ome/attachment/wiki/RenderingEngine/27.png>`_

`|image6| </ome/attachment/wiki/RenderingEngine/28.png>`_

`|image7| </ome/attachment/wiki/RenderingEngine/29.png>`_

`|image8| </ome/attachment/wiki/RenderingEngine/30.png>`_

`|image9| </ome/attachment/wiki/RenderingEngine/31.png>`_

`|image10| </ome/attachment/wiki/RenderingEngine/32.png>`_

Attachments
~~~~~~~~~~~

-  `23.png </ome/attachment/wiki/RenderingEngine/23.png>`_
   `|Download| </ome/raw-attachment/wiki/RenderingEngine/23.png>`_ (46.2
   KB) - added by *jmoore* `4
   years </ome/timeline?from=2008-09-16T09%3A19%3A09%2B01%3A00&precision=second>`_
   ago.
-  `24.png </ome/attachment/wiki/RenderingEngine/24.png>`_
   `|image12| </ome/raw-attachment/wiki/RenderingEngine/24.png>`_ (30.7
   KB) - added by *jmoore* `4
   years </ome/timeline?from=2008-09-16T09%3A19%3A25%2B01%3A00&precision=second>`_
   ago.
-  `25.png </ome/attachment/wiki/RenderingEngine/25.png>`_
   `|image13| </ome/raw-attachment/wiki/RenderingEngine/25.png>`_ (29.9
   KB) - added by *jmoore* `4
   years </ome/timeline?from=2008-09-16T09%3A20%3A31%2B01%3A00&precision=second>`_
   ago.
-  `26.png </ome/attachment/wiki/RenderingEngine/26.png>`_
   `|image14| </ome/raw-attachment/wiki/RenderingEngine/26.png>`_ (28.7
   KB) - added by *jmoore* `4
   years </ome/timeline?from=2008-09-16T09%3A21%3A01%2B01%3A00&precision=second>`_
   ago.
-  `27.png </ome/attachment/wiki/RenderingEngine/27.png>`_
   `|image15| </ome/raw-attachment/wiki/RenderingEngine/27.png>`_ (47.4
   KB) - added by *jmoore* `4
   years </ome/timeline?from=2008-09-16T09%3A21%3A43%2B01%3A00&precision=second>`_
   ago.
-  `28.png </ome/attachment/wiki/RenderingEngine/28.png>`_
   `|image16| </ome/raw-attachment/wiki/RenderingEngine/28.png>`_ (35.8
   KB) - added by *jmoore* `4
   years </ome/timeline?from=2008-09-16T09%3A21%3A57%2B01%3A00&precision=second>`_
   ago.
-  `29.png </ome/attachment/wiki/RenderingEngine/29.png>`_
   `|image17| </ome/raw-attachment/wiki/RenderingEngine/29.png>`_ (45.7
   KB) - added by *jmoore* `4
   years </ome/timeline?from=2008-09-16T09%3A22%3A11%2B01%3A00&precision=second>`_
   ago.
-  `30.png </ome/attachment/wiki/RenderingEngine/30.png>`_
   `|image18| </ome/raw-attachment/wiki/RenderingEngine/30.png>`_ (42.2
   KB) - added by *jmoore* `4
   years </ome/timeline?from=2008-09-16T09%3A22%3A55%2B01%3A00&precision=second>`_
   ago.
-  `31.png </ome/attachment/wiki/RenderingEngine/31.png>`_
   `|image19| </ome/raw-attachment/wiki/RenderingEngine/31.png>`_ (33.3
   KB) - added by *jmoore* `4
   years </ome/timeline?from=2008-09-16T09%3A23%3A09%2B01%3A00&precision=second>`_
   ago.
-  `32.png </ome/attachment/wiki/RenderingEngine/32.png>`_
   `|image20| </ome/raw-attachment/wiki/RenderingEngine/32.png>`_ (27.8
   KB) - added by *jmoore* `4
   years </ome/timeline?from=2008-09-16T09%3A23%3A21%2B01%3A00&precision=second>`_
   ago.

Deprecated Page

OMERO Thumbnail Service
=======================

In order to restore the `OmeroInsight </ome/wiki/OmeroInsight>`_ browser
and return thumbnailing to Shoola as a whole this service needs to be
created along side the `RenderingEngine </ome/wiki/RenderingEngine>`_
that exists now.

Preliminary ticket dependencies are:

-  `#6 </ome/ticket/6>`_ (Compression API)
-  `#306 </ome/ticket/306>`_ (Bean Creation Howto)
-  `#190 </ome/ticket/190>`_ (RenderingDef? creation in multi-user
   environments)
-  `#367 </ome/ticket/367>`_ (Scaling service)
-  `#368 </ome/ticket/368>`_ (ROMIO thumbnail caching service)

As part of `#449 </ome/ticket/449>`_, the thumbnail service is also now
significantly more performant as it does not need to copy buffered
images around in order to use the AWT scaling service.

As of r1067, the thumbnail service is now stateful.

After some discussion with the OMERO team and external input from
` Applied Precision LLC <http://www.apllc.com>`_ it was decided that the
service should allow images to be scaled up as well as down
(`#626 </ome/ticket/626>`_).

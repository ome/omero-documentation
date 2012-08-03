.. _server/rendering:

OMERO.server Image Rendering
============================

A major requirement for any image data application is the ability to
display images. In most applications, this is achieved by reading pixel
data from a filesystem and then mapping the pixel data to the 256 grey
level available on most computer display monitors. It is common in some
experiments to record and display multiple channels at once. Typically
three, four, or even five separate images must be mapped, and then
presented as a colour image for painting on a monitor. Because these
operations can require many thousands of operations and must be
displayed rapidly to support the display of time-lapse movies, most
image display software applications use a high-speed graphics CPU and
dedicated hardware for image rendering and display. This requirement
limits the deployment of these applications to high-powered
workstations.

OMERO.server includes an image server, a software application that
delivers rendered images to a client. This insures that client
applications can display image data. The OMERO Rendering Engine
(OMERO-RE) has been designed to minimise the amount of data transferred
to the client and thus removes the requirement for a specific graphics
CPU, allowing high-performance image viewing on standard laptop
computers. The OMERO-RE achieves this by limiting data transfer times by
being close to the data, using highly efficient network transfer
protocols, utilising modern multi-processor and multi-core machines to
provide the data to clients in a format that is as efficient to display
as possible. OMERO-RE is multi-threaded and can use multi-core servers
to simultaneously render individual channels before assembly to into a
final colour image ready for transfer to the client. The use of the RE
is not mandatory. If a client needs to have the full pixel data, it can.
This OriginalPixels facility is used for client-side analysis, like that
performed in the OMERO.insight measurement tool.

Transfer of image data even after rendering can limit performance,
especially when accessing data remotely on connections with limited
bandwidth (e.g., domestic ADSL). Therefore the OMERO-RE contains a
compression service with an API that allows a client adjustable
compression providing minimal image artefacts and a 20-fold range of
data size to the client.

The OMERO Rendering Engine is accessed by OMERO client applications
written in Java, C++, or Python via a binary protocol (ICE) provided by
`ZeroC <http://zeroc.com>`_.
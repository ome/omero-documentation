OMERO clients overview
======================

Most laboratories use a number of different imaging platforms and thus
require tools to manage, visualize and analyze heterogeneous sets of
image data recorded in a range of file formats. Ideally a single set of
applications, running on a user's laptop or workstation, could access
all sets of data, and provide easy-to-use access to this data.

OMERO ships as a server application called :program:`OMERO.server` and a
series of client applications (known simply as clients): :program:`OMERO.web`,
:program:`OMERO.insight` and :program:`OMERO.importer`. All run on the major
operating systems and provide image visualization, management, and annotation
to users from remote locations. With a large number of OMERO.server
installations worldwide, OMERO has been shown to be relatively easy to install
and get running.

OMERO.insight and OMERO.importer are desktop applications written in Java
and require Java |javaversion_min| (or higher) to be installed on the user's
computer (this can easily be installed from `<https://java.com/>`_ if it is not
already included in your OS).

Our user assistance :help:`help website<>` provides a series of
workflow-based guides to performing common actions in the client applications,
such as importing and viewing data, exporting images and using the measuring
tool. 

Our partners within the OME consortium are also producing new clients and
modules for OMERO, integrating additional functionality, particularly for more
complex image analysis. See the :omero:`features pages <analyze>` for
more details.

Features
--------

Among many features, the noteworthy elements of the two main clients
(OMERO.insight and OMERO.web) are:

- DataManager, a traditional tree-based view of the data hierarchies in an
  OMERO.server. DataManager supports access to all image metadata,
  annotations, tags etc.
- ImageViewer, for visualization of 5D images (space, channel, time). The
  ImageViewer makes use of the OMERO.server's Rendering Engine, and provides
  high-performance viewing of multi-dimensional images on standard
  workstations (e.g. scrolling through space and time), without requiring
  installation of high-powered graphics cards. Most importantly, image viewing
  at remote locations is enabled. Image rendering settings are saved and
  chosen by user ID
- Working Area, for viewing, annotating, and manipulating large sets of image
  data
- user and group administration

.. _omero-web:

OMERO.web
---------

OMERO.web is a web-based client for users who wish to access their data in the
browser. This offers a similar view to the OMERO.insight desktop client.
Figures :ref:`omeroweb_52` and :ref:`omero_web_5_2` present the user
interface. Developers can use the |OmeroWeb| to build customized
views.

.. _omeroweb_52:
.. figure:: /images/omero_web.png
    :width: 60%
    :align: center
    :alt: OMERO.web user interface
    
    OMERO.web user interface

.. _omero_web_5_2:
.. figure:: /images/web_viewer.png
    :width: 60%
    :align: center
    :alt: OMERO.web image viewer
    
    OMERO.web image viewer

OMERO.web features almost all of the functionality of OMERO.insight barring
import.
A number of apps are available to add functionality to OMERO.web, such as
:omero:`OMERO.figure <figure/>` and :omero:`OMERO.iviewer <iviewer/>`.
See the main website for a :omero:`list of released apps <apps/>`.

For more information and guides to using OMERO.web, see our
:help:`help website <>`.

.. _omero-insight:

OMERO.insight
-------------

.. note:: With the release of OMERO 5.3.0, the OMERO.insight desktop client
    has entered **maintenance mode**, meaning it will only be updated if a
    major bug is discovered. Instead, the OME team will be focusing on
    developing and extending the web clients.

OMERO.insight provides a number of tools for accessing and using data in an
OMERO server. Figures :ref:`omero_insight_screenshot_5_2` and
:ref:`omero_insight_5_2_viewer` present the user interface. To find out more,
see the :help:`OMERO.insight user guides <>`.

.. _omero_insight_screenshot_5_2:
.. figure:: /images/insight.png
    :align: center
    :width: 60%
    :alt: OMERO.insight
    
    OMERO.insight

.. _omero_insight_5_2_viewer:
.. figure:: /images/insight-viewer.png
    :align: center
    :width: 60%
    :alt: OMERO.insight ImageViewer and Measurement Tool

    OMERO.insight ImageViewer and Measurement Tool

The two main additional features of OMERO.insight which are not available as
yet for OMERO.web are:

- Measurement Tool, a sub-application of ImageViewer that enables size and
  intensity measurements of defined regions-of-interest (ROIs)
- image import

Our user assistance :help:`help website <>` features a number of
workflow-based guides to importing, viewing, managing and exporting your data
using OMERO.insight.

.. _omero-importer:

OMERO.importer
--------------

The OMERO.importer is part of the OMERO.insight client, but can also run as a
stand-alone application. The OMERO.importer allows the import of proprietary
image data files from a filesystem accessed from the user's computer to a
running OMERO server. This tool uses a standard file browser to select the
image files for import into an OMERO server.

The tool uses Bio-Formats for translation of proprietary file formats in
preparation for upload to an OMERO.server. Visit
:bf_v_doc:`Supported Formats <supported-formats.html>`
for a detailed list of supported formats.

.. figure:: /images/importer.png
    :align: center
    :width: 60%
    :alt: OMERO.importer
    
    OMERO.importer

OMERO.cli
---------

The |CLI| is a set of Python-based system administration, deployment and
advanced user tools. Most of commands work remotely so that the |CLI| can be
used as a client against an OMERO server. See :doc:`cli/index` for further
information.


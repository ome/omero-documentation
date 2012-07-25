.. _rst_gettingstarted:

Getting Started
===============

Overview
--------

With over 1900 OMERO.server instances up and running worldwide, OMERO
has been shown to be relatively easy to install and get running. There
are instructions for manual install on Linux and OS X, as well as
Windows.

OMERO Client Documentation
--------------------------

All our 'for scientists' documentation, :plone:`downloads
<support/omero4/downloads>`, and install instructions can be found
from the :ref:`rst_gettingstarted_clientdocumentation` page.

OMERO Server Documentation
--------------------------

If you are a OMERO.server administrator or developer, head over to the
`OMERO Trac <http://trac.openmicroscopy.org.uk/ome>`_ website for all our
admin and dev documentation.

OMERO.server Installation
-------------------------

As a full server product, installing OMERO.server is a more technical
process. Detailed instructions are available for installing and
upgrading.

-  `OMERO.server downloads <../downloads>`_
-  :ref:`rst_installation`
-  :ref:`rst_install-windows`
-  :ref:`rst_upgrade`

--------------

Prerequisites
-------------

Each component of the OMERO platform has a separate set of
prerequisites. Where possible, we provide tips on getting started with
each of these technologies, but we can only provide free support within
limits.

.. raw:: html

   <center>
   <div id="prerequisites-table">
   <table style="border: 1px solid #333; padding: 6px 6px 6px 12px;" cellpadding="6" border="1">
     <tr>
       <th>

Package

.. raw:: html

   </th>
       <th>

OMERO.server

.. raw:: html

   </th>
       <th>

Java

.. raw:: html

   </th>
       <th>

Python

.. raw:: html

   </th>
       <th>

Ice

.. raw:: html

   </th>
       <th>

PostgreSQL

.. raw:: html

   </th>
     </tr>
     <tr>
       <td>

OMERO.importer

.. raw:: html

   </td>
       <td>

Required

.. raw:: html

   </td>
       <td>

Required

.. raw:: html

   </td>
       <td></td>
       <td></td>
       <td></td>
     </tr>
     <tr>
       <td>

OMERO.insight

.. raw:: html

   </td>
       <td>

Required

.. raw:: html

   </td>
       <td>

Required

.. raw:: html

   </td>
       <td></td>
       <td></td>
       <td></td>
     </tr>
     <tr>
       <td>

OMERO.editor

.. raw:: html

   </td>
       <td>

Required for some functionality

.. raw:: html

   </td>
       <td>

Required

.. raw:: html

   </td>
       <td></td>
       <td></td>
       <td></td>
     </tr>
     <tr>
        <td>

OMERO.server

.. raw:: html

   </td>
        <td></td>
        <td>

Required

.. raw:: html

   </td>
        <td>

Required

.. raw:: html

   </td>
        <td>

Required

.. raw:: html

   </td>
        <td>

Required

.. raw:: html

   </td>
     </tr>
     <tr>
       <td>

OMERO.web

.. raw:: html

   </td>
       <td>

Required

.. raw:: html

   </td>
       <td></td>
       <td>

Required

.. raw:: html

   </td>
       <td>

Required

.. raw:: html

   </td>
       <td></td>
     </tr>
     <tr>
       <td>

OMERO.py

.. raw:: html

   </td>
       <td>

Required for most functionality

.. raw:: html

   </td>
       <td></td>
       <td>

Required

.. raw:: html

   </td>
       <td>

Required

.. raw:: html

   </td>
       <td></td>
     </tr>
     <tr>
       <td>

OMERO.cpp

.. raw:: html

   </td>
       <td>

Required for most functionality

.. raw:: html

   </td>
       <td></td>
       <td></td>
       <td>

Required

.. raw:: html

   </td>
       <td></td>
     </tr>
   </table>
   </div>
   <table>
     <tr>
       <td valign="top">

Notes

.. raw:: html

   </td>
       <td>

 

.. raw:: html

   </td>
       <td>

Java 1.5 SE Development Kit (JDK) or higher installed. Available from:
http://java.sun.com/javase/downloads/index.jsp

.. raw:: html

   </td>
     </tr>
   </table>
   </center>

Extending OMERO
---------------

Developers documentation is available on
`Trac <http://trac.openmicroscopy.org.uk/omero/wiki>`_. There are
extension points to add OMERO server functionality as described on the
:wiki:`Extending OMERO <ExtendingOmero>` page as
well as add to agents to OMERO.insight. See
:wiki:`OmeroInsightArchitecture` for more information.

Instructions on writing your own :wiki:`OmeroClients` or 
scripts that work via the :wiki:`OMERO API <OmeroApi>`, in a
number of languages are listed as part of the [analysis]
(support/omero4/analysis) page.

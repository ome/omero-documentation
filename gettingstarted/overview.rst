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

-  :plone:`OMERO.server downloads <support/omero4/downloads>`
-  :ref:`server/installation`
-  :ref:`server/install-windows`
-  :ref:`rst_upgrade`

--------------

Prerequisites
-------------

Each component of the OMERO platform has a separate set of
prerequisites. Where possible, we provide tips on getting started with
each of these technologies, but we can only provide free support within
limits.

============== =============================== ======== ======== ======== ==========
Package        OMERO.server                    Java     Python   Ice      PostgreSQL
============== =============================== ======== ======== ======== ==========
OMERO.importer Required                        Required
OMERO.insight  Required                        Required
OMERO.editor   Required for some functionality Required
OMERO.server                                   Required Required Required Required
OMERO.web      Required                                 Required Required
OMERO.py       Required for some functionality          Required Required
OMERO.cpp      Required for some functionality                   Required
============== =============================== ======== ======== ======== ==========

Java 1.5 SE Development Kit (JDK) or higher installed. Available from:
`<http://www.oracle.com/technetwork/java/javase/downloads/index.html>`_

Extending OMERO
---------------

Developers documentation is available on
`Trac <http://trac.openmicroscopy.org.uk/ome/wiki>`_. There are
extension points to add OMERO server functionality as described on the
|ExtendingOmero| page as well as add to agents to OMERO.insight. See
:wiki:`OmeroInsightArchitecture` for more information.

Instructions on writing your own |OmeroClients| or scripts that work 
via the |OmeroApi|, in a number of languages are listed as part of the 
:plone:`analysis <support/omero4/analysis>` page.

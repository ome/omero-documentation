OME overview
##############

.. topic:: Overview

   This page is dedicated to the project quick overview and organisation.


The Open Microscopy Environment (OME) is a multi-site collaborative effort producing tools to enable data management for biological imaging. Our goal is to provide life scientists with sophisticated software and data analysis tools to support their work. Designed to interact with existing commercial software, all OME formats and software are freely available under an `open source license <http://www.gnu.org/copyleft/gpl.html>`_.

OME is developed as a joint project between research-active laboratories at the `University of Dundee <http://www.glencoesoftware.com/>`_, `NIA Baltimore <http://www.grc.nia.nih.gov/branches/blsa/blsa.htm>`_ and `LOCI Madison (Laboratory for Optical and Computational Instrumentation) <http://loci.wisc.edu//>`_. OME has active collaborations with many imaging, informatics and industry groups.

`Glencoe Software <http://www.glencoesoftware.com/>`_ provides commercial licenses for both OMERO and Bio-Formats along with delivering the Glencoe Software DME, a customized and supported version of OMERO.

Components
==========

The OME system can be divided into several components:

 * OMERO: A client-server data management solution for images.
 * Bio-Formats: A Java library for proprietary data conversion.
 * OME-XML/OME-TIFF: A standardised data model (OME data model) and data storage.


OMERO
=====

Server
------

OMERO (OME Remote Objects) is a Java Enterprise application that provides integration, visualisation, management, and analysis facilities for biological image data. Support for microscopy, HCS, and graphics image data is built-in, and full data query and search facilities are enabled. Data are stored in a relational database modeled on the OME data model and binary files. All data in OMERO are accessible by any OMERO client through an API (*Application Programming Interface*) in Java, Python, Matlab and C++. The same API is used by all "clients" from simple code samples up to full GUI applications (see below). A single OMERO.server installation can support the image data requirements of a laboratory or an imaging facility.


.. figure:: training_screenshots/api_figure.png
   :scale: 50%
   :alt: API
   :align: center

   .. 

   Data stored in an OMERO server are accessed via an API in several languages used by various clients.


Clients
-------

 * **OMERO.insight** provides access to data stored in an installation of OMERO.server. This allows a scientist to remotely manage, view, collaborate, annotate, tag, and measure multi-dimensional images from anywhere. It also provides integrated access and use of the OMERO.importer and OMERO.editor.
 * **OMERO.importer** allows the importing and archiving of all file formats supported by Bio-formats. It provides a standard file browser to help the user choose which files to import and where to put them in an OMERO.server.
 * **OMERO.web** enables a web browser to connect to an OMERO.server and combines a multi-dimensional image viewer with a platform for collaboration and a pathway for publishing work.
 * **OMERO.editor** records experimental data in a structured way. This can be used to annotate OMERO.server images or be viewed independently. Complex protocols can be assembled using workflow templates.


Bio-Formats
===========

`Bio-Formats <http://www.loci.wisc.edu/software/bio-formats>`_ is a standalone Java library for reading and writing microscopy images. It can parse pixels and metadata from a large number of formats (see `Supported Formats <http://www.loci.wisc.edu/bio-formats/formats>`_). Its primary purpose is to convert proprietary microscopy data into an open standard called the OME data model, particularly into the OME-TIFF file format.

Usable with `ImageJ <http://rsbweb.nih.gov/ij/>`_ or your own code. Bio-Formats is used to import data to an OMERO server.

OME-XML/OME-TIFF
==================

OME-XML is a common specification for light microscopy file formats. It provides a rich extensible model to save information related to microscopy experiments with the acquired images. OME-TIFF stores multi-dimensional microscope images and associated metadata in simple, standardised file format that can be read by ImageJ, Matlab, Photoshop, and many commercial imaging software tools.


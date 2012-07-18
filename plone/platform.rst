Title: OMERO Platform v4 Description: Overview of OMERO

OME Remote Objects (OMERO) is a modern client-server software platform
for visualising, managing, and annotating scientific image data. OMERO
also provides components for image importing, archiving, protocol
recording, and user administration. OMERO consists of a Java server,
several Java client applications, as well as Python and C++ bindings and
a Django-based web application. See the OMERO `feature
list <products/feature-list>`_.

The OMERO server is built as a set of separate but linked subsystems.
All imported image data is split into two types: binary pixel data is
stored in an image repository and accessed through the Rendering Engine
and other services while all experimental and image metadata are stored
within a relational database and accessed through the OMERO Metadata
Service. The database is a representation of the `OME Data
Model </site/support/file-formats>`_ and is mapped to objects via
`Hibernate <http://www.hibernate.org>`_.

The suite of Java-based tools for data visualisation and management, the
OMERO clients, is cross-platform. To run on your computer they require
Java 1.5 or 1.6 be installed. This is included with most modern systems
and is an easy install for others from http://java.com.

The OMERO.insight client gets all of its information from a remote OMERO
server — the location of the server is specified at login. Since this
connection utilises a standard network connection, the client can be run
anytime the user is connected to the internet.

There are a number of demonstration videos available on the `Features
List <products/feature-list>`_ page providing an overview of the
applications. For an initial impression please browse out
`screenshots <screenshots>`_. For a detailed overview of the OMERO
clients, see the `OMERO.clients <clients>`_.

This documentation is for the latest version of the OMERO Platform. We
also have archived versions available for `legacy versions of
OMERO </site/support/legacy/>`_.

Most other **technical documentation** is located on the developer
maintained Trac systems for either the
`server <http://trac.openmicroscopy.org.uk/omero/>`_ or
`clients <http://trac.openmicroscopy.org.uk/shoola/>`_.

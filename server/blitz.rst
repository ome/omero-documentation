.. _rst_blitz:

OMERO.blitz
===========

The OMERO.blitz server is responsible for providing secure access to
data and metadata via user sessions (:wiki:`OmeroSessions`)
and cleaning up all resources when they are no longer being used.
Various server capabilities are accessed via a multitude services
collectively known as the :wiki:`OMERO API <OmeroApi>`.

Metadata
~~~~~~~~

Metadata stored in an object-relational database is mapped into the
OMERO :wiki:`ObjectModel` via `Hibernate <http://www.hibernate.org>`_. Hibernate Query Language (HQL)
calls can be made against the server and have all ownership information
automatically taken into account.

Image data
~~~~~~~~~~

The binary image data can either be accessed in its raw form via the
RawPixelsStore service, or can be rendered by the :ref:`rst_rendering` service.
.. _server/blitz:

OMERO.blitz
===========

The OMERO.blitz server is responsible for providing secure access to
data and metadata via user sessions (:ref:`developers/Omero/Server/Sessions`)
and cleaning up all resources when they are no longer being used.
Various server capabilities are accessed via a multitude services
collectively known as the |OmeroApi|.

Metadata
~~~~~~~~

Metadata stored in an object-relational database is mapped into the
OMERO :ref:`developers/Omero/Model` via Hibernate_. Hibernate Query Language (HQL)
calls can be made against the server and have all ownership information
automatically taken into account.

Image data
~~~~~~~~~~

The binary image data can either be accessed in its raw form via the
RawPixelsStore service, or can be rendered by the :ref:`server/rendering` service.
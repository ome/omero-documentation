OMERO.blitz
===========

The OMERO.blitz server is responsible for providing secure access to
data and metadata via user sessions (:doc:`/developers/Server/Sessions`),
and cleaning up all resources when they are no longer being used.
Various server capabilities are accessed via a multitude of services
collectively known as the |OmeroApi|.

Metadata
~~~~~~~~

Metadata stored in an object-relational database is mapped into the
OMERO :doc:`/developers/Model` via Hibernate_. Hibernate Query Language (HQL)
calls can be made against the server and have all ownership information
automatically taken into account.

Image data
~~~~~~~~~~

The binary image data can either be accessed in its raw form via the
RawPixelsStore service, or can be rendered by the :doc:`server-rendering` 
service.
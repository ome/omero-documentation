Deprecated Page

**NOTE: With the introduction of
`OmeroSessions </ome/wiki/OmeroSessions>`_, the license service is
largely deprecated. Rather than managing licenses directly, licenses can
be bound to session count providing the same functionality. Please
contact the mailing list if you are interested.**

--------------

The licenses service is responsible for controlling how many concurrent
users can access ``OMERO.server`` simultaneously.

A sample license store is provided in the
`tools/licenses </ome/browser/ome.git/components/tools/licenses>`_
component. It, however, is not (yet) intended for production use and
defaults to Long.MAX\_VALUE number of licenses.

For each registered user, a license token is created if a license is
available; if not a ``LicenseException`` is thrown.

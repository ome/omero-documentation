Editing OMERO.web
=================

If you need to make changes to OMERO.web itself, then you
will want to check out the OMERO source code and build the server
as described in :doc:`/developers/installation`.

You will then have 2 copies of the OMERO.web code -
source code under ``components/tools/OmeroWeb/omeroweb`` and the server
build under ``dist/lib/python/omeroweb``.

In order to avoid a build step during development, you can delete
the omeroweb code under ``dist`` and replace it with a sym-link
to the source code::

    $ rm -rf dist/lib/python/omeroweb
    $ ln -s /path/to/openmicroscopy/components/tools/OmeroWeb/omeroweb/ /path/to/openmicroscopy/dist/lib/python


You can then run OMERO.web using either of the methods described at :doc:`/developers/Web/Deployment`,
refreshing the browser after saving your code.


Deprecated Page

`ObjectFactoryRegistry </ome/wiki/ObjectFactoryRegistry>`_
----------------------------------------------------------

Ice objects are defined in slice files, primarily under
components/blitz/resources/omero. `OmeroBuild </ome/wiki/OmeroBuild>`_
then turns them into `OmeroJava </ome/wiki/OmeroJava>`_,
`OmeroCpp </ome/wiki/OmeroCpp>`_, and `OmeroPy </ome/wiki/OmeroPy>`_
code. Third-parties can also write their own slice files and have
compiled classes made available to the server (See
`ExtendingOmero </ome/wiki/ExtendingOmero>`_ for more information).

By default, Ice will instantiate a "dumb" base class that it has
generated. If you would like to inject your own smart subclasses of the
base class, then you can use a
`ObjectFactoryRegistry </ome/wiki/ObjectFactoryRegistry>`_ to tell Ice
how to create these classes.

An existing example
~~~~~~~~~~~~~~~~~~~

One such registry used by the server is the
` omero.cmd.RequestObjectFactoryRegistry <https://github.com/openmicroscopy/openmicroscopy/blob/develop/components/blitz/src/omero/cmd/RequestObjectFactoryRegistry.java>`_.
Each command object (e.g. ``omero.cmd.Chgrp``, ``omero.cmd.Delete``,
etc.) are subclasses of ``omero.cmd.Request``. Clients create the dumb
version of these method-objects and fill in the values:

::

       delete = omero.cmd.Delete()
       delete.type = "/Image"
       delete.id = 1
       # Etc.

These are then sent to the server via ``session.submit()``. On the
server-side, however, the ``RequestObjectFactoryRegistrar`` doesn't load
the base object, but instantiates a version which implements the
` omero.cmd.IRequest <https://github.com/openmicroscopy/openmicroscopy/blob/develop/components/blitz/src/omero/cmd/IRequest.java>`_
interface. One concrete example would be
` omero.cmd.graphs.DeleteI <https://github.com/openmicroscopy/openmicroscopy/blob/develop/components/blitz/src/omero/cmd/graphs/DeleteI.java>`_.

Adding your own
~~~~~~~~~~~~~~~

If you would like to add your own command, for example, you would need
to write a slice file and subclass ``omero.cmd.Request``. The definition
of ``omero.cmd.Delete`` is in
` Graphs.ice <https://github.com/openmicroscopy/openmicroscopy/blob/develop/components/blitz/resources/omero/cmd/Graphs.ice>`_.
Then you will need to create your own ``ObjectFactoryRegistrar``
subclass and configuration it in Sprint XML files as described under
`ExtendingOmero </ome/wiki/ExtendingOmero>`_. For example, the
configuration for ``RequestObjectFactoryRegistry`` takes place in
` blitz-servantDefinitions.xml <https://github.com/openmicroscopy/openmicroscopy/blob/develop/components/blitz/resources/ome/services/blitz-servantDefinitions.xml#L343>`_.

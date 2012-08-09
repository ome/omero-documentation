API Changes from 4\_3 to 4\_4
-----------------------------

Cross-language API
~~~~~~~~~~~~~~~~~~

-  Most delete functions have been deprecated. This includes all methods
   in IDelete. The exceptions are:

   -  ``IUpdate.deleteObject`` still attempts to delete a single row
      from the database. No extra logic is included
   -  ``omero.cmd.Delete`` attempts graph wide deletes. This replaces
      ``IDelete.queueDelete([omero.api.delete.DeleteCommand])`` from
      4\_3.

-  ``omero.cmd.Chgrp`` replaces ``IAdmin.changeGroup``. The
   functionality is the same, but ``omero.cmd.Chgrp`` like
   ``omero.cmd.Delete`` allows cancellation.
-  ``omero.api.Gateway`` has been deprecated. All uses of this service
   should be removed before the next version.
-  CallContext?: in order to query in another group, across groups, or
   as a different user, pass a call context argument as the optional
   last argument to any Ice method.

Python API (BlitzGateway?)
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  IDelete and CallContext? (cross-group queries etc) examples have been
   updated on the `OmeroPy </ome/wiki/OmeroPy>`_ page and under
   examples/Training/python

Server-side
~~~~~~~~~~~

-  It's possible to write your own command objects like
   ``omero.cmd.Chgrp`` and ``omero.cmd.Delete`` above and have them
   registered with the server via the
   `ObjectFactoryRegistry </ome/wiki/ObjectFactoryRegistry>`_ `extension
   point </ome/wiki/ExtendingOmero>`_. Clients who try to connect to a
   server missing this command will receive a null response.

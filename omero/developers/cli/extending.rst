Extensions
----------

Plugins can be written and put in the ``lib/python/omero/plugins``
directory. On execution, all plugins in that directory are registered
with the |CLI|.

For testing purposes the ``--path`` argument can be used to point to other
plugin files or directories, too.

Alternatively, plugins can be added to any directory ending with
``omero/plugins``. If this directory is part of the :envvar:`PYTHONPATH` the
|CLI| will automatically include them. An example of such a plugin is
:omero_subs_github_repo_root:`omero-cli-render <omero-cli-render/>`.

Team-supported |CLI| plugins will be pip-installable. Search for
"`omero cli <https://pypi.org/search/?q=omero+cli>`_"
on PyPI_.

Thread-safety
^^^^^^^^^^^^^

The ``omero.cli.CLI`` should be considered not thread-safe. A single
connection object is accessible from all plugins via
``self.ctx.conn(args)``, and it is assumed that changes to this object
will only take place in the current thread. The |CLI| instance itself,
however, can be passed between multiple threads, as long as only one
accesses it sequentially, possibly via locking.

.. seealso::
    |ExtendingOmero|
        Other extensions to OMERO

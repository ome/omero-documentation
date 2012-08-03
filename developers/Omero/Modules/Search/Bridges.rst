Search Bridges
==============

A "bridge" is the mapping between your metadata and how it is stored in
the ` Lucene <http://lucene.apache.org>`_ index.
:ref:`developers/Omero/Modules/Search` uses one internal bridge to parse
all of your metadata for later searching. If, however, there is more
metadata that you would like to add to the index, you can implement the
``org.hibernate.search.bridge.FieldBridge`` interface yourself, or
subclass the helper class
:source:`components/server/src/ome/services/fulltext/BridgeHelper.java`

Example
-------

Assume you wanted to be able to search for a project based on the name
of all images contained in that project. In the set method,

::

        public void set(final String name, final Object value,
                final Document document, final Field.Store store,
                final Field.Index index, final Float boost) {

you would need to add a field to the ``Document`` for each ``Image``.

::

            Project p = (Project) value;
            List<Image> images = getImages(p);
            for (Image image : images) {
                    add(document, "image_name", image.getName(), store, index, boost);

             }

Configuration
-------------

Custom bridges are configured in etc/omero.properties but can be
overridden via the ` standard configuration
mechanisms <https://www.openmicroscopy.org/site/support/omero4/server/installation>`_.
The **omero.search.bridges** property defines a comma-separated list of
bridge classes which will be passed to
:source:`components/server/src/ome/services/fulltext/FullTextBridge.java`.

See :ref:`developers/Server/ExtendingOmero#JavaDeployment`
for how to have your bridge classes included on the server's classpath
if it doesn't get built by the :ref:`developers/Omero/Build`.

Available bridges
-----------------

See :source:`components/server/src/ome/services/fulltext/bridges`
for a list of provided (example) bridges.

Re-indexing
-----------

``BridgeHelper`` provides two methods -- ``reindex(IObject)`` and
``reindexAll(List<IObject>)`` -- for keeping the indexes for objects in
sync.

For example, if the ``image.name`` above were to be changed, the index
for the ``Project`` would be stale until the ``Project`` itself were
re-indexed. Custom bridges can call ``reindex(Project)`` while indexing
the image to have the Project re-indexed from the **backlog**. Before
any new changes are processed, the backlog is always first cleared. One
caveat: while processing the backlog, no new objects can be added to it.

For bridge writers, this means concretely that implementations should
check for all related types and index them in groups, rather than
relying on transitivity. For example,

::

           if (value instanceof Project) {
                final Project p = (Project) value;
                handleProject(p, document, store, index, boost);

                for (final ProjectDatasetLink pdl : p.unmodifiableDatasetLinks()) {
                    final Dataset d = pdl.child();
                    reindex.add(d);
                    handleDataset(d, document, store, index, boost);

                    for (final DatasetImageLink dil : d.unmodifiableImageLinks()) {
                        final Image i = dil.child();
                        reindex.add(i);
                        handleImage(document, store, index, two_step_boost, i);
                    }
                }
            } else if (value instanceof Dataset) {
                final Dataset d = (Dataset) value;
                handleDataset(d, document, store, index, boost);

                for (final ProjectDatasetLink pdl : d.unmodifiableProjectLinks()) {
                    final Project p = pdl.parent();
                    reindex.add(p);
                    handleProject(p, document, store, index, two_step_boost);
                }

                for (final DatasetImageLink dil : d.unmodifiableImageLinks()) {
                    final Image i = dil.child();
                    reindex.add(i);
                    handleImage(document, store, index, two_step_boost, i);
                }

            } else if (value instanceof Image) {

                final Image i = (Image) value;
                handleImage(document, store, index, two_step_boost, i);


                for (final DatasetImageLink dil : i.unmodifiableDatasetLinks()) {
                    final Dataset d = dil.parent();
                    reindex.add(d);
                    handleDataset(d, document, store, index, boost);
                    for (final ProjectDatasetLink pdl : d
                            .unmodifiableProjectLinks()) {
                        final Project p = pdl.parent();
                        reindex.add(p);
                        handleProject(p, document, store, index, boost);
                    }
                }
            }

            //
            // Handle re-indexing
            //
            if (reindex.size() > 0) {
                reindexAll(reindex);
            }

    }

In which case, regardless of whether an Image, Dataset, or Project is
indexed, all related objects are simultaneously added to the backlog,
which will be processed in the next cycle, but **their** indexing will
not add any new values to the backlog.

See :ticket:`955` and :ticket:`1102`

--------------

.. seealso:: :ref:`developers/Omero/Modules/Search`

A service for deletions with model changes
==========================================

**Josh Moore, April/2007**

Note (Jan/2008): A simpler, stateless DeleteService? (IDelete) has been
added, as outlined by `#857 </ome/ticket/857>`_.

::

      public interface DeleteTransaction extends StatefulServiceInterface {

        void addObject(IObject o); // Same semantics as IUpdate.deleteObject
        void addGraph(IObject graph); // Tries to delete all passed items. Unload where needed
        void addCollection(java.util.Collection<IObject> coll); // As previous
        void addAllByQuery(String query, ome.params.Parameters p); // Same query string as IQuery
        IObject[] listObjects();

        void purge();
        void isPurge();
        void useTrashCan();
        void isUseTrashCan();
        void optionallyUseTrashCan();
        void isOptionallUseTrashCan();

        /** 
         * Executes the commit, and returns the number of elements that were actually deleted.
         */
        int commit();

      }

The reason for having a stateful service is that often one would want to
check what is going to be deleted before doing so:

::

       IObject[] objs = iQuery.findAllByQuery("some.long.query",null);
       // check objs
       iDelete.deleteAllByQuery("some.long.query",null);

This unfortunately is tedious *and* hits the db way too often. Instead,
we can encapsulate as a stateful service.

Implementation
--------------

-  **Partial ordering** -- ExtendedMetadata? would offer a Java
   comparator via getPartialOrdering() which would allow a list of
   objects to be ordered by class for individual deletion
-  **GarbageCollector?** -- checks for original files, pixel files, etc.
   that no longer have an entry in the db, and expunges them. This frees
   us from having to worry writing "handlers" which intercept delete
   actions, etc.
-  If the "**trashCan**\ " logic from the interface is to be
   implemented, we'll have to have a "hidden" flag on all IObject
   entities (``IObject.isHidden()``) which clients would be required to
   check.

Issues
------

-  **Thumbnails** and other 3rd person "annotations" which prevent
   entities from being deleted via foreign key constraints -- The
   solutions I see are:

   #. Keep the the thumbnails as they are currently; an admin has to
      delete them.
   #. Give thumbnails a special status ("attribute") so they can be
      deleted. See
      `proposals/Attributes </ome/wiki/proposals/Attributes>`_
   #. Rework the security system; changing our concept of "links"

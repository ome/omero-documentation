Collection Counts
=================

The
:source:`IPojos <components/common/src/ome/api/IPojos.java>`
interface has always provided a method for returning the count of some
collection types via ``getDetails().getCounts()``. Previous to
3.0-Beta3, the counting process was fairly time intensive, and has been
removed.

In its place, the 3.0-Beta3 server has database views for all link
collections. These are accessed through HQL directly, such as:

::

       Long self = iAdmin.getEventContext().getCurrentUserId();
       Image i = iQuery.findByQuery(
          "select i from Image i left outer join fetch i.annotationLinksCountPerOwner", null);
       Map<Long, Long> countsPerOwner = i.getAnnotationLinksCountPerOwner();

       // Map may be null if not fetched.
       if (countsPerOwner != null) {
           
           // countOfAnnotationsForImageByUser 
           Long count = countsPerOwner.get(self);
           if (count != null) {
               // do something
           }
       }

Values written to the map will not be persisted to the database, since
they are continually re-generated.

Pojo Options
------------

The
:source:`PojoOptions <components/model/src/ome/util/builders/PojoOptions.java>`
configuration of what elements are counted has been removed from the
API. Instead, the returned map contains all values for all users, and
can be summed to acquire the total count.

Restrictions
------------

Currently a Hibernate bug (waiting to be filed) prevents retrieving the
counts on any other than the top-level object ("select this").

Instructions
------------

Starting with ``OMERO3A__3``, the views.sql script is automatically
executed when initializing your database. If you have an older database,
upgrade it to the latest version, and apply the ``views.sql`` manually.

--------------

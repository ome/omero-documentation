Collection counts
=================

The
:common_source:`IContainer <src/main/java/ome/api/IContainer.java>`
interface has always provided a method for returning the count of some
collection types via ``getDetails().getCounts()``. The server has database
views for all link collections. These are accessed through HQL directly, such
as:

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

Pojo options
------------

The PojoOptions configuration of what elements are counted has been
removed from the API. Instead, the returned map contains all values for
all users, and can be summed to acquire the total count.

Restrictions
------------

Currently a Hibernate bug (waiting to be filed) prevents retrieving the
counts on any other than the top-level object ("select this").

Instructions
------------

The views.sql script is automatically executed when initializing your
database.
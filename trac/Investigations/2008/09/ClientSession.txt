Our `ClientSession </ome/wiki/proposals/ClientSession>`_
(`source </ome/browser/ome.git/components/client/src/ome/client/Session.java>`_)
is a modified version of Fowler's UnitOfWork. More specifically, it
allows for the following methods:

ome.client.Session
------------------

-  ``__register()__`` : add a new or persisted object. Since we have
   rules about separating new from persisted objects, this can be done
   in one step.
-  ``find()`` : find registered, non-deleted, non-new entity.
-  ``markDirty()`` : does as told. On next flush(), state will be saved.
-  ``delete()`` : marks an object for deletion. Future calls to
   checkOut() will return null
-  ``checkOut()`` : returns the current copy of a given object
-  ``flush()`` : use
   `IUpdate </ome/browser/http?rev=%2F%2Fcvs.openmicroscopy.org.uk%2Fviewcvs%2Ftrunk%2Fcomponents%2Fcommon%2Fsrc%2Fome%2Fapi%2FIUpdate.java>`_
   instance acquired from the
   `ServiceFactory </ome/wiki/ServiceFactory>`_ passed in on
   construction to synchronize with the database. This essentially
   replaces the write methods on IPojos.
-  ``close()`` : all subsequent calls throw an exception. Storage is
   released.

And as opposed to insert, update, and delete arrays, we store our state
in a Storage instance
([souce:trunk/components/client/src/ome/client/Storage.java source])
which tracks inserts, deletes, updates, all objects, and replacements
for inserted objects.

Conflicts
---------

Other than replacing old objects with new objects (effectively updating
the version field of
`IMutable </ome/browser/ome.git/components/common/src/ome/model/IMutable.java>`_)
`ClientSession </ome/wiki/proposals/ClientSession>`_ can also mitigate
conflicts. A conflict arises when an object is registered, an early
version of which has already been marked dirty or deleted.

To handle this, the `ClientSession </ome/wiki/proposals/ClientSession>`_
also has a
`ConflictResolver </ome/browser/ome.git/components/client/src/ome/client/ConflictResolver>`_
which has a chance to suggest a replacement for the object. Currently
the default resolver justs throws an exception, but resolvers which
provide a pop-up to users would be straight-forward.

Wrappers
--------

To make working with this as easy as possible, and ease the hot-swapping
needed for values, the
`Pojos </ome/browser/ome.git/components/shoola-adapter/src/pojos>`_ have
been turned into proxies (See:
` TombStone <http://c2.com/cgi/wiki?TombStone>`_ or more generally
` HandleBodyPattern <http://c2.com/cgi/wiki?HandleBodyPattern>`_) which
check the `ClientSession </ome/wiki/proposals/ClientSession>`_ on all
access (GettersAndSetters).

Threading
---------

`ClientSession </ome/wiki/proposals/ClientSession>`_ is not
multi-threaded. Access to it should be restricted to one thread or
externally synchronized.

Future directions
-----------------

Since the `ClientSession </ome/wiki/proposals/ClientSession>`_ has a
`ServiceFactory </ome/wiki/ServiceFactory>`_ it can also acquire an
IQuery for LazyLoading. This can be used by all with the find() method,
or can be wrapped with the Pojos so that any accessor which detects an
unloaded (See: `ObjectModel </ome/wiki/ObjectModel>`_) can call
clientSession.find() and replace it.

Requirements
------------

#. An object in the presentation layer can have its backend delegate
   "hot-swapped". (What needs to happen then? Events?)
#. An objects of a given type and with a given id will only occur once
   within a session. If an agent attempts to register an object of equal
   type and id, the conflict resolver will be called.
#. New, dirty, and deleted objects should be kept track of. Dirties and
   deletes produce conflicts. News are benign. (Good grammatic, eh?)
#. The replacement values for new objects must be tracked so that on
   subsequent checkOut()s all agents receive the new value.

Possible:
---------

-  Does ome.client.Session need to be synchronized?
-  Property change events. Would this cause havoc in the refreshing of
   agents?

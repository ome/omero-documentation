Developing OMERO clients
========================

.. note::

    - If you are only interested in **using** our OMERO clients, please
      see the :doc:`/users/clients-overview` section, which
      will point you to user guides, demo videos, and download sites.

    - This page is intended for developers already familiar with
      client/server programming. If you are not, **your best starting
      point is to read the**
      :zerocdoc:`Hello World <display/Ice/Hello+World+Application>`
      **chapter of the Ice manual (or more)**. A deeper understanding of
      Ice might not be necessary, but certainly understanding the Ice
      basics will make reading this guide **much** easier.


For developers, there are many examples listed below, all of which are
stored under: :sourcedir:`examples` and
buildable/runnable via `scons <https://www.scons.org>`_:

::

      cd omero-src
      ./build.py build-all
      cd omero-src/examples
      python ../target/scons/scons.py

Other examples (in Python) can be found :doc:`here </developers/Python>`.

Introduction
------------

A Blitz client is any application which uses the
|OmeroApi| to talk to the :doc:`/developers/server-blitz` server in any of the supported
languages, like :doc:`Python </developers/Python>`,
:doc:`C++ </developers/Cpp>`, :doc:`Java </developers/Java>`, or
:doc:`MATLAB </developers/Matlab>`. A general understanding of the
:doc:`/developers/Server` may make what is happening
behind the scenes more transparent, but is not necessary. The points
below outline all that an application writer is expected to know with
links to further information where necessary.


Distributed computing
---------------------

The first hurdle when beginning to work with OMERO is to realize that
building distributed-object systems is different from both building
standalone clients and writing web applications in frameworks like
mod\_perl, django, or Ruby on Rails. The remoting framework used by
OMERO is Ice_ from ZeroC. Ice is comparable
to CORBA in many ways, but is typically easier to use.

A good first step is to be aware of the difference between remote and
local invocations. Any invocation on a proxy (``<class_name>Prx``,
described below) will result in a call over the network with all the
costs that entails. The often-cited `fallacies of distributed
computing <https://en.wikipedia.org/wiki/Fallacies_of_Distributed_Computing>`_
all apply, and the developer must be aware of concurrency and latency
issues, as well as complete loss of connectivity, all of which we will
discuss below.

.. _AdvancedClientDevelopment#Objects:

Objects
-------

Before we can begin talking about what you can do with OMERO (the remote
method calls available in the |OmeroApi|), it is
helpful to first know what the objects are that we will be distributing.
These are the only types that can pass through the API.

"Slice" mapping language
^^^^^^^^^^^^^^^^^^^^^^^^

Ice provides an `interface definition language
(IDL) <https://en.wikipedia.org/wiki/Interface_description_language>`_
for defining class hierarchies for passing data in a binary format.
Similar to WSDL in web services or CORBA's IDL, slice provides a way to
specify how types can pass between different programming languages. For
just that reason, several constructs not available in all the supported
languages are omitted:

-  multiple inheritance (C++ and Python)
-  nullable primitive wrappers (e.g. Java's java.lang.Integer)
-  interfaces (Java)
-  HashSet types
-  iterator types

Primitives
^^^^^^^^^^

Slice defines the usual primitives -- ``long``, ``string``, ``bool``, as
well as ``int``, ``double``, and ``float`` -- which map into each
language as would be expected. Aliases like "Ice::Long" are available
for C++ to handle both 32 and 64 bit architectures.

A simple struct can then be built out of any combination of these types.
From :blitz_source:`src/main/slice/omero/System.ice`:

::

        // The EventContext is all the information the server knows about a
        // given method call, including user, read/write status, etc.
        class EventContext
        {
          …
          long   userId;
          string userName;
          …
          bool   isAdmin;
          …

Sequences, dictionaries, enums, and constants
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Other than the "user-defined classes" which we will get to below, slice
provides only four built-in building blocks for creating a type hierarchy.

-  **Sequences.** & **Dictionaries** : Most of the sequences and
   dictionaries in use by the |OmeroApi| are
   defined in :blitz_source:`src/main/slice/omero/Collections.ice`.
   Each sequence or dictionary must be defined before it can be used in
   any class. By default a sequence will map to an array of the given
   type in Java or a vector in C++, but these mappings can be changed
   via metadata. (In most cases, a ``List`` is used in the Java
   mapping).

-  **Constants.** : Most of the enumerations for
   |OmeroApi| are defined in
   :blitz_source:`src/main/slice/omero/Constants.ice`.
   These are values which can be defined once and then referenced in
   each of the supported programming languages. The only real surprise
   when working with enumerations is that in Java each constant is
   mapped to an interface with a single ``public final static`` field
   named "value".

::

    #include <iostream>
    #include <omero/Constants.h>
    using namespace omero::constants;
    int main() {
        std::cout << "By default, no method call can pass more than ";
        std::cout << MESSAGESIZEMAX << "kb" << std::endl;
        std::cout << "By default, client.createSession() will wait ";
        std::cout << (CONNECTTIMEOUT / 1000) << " seconds for a connection" << std::endl;
    }

Example: :source:`examples/OmeroClients/constants.cpp`

::

    sz=omero.constants.MESSAGESIZEMAX.value;
    to=omero.constants.CONNECTTIMEOUT.value/1000;
    disp(sprintf('By default, no method call can pass more than %d kb',sz));
    disp(sprintf('By default, client.createSession() will wait %d seconds for a connection', to));

Example: :source:`examples/OmeroClients/constants.m`

::

    from omero.constants import *
    print("By default, no method call can pass more than %s kb" % MESSAGESIZEMAX)
    print("By default, client.createSession() will wait %s seconds for a connection" % (CONNECTTIMEOUT/1000))

Example: :source:`examples/OmeroClients/constants.py`

::

    import static omero.rtypes.*;
    public class constants {
        public static void main(String[] args) {
            System.out.println(String.format(
                "By default, no method call can pass more than %s kb",
                omero.constants.MESSAGESIZEMAX.value));
            System.out.println(String.format(
                "By default, client.createSession() will wait %s seconds for a connection",
                omero.constants.CONNECTTIMEOUT.value/1000));
        }
    }

Example: :source:`examples/OmeroClients/constants.java`

-  **Enums.** Finally, enumerations which are less used through
   |OmeroApi|, but which can be useful for
   simplyifying working with constants.

::

    #include <iostream>
    #include <omero/Constants.h>
    using namespace omero::constants::projection;
    int main() {
        std::cout << "IProjection takes arguments of the form: ";
        std::cout << MAXIMUMINTENSITY;
        std::cout << std::endl;
    }

Example: :source:`examples/OmeroClients/enumerations.cpp`

::

    v=omero.constants.projection.ProjectionType.MAXIMUMINTENSITY.value();
    disp(sprintf('IProjection takes arguments of the form: %s', v));

Example: :source:`examples/OmeroClients/enumerations.m`

::

    import omero
    import omero_Constants_ice
    print("IProjection takes arguments of the form: %s" % omero.constants.projection.ProjectionType.MAXIMUMINTENSITY)

Example: :source:`examples/OmeroClients/enumerations.py`

::

    public class enumerations {
        public static void main(String[] args) {
            System.out.println(String.format(
               "IProjection takes arguments of the form: %s",
                 omero.constants.projection.ProjectionType.MAXIMUMINTENSITY));
        }
    }

Example: :source:`examples/OmeroClients/enumerations.java`

RTypes
^^^^^^

In Java, the Ice primitives map to non-nullable primitives. And in fact,
for the still nullable types ``java.lang.String`` as well as all
collections and arrays, Ice goes so far as to send an empty string ("")
or collection([]) rather than null.

However, the database and OMERO support nullable values and so
:doc:`/developers/server-blitz` defines a hierarchy of types which
wraps the primitives: :blitz_source:`RTypes <src/main/slice/omero/RTypes.ice>`
Since Ice allows references to be nulled, as opposed to primitives, it is
possible to send null strings, integers, etc.

::

    #include <omero/RTypesI.h>
    using namespace omero::rtypes;
    int main() {
        omero::RStringPtr s = rstring("value");
        omero::RBoolPtr b = rbool(true);
        omero::RLongPtr l = rlong(1);
        omero::RIntPtr i = rint(1);
    }

Example: :source:`examples/OmeroClients/primitives.cpp`

::

    import omero.rtypes;
    a = rtypes.rstring('value');
    b = rtypes.rbool(true);
    l = rtypes.rlong(1);
    i = rtypes.rint(1);

Example: :source:`examples/OmeroClients/primitives.m`

::

    from omero.rtypes import *
    s = rstring("value")
    b = rbool(True)
    l = rlong(1)
    i = rint(1)

Example: :source:`examples/OmeroClients/primitives.py`

::

    import static omero.rtypes.*;
    public class primitives {
        public static void main(String[] args) {
            omero.RString a = rstring("value");
            omero.RBool b = rbool(true);
            omero.RLong l = rlong(1l);
            omero.RInt i = rint(1);
        }
    }

Example: :source:`examples/OmeroClients/primitives.java`

The same works for collections. The RCollection subclass of RType holds
a sequence of any other RType.

::

    #include <omero/RTypesI.h>
    using namespace omero::rtypes;
    int main() {
        // Sets and Lists may be interpreted differently on the server
        omero::RListPtr l = rlist(); // rstring("a"), rstring("b"));
        omero::RSetPtr s = rset();   // rint(1), rint(2));
                                     // No-varargs (#1242)
    }

Example: :source:`examples/OmeroClients/rcollection.cpp`

::

    % Sets and Lists may be interpreted differently on the server
    ja = javaArray('omero.RString',2);
    ja(1) = omero.rtypes.rstring('a');
    ja(2) = omero.rtypes.rstring('b');
    list = omero.rtypes.rlist(ja)
    ja = javaArray('omero.RInt',2);
    ja(1) = omero.rtypes.rint(1);
    ja(2) = omero.rtypes.rint(2);
    set = omero.rtypes.rset(ja)

Example: :source:`examples/OmeroClients/rcollection.m`

::

    import omero
    from omero.rtypes import *
    # Sets and Lists may be interpreted differently on the server
    list = rlist(rstring("a"), rstring("b"));
    set = rset(rint(1), rint(2));

Example: :source:`examples/OmeroClients/rcollection.py`

::

    import static omero.rtypes.*;
    public class rcollection {
        public static void main(String[] args) {
            // Sets and Lists may be interpreted differently on the server
            omero.RList list = rlist(rstring("a"), rstring("b"));
            omero.RSet set = rset(rint(1), rint(2));
        }
    }

Example: :source:`examples/OmeroClients/rcollection.java`

A further benefit of the RTypes is that they support **polymorphism**.
The original |OmeroApi| was designed strictly for
Java, in which the ``java.lang.Object`` type or collections of
``java.lang.Object`` could be passed. This is not possible with Ice,
since there is no ``Any`` type as there is in CORBA.

Instead, ``omero.RType`` is the abstract superclass of our "**r**\ emote
**type**" hierarchy, and any method which takes an "RType" can take any
subclass of "RType".

To allow other types discussed later to also take part in the
polymorphism, it is necessary to include RType wrappers for them. This
is the category that ``omero::RObject`` and ``omero::RMap`` fall into.

``omero::RTime`` and ``omero::RClass`` fall into a different category.
They are identical to ``omero::RLong`` and ``omero::RString``,
respectively, but are provided as type safe variants.

OMERO model objects
^^^^^^^^^^^^^^^^^^^

With these components -- rtypes, primitives, constants, etc. -- it is
possible to define the core nouns of OME, the |OmeroModel|. The OMERO
|OmeroModel| is a translation of the 
:model_doc:`OME XML specification <ome-xml/>` 
into objects for use by the server, built out of RTypes, sequences and 
dictionaries, and Details.

Details
~~~~~~~

The ``omero.model.Details`` object contains security and other internal
information which does not contain any domain value. Attempting to set
any values which are not permitted, will result in a
``SecurityViolation``, for example trying to change the
``details.owner`` to the current user.

::

    #include <omero/model/ImageI.h>
    #include <omero/model/PermissionsI.h>
    using namespace omero::model;
    int main() {
        ImagePtr image = new ImageI();
        DetailsPtr details = image->getDetails();
        PermissionsPtr p = new PermissionsI();
        p->setUserRead(true);
        assert(p->isUserRead());
        details->setPermissions(p);
        // Available when returned from server
        // Possibly modifiable
        details->getOwner();
        details->setGroup(new ExperimenterGroupI(1L, false));
        // Available when returned from server
        // Not modifiable
        details->getCreationEvent();
        details->getUpdateEvent();
    }

Example: :source:`examples/OmeroClients/details.cpp`

::

    image = omero.model.ImageI();
    details_ = image.getDetails();
    p = omero.model.PermissionsI();
    p.setUserRead(true);
    assert( p.isUserRead() );
    details_.setPermissions( p );
    % Available when returned from server
    % Possibly modifiable
    details_.getOwner();
    details_.setGroup( omero.model.ExperimenterGroupI(1, false) );
    % Available when returned from server
    % Not modifiable
    details_.getCreationEvent();
    details_.getUpdateEvent();

Example: :source:`examples/OmeroClients/details.m`

::

    import omero
    import omero.clients
    image = omero.model.ImageI()
    details = image.getDetails()
    p = omero.model.PermissionsI()
    p.setUserRead(True)
    assert p.isUserRead()
    details.setPermissions(p)
    # Available when returned from server
    # Possibly modifiable
    details.getOwner()
    details.setGroup(omero.model.ExperimenterGroupI(1L, False))
    # Available when returned from server
    # Not modifiable
    details.getCreationEvent()
    details.getUpdateEvent()

Example: :source:`examples/OmeroClients/details.py`

::

    import omero.model.Image;
    import omero.model.ImageI;
    import omero.model.Details;
    import omero.model.Permissions;
    import omero.model.PermissionsI;
    import omero.model.ExperimenterGroupI;
    public class details {
        public static void main(String args[]) {
            Image image = new ImageI();
            Details details = image.getDetails();
            Permissions p = new PermissionsI();
            p.setUserRead(true);
            assert p.isUserRead();
            details.setPermissions(p);
            // Available when returned from server
            // Possibly modifiable
            details.getOwner();
            details.setGroup(new ExperimenterGroupI(1L, false));
            // Available when returned from server
            // Not modifiable
            details.getCreationEvent();
            details.getUpdateEvent();
        }
    }

Example: :source:`examples/OmeroClients/details.java`

.. warning::

  Do *not* use :ref:`IQuery`'s :slicedoc_blitz:`projection
  <omero/api/IQuery.html#projection>` operation to read a data object
  *obj*'s ``obj.details.permissions`` field because it can give a
  misleading result. Instead :ref:`OMERO.web <web_index>` instantiates a
  Map in reading ``obj_details_permissions``. This pattern is shown in
  the first section of OME's :presentations:`Hibernate 3.5 Training
  <2017/Team-Training/Hibernate/>` where it covers the querying of
  permissions.

ObjectFactory and casting
~~~~~~~~~~~~~~~~~~~~~~~~~

In the previous examples, you may have noticed how there are two classes
for each type: ``Image`` and ``ImageI``. Classes defined in slice are by
default data objects, more like C++'s ``struct``\ s than anything else.
As soon as a class defines a method, however, it becomes an abstract
entity and requires application writers to provide a **concrete
implementation** (hence the "I"). All OMERO classes define methods, but
OMERO takes care of providing the implementations for you via code
generation. For each slice-defined and Ice-generated class
``omero.model.Something``, there is an OMERO-generated class
``omero.model.SomethingI`` which can be instantiated.

::

    #include <omero/model/ImageI.h>
    #include <omero/model/DatasetI.h>
    using namespace omero::model;
    int main() {
        ImagePtr image = new ImageI();
        DatasetPtr dataset = new DatasetI(1L, false);
        image->linkDataset(dataset);
    }

Example: :source:`examples/OmeroClients/constructors.cpp`

::

    import omero.model.*;
    image = ImageI();
    dataset = DatasetI(1, false);
    image.linkDataset(dataset)

Example: :source:`examples/OmeroClients/constructors.m`

::

    import omero
    import omero.clients
    image = omero.model.ImageI()
    dataset = omero.model.DatasetI(long(1), False)
    image.linkDataset(dataset)

Example: :source:`examples/OmeroClients/constructors.py`

::

    import java.util.Iterator;
    import omero.model.Image;
    import omero.model.ImageI;
    import omero.model.Dataset;
    import omero.model.DatasetI;
    import omero.model.DatasetImageLink;
    import omero.model.DatasetImageLinkI;
    public class constructors {
        public static void main(String args[]) {
            Image image = new ImageI();
            Dataset dataset = new DatasetI(1L, false);
            image.linkDataset(dataset);
        }
    }

Example: :source:`examples/OmeroClients/constructors.java`

When |OmeroModel|  instances are serialized
over the wire and arrive in the client, the Ice runtime must determine
which constructor to call. It consults with the ObjectFactory, also
provided by OMERO, to create the new classes. If you would like to have
your own classes or subclasses created on deserialization, see the
``Advanced topics`` section below.

Such concrete implementations provide features which are not available
in the solely Ice-based versions. When you would like to use these 
features, it is necessary to down-cast to the OMERO-based type.

For example, objects in each language binding provide a "more natural"
form of iteration for that language.

::

    #include <omero/model/ImageI.h>
    #include <omero/model/DatasetI.h>
    #include <omero/model/DatasetImageLinkI.h>
    using namespace omero::model;
    int main() {
        ImageIPtr image = new ImageI();
        DatasetIPtr dataset = new DatasetI();
        DatasetImageLinkPtr link = dataset->linkImage(image);
        omero::model::ImageDatasetLinksSeq seq = image->copyDatasetLinks();
        ImageDatasetLinksSeq::iterator beg = seq.begin();
        while(beg != seq.end()) {
            beg++;
        }
    }

Example: :source:`examples/OmeroClients/iterators.cpp`

::

    import omero.model.*;
    image = ImageI();
    dataset = DatasetI();
    link = dataset.linkImage(image);
    it = image.iterateDatasetLinks();
    while it.hasNext()
       it.next().getChild().getName()
    end

Example: :source:`examples/OmeroClients/iterators.m`

::

    import omero
    from omero_model_ImageI import ImageI
    from omero_model_DatasetI import DatasetI
    from omero_model_DatasetImageLinkI import DatasetImageLinkI
    image = ImageI()
    dataset = DatasetI()
    link = dataset.linkImage(image)
    for link in image.iterateDatasetLinks():
        link.getChild().getName();

Example: :source:`examples/OmeroClients/iterators.py`

::

    import omero.model.ImageI;
    import omero.model.Dataset;
    import omero.model.DatasetI;
    import omero.model.DatasetImageLink;
    import omero.model.DatasetImageLinkI;
    import java.util.*;
    public class iterators {
        public static void main(String args[]) {
            ImageI image = new ImageI();
            Dataset dataset = new DatasetI();
            DatasetImageLink link = dataset.linkImage(image);
            Iterator<DatasetImageLinkI> it = image.iterateDatasetLinks();
            while (it.hasNext()) {
                it.next().getChild().getName();
            }
        }
    }

Example: :source:`examples/OmeroClients/iterators.java`

]

Also, each concrete implementation provides static constants of various
forms.

::

    #include <omero/model/ImageI.h>
    #include <iostream>
    int main() {
            std::cout << omero::model::ImageI::NAME << std::endl;
            std::cout << omero::model::ImageI::DATASETLINKS << std::endl;
    }

Example: :source:`examples/OmeroClients/staticfields.cpp`

::

    disp(omero.model.ImageI.NAME);
    disp(omero.model.ImageI.DATASETLINKS);

Example: :source:`examples/OmeroClients/staticfields.m`

::

    import omero
    from omero_model_ImageI import ImageI as ImageI
    print(ImageI.NAME)
    print(ImageI.DATASETLINKS)

Example: :source:`examples/OmeroClients/staticfields.py`

::

    import omero.model.ImageI;
    public class staticfields {
        public static void main(String[] args) {
            System.out.println(ImageI.NAME);
            System.out.println(ImageI.DATASETLINKS);
        }
    }

Example: :source:`examples/OmeroClients/staticfields.java`

Visibility and loadedness
~~~~~~~~~~~~~~~~~~~~~~~~~

In the constructor example above, a constructor with two arguments was
used to create the ``Dataset`` instance linked to the new ``Image``. The
``Dataset`` instance so created is considered "unloaded".

Objects and collections can be created unloaded as a pointer to an
actual instance or they may be returned unloaded from the server when
they are not actively accessed in a query. Because of the
interconnectedness of the |OmeroModel|,
loading one object could conceivably require downloading a large part of
the database if there were not some way to "snip-off" sections.

::

    #include <omero/model/ImageI.h>
    #include <omero/model/DatasetI.h>
    #include <omero/ClientErrors.h>
    using namespace omero::model;
    int main() {
        ImagePtr image = new ImageI();         // A loaded object by default
        assert(image->isLoaded());
        image->unload();                       // can then be unloaded
        assert(! image->isLoaded());
        image = new ImageI( 1L, false );       // Creates an unloaded "proxy"
        assert(! image->isLoaded());
        image->getId();                        // Ok
        try {
            image->getName();                  // No data access is allowed other than id.
        } catch (const omero::ClientError& ce) {
            // Ok.
        }
    }

Example: :source:`examples/OmeroClients/unloaded.cpp`

::

    image = omero.model.ImageI();                 % A loaded object by default
    assert(image.isLoaded());
    image.unload();
    assert( ~ image.isLoaded() );                 % can then be unloaded
    image = omero.model.ImageI( 1, false );
    assert( ~ image.isLoaded() );                 % Creates an unloaded "proxy"
    image.getId();                                % Ok.
    try
        image.getName();                          % No data access is allowed other than id
    catch ME
        % OK
    end

Example: :source:`examples/OmeroClients/unloaded.m`

::

    import omero
    import omero.clients
    image = omero.model.ImageI()                # A loaded object by default
    assert image.isLoaded()
    image.unload()                              # can then be unloaded
    assert (not image.isLoaded())
    image = omero.model.ImageI( 1L, False )     # Creates an unloaded "proxy"
    assert (not image.isLoaded())
    image.getId()                               # Ok
    try:
        image.getName()                         # No data access is allowed other than id.
    except:
        pass

Example: :source:`examples/OmeroClients/unloaded.py`

::

    import omero.model.ImageI;
    public class unloaded {
        public static void main(String args[]) {
            ImageI image = new ImageI();           // A loaded object by default
            assert image.isLoaded();
            image.unload();                        // can then be unloaded
            assert ! image.isLoaded();
            image = new ImageI( 1L, false );       // Creates an unloaded "proxy"
            assert ! image.isLoaded();
            image.getId();                         // Ok.
            try {
                image.getName();                   // No data access is allowed other than id.
            } catch (Exception e) {
                // Ok.
            }
        }
    }

Example: :source:`examples/OmeroClients/unloaded.java`

When saving objects that have unloaded instances in their graph, the
server will automatically fill in the values. So, if your ``Dataset``
contains a collection of ``Image``\ s, all of which are unloaded, then
they will be reloaded before saving, based on the id. If, however, you
had tried to set a value on one of the ``Image``\ s, you will get an
exception.

To prevent errors when working with unloaded objects, all the
|OmeroModel| classes are marked as protected
in the slice definitions which causes the implementations in each
language to try to hide the fields. In Java and C++ this results in
fields with "protected" visibility. In Python, an underscore is prefixed
to all the variables. (In the Python case, we have also tried to
"strengthen" the hiding of the fields, by overriding ``__setattr__``.
This is not full proof, but only so much can be done to hide values in
Python.)

Collections
~~~~~~~~~~~

Just as an entire object can be unloaded, any collection field can also
be unloaded. However, as mentioned above, since it is not possible to
send a null collection over the wire with Ice and working with RTypes
can be inefficient, all the |OmeroModel| collections are hidden behind several methods.

::

    #include <omero/model/DatasetI.h>
    #include <omero/model/DatasetImageLinkI.h>
    #include <omero/model/EventI.h>
    #include <omero/model/ImageI.h>
    #include <omero/model/PixelsI.h>
    using namespace omero::model;
    int main(int argc, char* argv[]) {
        ImagePtr image = new ImageI(1, true);
        image->getDetails()->setUpdateEvent( new EventI(1L, false) );
        // On creation, all collections are
        // initialized to empty, and can be added
        // to.
        assert(image->sizeOfDatasetLinks() == 0);
        DatasetPtr dataset = new DatasetI(1L, false);
        DatasetImageLinkPtr link = image->linkDataset(dataset);
        assert(image->sizeOfDatasetLinks() == 1);
        // If you want to work with this collection,
        // you'll need to get a copy.
        ImageDatasetLinksSeq links = image->copyDatasetLinks();
        // When you are done working with it, you can
        // unload the datasets, assuming the changes
        // have been persisted to the server.
        image->unloadDatasetLinks();
        assert(image->sizeOfDatasetLinks() < 0);
        try {
            image->linkDataset( new DatasetI() );
        } catch (…) {
            // Can't access an unloaded collection
        }
        // The reload...() method allows one instance
        // to take over a collection from another, if it
        // has been properly initialized on the server.
        // sameImage will have its collection unloaded.
        ImagePtr sameImage = new ImageI(1L, true);
        sameImage->getDetails()->setUpdateEvent( new EventI(1L, false) );
        sameImage->linkDataset( new DatasetI(1L, false) );
        image->reloadDatasetLinks( sameImage );
        assert(image->sizeOfDatasetLinks() == 1);
        assert(sameImage->sizeOfDatasetLinks() < 0);
        // If you would like to remove all the member
        // elements from a collection, don't unload it
        // but "clear" it.
        image->clearDatasetLinks();
        // Saving this to the database will remove
        // all dataset links!
        // Finally, all collections can be unloaded
        // to use an instance as a single row in the database.
        image->unloadCollections();
        // Ordered collections have slightly different methods.
        image = new ImageI(1L, true);
        image->addPixels( new PixelsI() );
        image->getPixels(0);
        image->getPrimaryPixels(); // Same thing
        image->removePixels( image->getPixels(0) );
    }

Example: :source:`examples/OmeroClients/collectionmethods.cpp`

::

    import omero.model.*;
    image = ImageI(1, true);
    image.getDetails().setUpdateEvent( EventI(1, false) );
    % On creation, all collections are
    % initialized to empty, and can be added
    % to.
    assert(image.sizeOfDatasetLinks() == 0);
    dataset = DatasetI(1, false);
    link = image.linkDataset(dataset);
    assert(image.sizeOfDatasetLinks() == 1);
    % If you want to work with this collection,
    % you'll need to get a copy.
    links = image.copyDatasetLinks();
    % When you are done working with it, you can
    % unload the datasets, assuming the changes
    % have been persisted to the server.
    image.unloadDatasetLinks();
    assert(image.sizeOfDatasetLinks() < 0);
    try
        image.linkDataset( DatasetI() );
    catch ME
        % Can't access an unloaded collection
    end
    % The reload...() method allows one instance
    % to take over a collection from another, if it
    % has been properly initialized on the server.
    % sameImage will have its collection unloaded.
    sameImage = ImageI(1, true);
    sameImage.getDetails().setUpdateEvent( EventI(1, false) );
    sameImage.linkDataset( DatasetI(1, false) );
    image.reloadDatasetLinks( sameImage );
    assert(image.sizeOfDatasetLinks() == 1);
    assert(sameImage.sizeOfDatasetLinks() < 0);
    % If you would like to remove all the member
    % elements from a collection, don't unload it
    % but "clear" it.
    image.clearDatasetLinks();
    % Saving this to the database will remove
    % all dataset links!
    % Finally, all collections can be unloaded
    % to use an instance as a single row in the database.
    image.unloadCollections();
    % Ordered collections have slightly different methods.
    image = ImageI(1, true);
    image.addPixels( PixelsI() );
    image.getPixels(0);
    image.getPrimaryPixels(); % Same thing
    image.removePixels( image.getPixels(0) );

Example: :source:`examples/OmeroClients/collectionmethods.m`

::

    import omero
    import omero.clients
    ImageI = omero.model.ImageI
    DatasetI = omero.model.DatasetI
    EventI = omero.model.EventI
    PixelsI = omero.model.PixelsI
    image = ImageI(long(1), True)
    image.getDetails().setUpdateEvent( EventI(1L, False) )
    # On creation, all collections are
    # initialized to empty, and can be added
    # to.
    assert image.sizeOfDatasetLinks() == 0
    dataset = DatasetI(long(1), False)
    link = image.linkDataset(dataset)
    assert image.sizeOfDatasetLinks() == 1
    # If you want to work with this collection,
    # you'll need to get a copy.
    links = image.copyDatasetLinks()
    # When you are done working with it, you can
    # unload the datasets, assuming the changes
    # have been persisted to the server.
    image.unloadDatasetLinks()
    assert image.sizeOfDatasetLinks() < 0
    try:
        image.linkDataset( DatasetI() )
    except:
        # Can't access an unloaded collection
        pass
    # The reload...() method allows one instance
    # to take over a collection from another, if it
    # has been properly initialized on the server.
    # sameImage will have its collection unloaded.
    sameImage = ImageI(1L, True)
    sameImage.getDetails().setUpdateEvent( EventI(1L, False) )
    sameImage.linkDataset( DatasetI(long(1), False) )
    image.reloadDatasetLinks( sameImage )
    assert image.sizeOfDatasetLinks() == 1
    assert sameImage.sizeOfDatasetLinks() < 0
    # If you would like to remove all the member
    # elements from a collection, don't unload it
    # but "clear" it.
    image.clearDatasetLinks()
    # Saving this to the database will remove
    # all dataset links!
    # Finally, all collections can be unloaded
    # to use an instance as a single row in the database.
    image.unloadCollections()
    # Ordered collections have slightly different methods.
    image = ImageI(long(1), True)
    image.addPixels( PixelsI() )
    image.getPixels(0)
    image.getPrimaryPixels() # Same thing
    image.removePixels( image.getPixels(0) )

Example: :source:`examples/OmeroClients/collectionmethods.py`

::

    import omero.model.Dataset;
    import omero.model.DatasetI;
    import omero.model.DatasetImageLink;
    import omero.model.DatasetImageLinkI;
    import omero.model.EventI;
    import omero.model.Image;
    import omero.model.ImageI;
    import omero.model.Pixels;
    import omero.model.PixelsI;
    import java.util.*;
    public class collectionmethods {
        public static void main(String args[]) {
            Image image = new ImageI(1, true);
            image.getDetails().setUpdateEvent( new EventI(1L, false) );
            // On creation, all collections are
            // initialized to empty, and can be added
            // to.
            assert image.sizeOfDatasetLinks() == 0;
            Dataset dataset = new DatasetI(1L, false);
            DatasetImageLink link = image.linkDataset(dataset);
            assert image.sizeOfDatasetLinks() == 1;
            // If you want to work with this collection,
            // you'll need to get a copy.
            List<DatasetImageLink> links = image.copyDatasetLinks();
            // When you are done working with it, you can
            // unload the datasets, assuming the changes
            // have been persisted to the server.
            image.unloadDatasetLinks();
            assert image.sizeOfDatasetLinks() < 0;
            try {
                image.linkDataset( new DatasetI() );
            } catch (Exception e) {
                // Can't access an unloaded collection
            }
            // The reload...() method allows one instance
            // to take over a collection from another, if it
            // has been properly initialized on the server.
            // sameImage will have its collection unloaded.
            Image sameImage = new ImageI(1L, true);
            sameImage.getDetails().setUpdateEvent( new EventI(1L, false) );
            sameImage.linkDataset( new DatasetI(1L, false) );
            image.reloadDatasetLinks( sameImage );
            assert image.sizeOfDatasetLinks() == 1;
            assert sameImage.sizeOfDatasetLinks() < 0;
            // If you would like to remove all the member
            // elements from a collection, don't unload it
            // but "clear" it.
            image.clearDatasetLinks();
            // Saving this to the database will remove
            // all dataset links!
            // Finally, all collections can be unloaded
            // to use an instance as a single row in the database.
            image.unloadCollections();
            // Ordered collections have slightly different methods.
            image = new ImageI(1L, true);
            image.addPixels( new PixelsI() );
            image.getPixels(0);
            image.getPrimaryPixels(); // Same thing
            image.removePixels( image.getPixels(0) );
       }
    }

Example: :source:`examples/OmeroClients/collectionmethods.java`

These methods prevent clients from accessing the collections directly,
and any improper access will lead to an ``omero.ClientError``.

Interfaces
~~~~~~~~~~

As mentioned above, one of the Java features which is missing from the
slice definition language is the ability to have concrete classes
implement **multiple** interfaces. Much of the
|OmeroModel|  in the RMI-based types
(``ome.model``) was based on the use of interfaces.

-  :model_source:` IObject <src/main/java/ome/model/IObject.java>`
   is the root interface for all object types. **Methods**: ``getId()``,
   ``getDetails()``, …
-  :model_source:` IEnum <src/main/java/ome/model/IEnum.java>`
   is an enumeration value. **Methods**: ``getValue()``
-  :model_source:` ILink <src/main/java/ome/model/ILink.java>`
   is a link between two other types. **Methods**: ``getParent()``,
   ``getChild()``
-  :model_source:` IMutable <src/main/java/ome/model/IMutable.java>`
   is an instance for changes will be persisted. **Methods**:
   ``getVersion()``

Instead, the Ice-based types (``omero.model``) all subclass from the
same concrete type -- ``omero.model.IObject`` -- and it has several
methods defined for testing which of the ``ome.model`` interfaces are
implemented by any type.

Use of such methods is naturally less object-oriented and requires
if/then blocks, but within the confines of the mapping language is a
next-best option.

::

    # No cpp example

::

    import omero.model.*;
    o = EventI();
    assert( ~ o.isMutable() );
    o = ExperimenterI();
    assert( o.isMutable() );
    assert( o.isGlobal() );
    assert( o.isAnnotated() );
    o = GroupExperimenterMapI();
    assert( o.isLink() );
    someObject = ExperimenterI();
    % Some method call and you no longer know what someObject is
    if (~ someObject.isMutable() )
        % No need to update
    elseif (someObject.isAnnotated())
        % deleteAnnotations(someObject);
    end

Example: :source:`examples/OmeroClients/interfaces.m`

::

    import omero
    from omero_model_EventI import EventI
    from omero_model_ExperimenterI import ExperimenterI
    from omero_model_GroupExperimenterMapI import GroupExperimenterMapI
    assert ( not EventI().isMutable() )
    assert ExperimenterI().isMutable()
    assert ExperimenterI().isGlobal()
    assert ExperimenterI().isAnnotated()
    assert GroupExperimenterMapI().isLink()

Example: :source:`examples/OmeroClients/interfaces.py`

::

    import omero.model.IObject;
    import omero.model.EventI;
    import omero.model.ExperimenterI;
    import omero.model.GroupExperimenterMapI;
    public class interfaces {
        public static void main(String args[]) {
            assert ! new EventI().isMutable();
            assert new ExperimenterI().isMutable();
            assert new ExperimenterI().isGlobal();
            assert new ExperimenterI().isAnnotated();
            assert new GroupExperimenterMapI().isLink();
            IObject someObject = new ExperimenterI();
            // Some method call and you no longer know what someObject is
            if ( ! someObject.isMutable()) {
                // No need to update
            } else if (someObject.isAnnotated()) {
               // deleteAnnotations(someObject);
            }
        }
    }

Example: :source:`examples/OmeroClients/interfaces.java`

Improvement of this situation by adding abstract classes is planned.
However, the entire functionality will not be achievable because of
single inheritance.

Language-specific behavior
^^^^^^^^^^^^^^^^^^^^^^^^^^

Smart pointers (C++ only)
~~~~~~~~~~~~~~~~~~~~~~~~~

An important consideration when working with C++ is that the
|OmeroModel|  classes themselves have no
copy-constructors and no assignment operator (operator=), and so cannot
be allocated on the stack. Combined with smart pointers this effectively
prevents memory leaks.

The code generated types must be allocated on the heap with ``new`` and
used in combination with the smart pointer typedefs which handle calling
the destructor when the reference count hits zero.

::

    #include <omero/model/ImageI.h>
    using namespace omero::model;
    int main()
    {
        // ImageI image();                  // ERROR
        // ImageI image = new ImageI();     // ERROR
        ImageIPtr image1 = new ImageI();     // OK
        ImageIPtr image2(new ImageI());      // OK
        // image1 pointer takes value of image2
        // image1's content is garbage collected
        image1 = image2;
        //
        // Careful with boolean contexts
        //
        if (image1 && image1 == 1) {
            // Means non-null
            // This object can be dereferenced
        }
        ImageIPtr nullImage; // No assignment
        if ( !nullImage && nullImage == 0) {
            // Dereferencing nullImage here would throw an exception:
            // nullImage->getId(); // IceUtil::NullHandleException !
        }
    }

Example: :source:`examples/OmeroClients/smartpointers.cpp`

::

    # No m example

::

    # No py example

::

    # No java example

.. Warning:: 
    As shown in the example, using a smart pointer instance in
    a boolean or integer/long context, returns 1 for true (i.e. non-null) or
    0 for false (i.e. null). Be especially careful with the RTypes.

For more information, see :zerocdoc:`6.14.6 Smart Pointers for
Classes <display/Ice/Smart+Pointers+for+Classes>` in the
Ice manual, which also describes the ``Ice.GC.Interval`` parameter which
determines how often garbage collection runs in C++ to reap objects.
This is necessary with the |OmeroModel| 
since there are inherently cycles in the object graph.

Another point type which may be of use is ``omero::client_ptr``. It also
performs reference counting and will call ``client.closeSession()`` once
the reference count hits zero. Without ``client_ptr``, your code will
need to be surrounded by a try/catch block. Otherwise, 1) sessions will
be left open on the server, and 2) your client may hang on exit.

::

    #include <omero/client.h>
    int main(int argc, char* argv[])
    {
        // Duplicating the argument list. ticket:1246
        Ice::StringSeq args1 = Ice::argsToStringSeq(argc, argv);
        Ice::StringSeq args2(args1);
        Ice::InitializationData id1, id2;
        id1.properties = Ice::createProperties(args1);
        id2.properties = Ice::createProperties(args2);
        // Either
        omero::client client(id1);
        try {
            // Do something like
            // client.createSession();
        } catch (…) {
            client.closeSession();
        }
        //
        // Or
        //
        {
            omero::client_ptr client = new omero::client(id2);
            // Do something like
            // client->createSession();
        }
        // Client was destroyed via RAII
    }

Example: :source:`examples/OmeroClients/clientpointer.cpp`

::

    # No m example

::

    # No py example

::

    # No java example

__getattr__ and __setattr__ (Python only)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Like smart pointers for |OmeroCpp|, the |OmeroPy| SDK defines ``__getattr__`` and
``__setattr__`` methods for all |OmeroModel| 
classes. Rather than explicitly calling the ``getFoo()`` and
``setFoo()`` methods, field-like access can be used. (It should be
noted, however, that the accessors will perform marginally faster.)

::

    # No cpp example

::

    # No m example

::

    import omero
    import omero.clients
    from omero.rtypes import *
    i = omero.model.ImageI()
    #
    # Without __getattr__ and __setattr__
    #
    i.setName( rstring("name") )
    assert i.getName().getValue() == "name"
    #
    # With __getattr__ and __setattr__
    #
    i = omero.model.ImageI()
    i.name = rstring("name")
    assert i.name.val == "name"
    #
    # Collections, however, cannot be accessed
    # via the special methods due to the dangers
    # outlined above
    #
    try:
        i.datasetLinks[0]
    except AttributeError, ae:
        pass

Example: :source:`examples/OmeroClients/getsetattr.py`

::

    # No java example

Method inspection and code completion (MATLAB & Python)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ice generates a number of internal (private) methods which are not
intended for general consumption. Unfortunately, MATLAB's
code-completion as well as Python's ``dir`` method return these methods,
which can lead to confusion. In general, the API user can ignore any
method beginning with an underscore or with ``ice_``. For example,

::

    >>>for i in dir(omero.model.ImageI):
    ...     if i.startswith("_") or i.startswith("ice_"):
    ...             print(i)
    ... 
    (snip)
    _op_addAllDatasetImageLinkSet
    _op_addAllImageAnnotationLinkSet
    _op_addAllPixelsSet
    _op_addAllRoiSet
    _op_addAllWellSampleSet
    ...
    ice_id
    ice_ids
    ice_isA
    ice_ping
    ice_postUnmarshal
    ice_preMarshal
    ice_staticId
    ice_type
    >>> 


Services overview
-----------------

After discussing the many types and how to create them, the next obvious
question is what one can actually do with them. For that, we have to
look at what services are provided by :doc:`/developers/server-blitz`, how they are obtained, 
used, and cleaned up.

OMERO client configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^

The first step in accessing the |OmeroApi| and
therefore the first thing to plan when writing an OMERO client is the
proper configuration of an ``omero.client`` instance. The omero.client
(or in C++ omero::client) class tries to wrap together and simplify as
much of working with Ice as possible. Where it can, it imports or
<#includes> types for you, creates an Ice.Communicator and registers an
ObjectFactory. Typically, the only work on the client developers part
is to properly configure the omero.client object and then login.

In the simplest case, configuration requires only the server host,
username, and password with which you want to login. But as you can see
below, there are various ways to configure your client, and this is
really only the beginning.

::

    #include <omero/client.h>
    #include <iostream>
    int main(int argc, char* argv[]) {
        // All configuration in file pointed to by
        // --Ice.Config=file.config
        // No username, password entered
        try {
            omero::client client1(argc, argv);
            client1.createSession();
            client1.closeSession();
        } catch (const Glacier2::PermissionDeniedException& pd) {
            // Bad password?
        } catch (const Ice::ConnectionRefusedException& cre) {
            // Bad address or port?
        }
        // Most basic configuration.
        // Uses default port 4064
        // createSession needs username and password
        try {
            omero::client client2("localhost");
            client2.createSession("root", "ome");
            client2.closeSession();
        } catch (const Glacier2::PermissionDeniedException& pd) {
            // Bad password?
        } catch (const Ice::ConnectionRefusedException& cre) {
            // Bad address or port?
        }
        // Configuration with port information
        try {
            omero::client client3("localhost", 24063);
            client3.createSession("root", "ome");
            client3.closeSession();
        } catch (const Glacier2::PermissionDeniedException& pd) {
            // Bad password?
        } catch (const Ice::ConnectionRefusedException& cre) {
            // Bad address or port?
        }
        // Advanced configuration in C++ takes place
        // via an InitializationData instance.
        try {
            Ice::InitializationData data;
            data.properties = Ice::createProperties();
            data.properties->setProperty("omero.host", "localhost");
            omero::client client4(data);
            client4.createSession("root", "ome");
            client4.closeSession();
        } catch (const Glacier2::PermissionDeniedException& pd) {
            // Bad password?
        } catch (const Ice::ConnectionRefusedException& cre) {
            // Bad address or port?
        }
        // std::map to be added (ticket:1278)
        try {
            Ice::InitializationData data;
            data.properties = Ice::createProperties();
            data.properties->setProperty("omero.host", "localhost");
            data.properties->setProperty("omero.user", "root");
            data.properties->setProperty("omero.pass", "ome");
            omero::client client5(data);
            // Again, no username or password needed
            // since present in the data. But they *can*
            // be overridden.
            client5.createSession();
            client5.closeSession();
        } catch (const Glacier2::PermissionDeniedException& pd) {
            // Bad password?
        } catch (const Ice::ConnectionRefusedException& cre) {
            // Bad address or port?
        }
    }

Example: :source:`examples/OmeroClients/configuration.cpp`

::

    % All configuration in file pointed to by
    % --Ice.Config=file.config
    % No username, password entered
    args = javaArray('java.lang.String',1);
    args(1) = java.lang.String('--Ice.Config=ice.config');
    client1 = omero.client(args);
    client1.createSession();
    client1.closeSession();
    % Most basic configuration.
    % Uses default port 4064
    % createSession needs username and password
    client2 = omero.client('localhost');
    client2.createSession('root', 'ome');
    client2.closeSession();
    % Configuration with port information
    client3 = omero.client('localhost', 10463);
    client3.createSession('root', 'ome');
    client3.closeSession();
    % Advanced configuration can also be done
    % via an InitializationData instance.
    data = Ice.InitializationData();
    data.properties = Ice.Util.createProperties();
    data.properties.setProperty('omero.host', 'localhost');
    client4 = omero.client(data);
    client4.createSession('root', 'ome');
    client4.closeSession();
    % Or alternatively via a java.util.Map instance
    map = java.util.HashMap();
    map.put('omero.host', 'localhost');
    map.put('omero.user', 'root');
    map.put('omero.pass', 'ome');
    client5 = omero.client(map);
    % Again, no username or password needed
    % since present in the map. But they *can*
    % be overridden.
    client5.createSession();
    client5.closeSession();

Example: :source:`examples/OmeroClients/configuration.m`

::

    import omero
    import Ice
    # All configuration in file pointed to by
    # --Ice.Config=file.config or ICE_CONFIG
    # environment variable;
    # No username, password entered
    try:
        client1 = omero.client()
        client1.createSession()
        client1.closeSession()
    except Ice.ConnectionRefusedException:
        pass # Bad address or port?
    # Most basic configuration.
    # Uses default port 4064
    # createSession needs username and password
    try:
        client2 = omero.client("localhost")
        client2.createSession("root","ome")
        client2.closeSession()
    except Ice.ConnectionRefusedException:
        pass # Bad address or port?
    # Configuration with port information
    try:
        client3 = omero.client("localhost", 24064)
        client3.createSession("root","ome")
        client3.closeSession()
    except Ice.ConnectionRefusedException:
        pass # Bad address or port?
    # Advanced configuration can also be done
    # via an InitializationData instance.
    data = Ice.InitializationData()
    data.properties = Ice.createProperties()
    data.properties.setProperty("omero.host", "localhost")
    try:
        client4 = omero.client(data)
        client4.createSession("root","ome")
        client4.closeSession()
    except Ice.ConnectionRefusedException:
        pass # Bad address or port?
    # Or alternatively via a dict instance
    m = {"omero.host":"localhost",
         "omero.user":"root",
         "omero.pass":"ome"}
    client5 = omero.client(m)
    # Again, no username or password needed
    # since present in the map. But they *can*
    # be overridden.
    try:
        client5.createSession()
        client5.closeSession()
    except Ice.ConnectionRefusedException:
        pass # Bad address or port?

Example: :source:`examples/OmeroClients/configuration.py`

::

    public class configuration {
      public static void main(String[] args) throws Exception {
        // All configuration in file pointed to by
        // --Ice.Config=file.config
        // No username, password entered
        omero.client client1 = new omero.client(args);
        try {
            client1.createSession();
        } catch (Ice.ConnectionRefusedException cre) {
            // Bad address or port?
        } finally {
            client1.closeSession();
        }
        // Most basic configuration.
        // Uses default port 4064
        // createSession needs username and password
        omero.client client2 = new omero.client("localhost");
        try {
            client2.createSession("root", "ome");
        } catch (Ice.ConnectionRefusedException cre) {
            // Bad address or port?
        } finally {
            client2.closeSession();
        }
        // Configuration with port information
        omero.client client3 = new omero.client("localhost", 24064);
        try {
            client3.createSession("root", "ome");
        } catch (Ice.ConnectionRefusedException cre) {
            // Bad address or port?
        } finally {
            client3.closeSession();
        }
        // Advanced configuration can also be done
        // via an InitializationData instance.
        Ice.InitializationData data = new Ice.InitializationData();
        data.properties = Ice.Util.createProperties();
        data.properties.setProperty("omero.host", "localhost");
        omero.client client4 = new omero.client(data);
        try {
            client4.createSession("root", "ome");
        } catch (Ice.ConnectionRefusedException cre) {
            // Bad address or port?
        } finally {
            client4.closeSession();
        }
        // Or alternatively via a java.util.Map instance
        java.util.Map<String, String> map = new java.util.HashMap<String, String>();
        map.put("omero.host", "localhost");
        map.put("omero.user", "root");
        map.put("omero.pass", "ome");
        omero.client client5 = new omero.client(map);
        // Again, no username or password needed
        // since present in the map. But they *can*
        // be overridden.
        try {
            client5.createSession();
        } catch (Ice.ConnectionRefusedException cre) {
            // Bad address or port?
        } finally {
            client5.closeSession();
        }
      }
    }

Example: :source:`examples/OmeroClients/configuration.java`

To find out more about using the ``Ice.Config`` file for configuration,
see :source:`etc/templates/ice.config`.

What is a ServiceFactory?
^^^^^^^^^^^^^^^^^^^^^^^^^

In each of the examples above, the result of configuration was the
ability to call ``createSession`` which returns a ``ServiceFactoryPrx``.

The ServiceFactory is the clients representation of the user's :doc:`server-side
session </developers/Server/Sessions>`, which multiple clients can connect
to it simultaneously. A ServiceFactoryPrx? object is acquired on login
via the ``createSession`` method, and persists until either it is closed
or a timeout is encountered **unless** additional clients attach to it.
This is done via ``client.joinSession(String uuid)``. In that case, the
session is not finally closed until its reference count drops to zero.

It produces services!
~~~~~~~~~~~~~~~~~~~~~

Once a client has been configured properly, and has an active in
ServiceFactory in hand, it is time to start accessing services.

The collection of all services provided by OMERO is known as the
|OmeroApi|. Each service is defined in a slice file under
:blitz_sourcedir:`src/main/slice/omero`.
The central definitions are in
:blitz_source:`src/main/slice/omero/API.ice`,
along with the definition of
ServiceFactory itself:

::

            interface ServiceFactory extends Glacier2::Session
            {
                // Central OMERO.blitz stateless services.
                IAdmin*          getAdminService() throws ServerError;
                IConfig*         getConfigService() throws ServerError;
                …
                // Central OMERO.blitz stateful services.
                Gateway*         createGateway() throws ServerError;
                …

In the definition above, the return values look like C/C++ pointers,
which in Ice's definition language represents return-by-proxy. When a
client calls, serviceFactory.getAdminService() it will receive an
IAdminPrx. **Any call on that object is a remote invocation.**

Stateless vs. stateful
^^^^^^^^^^^^^^^^^^^^^^

Most methods on the ServiceFactory return
either a stateless or a stateful service factory. Stateless services are
those returned by calls to "getSomeNameService()". They implement
``omero.api.ServiceInterface`` but not its subinterface
``omero.api.StatefulServiceInterface``. Stateless services are for all
intents and purposes singletons, though the implementation may vary.

Stateful services are returned by calls to "createSomething()" and
implement ``omero.api.StatefulServiceInterface``. Each maintains a state
machine with varying rules on initialization and usage. It is important
to guarantee that calls are ordered as described in the documentation
for each stateful service. **It is also important to always close
stateful services to free up server resources.** If you fail to manually
call ``StatefulServiceInterfacePrx.close()``, it will be called for you
on session close/timeout.

What are timeouts?
~~~~~~~~~~~~~~~~~~

The following code has a resource leak:

::

    import omero, sys
    c = omero.client()
    s = c.createSession()
    sys.exit(0)

Although the client will not suffer any consequences, this snippet leaves
a :doc:`session </developers/Server/Sessions>` open on the server.
If the server failed to eventually reap such sessions, they would
eventually consume all available memory. To get around this, the server
implements timeouts on all sessions. **It is the clients responsibility
to periodically contact the server to keep the session alive.** Since
threading policies vary in applications, no strict guideline is
available on how to do this. Almost any API method will suffice to tell
the server that the client is still active. Important is that the call
happens within every timeout window.

::

    # No cpp example

::

    # No m example

::

    import time
    import omero
    import threading
    IDLETIME = 5
    c = omero.client()
    s = c.createSession()
    re = s.createRenderingEngine()
    class KeepAlive(threading.Thread):
        def run(self):
            self.stop = False
            while not self.stop:
                time.sleep(IDLETIME)
                print("calling keep alive")
                # Currently, passing a null or empty array to keepAllAlive
                # would suffice. For future-proofing, however, it makes sense
                # to pass stateful services.
                try:
                    s.keepAllAlive([re])
                except:
                    c.closeSession()
                    raise
    keepAlive = KeepAlive()
    keepAlive.start()
    time.sleep(IDLETIME * 2)
    keepAlive.stop = True

Example: :source:`examples/OmeroClients/timeout.py`

::

    import omero.*;
    import omero.api.*;
    import omero.model.*;
    import omero.sys.*;
    public class timeout {
        static int IDLETIME = 5;
        static client c;
        static ServiceFactoryPrx s;
        public static void main(String[] args) throws Exception {
            final int idletime = args.length > 1 ? Integer.parseInt(args[0]) : IDLETIME;
            c = new client(args);
            s = c.createSession();
            System.out.println(s.getAdminService().getEventContext().sessionUuid);
            final RenderingEnginePrx re = s.createRenderingEngine(); // for keep alive
            class Run extends Thread {
                public boolean stop = false;
                    public void run() {
                    while ( ! stop ) {
                        try {
                            Thread.sleep(idletime*1000L);
                        } catch (Exception e) {
                            // ok
                        }
                        System.out.println(System.currentTimeMillis() + " calling keep alive");
                        try {
                            // Currently, passing a null or empty array to keepAllAlive
                            // would suffice. For future-proofing, however, it makes sense
                            // to pass stateful services.
                            s.keepAllAlive(new ServiceInterfacePrx[]{re});
                        } catch (Exception e) {
                            c.closeSession();
                            throw new RuntimeException(e);
                        }
                    }
                }
            }
            final Run run = new Run();
            class Stop extends Thread {
                public void run() {
                    run.stop = true;
                }
            }
            Runtime.getRuntime().addShutdownHook(new Stop());
            run.start();
        }
    }

Example: :source:`examples/OmeroClients/timeout.java`

Exceptions
~~~~~~~~~~

Probably the most critical thing to realize is that any call on a proxy,
which includes ``ServiceFactoryPrx`` or any of the \*Prx service classes
is a remote invocation on the server. Therefore proper exception
handling is critical. The definition of the various exceptions is
outlined on the :doc:`/developers/Modules/ExceptionHandling` page
and so will not be repeated here. However, how are these sensibly used?

One easy rule is that every ``omero.client`` object which you
successfully call ``createSession()`` on must have ``closeSession()``
called on it before you exit.

::

    omero.client client = new omero.client();
    client.createSession();
    try {
      // do whatever you want
    } finally {
      client.closeSession();
    }

Obviously, the work you do in your client will be much more complicated,
and may be under layers of application code. But when designing where
active ``omero.client`` objects are kept, be sure that your clean-up
code takes care of them.


.. _IQuery:

IQuery
------

Now that we have a good idea of the basics, it might be interesting
to start asking the server what it has got. The most powerful way of doing
this is by using IQuery and the Hibernate Query Language (HQL).

::

    #include <omero/api/IQuery.h>
    #include <omero/client.h>
    #include <omero/RTypesI.h>
    #include <omero/sys/ParametersI.h>
    using namespace omero::rtypes;
    int main(int argc, char* argv[]) {
        omero::client_ptr client = new omero::client(argc, argv);
        omero::api::ServiceFactoryPrx sf = client->createSession();
        omero::api::IQueryPrx q = sf->getQueryService();
        std::string query_string = "select i from Image i where i.id = :id and name like :namedParameter";
        omero::sys::ParametersIPtr p = new omero::sys::ParametersI();
        p->add("id", rlong(1L));
        p->add("namedParameter", rstring("cell%mit%"));
        omero::api::IObjectList results = q->findAllByQuery(query_string, p);
    }

Example: :source:`examples/OmeroClients/queries.cpp`

::

    [client,sf] = loadOmero;
    try
        q = sf.getQueryService();
        query_string = 'select i from Image i where i.id = :id and name like :namedParameter';
        p = omero.sys.ParametersI();
        p.add('id', omero.rtypes.rlong(1));
        p.add('namedParameter', omero.rtypes.rstring('cell%mit%'));
        results = q.findAllByQuery(query_string, p) % java.util.List
    catch ME
        client.closeSession();
    end

Example: :source:`examples/OmeroClients/queries.m`

::

    import sys
    import omero
    from omero.rtypes import *
    from omero_sys_ParametersI import ParametersI
    client = omero.client(sys.argv)
    try:
        sf = client.createSession()
        q = sf.getQueryService()
        query_string = "select i from Image i where i.id = :id and name like :namedParameter";
        p = ParametersI()
        p.addId(1L)
        p.add("namedParameter", rstring("cell%mit%"));
        results = q.findAllByQuery(query_string, p)
    finally:
        client.closeSession()

Example: :source:`examples/OmeroClients/queries.py`

::

    import java.util.List;
    import static omero.rtypes.*;
    import omero.api.ServiceFactoryPrx;
    import omero.api.IQueryPrx;
    import omero.model.IObject;
    import omero.model.ImageI;
    import omero.model.PixelsI;
    import omero.sys.ParametersI;
    public class queries {
        public static void main(String args[]) throws Exception {
            omero.client client = new omero.client(args);
            try {
                ServiceFactoryPrx sf = client.createSession();
                IQueryPrx q = sf.getQueryService();
                String query_string = "select i from Image i where i.id = :id and name like :namedParameter";
                ParametersI p = new ParametersI();
                p.add("id", rlong(1L));
                p.add("namedParameter", rstring("cell%mit%"));
                List<IObject> results = q.findAllByQuery(query_string, p);
            } finally {
                client.closeSession();
            }
        }
    }

Example: :source:`examples/OmeroClients/queries.java`

The ``query_string`` is an example of HQL. It looks a lot like SQL, but
works with objects and fields rather than tables and columns (though in
OMERO these are usually named the same). The ``Parameters`` object allow
for setting named parameters (``:id``) in the query to allow for re-use,
and is the only other argument need to ``IQueryPrx.findAllByQuery()`` to
get a list of ``IObject`` instances back. They are guaranteed to be of
type ``omero::model::Image``, but you may have to cast them to make full
use of that information.


IUpdate
-------

After you have successfully read objects, an obvious thing to do is create
your own. Below is a simple example of creating an image object:

::

    #include <IceUtil/Time.h>
    #include <omero/api/IUpdate.h>
    #include <omero/client.h>
    #include <omero/RTypesI.h>
    #include <omero/model/ImageI.h>
    using namespace omero::rtypes;
    int main(int argc, char* argv[]) {
        omero::client_ptr client = new omero::client(argc, argv);
        omero::model::ImagePtr i = new omero::model::ImageI();
        i->setName( rstring("name") );
        i->setAcquisitionDate( rtime(IceUtil::Time::now().toMilliSeconds()) );
        omero::api::ServiceFactoryPrx sf = client->createSession();
        omero::api::IUpdatePrx u = sf->getUpdateService();
        i = omero::model::ImagePtr::dynamicCast( u->saveAndReturnObject( i ) );
    }

Example: :source:`examples/OmeroClients/updates.cpp`

::

    [client,sf] = loadOmero;
    try
        i = omero.model.ImageI();
        i.setName(omero.rtypes.rstring('name'));
        i.setAcquisitionDate(omero.rtypes.rtime(java.lang.System.currentTimeMillis()));
        u = sf.getUpdateService();
        i = u.saveAndReturnObject( i );
        disp(i.getId().getValue());
    catch ME
        disp(ME);
        client.closeSession();
    end

Example: :source:`examples/OmeroClients/updates.m`
::

    import sys
    import time
    import omero
    import omero.clients
    from omero.rtypes import *
    client = omero.client(sys.argv)
    try:
        i = omero.model.ImageI()
        i.name = rstring("name")
        i.acquisitionDate = rtime(time.time() * 1000)
        sf = client.createSession()
        u = sf.getUpdateService()
        i = u.saveAndReturnObject( i )
    finally:
        client.closeSession()

Example: :source:`examples/OmeroClients/updates.py`

::

    import java.util.List;
    import static omero.rtypes.*;
    import omero.api.ServiceFactoryPrx;
    import omero.api.IUpdatePrx;
    import omero.model.ImageI;
    import omero.model.Image;
    public class updates {
        public static void main(String args[]) throws Exception {
            omero.client client = new omero.client(args);
            try {
                Image i = new ImageI();
                i.setName( rstring("name") );
                i.setAcquisitionDate( rtime(System.currentTimeMillis()) );
                ServiceFactoryPrx sf = client.createSession();
                IUpdatePrx u = sf.getUpdateService();
                i = (Image) u.saveAndReturnObject( i );
            } finally {
                client.closeSession();
            }
        }
    }

Example: :source:`examples/OmeroClients/updates.java`



Examples
--------

To tie together some of the topics which we have outlined above, we would
like to eventually have several more or less complete application
examples which you can use to get started. For the moment, there is just
one simpler example ``TreeList``, but more will certainly be added. Let
us know any ideas you may have.

``TreeList``
^^^^^^^^^^^^

::

    # No cpp example

::

    function projects = AllProjects(query, username)
    q = ['select p from Project p join fetch p.datasetLinks dil ',...
         'join fetch dil.child where p.details.owner.omeName = :name'];
    p = omero.sys.ParametersI();
    p.add('name', omero.rtypes.rstring(username));
    projects = query.findAllByQuery(q, p);

Example: :source:`examples/TreeList/AllProjects.m`

::

    import omero
    from omero.rtypes import *
    from omero_sys_ParametersI import ParametersI
    def getProjects(query_prx, username):
        return query_prx.findAllByQuery(
                "select p from Project p join fetch p.datasetLinks dil join fetch dil.child where p.details.owner.omeName = :name",
                ParametersI().add("name", rstring(username)))

Example: :source:`examples/TreeList/AllProjects.py`

::

    import java.util.List;
    import omero.model.Project;
    import omero.api.IQueryPrx;
    import omero.sys.ParametersI;
    import static omero.rtypes.*;
    public class AllProjects {
        public static List<Project> getProjects(IQueryPrx query, String username) throws Exception {
            List rv = query.findAllByQuery(
                "select p from Project p join fetch p.datasetLinks dil join fetch dil.child where p.details.owner.omeName = :name",
                new ParametersI().add("name", rstring(username)));
            return (List<Project>) rv;
        }
    }

Example: :source:`examples/TreeList/AllProjects.java`

::

    # No cpp example

::

    function PrintProjects(projects)
    if (projects.size()==0)
        return;
    end;
    for i=0:projects.size()-1,
        project = projects.get(i);
        disp(project.getName().getValue());
        links = project.copyDatasetLinks();
        if (links.size()==0)
            return
        end
        for j=0:links.size()-1,
            pdl = links.get(j);
            dataset = pdl.getChild();
            disp(sprintf('  %s', char(dataset.getName().getValue())));
        end
    end

Example: :source:`examples/TreeList/PrintProjects.m`

::

    def print_(projects):
        for project in projects:
            print(project.getName().val)
            for pdl in project.copyDatasetLinks():
                dataset = pdl.getChild()
                print("  " + dataset.getName().val)

Example: :source:`examples/TreeList/PrintProjects.py`

::

    import java.util.List;
    import omero.model.Project;
    import omero.model.ProjectDatasetLink;
    import omero.model.Dataset;
    public class PrintProjects {
        public static void print(List<Project> projects) {
            for (Project project : projects) {
                System.out.print(project.getName().getValue());
                for (ProjectDatasetLink pdl : project.copyDatasetLinks()) {
                    Dataset dataset = pdl.getChild();
                    System.out.println("  " + dataset.getName().getValue());
                }
            }
        }
    }

Example: :source:`examples/TreeList/PrintProjects.java`

::

    #include <omero/client.h>
    #include <Usage.h>
    #include <AllProjects.h>
    #include <PrintProjects.h>
    int main(int argc, char* argv[]) {
        std::string host, port, user, pass;
        try {
            host = argv[0];
            port = argv[1];
            user = argv[2];
            pass = argv[3];
        } catch (…) {
            Usage::usage();
        }
        omero::client client(argc, argv);
        int rc = 0;
        try {
            omero::api::ServiceFactoryPrx factory = client.createSession(user, pass);
            std::vector<omero::model::ProjectPtr> projects = AllProjects::getProjects(factory->getQueryService(), user);
            PrintProjects::print(projects);
        } catch (…) {
            client.closeSession();
        }
        return rc;
    }

Example: :source:`examples/TreeList/Main.cpp`

::

    function Main(varargin)
    try
        host = varargin{1};
        port = varargin{2};
        user = varargin{3};
        pass = varargin{4};
    catch ME
        Usage
    end
    client = omero.client(host, port);
    factory = client.createSession(user, pass);
    projects = AllProjects(factory.getQueryService(), user);
    PrintProjects(projects);
    client.closeSession();

Example: :source:`examples/TreeList/Main.m`

::

    import sys
    import omero
    import Usage, AllProjects, PrintProjects
    if __name__ == "__main__":
        try:
            host = sys.argv[1]
            port = sys.argv[2]
            user = sys.argv[3]
            pasw = sys.argv[4]
        except:
            Usage.usage()
        client = omero.client(sys.argv)
        try:
            factory = client.createSession(user, pasw)
            projects = AllProjects.getProjects(factory.getQueryService(), user)
            PrintProjects.print_(projects)
        finally:
            client.closeSession()

Example: :source:`examples/TreeList/Main.py`

::

    import omero.api.ServiceFactoryPrx;
    import omero.model.Project;
    import java.util.List;
    public class Main {
        public static void main(String args[]) throws Exception{
            String host = null, port = null, user = null, pass = null;
            try {
                host = args[0];
                port = args[1];
                user = args[2];
                pass = args[3];
            } catch (Exception e) {
                Usage.usage();
            }
            omero.client client = new omero.client(args);
            try {
                ServiceFactoryPrx factory = client.createSession(user, pass);
                List<Project> projects = AllProjects.getProjects(factory.getQueryService(), user);
                PrintProjects.print(projects);
            } finally {
                client.closeSession();
            }
        }
    }

Example: :source:`examples/TreeList/Main.java`


Advanced topics
---------------

Sudo
^^^^

If you are familiar with the admin user concept in OMERO, you might
wonder if it is possible for administrative users to perform tasks for
regular users. Under Unix-based systems this is commonly known as "sudo"
functionality. Although not (yet) as straightforward, it is possible to
create sessions for other users and carry out actions on their behalf.

::

    #include <iostream>
    #include <omero/api/IAdmin.h>
    #include <omero/api/ISession.h>
    #include <omero/client.h>
    #include <omero/model/Session.h>
    int main(int argc, char* argv[]) {
        Ice::StringSeq args1 = Ice::argsToStringSeq(argc, argv);
        Ice::StringSeq args2(args1); // Copies
        // ticket:1246
        Ice::InitializationData id1;
        id1.properties = Ice::createProperties(args1);
        Ice::InitializationData id2;
        id2.properties = Ice::createProperties(args2);
        omero::client_ptr client = new omero::client(id1);
        omero::client_ptr sudoClient = new omero::client(id2);
        omero::api::ServiceFactoryPrx sf = client->createSession();
        omero::api::ISessionPrx sessionSvc = sf->getSessionService();
        omero::sys::PrincipalPtr p = new omero::sys::Principal();
        p->name = "root"; // Can change to any user
        p->group = "user";
        p->eventType = "User";
        omero::model::SessionPtr sudoSession = sessionSvc->createSessionWithTimeout( p, 3*60*1000L ); // 3 minutes to live
        omero::api::ServiceFactoryPrx sudoSf = sudoClient->joinSession( sudoSession->getUuid()->getValue() );
        omero::api::IAdminPrx sudoAdminSvc = sudoSf->getAdminService();
        std::cout << sudoAdminSvc->getEventContext()->userName;
    }

Example: :source:`examples/OmeroClients/sudo.cpp`

::

    client = omero.client();
    sudoClient = omero.client();
    try
        sf = client.createSession('root','ome');
        sessionSvc = sf.getSessionService();
        p = omero.sys.Principal();
        p.name = 'root'; % Can change to any user
        p.group = 'user';
        p.eventType = 'User';
        sudoSession = sessionSvc.createSessionWithTimeout( p, 3*60*1000 ); % 3 minutes to live
        sudoSf = sudoClient.joinSession( sudoSession.getUuid().getValue() );
        sudoAdminSvc = sudoSf.getAdminService();
        disp(sudoAdmin.Svc.getEventContext().userName);
    catch ME
        sudoClient.closeSession();
        client.closeSession();
    end

Example: :source:`examples/OmeroClients/sudo.m`

::

    import sys
    import omero
    args = list(sys.argv)
    client = omero.client(args)
    sudoClient = omero.client(args)
    try:
        sf = client.createSession("root", "ome")
        sessionSvc = sf.getSessionService()
        p = omero.sys.Principal()
        p.name = "root" # Can change to any user
        p.group = "user"
        p.eventType = "User"
        sudoSession = sessionSvc.createSessionWithTimeout( p, 3*60*1000L ) # 3 minutes to live
        sudoSf = sudoClient.joinSession( sudoSession.getUuid().getValue() )
        sudoAdminSvc = sudoSf.getAdminService()
        print(sudoAdminSvc.getEventContext().userName)
    finally:
        sudoClient.closeSession()
        client.closeSession()

Example: :source:`examples/OmeroClients/sudo.py`

::

    import java.util.List;
    import omero.api.IAdminPrx;
    import omero.api.ISessionPrx;
    import omero.api.ServiceFactoryPrx;
    import omero.model.Session;
    import omero.sys.Principal;
    public class sudo {
        public static void main(String args[]) throws Exception {
            omero.client client = new omero.client(args);
            omero.client sudoClient = new omero.client(args);
            try {
                ServiceFactoryPrx sf = client.createSession("root", "ome");
                ISessionPrx sessionSvc = sf.getSessionService();
                Principal p = new Principal();
                p.name = "root"; // Can change to any user
                p.group = "user";
                p.eventType = "User";
                Session sudoSession = sessionSvc.createSessionWithTimeout( p, 3*60*1000L ); // 3 minutes to live
                ServiceFactoryPrx sudoSf = sudoClient.joinSession( sudoSession.getUuid().getValue() );
                IAdminPrx sudoAdminSvc = sudoSf.getAdminService();
                System.out.println( sudoAdminSvc.getEventContext().userName );
            } finally {
                sudoClient.closeSession();
                client.closeSession();
            }
        }
    }

Example: :source:`examples/OmeroClients/sudo.java`

Proposed
^^^^^^^^

Like the complete examples above, there are several topics which need to
be covered in more detail:

-  how to detect client/server version mismatches
-  how to make asynchronous methods
-  how to use client callbacks
-  how to make use of your own ``ObjectFactory``


Planned improvements and known issues
-------------------------------------

Topics to be added
^^^^^^^^^^^^^^^^^^

Obviously, this introduction is still not exhaustive by any means. Some
topics which we would like to see added here in the near future include:

-  more examples of working with the |OmeroModel| 
-  examples of all services
-  security and ownership
-  performance

Code generation
^^^^^^^^^^^^^^^

Although not directly relevant to writing a client, it is important to
note that much of the code for |OmeroPy|, |OmeroCpp|, and |OmeroJava|
is code generated by the BlitzBuild. Therefore,
many of the imported and included files in the examples above cannot be found 
in `github <https://github.com/ome/openmicroscopy>`_.

We plan to include packages of the generated source code in future
releases. Until then, it is possible to find our latest builds on 
:jenkins:`jenkins <>` or to build them locally, although some of the
generated files are later overwritten by hand-written versions:

-  model is located in ``components/tools/OmeroCpp/src/omero/model/``
-  OmeroPy is located in ``components/tools/OmeroPy/src/``

Lazy loading and caching
^^^^^^^^^^^^^^^^^^^^^^^^

Separate method calls will often return one and the same object, say
``Dataset#123``. Your application, however, will not necessarily
recognize them as the same entity unless you explicitly check the id
value. A client-side caching mechanism would allow duplicate objects to
be handled transparently, and would eventually facilitate lazy loading.

Helper classes
^^^^^^^^^^^^^^

Several types are harder to use than they need be. omero.sys.Parameters,
for example, is a class for which native implementations are quite
helpful. We have provided omero.sys.ParametersI in all supported
languages, and will most likely support more over time:

Other
^^^^^

-  Superclasses need to be introduced where possible to replace the
   ``ome.model.*`` interfaces
-  Annotation-link-loading can behave strangely if
   ``AnnotationLink.child`` is not loaded.

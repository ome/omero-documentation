How To Create A Service
=======================

.. topic:: Overview
	These instructions are for core developers only and may be
	slightly out of date. They will eventually be revised, but if you are
	looking for general instructions on extending OMERO with a service, see
	|ExtendingOmero|. If you would indeed like to create a core service, 
	please contact the `ome-devel mailing 
	<http://www.openmicroscopy.org/site/community/mailing-lists>`_ list

--------------

--------------


To fulfill `#306 </ome/ticket/306>`_, r905 provides all the classes and
modifications needed to create a new stateless service (where this
varies from stateful services is also detailed). In brief, a service
provider must create an
`interface </ome/browser/ome.git/components/common/src/ome/api/IConfig.java>`_,
an
`implementation </ome/browser/ome.git/components/server/src/ome/logic/ConfigImpl.java>`_
of that interface, a `Spring configuration
file </ome/browser/ome.git/components/server/resources/ome/services/service-ome.api.IConfig.xml>`_,
as well as modify the `client
configuration </ome/browser/ome.git/components/client/resources/ome/client/spring.xml>`_
and the central `service
factory </ome/browser/ome.git/components/common/src/ome/system/ServiceFactory.java>`_
(These last two points stand to change with `#314 </ome/ticket/314>`_).

**Note:** With the creation of `OmeroBlitz </ome/wiki/OmeroBlitz>`_,
there are several other locations which need to be modified. These are
also listed below.

Files to Create
~~~~~~~~~~~~~~~

`ome.git/components/common/src/ome/api/IConfig.java </ome/browser/ome.git/components/common/src/ome/api/IConfig.java>`_
    the interface which will be made available to client and server
    alike (which is why all interfaces must be located in the
    **/common** component). Only serializable and client-available types
    should enter or exit the API. Must subclass
    **``ome.api.ServiceInterface``**.

`ome.git/components/server/src/ome/logic/ConfigImpl.java </ome/browser/ome.git/components/server/src/ome/logic/ConfigImpl.java>`_
    the implementation which will usually subclass
    ``AbstractLevel{1,2}Service`` or ``AbstractBean`` (See more below on
    **super-classes**) This is class obviously requires the most work,
    both to fulfill the interface's contract and to provide all the
    metadata (annotations) necessary to properly deploy the service.

`ome.git/components/server/resources/ome/services/service-ome.api.IConfig.xml </ome/browser/ome.git/components/server/resources/ome/services/service-ome.api.IConfig.xml>`_
    a ` Spring <http://www.springframework.org>`_ configuration file,
    which can "inject" any value available in the server (Omero)context
    into the implementation. Two short definitions are the minimum.
    (Currently not definable with annotations.) As explained in the
    file, the name of the file is not required and in fact the two
    definitions can be added to any of the files which fall within the
    lookup definition in the server's
    `beanRefContext.xml </ome/browser/ome.git/components/server/resources/beanRefContext.xml>`_
    file (see below).

`ome.git/components/blitz/src/ome/services/blitz/impl/ConfigI.java </ome/browser/ome.git/components/blitz/src/ome/services/blitz/impl/ConfigI.java>`_
    a ` Ice <http://zeroc.com/>`_ "servant" implementation which can use
    on of several methods for delegating to the ``ome.api.IConfig``
    interface, but all of which support
    `throttling </ome/wiki/OmeroThrottling>`_.

Files to Edit (not strictly necessary, see `#314 </ome/ticket/314>`_)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`ome.git/components/common/src/ome/system/ServiceFactory.java </ome/browser/ome.git/components/common/src/ome/system/ServiceFactory.java>`_
    our central API factory, needs an additional method for looking up
    the new interface (**get<interface name>Service()**)

`ome.git/components/client/resources/ome/client/spring.xml </ome/browser/ome.git/components/client/resources/ome/client/spring.xml>`_
    client ` Spring <http://www.springframework.org>`_ configuration,
    which makes the use of JNDI and JAAS significantly simpler.

`ome.git/components/blitz/resources/omero/API.ice </ome/browser/ome.git/components/blitz/resources/omero/API.ice>`_
(**blitz**)
    a ` http://www.zeroc.com <http://www.zeroc.com>`_ slice definition
    file, which provides cross-language mappings. Add the same service
    method to ``ServiceFactoryI`` as to ``ServiceFactory.java``.

`ome.git/components/blitz/resources/ome/services/blitz-servantDefinitions.xml </ome/browser/ome.git/components/blitz/resources/ome/services/blitz-servantDefinitions.xml>`_
(**blitz**)
    a ` Spring <http://www.springframework.org>`_ configuration, which
    defines a mapping between Ice servants and Java services.

`ome.git/components/blitz/resources/omero/Constants.ice </ome/browser/ome.git/components/blitz/resources/omero/Constants.ice>`_
(**blitz**)
    a ` http://www.zeroc.com <http://www.zeroc.com>`_ slice definition
    file, which provides constants needed for looking up services, etc.

`ome.git/components/blitz/src/ome/services/blitz/impl/ServiceFactoryI.java </ome/browser/ome.git/components/blitz/src/ome/services/blitz/impl/ServiceFactoryI.java>`_
(**blitz**)
    the central session in a blitz. Should always be edited parallel to
    ``ServiceFactory.java``. Also optional in that
    ``MyServicePrxHelper.uncheckedCast( serviceFactoryI.getByName(String) )``
    can be used instead.

Files Involved
~~~~~~~~~~~~~~

`ome.git/components/client/resources/beanRefContext.xml </ome/browser/ome.git/components/client/resources/beanRefContext.xml>`_
`ome.git/components/server/resources/beanRefContext.xml </ome/browser/ome.git/components/server/resources/beanRefContext.xml>`_
`ome.git/components/blitz/resources/beanRefContext.xml </ome/browser/ome.git/components/blitz/resources/beanRefContext.xml>`_
    ` Singleton
    definitions <http://static.springframework.org/spring/docs/2.0.x/reference/beans.html#d0e5298>`_
    which allow for the static location of the active context. These do
    not need to be edited, but in the case of the server
    `beanRefContext.xml </ome/browser/ome.git/components/server/resources/beanRefContext.xml>`_,
    it does define which files will be used to create the new context
    (of importance is the line
    **classpath\*:ome/services/service-\*.xml**). blitz's
    ``beanRefContext.xml`` defines the pattern
    **classpath\*:ome/services/blitz-\*.xml** to allow for
    blitz-specific configuration.

And don't forget the tests
~~~~~~~~~~~~~~~~~~~~~~~~~~

`ome.git/components/server/test/ome/server/itests/ConfigTest.java </ome/browser/ome.git/components/server/test/ome/server/itests/ConfigTest.java>`_
    tests only the implementation without a container.

`ome.git/components/client/test/ome/client/itests/ConfigTest.java </ome/browser/ome.git/components/client/test/ome/client/itests/ConfigTest.java>`_
    tests the entire stack. The application must be deployed and the
    test must use a valid username.

    **blitz**: Currently testing blitz is out side the scope of this
    document.

Things to be aware of
~~~~~~~~~~~~~~~~~~~~~

Local apis
^^^^^^^^^^

Several services implement a server-side subclass of the **ome.api**
interface rather than the interface itself. These interfaces are
typically in
`ome.api.local </ome/browser/trunk/components/server/src/ome/api/local>`_.
Such local interfaces can provide methods that should not be made
available to clients, but which are needed within the server. Though not
currently used, the **@Local()** annotation on the implementation can
list the local interface for future use. See
`UpdateImpl </ome/browser/ome.git/components/server/src/ome/logic/UpdateImpl.java>`_
for an example.

Stateful services
^^^^^^^^^^^^^^^^^

Currently all stateful services are in their own component
(`ome.git/components/rendering </ome/browser/ome.git/components/rendering>`_
and `ome.git/components/romio </ome/browser/ome.git/components/romio>`_
) but their interface will still need to be under
`ome.git/components/common </ome/browser/ome.git/components/common>`_
for them to be accessible to clients. `ToBeDone </ome/wiki/ToBeDone>`_

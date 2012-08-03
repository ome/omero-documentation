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


To fulfill :ticket:`306`, r905 provides all the classes and
modifications needed to create a new stateless service (where this
varies from stateful services is also detailed). In brief, a service
provider must create an
:source:`interface <components/common/src/ome/api/IConfig.java>`,
an
:source:`implementation <components/server/src/ome/logic/ConfigImpl.java>`
of that interface, a :source:`Spring configuration
file <components/server/resources/ome/services/service-ome.api.IConfig.xml>`,
as well as modify the :source:`client
configuration <components/client/resources/ome/client/spring.xml>`
and the central :source:`service
factory <components/common/src/ome/system/ServiceFactory.java>`
(These last two points stand to change with :ticket:`314`).

.. note::
    With the creation of OmeroBlitz, there are several other locations 
    which need to be modified. These are also listed below.

Files to Create
~~~~~~~~~~~~~~~

:source:`components/common/src/ome/api/IConfig.java`
    the interface which will be made available to client and server
    alike (which is why all interfaces must be located in the
    **/common** component). Only serializable and client-available types
    should enter or exit the API. Must subclass
    **``ome.api.ServiceInterface``**.

:source:`components/server/src/ome/logic/ConfigImpl.java`
    the implementation which will usually subclass
    ``AbstractLevel{1,2}Service`` or ``AbstractBean`` (See more below on
    **super-classes**) This is class obviously requires the most work,
    both to fulfill the interface's contract and to provide all the
    metadata (annotations) necessary to properly deploy the service.

:source:`components/server/resources/ome/services/service-ome.api.IConfig.xml`
    a ` Spring <http://www.springframework.org>`_ configuration file,
    which can "inject" any value available in the server (Omero)context
    into the implementation. Two short definitions are the minimum.
    (Currently not definable with annotations.) As explained in the
    file, the name of the file is not required and in fact the two
    definitions can be added to any of the files which fall within the
    lookup definition in the server's
    :source:`beanRefContext.xml <components/server/resources/beanRefContext.xml>`
    file (see below).

:source:`components/blitz/src/ome/services/blitz/impl/ConfigI.java`
    a ` Ice <http://zeroc.com/>`_ "servant" implementation which can use
    on of several methods for delegating to the ``ome.api.IConfig``
    interface, but all of which support
    `throttling </ome/wiki/OmeroThrottling>`_.

Files to Edit (not strictly necessary, see :ticket:`314`)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:source:`components/common/src/ome/system/ServiceFactory.java`
    our central API factory, needs an additional method for looking up
    the new interface (**get<interface name>Service()**)

:source:`components/client/resources/ome/client/spring.xml`
    client ` Spring <http://www.springframework.org>`_ configuration,
    which makes the use of JNDI and JAAS significantly simpler.

:source:`components/blitz/resources/omero/API.ice`
(**blitz**)
    a ` http://www.zeroc.com <http://www.zeroc.com>`_ slice definition
    file, which provides cross-language mappings. Add the same service
    method to ``ServiceFactoryI`` as to ``ServiceFactory.java``.

:source:`components/blitz/resources/ome/services/blitz-servantDefinitions.xml`
(**blitz**)
    a ` Spring <http://www.springframework.org>`_ configuration, which
    defines a mapping between Ice servants and Java services.

:source:`components/blitz/resources/omero/Constants.ice`
(**blitz**)
    a ` http://www.zeroc.com <http://www.zeroc.com>`_ slice definition
    file, which provides constants needed for looking up services, etc.

:source:`components/blitz/src/ome/services/blitz/impl/ServiceFactoryI.java`
(**blitz**)
    the central session in a blitz. Should always be edited parallel to
    ``ServiceFactory.java``. Also optional in that
    ``MyServicePrxHelper.uncheckedCast( serviceFactoryI.getByName(String) )``
    can be used instead.

Files Involved
~~~~~~~~~~~~~~

:source:`components/client/resources/beanRefContext.xml`
:source:`components/server/resources/beanRefContext.xml`
:source:`components/blitz/resources/beanRefContext.xml`
    ` Singleton
    definitions <http://static.springframework.org/spring/docs/2.0.x/reference/beans.html#d0e5298>`_
    which allow for the static location of the active context. These do
    not need to be edited, but in the case of the server
    :source:`beanRefContext.xml <components/server/resources/beanRefContext.xml>`,
    it does define which files will be used to create the new context
    (of importance is the line
    **classpath\*:ome/services/service-\*.xml**). blitz's
    ``beanRefContext.xml`` defines the pattern
    **classpath\*:ome/services/blitz-\*.xml** to allow for
    blitz-specific configuration.

And don't forget the tests
~~~~~~~~~~~~~~~~~~~~~~~~~~

:source:`components/server/test/ome/server/itests/ConfigTest.java`
    tests only the implementation without a container.

:source:`components/client/test/ome/client/itests/ConfigTest.java`
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
:source:`UpdateImpl <components/server/src/ome/logic/UpdateImpl.java>`
for an example.

Stateful services
^^^^^^^^^^^^^^^^^

Currently all stateful services are in their own component
(:source:`components/rendering` and :source:`components/romio`) 
but their interface will still need to be under
:source:`components/common`
for them to be accessible to clients. `ToBeDone </ome/wiki/ToBeDone>`_

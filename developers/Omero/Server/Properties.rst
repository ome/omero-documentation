Properties
==========

**As of `milestone:OMERO-Beta4 </ome/milestone/OMERO-Beta4>`_
(:ticket:`800`), client usage of these properties has
significantly changed. Please see the ` user
documentation <https://www.openmicroscopy.org/site/documents/data-management/omero4/server>`_
for how to configuration your server installation**

Under the ``etc/`` directory in both the source and the binary
distributions, several files are provided which help to configure
OMERO.server:

::

      etc/omero.properties             - Our central configuration file with all defaults.
      etc/hibernate.properties         - Required by Hibernate since some properties are only configurable 
                                         via a classpath:hibernate.properties file.
      etc/log4j.xml                    - Logging configuration
      etc/local.properties.example     - The properties that you will most likely want to change.
                                         This file can be copied to etc/local.properties to being, or 
                                         alternatively you can run "java omero setup"
                                         (Name will change to "...default")
      etc/local.properties             - Local overrides for other properties (used by build only)

During the build, these files get stored in the ``blitz.jar`` and are
read-only. On creation of an `OmeroContext </ome/wiki/OmeroContext>`_,
the lookup for properties is (first wins):

-  Properties passed into the constructor (if none, then the default
   properties in
   `internal.xml </ome/browser/ome.git/components/client/resources/ome/client/internal.xml>`_)
-  System.properties set via "java -Dproperty=value"
-  Configuration files in order listed.

This ordering is defined for the various components via "placeholder
configurers" in:

-  `source:ome.git/components/server/resources/ome/services/config-local.xml </ome/browser/ome.git/components/server/resources/ome/services/config-local.xml>`_
-  `source:ome.git/components/client/resources/ome/client/spring.xml </ome/browser/ome.git/components/client/resources/ome/client/spring.xml>`_
-  `source:ome.git/components/blitz/resources/omero/client.xml </ome/browser/ome.git/components/blitz/resources/omero/client.xml>`_

Once configured at start, all values declared in one of the mentioned
ways can be used in Spring configurations via the syntax:

::

     <bean id=...>
       <property name="mySetter" value="${property.name}"/>
     </bean>

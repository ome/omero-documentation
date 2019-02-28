Properties
==========

Under the :file:`etc/` directory in both the source and the binary
distributions, several files are provided which help to configure
OMERO.server:

:source:`etc/omero.properties`
  Our central configuration file with all defaults

:source:`etc/hibernate.properties`
  Required by Hibernate since some properties are only configurable via a 
  classpath:hibernate.properties file

:source:`etc/logback.xml`
  Logging configuration

:source:`etc/build.properties`
  The properties that you will most likely want to change

:file:`etc/local.properties`
  Local file overriding :file:`etc/build.properties` (used by build only)

The most useful of the properties are listed in a :doc:`glossary
</sysadmins/config>`.

During the build, these files get stored in the ``blitz.jar`` and are
read-only. On creation of an :doc:`/developers/Server/Context`,
the lookup for properties is (first wins):

-  Properties passed into the constructor (if none, then the default
   properties in :common_source:`config.xml <src/main/resources/ome/config.xml>`)
-  System.properties set via "java -Dproperty=value"
-  Configuration files in order listed.

This ordering is defined for the various components via "placeholder
configurers" in:

-  :server_source:`src/main/resources/ome/services/services.xml`

Once configured at start, all values declared in one of the mentioned
ways can be used in Spring configurations via the syntax:

::

     <bean id=…>
       <property name="mySetter" value="${property.name}"/>
     </bean>

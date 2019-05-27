Properties
==========

Under the :file:`etc/` directory in both the source and the binary
distributions, several files are provided which help to configure
OMERO.server:

:source:`etc/omero.properties`
  Since 5.5, the following repositories have now 
  a ``properties`` file with the properties used in the repository itself.
  See :model_source:`omero-model.properties <src/main/resources/omero-model.properties>`,
  :common_source:`omero-common.properties <src/main/resources/omero-common.properties>`,
  :server_source:`omero-server.properties <src/main/resources/omero-server.properties>`,
  :blitz_source:`omero-blitz.properties <src/main/resources/omero-blitz.properties>`.

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

On creation of an :doc:`/developers/Server/Context`,
the lookup for properties is (first wins):

-  Properties passed into the constructor (if none, then the default
   properties in :common_source:`config.xml <src/main/resources/ome/config.xml>`)
-  System.properties set via "java -Dproperty=value"
-  Configuration files in order listed.

This ordering is defined for the various components via "placeholder
configurers" in the following file in :omero_subs_github_repo_root:`omero-server`:

-  :server_source:`src/main/resources/ome/services/services.xml`

Once configured at start, all values declared in one of the mentioned
ways can be used in Spring configurations via the syntax:

::

     <bean id=…>
       <property name="mySetter" value="${property.name}"/>
     </bean>

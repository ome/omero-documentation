.. _developers/Server/ExtendingOmero:

Extending OMERO
===============

.. topic:: Overview

    Despite all the effort put into building OMERO, it will never
    satisfy the requirements of every group. Where we have seen it
    useful to do so, we have created extension points which can be used
    by third-party developers to extend, improve, and adapt OMERO. We
    outline most of these options below as well as some of their
    trade-offs. We are also always interested to hear other possible
    extension points. Please contact ome-devel with any such
    suggestions.


.. contents::

Other starting points
---------------------

Clients
~~~~~~~

To write you own clients or scripts against the OMERO API, see the
|OmeroClients| page. Though writing your own
client is a form of extending OMERO, the topics that follow are for
extending the server and do not cover clients. For information specific
to Insight, please see the client trac:

-  `OmeroInsightHowToBuildAgent </ome/wiki/OmeroInsightHowToBuildAgent>`_
-  `OmeroInsightHowToBuildAgentView </ome/wiki/OmeroInsightHowToBuildAgentView>`_
-  `OmeroInsightHowToRetrieveData </ome/wiki/OmeroInsightHowToRetrieveData>`_

List of Extension points
~~~~~~~~~~~~~~~~~~~~~~~~

To get a feeling for what type of extension points are available, you
might want to take a look at the following pages. Many of them will
point you back to this page for packaging and deploying your new code.

-  `FileParsers </ome/wiki/FileParsers>`_: Write Java file parsers to
   further extend search
-  `LoginAttemptListener </ome/wiki/LoginAttemptListener>`_: Write a
   Java handler for failed login attempts
-  `ObjectFactoryRegistry </ome/wiki/ObjectFactoryRegistry>`_: Write
   server-side handlers for your Ice implementations
-  |OmeroCli|: Write drop in Python extensions for
   the command-line
-  `OmeroScripts </ome/wiki/OmeroScripts>`_: Write python scripts to
   process data server-side
-  `OmeroLdap </ome/wiki/OmeroLdap>`_: Write a Java authentication
   plugin
-  `PasswordProvider </ome/wiki/PasswordProvider>`_: Write a Java
   password backend
-  `SearchBridges </ome/wiki/SearchBridges>`_: Write Java Lucene parsers
   to extend search

--------------

Main topics
-----------

Model
~~~~~

The OME Data Model and its OMERO representation, the
`ObjectModel </ome/wiki/ObjectModel>`_, intentionally draw lines between
what metadata can be supported and what can't. Though we are always
examining new fields for inclusion (as of Summer 2009 two examples of
these are lifetime and electron microscopy), it's not possible to
represent everyone's model within OME.

Structured Annotations
^^^^^^^^^^^^^^^^^^^^^^

The primary extension point for including external data are the
`StructuredAnnotations </ome/wiki/StructuredAnnotations>`_ (SAs). SAs
are designed as email-like attachments which can be associated with
various core metadata types. In general, they should like to information
outside of the OME model, i.e. information of which OMERO clients and
servers should have no understanding. URLs can point to external data
sources, or XML in a non-OME namespace can be attached.

The primary drawbacks are that the attachments are opaque and cannot be
used in a fine-grain manner.

Code generation
^^^^^^^^^^^^^^^

Since it is prohibitive to model full objects with the SAs, one
alternative is to add types directly to the code-generated. By adding a
file named ``*.ome.xml`` to :source:`components/model/resources/mappings`
and running a full-build, it is possible to have new objects generated
in all `OmeroBlitz </ome/wiki/OmeroBlitz>`_ languages. Supported fields
include:

-  boolean
-  string
-  long
-  double
-  timestamp
-  links to any other ``ome.model.*`` object, including enumerations

For example:

::

    <types>
      <!-- "named" and "described" are short-cuts to generate the fields "name" and "description" -->
      <type id="ome.model.myextensions.Example" named="true" described="true">
        <required name="valueA" type="boolean"/>  <!-- This is NONNULL -->
        <optional name="valueB" type="long"/>     <!-- This is nullable -->
        <onemany  name="images" type="ome.model.core.Image"/> <!-- A set of images -->
      </type>
    </types>

Collections of primitive values like
``<onemany name="values" type="long"/>`` are not supported. Please see
the existing mapping files for more examples of what can be done.

The primary drawback of code-generating your own types is isolation and
maintenance. Firstly, your installation becomes isolated from the rest
of the OME ecosystem. New types are not understood by other servers and
clients, and cannot be exported or shared. Secondly, you will need to
maintain your own server **and** client builds of the system, since the
provided binary builds would not have your new types.

Measurement results
^^^^^^^^^^^^^^^^^^^

For storing large quantites of only partially structured data, such as
tabular/CSV data with no pre-defined columns, neither the SAs nor the
code-generation extensions are ideal. SAs cannot easily be aggregated,
and code-generation would generate too many types. This is particularly
clear in the storage and management of HCS analysis results.

To solve this problem, we provide the
`OmeroTables </ome/wiki/OmeroTables>`_ API for storing tabular data
indexed via Roi, Well, or Image id.

Services
~~~~~~~~

Traditionally, services were added via Java interfaces in the
:source:`components/common/src/ome/api`
package. The creation of such "core" services is described under
`wiki:HowToCreateAService </ome/wiki/HowToCreateAService>`_. However,
with the introduction of `OmeroBlitz </ome/wiki/OmeroBlitz>`_, it's also
possible to write blitz-only services which are defined by a slice
definition under :source:`components/blitz/resources/omero`.

A core service is required when server internal code should also make
use of the interface. Since this is very rarely the case for third-party
developers wanting to extend OMERO, only the creation of blitz services
will be discussed here.

Add a slice definition
^^^^^^^^^^^^^^^^^^^^^^

The easiest possible service definition in slice is:

::

      module example {
        interface NewService {
          void doSomething();
        };
      };

This should be added to any existing or a new ``*.ice`` file under the
``blitz/resources/omero`` directory. After the next ant build, stubs
will be created for all the `OmeroBlitz </ome/wiki/OmeroBlitz>`_
languages, i.e.  |OmeroJava|, |OmeroPy|, and |OmeroCpp|.

**Note:** Once you have gotten your code working, it is most re-usable
if you can put it all in a single directory under tools/. These
components also have their ``resources/*.ice`` files turned into code,
and they can produce their own artifacts which you can distribute
without modifying the main code base.

Warning: Exceptions
^^^^^^^^^^^^^^^^^^^

You will need to think carefully about what exceptions to handle. Ice
(especially |OmeroCpp|) does not handle exceptions
well that are not strictly defined. In general, if you would like to add
your own exception type, feel free to do so, but either 1) subclass
``omero::ServerError`` or 2) add it the appropriate ``throws`` clauses.
And regardless, if you are accessing any internal OMERO API, add
``omero::ServerError`` to your ``throws`` clause.

See `ExceptionHandling </ome/wiki/ExceptionHandling>`_ for more
information.

Java Implementation using ``_Disp``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To implement your service, create a class subclassing
"example.\_NewServiceDisp" class which was code-generated. In this
example, the class would be named "NewServiceI", by convention. If this
service needs to make use of any of the internal API, it should do so
via dependency injection. For example, to use IQuery, add either:

::

        void setLocalQuery(LocalQuery query) {
            this.query = query;
        }

or

::

        NewServiceI(LocalQuery query) {
            this.query = query;
        }

The next step "Java Configuration" will take care of how those objects
get injected.

Java Implementation using ``_Tie``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Rather than subclassing the ``_Disp`` object, it is also possible to
implement the ``_Tie`` inteface for your new service. This allows
wrapping and testing your implementation more easily at the cost of a
little indirection. You can see how such an object is configured in
:source:`components/blitz/resources/ome/services/blitz-servantDefinitions.xml#L36`
blitz-servantDefinitions.

Java Configuration
^^^^^^^^^^^^^^^^^^

Configuration in the Java servers takes place via
` Spring <http://springframework.org>`_. One or more files matching a
pattern like ``ome/services/blitz-*.xml`` should be added to your
application.

::

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE beans PUBLIC "-//SPRING//DTD BEAN//EN" "http://www.springframework.org/dtd/spring-beans.dtd">
    <beans>

      <bean class="NewServiceI">
        <description>
        This is a simple bean definition in Spring. The description is not necessary.
        </description>
        <constructor-arg ref="internal-ome.api.IQuery"/>
      </bean>

    </beans>

The three patterns which are available are:

-  ``ome/services/blitz-*.xml`` : highest-level objects which have
   access to all the other defined objects.
-  ``ome/services/services-*.xml`` : internal server objects which do
   not have access to ``blitz-*.xml`` objects.
-  ``ome/services/db-*.xml`` : base connection and security objects.
   These will be included in background java process like the index and
   pixeldata handlers. **NB:**
   `PasswordProvider </ome/wiki/PasswordProvider>`_ and similar should
   be included at this level.

See :source:`components/blitz/resources/ome/services`
and :source:`components/server/resources/ome/services`
for all the available objects.

.. _developers/Server/ExtendingOmero#JavaDeployment:

Java Deployment
^^^^^^^^^^^^^^^

Finally, these resources:

-  the code generated classes
-  your ``NewServiceI.class`` file and any related classes
-  your ``ome/service/blitz-*.xml`` file (or other XML)

should all be added to ``OMERO_DIST/lib/server/extensions.jar``.

Future topics
^^^^^^^^^^^^^

Information on:

-  implementation, configuration, and deploy in other
   `OmeroBlitz </ome/wiki/OmeroBlitz>`_ languages
-  Subclassing from existing servant implementation
-  Using AMD to reduce server contention

will be provided in the future or upon request.

Non-service beans
~~~~~~~~~~~~~~~~~

In addition to writing your own services, the instructions above can be
used to package any Spring-bean into the OMERO server. For example,

::

    //
    // MyLoginAttemptListener.java
    //
    import ome.services.messages.LoginAttemptMessage;

    import org.springframework.context.ApplicationListener;

    /**
     * Trivial listener for login attempts.
     */

    public class MyLoginAttemptListener implements
            ApplicationListener<LoginAttemptMessage> {

        public void onApplicationEvent(LoginAttemptMessage lam) {
            if (lam.success != null && !lam.success) {
                // Do something
            }
        }

    }

::

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE beans PUBLIC "-//SPRING//DTD BEAN//EN" "http://www.springframework.org/dtd/spring-beans.dtd">
    <!--
    //
    // ome/services/blitz-myLoginListener.xml
    //
    -->
    <beans>
      <bean class="myLoginAttemptListener" class="MyLoginAttemptListener">
        <description>
        This listener will be added to the Spring runtime and listen for all LoginAttemptMessages.
        </description>
      </bean>

    </beans>

Putting ``MyLoginAttemptListener.class`` and
``ome/services/blitz-myLoginListener.xml`` into
``lib/server/extensions.jar`` is enough to activate your code:

::

    ~/example $ ls -1
    MyLoginListener.class
    MyLoginListener.java
    lib
    ...
    ~/example $ jar cvf lib/server/extensions.jar MyLoginListener.class ome/services/blitz-myLoginListener.xml 
    added manifest
    adding: MyLoginListener.class(in = 0) (out= 0)(stored 0%)
    adding: ome/services/blitz-myLoginListener.xml(in = 0) (out= 0)(stored 0%)

Servers
~~~~~~~

With the |OmeroGrid| infrastructure, it is
possible to have your own processes managed by the OMERO infrastructure.
For example, at some sites, ` Nginx <http://wiki.nginx.org/Main>`_ is
started to host |OmeroWeb|. Better integration is
possible, however, if your server also uses the
` Ice <http://www.zeroc.com>`_ remoting framework.

On way or the other, to have your server started, monitored, and
eventually shutdown by |OmeroGrid|, you will need
to add it to the "application descriptor" for your site. When using:

::

      bin/omero admin start

the application descriptor used is :source:`etc/grid/default.xml`.
The ``<application>`` element contains various ``<node>``\ s. Each node
is a single daemon process that can start and stop other processes.
Inside the nodes, you can either directly add a ``<server>`` element, or
in order to reuse your description, you can use a ``<server-instance>``
which must refer to a ``<server-template>``.

Let's make that a bit clearer with examples. Say you have a simple
application which should watch for newly created Images and send you an
email: ``mail_on_import.py``. To add this, either of the following would
work:

server element
^^^^^^^^^^^^^^

::

      <node name="my-emailer-node">  <!-- this could also be an existing node, but it must be unique -->
        <server id="my-emailer-server" exe="/home/josh/mail_on_import.py" activation="always">
          <env>${PYTHONPATH}</env>
          <!-- The adapter name must also be unique -->
          <adapter name="MyAdapter" register-process="true" endpoints="tcp"/>
        </server>
      </node>

server-template & seerver-instance elements
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

      <server-template id="emailer-template">  <!-- must also be unique -->
        <property name="user"/>
        <server id="emailer-server-${user}" exe="/home/${user}/mail_on_import.py" activation="always">
          <env>${PYTHONPATH}</env>
          <adapter name="MyAdapter" register-process="true" endpoints="tcp"/>
        </server>
      </server-template>

      <node name="our-emailer-node">
        <server-instance id="emailer-template" user="ann">
        <server-instance id="emailer-template" user="ann"> 
      </node>

--------------

-  See also: ` the ome-devel
   thread <http://lists.openmicroscopy.org.uk/pipermail/ome-devel/2009-July/001332.html>`_

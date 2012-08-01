Contributing to OMERO.insight
-----------------------------

Getting Started with OMERO.insight
----------------------------------

Getting started with OMERO.insight entails that you have an
` OMERO.server <http://trac.openmicroscopy.org.uk/omero>`_ already
deployed.

Installing From Source
----------------------

Since January 2011, OMERO.insight code base is part of the OMERO code
base. See `OmeroContributing </ome/wiki/OmeroContributing>`_, to check
out code using
` http://git.openmicroscopy.org/ <http://git.openmicroscopy.org/>`_

Requirements
~~~~~~~~~~~~

-  Install a Java 5 Development Kit (JDK), available from ` Java SE
   Downloads <http://java.sun.com/javase/downloads/index.jsp>`_ and
   required for both the OMERO server and client code. Set the
   ``JAVA_HOME`` environment variable to your JDK installation.

Running Code
~~~~~~~~~~~~

It is helpful to setup the project in
` Eclipse <http://www.eclipse.org>`_.

Build system
~~~~~~~~~~~~

Ant
^^^

The compilation, testing, launch, and delivery of the application are
automated by means of an Ant
(` http://ant.apache.org/ <http://ant.apache.org/>`_) build file,
located under the ``build`` directory (See `Directory
Contents </ome/wiki/OmeroInsightDirectoryContents>`_). Move to the build
directory and, from the command line, enter:

::

    java build

This will display the available targets to compile, run, test, and
create a distribution bundle. Use the target you wish, for example:

::

    java build all

Because all the tools needed to build the software are already included
in the build directory, you do not need to have Ant on your machine. If
you wish to use Ant instead, you can still do it by using the
``build.xml`` file under the ``build`` directory. However, there are
some dependencies to satisfy before; these are clearly documented in the
``build.xml`` file itself.

For more details, see `Software Build and
Deployment </ome/attachment/wiki/OmeroInsightContributing/sbdd.pdf>`_
`|Download| </ome/raw-attachment/wiki/OmeroInsightContributing/sbdd.pdf>`_.

Hudson
^^^^^^

The OME project currently uses ` Hudson <http://hudson.dev.java.net>`_
as a continuous integration server available at
` http://hudson.openmicroscopy.org.uk <http://hudson.openmicroscopy.org.uk>`_
. OMERO.insight is built by the "INSIGHT" job at
` http://hudson.openmicroscopy.org.uk/job/INSIGHT-trunk <http://hudson.openmicroscopy.org.uk/job/INSIGHT-trunk>`_
.

Hudson checks for SVN changes every 15 minutes and executes:

::

    export JBOSS_HOME=$HOME/root/opt/jboss
    export JAVA_OPTS=&quot;-Xmx600M -Djavac.maxmem=600M -Djavadoc.maxmem=600M -XX:MaxPermSize=256m&quot;

    #
    # Build
    #
    J=7 java $JAVA_OPTS omero build-all
    # integration unfinished


    #
    # Documentation and build reports
    #
    java $JAVA_OPTS omero -f components/antlib/resources/release.xml -Dbasedir=. javadoc
    java $JAVA_OPTS omero findbugs # separate call to prevent PermGen OOM
    java $JAVA_OPTS omero coverage


    #
    # Prepare a distribution
    #
    rm -f OMERO.insight-build*.zip
    java -Domero.version=build$BUILD_NUMBER omero zip

The Javadocs are available at
` http://hudson.openmicroscopy.org.uk/job/INSIGHT-trunk/javadoc <http://hudson.openmicroscopy.org.uk/job/INSIGHT-trunk/javadoc>`_
as well as several build metrics.

Attachments
~~~~~~~~~~~

-  `sbdd.pdf </ome/attachment/wiki/OmeroInsightContributing/sbdd.pdf>`_
   `|image2| </ome/raw-attachment/wiki/OmeroInsightContributing/sbdd.pdf>`_
   (102.7 KB) - added by *bwzloranger* `18
   ago.

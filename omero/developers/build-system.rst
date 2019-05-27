Build System
============

.. topic:: Overview

	The page goes into details about how the build system is configured.

.. _Ant: https://ant.apache.org
.. _Ivy: https://ant.apache.org/ivy
.. _Gradle: https://gradle.org/

Since 5.5, OMERO decouples many components and uses, for some components, an Gradle_-based build. The two overarching repositories are
:omero_subs_github_repo_root:`omero-build` and :omero_subs_github_repo_root:`omero-gradle-plugins`. 
See the README of each repository for more details.
OMERO still uses an Ant_-based build, for some components, with dependency management provided by
Ivy_. :doc:`C++ code </developers/Cpp>` is built using Cmake and Python
uses the traditional distutils/setuptools tools.

Structure of the build
----------------------

This is an (abbreviated) snapshot of the structure of the filesystem for
OMERO::

      OMERO_SOURCE_PREFIX
      |
      |-- build.xml .......................... Top-level build file
      |
      |-- build.py ........................... Python wrapper to handle OS-specific configuration
      |
      |-- omero.class ........................ Self-contained Ant launcher
      |
      |--etc ................................. Configuration folder
      |   |-- grid ........................... Deployment files folder
      |   |-- ivysettings.xml ................ Main Ivy configuration file
      |   |-- hibernate.properties
      |   |-- build.properties
      |   |-- logback.xml
      |   |-- omero.properties
      |   \-- profiles
      |
      |-- examples ........................... User examples
      |
      \components
        |
        |--<component-name> .................. Each component has this same basic structure.
        |    |-- build.xml ................... Build file
        |    |-- ivy.xml ..................... Jar dependencies
        |    |-- test.xml .................... Test dependencies
        |    |-- src ......................... Source code
        |    |-- resources ................... Other files of interest
        |    |-- test ........................ Test source code and test resources
        |    \-- target ...................... Build output (deleted on clean)
        |
        |  NOTABLE COMPONENTS
        |     
        |--tools ............................. Other server-components with special build needs.
        |    |--build.xml .................... Build scripts
        |    |
        |    \--<tool-name>
        |         |--build.xml ............... Build file
        |         \--ivy.xml ................. Jar dependencies
        |
        \--antlib ............................ Special component which is not built, but referenced by the build
            |
            \--resources ..................... Build resources
                |--global.xml ................ Global build properties
                |--hibernate.xml
                |--lifecycle.xml ............. Ivy-related targets
                \--version.xml ............... Version properties

.. note::
    User examples are explained under :doc:`/developers/GettingStarted`

Unfortunately, just the above snapshot of the code repository omits some
of the most important code. Many megabytes of source code is generated both by
our own :dsl_plugin_sourcedir:`DSLTask <>` as well as by
the Ice_ ``slice2java``, ``slice2cpp``, and
``slice2py`` code generators. These take an intermediate representation
of the :model_doc:`OME-Model <ome-xml/>` and generate our |OmeroModel|.
This code is not available in git, but once built, can be found in all the
directories named "generated".

Build tools
-----------

Ant
^^^

``./build.py`` is a complete replacement for your local ant install. In
many cases, you will be fine running :program:`ant`. If you have any issues
(for example ``OutOfMemory``) , please use ``./build.py`` instead. **However,
only use one or the other; do not mix calls between the two.**

The main build targets are defined in the top-level :file:`build.xml` file.
All available targets can be listed using::

    ./build.py -p

Ivy
^^^

The build system uses Ivy_ 2.3.0 as the dependency manager. The general Ivy
configuration is defined in a :ivydoc:`settings file <settings.html>` located
under :source:`etc/ivysettings.xml`.

In order to determine the transitive closure of all dependencies, Ivy resolves
each :file:`ivy.xml` file and stores the resolved artifacts in a
:ivydoc:`cache <settings/caches/cache.html>` to speed up other processes. The
OMERO build system defines and uses two kinds of caches:

#. the local dependencies cache under :file:`lib/cache` is used by most
   resolvers
#. Maven resolvers use the Maven cache under :file:`~/.m2/repository`

.. note::

   When the Ivy configuration file or the version number is changed, the
   cache can become stale. Calling ``./build.py clean`` from the top-level
   build will delete the content of the local cache.

:ivydoc:`Resolvers <settings/resolvers.html>` are key to how Ivy functions. Multiple dependency resolvers can be defined fine-grained enough to resolve an individual jar in order to pick up the latest version of any library from a
:ivydoc:`repository <resolver/ibiblio.html>`, a
:ivydoc:`generic URL <resolver/url.html>` or from the
:ivydoc:`local file system <resolver/filesystem.html>`.
Since OMERO 5.1.3, the remote repository resolvers are set up to resolve
transitive dependencies.

The OMERO build system uses by default a
:ivydoc:`chain resolver <resolver/chain.html>` called ``omero-resolver`` which
resolves the following locations in order:

#. :file:`target/repository` which contains most artifacts published by the
   build system in the `install` step of the lifecycle
#. the local dependency repository under :file:`lib/repository`
#. the local Maven cache under :file:`~/.m2/repository`
#. the `Maven central repository <https://central.sonatype.org>`_
#. the `OME artifactory`_

Bio-Formats dependencies are resolved using a specific
:ivydoc:`chain resolver <resolver/chain.html>` called ``ome-resolver`` which
resolves the following locations in order:

#. the local Maven cache under :file:`~/.m2/repository`
#. the `OME artifactory`_

To define its dependencies, each component uses a top-level
:ivydoc:`Ivy file <ivyfile.html>`, :file:`ivy.xml`, for the build and
optionally another Ivy file, :file:`test.xml`, for the tests.

The OMERO build system defines and uses four types of Ivy
:ivydoc:`configurations <ivyfile/configurations.html>`:

#. build: defines dependencies to be used for building
#. server: defines dependencies to be bundled under :file:`lib/server`
#. client: defines dependencies to be bundled under :file:`lib/client`
#. test: defines dependencies to be used for running the tests

While building, most Java components follow the same lifecycle define in
:source:`lifecycle.xml <components/antlib/resources/lifecycle.xml>`. The
default `dist` target for each component calls each of the following steps in
order:

#. retrieve: :ivydoc:`retrieve <use/retrieve.html>` the resolved dependencies
   and copy them under :file:`target/libs`
#. prepare: prepare various resources (property files,
   :source:`lib/logback-build.xml`)
#. generate: copy all resources from the previous step for compilation
#. compile: compile the source files into the destination repository
#. package-extra: package the sources and the Javadoc into Jar files for
   publication
#. package: package the compiled classes into a Jar file for publication
#. install: convert the component Ivy file into a pom file using
   :ivydoc:`makepom <use/makepom.html>` and
   :ivydoc:`publish <use/publish.html>` the component artifacts

Individual components can override the content of this default lifecycle via
their :file:`build.xml`.

.. _build#OmeroTools:

OmeroTools
^^^^^^^^^^

The Ant_ build alone is not enough to describe all the products which get
built. Namely, the builds for the non-Java components stored under
:sourcedir:`components/tools` are a bit more complex. Each tools component
installs its artifacts to the tools/target directory which is copied **on top of** the :file:`dist` top-level distribution directory.


Jenkins
^^^^^^^

The OME project currently uses Jenkins_ as
a continuous integration server available :jenkins:`here <>`, so many
binary packages can be downloaded without compiling them yourself. See the :devs_doc:`Continuous Integration documentation <ci-omero.html>` for further details.

Server build
------------

The default ant target (``build-default``) will build the OMERO system and
copy the necessary components for a binary distribution to the :file:`dist`
directory. Below is a comparison of what is taken from the build, where
it is put, and what role it plays in the distribution.

.. list-table::
    :header-rows: 1

    * - OMERO_SOURCE_PREFIX
      - OMERO_SOURCE_PREFIX/dist
      - Comments
    * - components/tools/OmeroCpp/lib*
      - :file:`lib/`
      - Native shared libraries
    * - components/tools/OmeroPy/build/lib
      - :file:`lib/python`
      - Python libraries
    * - lib/repository/<some>
      - :file:`lib/client` & :file:`lib/server`
      - Libraries needed for the build
    * - etc/
      - :file:`etc/`
      - Configuration
    * - :file:`sql/*.sql`
      - :file:`sql/`
      - SQL scripts to prepare the database


.. note::
    By default, |OmeroCpp| are not built. Use ``build-all`` for that.

These files are then zipped to OMERO.server-<version>.zip via ``release-zip``

Coupled development
-------------------

Since OMERO 5.1.3, Bio-Formats is decoupled from the OMERO build system which
consumes Bio-Formats artifacts from the OME Maven repository via Ivy_.

While this decoupling matches most of the development use cases, it is
sometimes necessary to work on coupled Bio-Formats and OMERO branches
especially during breaking changes of the OME Data Model or the Bio-Formats
API.

The general rule for coupled branches is to build each component in their
dependency order and use the local Maven repository under :file:`~/.m2/repository` to share artifacts.

Building Bio-Formats
^^^^^^^^^^^^^^^^^^^^

From the top-level folder of the Bio-Formats repository,

#. if necessary, adjust the version of Bio-Formats which will be built,
   installed locally and consumed by OMERO e.g. for 5.2.0-SNAPSHOT::

     $ ./tools/bump_maven_version.py 5.2.0-SNAPSHOT

#. run the Maven command allowing to build and install the artifacts under the
   local Maven cache::

     $ mvn clean install

Building OMERO
^^^^^^^^^^^^^^

From the top-level folder of the OMERO repository,

#. adjust the version of ``ome:formats-gpl`` in
   :model_source:`build.gradle` to the version chosen for the Bio-Formats
   build

#. publish locally :omero_subs_github_repo_root:`omero-model`

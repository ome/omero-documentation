Running and writing tests
=========================

The following guidelines apply to tests in both the Java and Python test
components. However, some of the presented options apply to only one or the
other.

The default build target does not compile all the required testing resources.
You should run `test-compile` (or `build-dev` if you are using Eclipse) first:

::

    ./build.py build-default test-compile


You must rebuild the `test-compile` target if you subsequently modify any of
the Java tests.


.. note::
    The OMERO C++ components and tests are under heavy development, and
    are not compiled or run by the targets mentioned on this page.


Running tests
-------------

Running unit tests
^^^^^^^^^^^^^^^^^^

Starting from version 5.5, components have been migrated to their own repository.

The following repositories use `Gradle <https://gradle.org/>`_ to run the unit tests:
  - :omero_subs_github_repo_root:`omero-model`
  - :omero_subs_github_repo_root:`omero-common`
  - :omero_subs_github_repo_root:`omero-romio`
  - :omero_subs_github_repo_root:`omero-renderer`
  - :omero_subs_github_repo_root:`omero-server`
  - :omero_subs_github_repo_root:`omero-blitz`
  - :omero_subs_github_repo_root:`omero-gateway-java`

The following repositories use `pytest <https://docs.pytest.org/en/latest/>`_ to run the unit tests:
  - :omero_subs_github_repo_root:`omero-py`
  - :omero_subs_github_repo_root:`omero-web`


Running integration tests
^^^^^^^^^^^^^^^^^^^^^^^^^

Integration testing is a bit more complex because of the reliance on a
database, which is not easily mockable. All Hibernate-related classes
are tested in integration mode.

The tests require a fast computer. Running all the integration tests
places several restrictions on the environment:

- There must be a running OMERO database.
- An OMERO.server instance must be running.

Integration tests assume that:

- :envvar:`ICE_CONFIG` has been properly set. The contents of the
  :file:`etc/ice.config` file should be enough to configure a running server
  for integration testing. This means that code creating a client connection
  as outlined in
  :doc:`GettingStarted/AdvancedClientDevelopment`
  should execute without errors.
- An OMERO.server instance is running on the host and port specified in
  the :envvar:`ICE_CONFIG` file.

If any of the tests fail with a user authentication exception (or
``omero.client`` throws an exception), a new :file:`ice.config` file can be
created and pointed to by the :envvar:`ICE_CONFIG` environment variable.
Most likely the first settings that will have to be put there will be
``omero.user`` and ``omero.pass``.

Running all tests
"""""""""""""""""

To run all the integration tests, use

::

    ./build.py test-integration


Note that some Python tests are excluded by default,
see :ref:`using-markers-in-python-tests` for more details.

Component tests
"""""""""""""""

Running an integration test suite for an individual component can be done
explicitly via:

::

    ./build.py -f components/<component>/build.xml integration

Results are placed in ``components/<component>/target/reports``.


Individual tests
""""""""""""""""

.. warning::
    Some integration tests leak file descriptors. If many tests are run
    then they may start to fail after the system's open files limit is
    reached. Depending on your system the limit may be checked or
    adjusted using :command:`ulimit -n` and :file:`/etc/login.conf` or
    :file:`/etc/security/limits.conf`.

Running Java tests
^^^^^^^^^^^^^^^^^^

Individual tests
""""""""""""""""

Alternatively, you can run individual tests which you may currently be
working on using the ``--tests`` parameter. The test class must be provided
in the fully qualified name form.

::

    cd components/tools/OmeroJava
    gradle test --tests "integration.gateway.AdminFacilityTest"


Individual test class methods
"""""""""""""""""""""""""""""


Individual OmeroJava test class methods can be run using the 
``--tests`` parameter. The test method must be provided in the fully
qualified name form.

::

    cd components/tools/OmeroJava
    gradle test --tests "integration.chgrp.AnnotationMoveTest.testMoveTaggedImage"

Individual test groups
""""""""""""""""""""""

To run individual OmeroJava test groups the ``--tests`` parameter.

::

    cd components/tools/OmeroJava
    gradle test --tests "integration.*"


Using Eclipse to run tests
"""""""""""""""""""""""""""

To facilitate importing OMERO components into Eclipse, there are
:file:`.project` and :file:`.classpath-template` files stored in each
component directory (e.g. :file:`tools/OmeroJava`'s
:file:`.project` and :file:`.classpath-template`).

There are also top-level :file:`.classpath` and :file:`.project` files which
allow for importing all components as a single project, but this approach
requires more memory and does not clearly differentiate the classpaths, and
so can lead to confusion.

Before importing any component as a project into Eclipse, a successful
build has to have taken place:

::

    ./build.py

This is for two reasons. Firstly, the Eclipse projects are not configured to
perform the code generation needed. The :command:`build.py` command creates
the directory:

::

    <component>/target

which will be missing from any Eclipse project you open before building
the source.

Secondly, Ivy is used to copy all the jar dependencies from
``OMERO_SOURCE_PREFIX/lib/repository`` to ``<component>/target/libs``, which
is then used in the Eclipse :file:`.classpath` files.

If Eclipse ever gets out of sync after the first build,
:command:`./build.py build-eclipse` can be used to quickly synchronize.


A prerequisite of running unit and integration tests in the Eclipse UI is
having the TestNG plug-in installed and working (help available on the
`TestNG site <https://testng.org/doc/eclipse.html>`_).

Running the unit tests under Eclipse requires no extra settings and is as
easy as navigating to the package or class context menu :guilabel:`Run As`
or :guilabel:`Debug As`, then selecting :guilabel:`TestNG`.

Integration tests require the :envvar:`ICE_CONFIG` environment variable to
be available for the Eclipse-controlled JVM. This can be done by editing
Debug/Run configurations in Eclipse. After navigating to the Debug (or Run)
Configurations window, the :guilabel:`Environment` tab needs to be selected.
After clicking :guilabel:`New`, :envvar:`ICE_CONFIG` can be defined as a
path to the :file:`ice.config` file. This setting needs to be defined per
package, class or method.

By using the "debug" target from templates.xml, it is possible to have
OMERO listen on port 8787 for a debugging connection.

::

    omero admin stop
    omero admin start debug

Then in Eclipse, you can create a new "Debug" configuration by clicking
on :guilabel:`Remote Java Application`, and setting the port to 8787. These
values are arbitrary and can be changed locally.

**Keep in mind**:

- The server will not start up until you have connected with Eclipse. This
  is due to the "suspend=y" clause in templates.xml. If you would like
  the server to start without you connecting, use "suspend=n".
- If you take too much time examining your threads, your calls may
  throw timeout exceptions.

Running Python tests
^^^^^^^^^^^^^^^^^^^^

.. _using-markers-in-python-tests:

Using markers in OmeroPy tests
""""""""""""""""""""""""""""""

Tests under OmeroPy can be included or excluded according to markers defined
in the tests.
This can be done by using the ``-DMARK`` option. For example, to run all
the integration tests marked as ``broken``:

::

    ./build.py -f components/tools/OmeroPy/build.xml integration -DMARK=broken

By default tests marked as ``broken`` are excluded so
the following two builds are equivalent:

::

    ./build.py -f components/tools/OmeroPy/build.xml integration
    ./build.py -f components/tools/OmeroPy/build.xml integration -DMARK="not broken"

In order to run **all** tests, including ``broken``,
an empty marker must be used:

::

    ./build.py -f components/tools/OmeroPy/build.xml integration -DMARK=

.. seealso::
    :ref:`marking-python-tests`

.. _running-python-tests-directly:

Running tests directly
""""""""""""""""""""""

When writing tests it can be more convenient, flexible and powerful to run the
tests from :sourcedir:`components/tools/OmeroPy` or
:sourcedir:`components/tools/OmeroWeb` using :program:`pytest`.
Since Python is interpreted, tests can be written and then run without having
to rebuild or restart the server. A few basic options are shown below.

First create a python virtual environment
as described on the :doc:`OMERO Python </developers/Python>` page,
including ``omero-py`` and ``omero-web`` if you want to run OmeroWeb tests.
Some tests also require the installation of PyTables.

Then install some additional test dependencies::

    $ pip install pytest mox3 pyyaml tables

    # for Omeroweb tests
    $ pip install pytest-django

Run tests directly with pytest, setting the :envvar:`ICE_CONFIG` as described above.
Also set :envvar:`OMERODIR` to point to the OMERO.server::

    export ICE_CONFIG=/path/to/openmicroscopy/etc/ice.config
    export OMERODIR=/path/to/OMERO.server-x.x.x-ice36-bxx

    cd components/tools/OmeroPy
    pytest test/integration/test_admin.py

    # OR for OmeroWeb tests:
    cd components/tools/OmeroWeb

    pytest test/integration/test_annotate.py

.. program:: pytest

.. option:: -k <string>

    This option will run all integration tests containing the given string in
    their names. For example, to run all the tests under
    :file:`test/integration` with `permissions` in their names::

        pytest test/integration -k permissions

    This option can also be used to run a named test within a test module::

        pytest test/integration/test_admin.py -k testGetGroup

.. option:: -m <marker>

    This option will run integration tests depending on the markers they are
    decorated with. Available markers can be listed using the
    :option:`pytest --markers` option.
    For example, to run all integration tests excluding those decorated with
    the marker `broken`::

        pytest test/integration -m "not broken"

.. option:: --markers

    This option lists available markers for decorating tests::

        pytest --markers

.. option:: -s

    This option allows the standard output to be shown on the console::

        pytest test/integration/test_admin.py -s

.. option:: -h, --help

    This option displays the full list of available options::

        pytest -h

See `<https://pytest.org/en/latest/usage.html>`_ for more help in
running tests.

Failing tests
^^^^^^^^^^^^^

The ``test.with.fail`` ant property is set to ``false`` by default,
which prevents test failures from failing the build. However, it can instead
be set to ``true`` to allow test failures to fail the build. For example:

::

    ./build.py -Dtest.with.fail=true integration

Some components might provide individual targets for specific tests (e.g.
OmeroJava provides the ``broken`` target for running broken tests).
The :file:`build.xml` file is the reference in each component.

Writing tests
-------------

Writing Java tests
^^^^^^^^^^^^^^^^^^

For more information on writing tests in general see `<https://testng.org/>`_.
For a test to be an "integration" test, place it in the "integration"
TestNG group. If a test is temporarily broken, add it to the "broken" group:

::

    @Test(groups = {"integration", "broken"}
    public void testMyStuff() {

    }

Tests should be of the **Acceptance Test** form. The ticket number
for which a test is being written should be added in the TestNG annotation:

::

    @Test(groups = "ticket:60")

This works at either the method level (see :model_source:`SetsAndLinksTest.java
<src/test/java/ome/model/utests/SetsAndLinksTest.java>`)
or the class level (see :server_source:`UniqueResultTest.java
<src/test/java/ome/server/itests/query/UniqueResultTest.java>`).

The tests under :sourcedir:`components/tools/OmeroJava/test` will be the
starting point for most Java-client developers coming to OMERO. An example
skeleton for an integration test looks similar to

::

    @Test(groups = "integration")
    public class MyTest {

      omero.client client;

      @BeforeClass
      protected void setup() throws Exception {
        client = new omero.client();
        client.createSession();
      }

      @AfterClass
      protected void tearDown() throws Exception {
        client.closeSession();
      }

      @Test
      public void testSimple() throws Exception {
        client.getSession().getAdminService().getEventContext();
      }

    }


.. _writing-python-tests:

Writing Python tests
^^^^^^^^^^^^^^^^^^^^

To write and run Python tests you first need to install `pytest`:

::

    pip install pytest

For more information on writing tests in general see `<https://pytest.org/>`_.

Unit tests can be found in various repositories such as
:py_sourcedir:`omero-py <test/unit>`,
:web_sourcedir:`omero-web <test/unit>`, and
:dropbox_sourcedir:`omero-dropbox <test/unit>`.

Integration tests which require OMERO.server to run are found in the
``openmicroscopy`` repository. See:
:sourcedir:`components/tools/OmeroPy/test`,
:sourcedir:`components/tools/OmeroWeb/test` and
:sourcedir:`components/tools/OmeroFS/test`.

The file names must begin with `test_` for the tests to be found by `pytest`.

::

    import omero.clients

    class TestExample(object)

      def setup_method(self, method):
        client = new omero.client()
        client.createSession()

      def teardown_method(self, method):
        client.closeSession()

      def testSimple():
        ec = client.getSession().getAdminService().getEventContext()
        assert ec, "No EventContext!"

.. _marking-python-tests:

Marking OmeroPy tests
"""""""""""""""""""""

Methods, classes and functions can be decorated with `pytest` markers to allow
for the selection of tests. `pytest` provides some predefined markers and
markers can be simply defined as they are used. However, to centralize the use
of custom markers they should be defined in
:sourcedir:`components/tools/pytest.ini`.

To view all available markers the :option:`pytest --markers` option can
be used with :program:`pytest` or :program:`py.test` as detailed in
:ref:`running-python-tests-directly`.

There is one custom marker defined:

.. glossary::

    `broken`
        Used to mark broken tests. These are tests that fail consistently with no
        obvious quick fix. Broken tests are excluded from the main integration builds
        and instead are run in a separate daily build. `broken` markers should have a
        reason, an associated Trac ticket number or both. If there are multiple
        associated tickets then a comma-separated list should be used.

::

  import pytest

  class TestExample2(object):

      @pytest.mark.broken(reason="Asserting false", ticket="12345,67890")
      def testBroken():
          assert False, "Bound to fail"

Using the Python test library
"""""""""""""""""""""""""""""

The `OMERO Python test library <https://github.com/ome/omero-py/blob/master/src/omero/testlib/__init__.py>`_
defines an abstract ``ITest`` class that implements the connection set up as
well as many methods shared amongst all Python integration tests.

Each concrete instance of the ``ITest`` will initiate a connection to the
server specified by the :envvar:`ICE_CONFIG` environment variable at the
``setup_class()`` level. The following objects are created by
``ITest.setup_class()`` and shared by all test methods of this class:

- ``self.root`` is a client for the root user
- ``self.group`` is a new group which permissions are set to
  ``ITest.DEFAULT_PERMS`` by default. Overriding ``DEFAULTS_PERMS`` in a
  subclass of ``ITest`` means the group will be created with the new
  permissions.
- ``self.user`` is a new user and member of ``self.group``
- ``self.client`` is a client for the ``self.user`` created at class setup.

Additionally, for the ``self.client`` object, different shortcuts are available:

- ``self.sf`` is the non-root client session
- ``self.update`` is the update service for the non-root client session
- ``self.query`` is the query service for the  non-root client session
- ``self.ctx`` is the event context for the non-root client session. Note this
  corresponds to the context at creation time and should be refreshed if the
  context is modified.

The example below inherits the ``ITest`` class and would create a read-write
group by default ::

  from omero.testlib import ITest

  class TestExample(ITest):

      DEFAULT_PERMS = 'rwrw--'  # Override default permissions
      def test1():
          doAction(self.sf)

New user and groups can be instantiated by individual tests using the
``ITest.new_user()`` and ``ITest.new_group()`` methods::

      def testNewGroupOwner():
          new_group = self.new_group(perms='rwa---')
          new_owner = self.new_use(group=new_group, owner=True)
          assert new_owner.id.val, "No EventContext!"

New clients can be instantiated by individual tests using the
``ITest.new_client()`` or ``ITest.new_client_and_user()`` methods::

      def testNewClient():
          new_client = self.new_user_and_client()
          ec = new_client.getSession().getAdminService().getEventContext()
          assert ec, "No EventContext!"

Images can be imported using the ``ITest.import_fake_file()`` method::

      def testFileset():
          # 2 images sharing a fileset
          images = self.import_fake_file(2)
          assert len(images) == 2

Writing OMERO.web tests
"""""""""""""""""""""""

For OMERO.web integration tests, the `OMERO.web test library <https://github.com/ome/omero-web/blob/master/omeroweb/testlib/__init__.py>`_
defines an abstract ``IWebTest`` class that inherits from ``ITest`` and
also implements Django clients at the class setup using the
:djangodoc:`Django testing tools <topics/testing/tools>`.

On top of the elements created by ``ITest.setup_class()``, the ``IWebTest``
class creates:

- ``self.django_root_client`` is a Django test client for the root user
- ``self.django_client`` is a client for the new user created at the class
  setup.

::

  from omeroweb.testlib import IWebTest

  class TestExample(IWebTest):
      def testSimple():
          self.django_client.post('/login/', {'username': 'john'})

New Django test clients can be instantiated by individual tests using the
``IWebTest.new_django_client()`` method::

      def testNewDjangoClient():
          new_user = self.new_user()
          omeName = new_user.omeName.val
          new_django_client = self.new_django_client(omeName, omeName)

.. seealso::
    :source:`test_simple.py <components/tools/OmeroWeb/test/integration/test_simple.py>`
        Example test class using the OMERO.web test library methods

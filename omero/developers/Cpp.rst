OMERO C++ language bindings
===========================

Using the :zerocdoc:`Ice C++ language mapping
<display/Ice/Hello+World+Application>` from ZeroC_, OMERO provides
native access to your data from C++ code. `CMake
<https://www.cmake.org/>`_ is used for building the C++ bindings.

**Binaries are not provided**, therefore it will be necessary for you
to compile your own.

Prerequisites
-------------

* The OMERO source code
* A C++ compiler

  * GCC is recommended for Linux and MacOS X
  * :program:`Visual Studio` or the :program:`Platform SDK` for Windows

* The ZeroC :program:`Ice` libraries, headers and slice definitions
* :program:`cmake`
* Google Test (optional; needed to build the unit and integration tests)

.. note::

    Users of :program:`Visual Studio` with :program:`Ice` 3.6 will
    encounter this error while building OmeroCpp: ``LINK : fatal error
    LNK1189: library limit of 65535 objects exceeded`` and will be
    unable to build |OmeroCpp| for Windows as a result of a 16-bit
    limitation in the Windows PE-COFF executable format used for DLLs,
    even on 64-bit systems.  Workarounds include:

    - using :program:`Ice` 3.5 (requires building :program:`Ice`
      against Python 2.7 with the same version of :program:`Visual
      Studio`)

    - it is hoped that :program:`Ice` 3.7 (when released) will resolve
      the problem since it generates far fewer symbols than 3.6

Restrictions
------------

If you are restricted to a specific version of GCC or Ice, you may
need to obtain or build a compatible version of Ice or GCC,
respectively.

Preparing to build
-------------------

Begin by following the instructions under :doc:`/developers/installation` to
acquire the source code. Be **sure** that the git branch you are using
matches the version of your server!

The location of your Ice installation should be automatically detected
if installed into a standard location. If this is not the case, set
the location of your Ice installation using the :envvar:`ICE\_HOME`
environment variable or the :option:`cmake -DIce\_HOME` or
:option:`cmake -DIce_SLICE_DIR` :program:`cmake` options for your Ice
installation (see below). Some possible locations for the |iceversion|
version of Ice follow. Note these are just examples; you need to
adjust them for the Ice installation path and version in use on your
system.

* Ice built from source and installed into :file:`/opt`:

  .. parsed-literal::

      export ICE_HOME=/opt/Ice-|iceversion|

* Ice installed on Linux using RPM packages:

  .. parsed-literal::

      export ICE_HOME=/usr/share/Ice-|iceversion|

* MacOS X with homebrew:

  .. parsed-literal::

      export ICE_HOME=/usr/local/Cellar/ice/|iceversion|

* Windows using :program:`Visual Studio`:

  .. parsed-literal::

       set ICE_HOME=C:\\Program Files (x86)\\ZeroC\\Ice-|iceversion|

.. note ::

    If the Ice headers and libraries are not automatically discovered,
    these will need to be specified using appropriate :program:`cmake`
    options (see below).

Building the library
--------------------

The shared library and examples are always built by default. The unit
and integration tests are built if Google test (gtest) is detected.

On Linux, Unix or MacOS X with :program:`make`::

    export GTEST_ROOT=/path/to/gtest
    mkdir omero-build
    cd omero-build
    cmake [-Dtest=(TRUE|FALSE)] [cmake options] /path/to/openmicroscopy
    make

For example::

    cmake "-DCMAKE_CXX_FLAGS=$CMAKE_CXX_FLAGS" \
    "-DCMAKE_EXE_LINKER_FLAGS=$CMAKE_LD_FLAGS" \
    "-DCMAKE_MODULE_LINKER_FLAGS=$CMAKE_LD_FLAGS" \
    "-DCMAKE_SHARED_LINKER_FLAGS=$CMAKE_LD_FLAGS" \
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON /path/to/openmicroscopy
    make -j8

If you would like to build the C++ tests, run the above with the
:envvar:`GTEST_ROOT` environment variable set.

.. note::

    When :program:`cmake` is run, it will run ``./build.py
    build-default`` in the openmicroscopy source tree to generate some
    of the C++ and Ice sources. If you have previously done a build by
    running ``./build.py``, this step will be skipped. However, if you
    have recently switched branches *without cleaning the source
    tree*, please run ``./build.py clean`` in the source tree to clean
    up all the generated files prior to running :program:`cmake`.

If the build fails with errors such as ::

         /usr/include/Ice/ProxyHandle.h:176:13: error: ‘upCast’ was not declared in this scope,
         and no declarations were found by argument-dependent lookup at the point of
         instantiation

this is caused by the Ice headers being buggy, and newer versions of
GCC rejecting the invalid code. To compile in this situation, add
``-fpermissive`` to :envvar:`CXXFLAGS` to allow the invalid code to be
accepted, but do note that this may also mask other problems so should
not be used unless strictly needed.

:program:`cmake` build configuration
------------------------------------

:program:`cmake` supports configuration of the build using many
different environment variables and options; for a full list, see the
`cmake reference documentation
<https://www.cmake.org/cmake/help/documentation.html>`_. The following
environment variables are commonly needed:

:envvar:`CMAKE_INCLUDE_PATH`
    Directories to be searched for include files, for example

    .. parsed-literal::

        /opt/Ice-|iceversion|/include

    A ``:`` or ``;`` separator character is used to separate
    directories, depending on the platform. Note these are used only
    for feature tests, not for passing to the compiler when building,
    for which ``CMAKE_CXX_FLAGS`` is needed.


:envvar:`CMAKE_LIBRARY_PATH`
    Directories to be searched for libraries, for example

    .. parsed-literal::

        /opt/Ice-|iceversion|/lib

    Directories are separated by ``:`` or ``;`` as with
    :envvar:`CMAKE_INCLUDE_PATH`. Note these are used only for feature
    tests and finding libraries, not for passing to the linker when
    building, for which ``CMAKE_*_LINKER_FLAGS`` is needed.

:envvar:`CXX`
    C++ compiler executable. Useful with `ccache
    <https://ccache.samba.org/>`_.

:envvar:`CXXFLAGS`
    C++ compiler flags. Use of ``CMAKE_CXX_FLAGS`` is preferred.

:envvar:`ICE\_HOME`
    The location of the Ice installation. If this is not sufficient to
    discover the correct binary and library directories, they may
    otherwise be manually specified with the options below. Likewise
    for the :file:`include` and :file:`slice` directories. This may
    also be set as a :program:`cmake` cache variable (see below).

:envvar:`VERBOSE`
    If set to `1`, show the actual build commands rather than the
    pretty "Compiling XYZ..." statements.

In addition, :program:`cmake` options may be defined directly when
running :program:`cmake`. Commonly needed options include:

.. program:: cmake

.. option:: -DCMAKE_PREFIX_PATH

    Search this location when searching for programs, headers and
    libraries.  Use to search :file:`/usr/local` or :file:`/opt/Ice`,
    for example.  More specific search locations may be specified
    using :option:`cmake -DCMAKE_INCLUDE_PATH`, :option:`cmake -DCMAKE_LIBRARY_PATH`
    and :option:`cmake -DCMAKE_PROGRAM_PATH` separately, if required.

.. option:: -DCMAKE_INCLUDE_PATH

    Search this location when searching for headers.  Use to include
    :file:`/usr/local/include` or :file:`/opt/Ice/include`, for
    example.

.. option:: -DCMAKE_LIBRARY_PATH

    Search this location when searching for libraries.  Use to include
    :file:`/usr/local/lib` or :file:`/opt/Ice/lib`, for example.

.. option:: -DCMAKE_PROGRAM_PATH

    Search this location when searching for programs.  Use to include
    :file:`/usr/local/bin` or :file:`/opt/Ice/bin`, for example.

.. option:: -DCMAKE_CXX_FLAGS

    C++ compiler flags. Use to set any additional linker flags
    desired.

.. option:: -DCMAKE_EXE_LINKER_FLAGS

    Executable linker flags. Use to set any additional linker flags
    desired.

.. option:: -DCMAKE_MODULE_LINKER_FLAGS

    Loadable module linker flags. Use to set any additional linker
    flags desired.

.. option:: -DCMAKE_SHARED_LINKER_FLAGS

    Shared library linker flags. Use to set any additional linker
    flags desired.

.. option:: -DCMAKE_VERBOSE_MAKEFILE

    Default to printing all commands executed by make. This may be
    overridden with the make ``VERBOSE`` variable.

.. option:: -DIce\_HOME

    The location of the Ice installation. If this is not sufficient to
    discover the correct binary and library directories, they may
    otherwise be manually specified with the options below. Likewise
    for the :file:`include` and :file:`slice` directories.

.. option:: -DIce_SLICE2XXX_EXECUTABLE

    Specific location of individual Ice ``slice2xxx`` programs, e.g.
    ``Ice_SLICE2CPP_EXECUTABLE`` for :program:`slice2cpp` or
    ``Ice_SLICE2JAVA_EXECUTABLE`` for :program:`slice2java`. These are
    typically found in ``${ICE_HOME}/bin`` or on the default
    :envvar:`PATH`.  These will not normally require setting.

.. option:: -DIce_INCLUDE_DIR

    Location of Ice headers. This is typically ``${ICE_HOME}/include``
    or on the default include search path.  This will not normally
    require setting.

.. option:: -DIce_SLICE_DIR

    Location of Ice slice interface definitions. This is typically
    ``${ICE_HOME}/slice``. Use for installations where
    :option:`cmake -DIce\_HOME` does not contain :file:`slice` or situations
    where you wish to build without setting :option:`cmake -DIce\_HOME`. Note
    that when building using :program:`build.py`, rather than building
    directly with :program:`cmake`, the :envvar:`SLICEPATH`
    environment variable should be used instead (the :program:`ant`
    build can't use the :program:`cmake` variables since it only runs
    :program:`cmake` after a full build of the Java server).

.. option:: -DIce_<C>_LIBRARIES

    Specific libraries for Ice component ``<C>``, where ``<C>`` is the
    uppercased name of the Ice component, e.g. ``ICE`` for the ``Ice``
    component, ``ICEUTIL`` for the ``IceUtil`` component or
    ``GLACIER2`` for the ``Glacier2`` component. These libraries are
    typically found in ``${ICE_HOME}/lib`` or on the default library
    search path. These will not normally require setting.

.. option:: -DIce_DEBUG

    Set to ON to print detailed diagnostics about the detected Ice
    installation. Use if there are any problems finding Ice.

:program:`cmake` offers many additional options.  Please refer to the
`documentation <https://www.cmake.org/cmake/help/v3.0/>`_ for further
details, in particular to the `variables which change the behavior
<https://www.cmake.org/cmake/help/v3.0/manual/cmake-variables.7.html#variables-that-change-behavior>`_
of the build.

:program:`Visual Studio` configuration
--------------------------------------

.. warning::

    OMERO.cpp will not currently build on Windows due to exceeding DLL
    symbol limits on this platform, leading to a failure when linking
    the DLL. It is hoped that this platform limitation can be worked
    around in a future OMERO release.

:program:`cmake` has full support for :program:`Visual Studio`. Use
the :program:`cmake` ``-G`` option to set the generator for your
Visual Studio version, with a ``Win64`` suffix for an x64 build. The
correct Ice programs and libraries for your Ice installation should be
automatically discovered.

::

    cmake -G "Visual Studio 11 Win64" [cmake options] /path/to/openmicroscopy

This is for a 64-bit :program:`Visual Studio 2012` build. Modify appropriately
for other versions and compilers. Running

::

    cmake --help

will list the available generators for your platform (without the
``Win64`` suffix).

Once :program:`cmake` has finished running, the generated project and
solution files may be then opened in :program:`Visual Studio`, or
built directly using the :program:`msbuild` command-line tool (make
sure that the :program:`Visual Studio` command prompt matches the
generator chosen) or by running::

    cmake --build .

As for the Unix build, above, it is also possible to build on Windows
using :program:`build.py` or :program:`ant`, providing that you
configure the generator appropriately using the correct
:program:`cmake` options. However, this will not work for all
generators reliably, and the Windows shell quoting makes passing
nested quotes to ant quite tricky, so running :program:`cmake` by hand
is recommended.

.. note::

    It may be necessary to specify ``/Zm1000`` as an additional
    compiler setting.

Installing the library
----------------------

If using :program:`make`, run:

::

    make [DESTDIR=/path/to/staging/directory] install

If using another build system, please invoke the equivalent install
target for that system.

Using the library
-----------------

To use |OmeroCpp| it is necessary to point your compiler and linker at
the mentioned directories above. A simple GNU :program:`make`
:file:`Makefile` might look like this:

.. literalinclude:: ../examples/omerocpp/Makefile
   :language: make
   :linenos:

A trivial example: :file:`yourcode.cpp`
---------------------------------------

A simple example might look something like the following:

.. literalinclude:: ../examples/omerocpp/yourcode.cpp
   :language: c++
   :linenos:

This code does not do much. It creates a server session, loads a few
services, and prints the user's name. For serious examples, see
|OmeroClients|.

Compiling and running your code
-------------------------------

To compile and run :program:`yourcode`, download the two files above
(:file:`Makefile` and :file:`yourcode.cpp`) and then in a shell:

::

    make OMERO_DIST=dist yourcode
    LD_LIBRARY_PATH=dist/lib ./yourcode --Ice.Config=dist/etc/ice.config

where you have edited :file:`dist/etc/ice.config` to contain the
values:

::

    omero.host=localhost
    omero.user=your_name
    omero.pass=your_password

Alternatively, you can pass these on the command-line:

::

    LD_LIBRARY_PATH=dist/lib ./yourcode omero.host=localhost --omero.user=foo --omero.pass=bar

.. note::

    This example explains how to run on Linux only. For doing the
    same on MacOS X, change all instances of
    :envvar:`LD\_LIBRARY\_PATH` to :envvar:`DYLD\_LIBRARY\_PATH`.

Further information
-------------------

For the details behind writing, configuring, and executing a client, please
see |OmeroClients|.

.. seealso::

    Ice_, |OmeroGrid|, |OmeroApi|, :doc:`/developers/build-system`,
    :ticket:`1596` which added 64-bit support

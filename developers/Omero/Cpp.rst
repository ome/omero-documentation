.. _developers/Omero/Cpp:

OMERO C++ Language Bindings
===========================

.. contents::

Using the ` Ice C++ language
mapping <http://zeroc.com/doc/Ice-3.3.0/manual/Hello.4.3.html>`_ from
` http://zeroc.com <http://zeroc.com>`_, OMERO provides native access to
your data from C++ code. The "build-cpp" build target produces a
platform-dependent shared library which can be linked to your
application.

As of milestone:Beta4.1, **binaries are not provided** and so it will be
necessary to compile your own. Test versions are, however, built on a
small handful of platforms:

-  Windows Server 2003 (32 bit):
   ` http://hudson.openmicroscopy.org.uk/job/OMERO-trunk-components/component=cpp,label=x86-windows/ <http://hudson.openmicroscopy.org.uk/job/OMERO-trunk-components/component=cpp,label=x86-windows/>`_
-  Linux:
   ` http://hudson.openmicroscopy.org.uk/job/OMERO-trunk-components/component=cpp,label=linux/ <http://hudson.openmicroscopy.org.uk/job/OMERO-trunk-components/component=cpp,label=linux/>`_
-  MacOSX:
   ` http://hudson.openmicroscopy.org.uk/job/OMERO-trunk-components/component=cpp,label=macosx/ <http://hudson.openmicroscopy.org.uk/job/OMERO-trunk-components/component=cpp,label=macosx/>`_

Prepairing to build
-------------------

Begin by following the instructions under
`OmeroContributing </ome/wiki/OmeroContributing>`_ on acquiring the
source code. Be **sure** that the git branch you are using matches the
version of your server!

If you did not install Ice via a package manager like APT on
Debian/Ubuntu?, RPM on Centos/RHEL or Macports on Mac OS X, you will
need to manually set the ICE\_HOME environment variable for your
installation:

::

    export ICE_HOME=/opt/Ice-3.3

or on Windows either

::

    set ICE_HOME=c:\Ice-3.3.1

for Visual Studio 2005, or

::

    set ICE_HOME=c:\Ice-3.3.1-VC90

for Visual Studio 2008.

Additionally on Windows, you will need to run the Visual Studio
environment setup scripts:

::

    C:\Documents and Settings\USER>c:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat
    Setting environment for using Microsoft Visual Studio 2008 x86 tools.

or otherwise guarantee that the your environment is properly configured.
For the 64bit build, be sure to use the right setup, namely
"Start->Microsoft Visual Studio 2008->Visual Studio Tools->Visual Studio
2008 Command Prompt" or "...->Visual Studio 2008 x64 Win64 Command
Prompt".

Building the library
--------------------

Then, to build the C++ dynamic library:

::

    cd omero
    ./build.py
    ./build.py build-cpp

or

::

    ./build.py build-all

If you would like to build the C++ tests, you will need to install
` boost\_unit\_test-mt <http://www.boost.org/doc/libs/1_34_0/libs/test/doc/index.html>`_
and run:

::

    ./build.py test-compile-all
    ./build.py test-unit

or to test only C++:

::

    ./build.py -f components/tools/OmeroCpp/build.xml test

Information on installing Boost on Windows is available at
` http://www.boost.org/doc/libs/1\_39\_0/more/getting\_started/windows.html <http://www.boost.org/doc/libs/1_39_0/more/getting_started/windows.html>`_

**Note:** If you would like to work on just the C++ code without
worrying about the rest of the build, you can install ``scons`` and use
it directly. Alternatively, you can use the scons version which comes
with the OMERO source code:
``cd components/tools/OmeroCpp && python ../../../target/scons/scons.py test``.
This **does** require having run the top-level build (``build.py``) at
least once.

Further build configuration
---------------------------

As mentioned above, the C++ bindings use
` Scons <http://www.scons.org>`_ as a build system. Scons provides
several hooks into its operation.

The following environment variables as defined in
:source:`components/blitz/build_tools.py`
are considered:

-  ARCH - Either "x86" or "x64". "x64" will be used by default on a
   64bit machine, otherwise "x86"
-  CPPPATH - directories to be searched for include files
   (``-I/opt/Ice-3.3.0/includes``). (":" or ";" separator depending on
   platform)
-  CXXFLAGS - standard make-like CXXFLAGS variable
-  CXX - compiler executable. Useful with
   ` ccache <http://ccache.samba.org/>`_\ tform path separator ":" or
   ";" is used.
-  LIBPATH - directories to be searched for libraries
   (``-L/opt/Ice-3.3.0/lib``), separated by ":" or ";" as with CPPPATH.
-  ICE\_HOME - your Ice installation. ``lib`` and ``include`` will be
   added to your LIBPATH and CPPPATH
-  J - specifies to concurrently build tasks as with Make.
-  RELEASE - "debug" or "Os" (i.e. optimize for size). Debug is used by
   default.
-  VERBOSE - show the actual build commands rather than the pretty
   "Compiling XYZ..." statements.

Zip files containing the C++ header files, the libraries, and source
code are placed under OMERO\_HOME/target with other zip artifacts.

    If you are using make, you can unpack the main zip (e.g.
    ``OMERO.cpp-<version>-64dbg.zip``) to some directory
    (``OMERO_DIST``) and follow the instructions below get started. For
    help with other build systems, please contact the mailing list.

Using the library
-----------------

To use |OmeroCpp| it is necessary to point your compiler and linker at
the mentioned directories above. A simple `GNU make
<http://www.gnu.org/software/make/>`_ Makefile might look like this:

.. literalinclude:: ../../examples/omerocpp/Makefile
   :language: make
   :linenos:

A trivial example: ``yourcode.cpp``
-----------------------------------

And a simple example file might looking something like the following:

.. literalinclude:: ../../examples/omerocpp/yourcode.cpp
   :language: c++
   :linenos:

This code doesn't do much. It creates a server session, loads a few
services, and prints the user's name. For serious examples, see
|OmeroClients|.

Compiling and running ``yourcode``
----------------------------------

Therefore, to compile and run ``yourcode``, you'll need to download the
two files above (Makefile and yourcode.cpp) and then from the shell:

::

    make OMERO_DIST=dist yourcode
    LD_LIBRARY_PATH=dist/lib ./yourcode --Ice.Config=dist/etc/ice.config

where you've edited ``dist/etc/ice.config`` to contain the values:

::

    omero.host=localhost
    omero.user=your_name
    omero.pass=your_password

Alternatively, you can pass these on the command-line:

::

    LD_LIBRARY_PATH=dist/lib ./yourcode omero.host=localhost --omero.user=foo --omero.pass=bar

Notes for Mac users
-------------------

This example explains how to build on Linux only. For doing the same on
Mac OS X, change all instances of "LD\_LIBRARY\_PATH" to
"DYLD\_LIBRARY\_PATH".

Notes for Visual Studio users
-----------------------------

The SConstruct build file in |OmeroCpp| defines a
target "msproj" which can be used to generate an MS VS project and
solution. There is also a similarly named ant target:

::

    build -f components\tools\OmeroCpp\build.xml msproj

Also:

-  it may be necessary to specify "/Zm1000" as an additional compiler
   setting.

Further information
-------------------

For the details behind writing, configuring, and executing a client,
please see |OmeroClients|.

--------------

See also: ` http://zeroc.com <http://zeroc.com>`_,
`OmeroBlitz </ome/wiki/OmeroBlitz>`_, |OmeroGrid|, |OmeroApi|,
:ref:`developers/Omero/Build`, :ticket:`1596` which
added 64bit support

Attachments
~~~~~~~~~~~

-  `Makefile </ome/attachment/wiki/OmeroCpp/Makefile>`_
   `|image3| </ome/raw-attachment/wiki/OmeroCpp/Makefile>`_ (681 bytes)
   - added by *jmoore* `3
   years </ome/timeline?from=2009-08-31T18%3A44%3A14%2B01%3A00&precision=second>`_
   ago. Example Makefile
-  `yourcode.cpp </ome/attachment/wiki/OmeroCpp/yourcode.cpp>`_
   `|image4| </ome/raw-attachment/wiki/OmeroCpp/yourcode.cpp>`_ (877
   bytes) - added by *jmoore* `3
   years </ome/timeline?from=2009-08-31T18%3A44%3A33%2B01%3A00&precision=second>`_
   ago. Example source code

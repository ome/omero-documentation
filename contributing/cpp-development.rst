C++ components
==============

This document describes the conventions and process used by the OME team for
developing, maintaining and releasing its C++ components.

The set of rules and procedures described below applies to all the following
C++ libraries.

.. list-table::
    :header-rows: 1

    -   * Component name
        * GitHub URL
        * CMake project name

    -   * OME Common C++
        * https://github.com/ome/ome-common-cpp
        * `ome-common`

    -   * OME Data model
        * https://github.com/ome/ome-model
        * `ome-model`

    -   * OME Files C++
        * https://github.com/ome/ome-files-cpp
        * `ome-files-cpp`

    -   * OME Qt widgets
        * https://github.com/ome/ome-qtwidgets
        * `ome-qtwidgets`

    -   * OME CMake Superbuild
        * https://github.com/ome/ome-cmake-superbuild
        * `ome-cmake-superbuild`

    -   * OME Files Performance
        * https://github.com/openmicroscopy/ome-files-performance
        * `ome-files-performance`


Conventions
-----------

Source code and build system
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The source code of a C++ library should be maintained under version control
using Git_ and hosted on GitHub_.

CMake_ should be used as the primary build system. There is no standard CMake
directory layout. C++-only components like 
[ome-common-cpp](https://github.com/ome/ome-common-cpp) use a flattened
directory layout::

   cmake/
   CMakeLists.txt
   docs/
     sphinx/
     doxygen/
   lib/
   test/

Components containing both Java and C++ code like
[ome-model](https://github.com/ome/ome-model) organize the C++
sources according to the Maven recommended layout i.e.::

   src/main/cpp             Contains the C++ code
   src/main/java            Contains the Java code

Additionally, header files should be maintained alongside the source files.

Development
^^^^^^^^^^^

C++ components use `Semantic Versioning`_ i.e. given a version number
MAJOR.MINOR.PATCH, increment the:

- MAJOR version when you make incompatible API changes,
- MINOR version when you add functionality in a backwards-compatible manner,
  and
- PATCH version when you make backwards-compatible bug fixes.

Code contributions should follow the guidelines highlighted in :doc:`code-contributions`.

Distribution
^^^^^^^^^^^^

All the C++ sources and binaries are hosted on the OME downloads according to
the process described in the next section.

Release process
---------------

Maintainer prerequisites
^^^^^^^^^^^^^^^^^^^^^^^^

To be able to maintain a C++ component, a developer must:

- have a GitHub_ account and have push rights to the GitHub source code
  repository
- have a valid PGP key for signing the tags

Source release
^^^^^^^^^^^^^^

The first step of the C++ component release is to prepare a source release
from the Git_ repository.

A PGP-signed tag should be created for the released version e.g.
using :command:`scc tag-release` or more simply :command:`git tag -s`::

    $ scc tag-release -s x.y.z --prefix v

Push the master branch and the tag to your fork for validation by another
member of the team::

    $ git push <fork_name> master
    $ git push <fork_name> vx.y.z


Once the tag is created, a source release can be created by archiving the
repository::

    $ git archive -v --format=tar "--prefix=${project}-${version}/" -o "${dest}/${project}-${version}.tar" "${tag}"
    $ xz "{dest}/${project}-${version}.tar"
    $ git archive -v --format=zip "--prefix=${project}-${version}/" -o "${dest}/${project}-${version}.zip" "${tag}"

Next development version
^^^^^^^^^^^^^^^^^^^^^^^^

Once the release is accepted, the version number of `release-version` in :file:`CMakeLists.txt` should be incremented to the next patch number i.e. `x.y.z+1`.

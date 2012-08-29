.. _developers/Server/Grid/InstallMacOsx:

Installing OMERO Grid on Mac OS X
==================================

Ice
---

Two options are available for installing Ice on Mac OS X, both of which
require setting environment properties.

Binary download
~~~~~~~~~~~~~~~

You can download the Ice binaries for Mac at:
` http://www.zeroc.com/download/Ice/3.2/Ice-3.2.1-bin-macosx.tar.gz <http://www.zeroc.com/download/Ice/3.2/Ice-3.2.1-bin-macosx.tar.gz>`_

These can be unpacked anywhere on your system, but as outlined in the
README file, it's necessary to set several environment variables:

::

      export PYTHONPATH=$ICE_HOME/python
      export PATH=$ICE_HOME/bin:$PATH
      export LD_LIBRARY_PATH=$ICE_HOME/lib
      export DYLD_LIBRARY_PATH=$ICE_HOME/lib

An example of this is provided in :source:`docs/install/macosx10.4/env.sh`

Macports
~~~~~~~~

Installing via Macports is probably a good idea for developers. Follow
the instructions under
` http://www.macports.org <http://www.macports.org>`_ for installing the
Macports system. After that, use:

::

      sudo port install ice-cpp ice-java ice-python

to install Ice. While you are at it, you can also install Postgres via
Macports:

::

      sudo port install postgresql82 postgresql82-server

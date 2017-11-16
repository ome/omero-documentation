********************
Version requirements
********************

Summary of changes for OMERO 5.4 and provisional changes for 5.5
================================================================

Criteria for what is considered to be supportable includes whether
support by both upstream developers and operating system distributions
will be available for the lifetime of the 5.4 release (including
security support), and also upon our resources allocated to CI and
testing. If we are not actively testing it, we **cannot** claim it is
supported or functional. Software components must be provided and
supported either by an operating system distribution or their original
developers.

This section contains a summary of the changes made to the minimum
version requirements for the 5.4 release and also **possible** changes for
the following 5.5 release, albeit **tentatively at this point**. The
intent is to provide a roadmap in order that sysadmins may plan ahead
and ensure that prerequisites are in place ahead of time to ease
future upgrades. The following sections provide more detailed
information and the rationale for the changes.

Please check the meaning of the various :ref:`symbols <support-levels>` used
on this page. Any system/component with a green tick symbol is supported.

Operating systems
-----------------

* Microsoft Windows

  * From [5.3] client support only
  * Rationale: see `blog post explanation <http://blog.openmicroscopy.org/tech-issues/future-plans/deployment/2016/03/22/windows-support/>`_

* MacOS X

  * MacOS X is typically suited only to client use, not serious server
    deployment, although the server can be expected to build on versions with
    current security support for development purposes.

* Linux distribution CentOS/RHEL

  .. list-table::
     :header-rows: 1

     * - Distribution version
       - OMERO 5.3
       - OMERO 5.4
       - OMERO 5.5
     * - 6.x
       - |Deprecated|
       - |Deprecated|
       - |Dropped|
     * - 7.x
       - |Recommended|
       - |Recommended|
       - |Recommended|

* Linux distribution Ubuntu LTS

  .. list-table::
     :header-rows: 1

     * - Distribution version
       - OMERO 5.3
       - OMERO 5.4
       - OMERO 5.5
     * - 14.04
       - |Supported|
       - |Supported|
       - |Supported|
     * - 16.04
       - |Recommended|
       - |Recommended|
       - |Recommended|
       
  * Only LTS versions are supported and tested. Non-LTS versions
    following a supported LTS release are likely to work but are not
    officially supported or tested.
  * Rationale: No change in this timeframe.

Bitness
-------

Currently both client and server will work on 32- and 64-bit systems on all
platforms **with the exception of MacOS X (64-bit only)**.

.. list-table::
   :header-rows: 1

   * - Bitness
     - OMERO 5.3
     - OMERO 5.4
     - OMERO 5.5
   * - 32-bit
     - |Deprecated| for Ice and native code [client]
     - |Deprecated| for Ice and native code [client]
     - |Dropped| for Ice and native code [client]
   * - 64-bit
     - |Recommended|
     - |Recommended|
     - |Recommended|

Components
----------

* PostgreSQL

  .. list-table::
     :header-rows: 1

     * - PostgreSQL
       - OMERO 5.3
       - OMERO 5.4
       - OMERO 5.5
     * - 9.3
       - |Deprecated|
       - |Deprecated|
       - |Dropped|
     * - 9.4
       - |Supported|
       - |Supported|
       - |Deprecated|
     * - 9.5
       - |Supported|
       - |Supported|
       - |Supported|
     * - 9.6
       - |Recommended|
       - |Recommended|
       - |Recommended|

  * Rationale: Current releases available for all supported systems
    from upstream and for CentOS/RHEL 6.x officially via SCL (software
    collections).

* Python

  .. list-table::
       :header-rows: 1

       * - Python
         - OMERO.web 5.3
         - OMERO.server 5.3
         - OMERO.web 5.4
         - OMERO.server 5.4
         - OMERO 5.5
       * - 2.6
         - |Broken|
         - |Supported|
         - |Broken|
         - |Supported|
         - |Dropped|
       * - 2.7
         - |Recommended|
         - |Recommended|
         - |Recommended|
         - |Recommended|
         - |Recommended|
       * - 3.x
         - |Broken|
         - |Broken|
         - |Broken|
         - |Broken|
         - |Broken|

  * Rationale: 2.7 is provided by all systems except for CentOS/RHEL
    6.x, however it is available officially via SCL. Note that 3.3 is
    also available via SCL, so there is potential for a 3.x migration
    in the 5.4 timeframe. OMERO.web **no longer** works with Python 2.6,
    the OMERO.server can still be used with Python 2.6.

* Ice

  .. list-table::
       :header-rows: 1

       * - Ice
         - OMERO 5.3
         - OMERO 5.4
         - OMERO 5.5
       * - 3.5
         - |Deprecated|
         - |Deprecated|
         - |Dropped|
       * - 3.6
         - |Recommended|
         - |Recommended|
         - |Supported|
       * - 3.7
         - |Upcoming|
         - |Upcoming|
         - |Recommended|

* Java

  .. list-table::
       :header-rows: 1

       * - Java
         - OMERO 5.3
         - OMERO 5.4
         - OMERO 5.5
       * - 7
         - |Deprecated|
         - |Deprecated|
         - |Deprecated|
       * - 8
         - |Recommended|
         - |Recommended|
         - |Supported|
       * - 9
         - |Upcoming|
         - |Upcoming|
         - |Recommended|

  * Rationale: For 5.3 and 5.4 deprecate 7; this is because security support ended in April 2015.
    Currently, Matlab is shipped with Java 7 so it cannot be marked as dropped yet.

* nginx

  .. list-table::
       :header-rows: 1

       * - nginx
         - OMERO 5.3
         - OMERO 5.4
         - OMERO 5.5
       * - 1.6
         - |Deprecated|
         - |Dropped|
         - |Dropped|
       * - 1.8
         - |Supported|
         - |Deprecated|
         - |Dropped|
       * - 1.10
         - |Recommended|
         - |Recommended|
         - |Supported|
       * - 1.12
         - |Upcoming|
         - |Upcoming|
         - |Recommended|

.. _support-levels:

Support levels
==============

The following table defines the symbols used throughout this page to
describe the support status of a given component, as it progresses
from being new and not supported, to supported and tested on a
routine basis, and to finally being old and no longer supported
nor tested.

.. list-table::
    :header-rows: 1

    * - Level
      - Meaning
      - Description
    * - |Upcoming|
      - unsupported/new
      - New version not yet regularly tested and not officially supported; may or may not work (use at own risk)
    * - |Supported|
      - supported/suboptimal
      - Version which is tested, confirmed to work correctly, but may not offer optimal performance/experience
    * - |Recommended|
      - supported/optimal
      - Version which is regularly tested, confirmed to work correctly, recommended for optimal performance/experience
    * - |Deprecated|
      - supported/deprecated
      - Version which is less tested, expected to work correctly, but may not offer optimal performance/experience; official support may be dropped in the next major OMERO release
    * - |Dropped|
      - unsupported/old
      - Old version no longer tested and no longer officially supported; may or may not work (use at own risk)
    * - |Broken|
      - unsupported/broken
      - Known to not work
    * - |Unsupported|
      - unsupported/misc
      - Not supported for some reason other than the above

Operating system support
========================

The following subsections detail the versions of each operating system
which are supported by both its upstream developers (for security and
general updates) and by OME for OMERO building and server deployment.

UNIX (FreeBSD)
--------------

It only really makes sense to support the base toolchain for major
releases and the Ports tree (which is continually updated); these will
be covered in the dependencies, below.

Linux (CentOS and RHEL)
-----------------------

General overview for `RHEL
<https://access.redhat.com/site/articles/3078>`__ and `CentOS
<http://wiki.centos.org/FAQ/General#head-fe8a0be91ee3e7dea812e8694491e1dde5b75e6d>`__

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Upstream support
      - OMERO 5.3
      - OMERO 5.4
      - OMERO 5.5
      - Details
    * - 6
      - from Nov 2010
      - to Nov 2020
      - |Deprecated|
      - |Deprecated|
      - |Dropped|
      - `Reference <http://wiki.centos.org/FAQ/General#head-fe8a0be91ee3e7dea812e8694491e1dde5b75e6d>`__
    * - 7
      - from June 2014
      - to June 2024
      - |Recommended|
      - |Recommended|
      - |Recommended|
      - `Reference <http://wiki.centos.org/FAQ/General#head-fe8a0be91ee3e7dea812e8694491e1dde5b75e6d>`__

RHEL, CentOS 6 and 7 are supported at present. Given the long life
of enterprise releases, we intend to support only the latest release
at any given time or else it ties us into very old dependencies; 6.x
is already quite long in the tooth, however is in wide use and so will
require supporting at least 5.4.0.

Linux (Ubuntu)
--------------

`General overview <https://wiki.ubuntu.com/Releases>`__

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Upstream support
      - OMERO 5.3
      - OMERO 5.4
      - OMERO 5.5
    * - 14.04 LTS
      - from Apr 2014
      - to Apr 2019
      - |Supported|
      - |Supported|
      - |Supported|
    * - 16.04 LTS
      - from Apr 2016
      - to Apr 2021
      - |Recommended|
      - |Recommended|
      - |Recommended|

Only the LTS releases are supported due to resource limitations upon
CI and testing. Only the last two LTS releases are supported (being a
bit more frequent than CentOS/RHEL). There is currently no CI testing
for any version, but some developer use of 14.04 LTS, 16.04 LTS and
more recent non-LTS releases.


Dependencies
============

The following subsections detail the versions of each dependency
needed by OMERO which are supported by both its upstream developers
(for security and general updates) and by OME for OMERO building and
server and client deployment.

.. note::
    Versions in brackets are in development distributions and may
    change without notice.

Package lists
-------------

.. list-table::
    :header-rows: 1

    * - Operating system
      - Details
    * - CentOS 6 / RHEL 6
      - `Reference <http://mirror.centos.org/centos/6/os/x86_64/Packages/>`__
    * - CentOS 7 / RHEL 7
      - `Reference <http://mirror.centos.org/centos/7/os/x86_64/Packages/>`__
    * - Ubuntu
      - `Reference <http://packages.ubuntu.com/search?keywords=foo&searchon=names&suite=all&section=all>`__
    * - Homebrew
      - `Reference <https://github.com/Homebrew/homebrew-core/tree/master/Formula>`__
    * - FreeBSD Ports
      - `Reference <http://svnweb.freebsd.org/ports/head/>`__


PostgreSQL
----------

`General overview <http://www.postgresql.org/support/versioning/>`__

OMERO support policies
^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Upstream support
      - OMERO 5.3
      - OMERO 5.4
      - OMERO 5.5
    * - 9.3
      - from Sep 2013
      - to Sep 2018
      - |Deprecated|
      - |Deprecated|
      - |Dropped|
    * - 9.4
      - from Dec 2014
      - to Dec 2019
      - |Supported|
      - |Supported|
      - |Deprecated|
    * - 9.5
      - from Jan 2016
      - to Jan 2021
      - |Supported|
      - |Supported|
      - |Supported|
    * - 9.6
      - from Sep 2016
      - to Sep 2021
      - |Recommended|
      - |Recommended|
      - |Recommended|
    * - Details
      - 
      - `Reference <http://www.postgresql.org/support/versioning/>`__
      - 
      - 
      - 

Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If no version is provided, a suitable repository is indicated.

.. list-table::
    :header-rows: 1

    * - Version
      - CentOS/RHEL
      - Ubuntu
      - Homebrew
      - FreeBSD Ports
    * - 9.3
      - N/A
      - 14.04
      - N/A
      - Yes
    * - 9.4
      - 6 (`postgresql <http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/>`__), 7 (`postgresql <https://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/>`__)
      - 14.04, 16.04 (`postgresql <https://apt.postgresql.org/pub/repos/apt/>`__)
      - Yes
      - Yes
    * - 9.5
      - 6 (`postgresql <http://yum.postgresql.org/9.5/redhat/rhel-6-x86_64/>`__), 7 (`postgresql <https://yum.postgresql.org/9.5/redhat/rhel-7-x86_64/>`__)
      - 14.04 (`postgresql <https://apt.postgresql.org/pub/repos/apt/>`__), 16.04
      - Yes
      - Yes
    * - 9.6
      - 6 (`postgresql <http://yum.postgresql.org/9.6/redhat/rhel-6-x86_64/>`__), 7 (`postgresql <https://yum.postgresql.org/9.6/redhat/rhel-7-x86_64/>`__)
      - 14.04, 16.04 (`postgresql <https://apt.postgresql.org/pub/repos/apt/>`__)
      - Yes
      - Yes
    * - Details
      - 
      - `Reference <http://packages.ubuntu.com/search?keywords=postgresql&searchon=names&suite=all&section=all>`__
      - 
      - 

The PostgreSQL project provides `packages
<http://www.postgresql.org/download/>`__ for supported platforms.
Therefore distribution support is not critical since 9.4, 9.5 and 9.6 are
available for all platforms.

.. _python-requirements:

Python
------

OMERO support policies
^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Upstream support
      - OMERO 5.3
      - OMERO 5.4
      - OMERO 5.5
      - Details
    * - 2.6
      - from Oct 2008
      - to Oct 2013
      - |Dropped| [1]_ 
        |Supported| [2]_ 
      - |Dropped| [1]_ 
        |Supported| [2]_ 
      - |Dropped|
      - `PEP 361 <https://www.python.org/dev/peps/pep-0361/>`__
    * - 2.7
      - from Jul 2010
      - to 2020
      - |Recommended|
      - |Recommended|
      - |Recommended|
      - `PEP 373 <https://www.python.org/dev/peps/pep-0373/>`__
    * - 3.2
      - from Feb 2011
      - to Feb 2016
      - |Broken|
      - |Broken|
      - |Broken|
      - `PEP 392 <https://www.python.org/dev/peps/pep-0392/>`__
    * - 3.3
      - from Sep 2012
      - to Sep 2017
      - |Broken|
      - |Broken|
      - |Broken|
      - `PEP 398 <https://www.python.org/dev/peps/pep-0398/>`__
    * - 3.4
      - from Mar 2014
      - TBA
      - |Broken|
      - |Broken|
      - |Broken|
      - `PEP 429 <https://www.python.org/dev/peps/pep-0429/>`__
    * - 3.5
      - from Sept 2015
      - TBA
      - |Broken|
      - |Broken|
      - |Broken|
      - `PEP 478 <https://www.python.org/dev/peps/pep-0478/>`__
    * - 3.6
      - from Dec 2016
      - TBA
      - |Broken|
      - |Broken|
      - |Broken|
      - `PEP 494 <https://www.python.org/dev/peps/pep-0494/>`__

.. [1] For OMERO.web, Python 2.7 is the minimum supported version.
.. [2] For OMERO.py and OMERO.server, Python 2.6 is the minimum supported version.


Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1

    * - Version
      - CentOS/RHEL
      - Ubuntu
      - Homebrew
      - FreeBSD Ports
    * - 2.6
      - 6
      - 10.04
      - N/A
      - Yes
    * - 2.7
      - 7
      - 14.04, 16.04
      - Yes
      - Yes
    * - 3.2
      - N/A
      - N/A
      - N/A
      - Yes
    * - 3.3
      - N/A
      - N/A
      - N/A
      - Yes
    * - 3.4
      - N/A
      - 14.04
      - N/A
      - Yes
    * - 3.5
      - N/A
      - 16.04
      - N/A
      - Yes
    * - 3.6
      - N/A
      - N/A
      - Yes
      - Yes
    * - Details
      - 
      - `Python 2 <http://packages.ubuntu.com/search?keywords=python2&searchon=names&suite=all&section=all>`__
        `Python 3 <http://packages.ubuntu.com/search?keywords=python3&searchon=names&suite=all&section=all>`__
      - 
      - 

At the moment 2.7 support is present upstream for the foreseeable
future; 3.x versions continue to be released and retired regularly in
parallel. The limiting factor will be distribution support for 2.7 as
major packages are slowly switching to 3.x, and this might cause
problems if our python module dependencies are no longer available
without major effort.

The supported version of the Django module used by OMERO.web (1.8)
requires Python 2.7. The older version (1.6) will work with Python
2.6 but lacks security support, and is consequently not recommended
for production use.

.. _ice-requirements:

Ice
---

:zeroc:`General overview <download.html>`

OMERO support policies
^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Upstream support
      - OMERO 5.3
      - OMERO 5.4
      - OMERO 5.5
      - Details
    * - 3.5
      - from Mar 2013
      - to Oct 2013
      - |Deprecated|
      - |Deprecated|
      - |Dropped|
      - :zerocforum:`3.5.0 <announcements/6093-ice-3-5-0-released>`,
        :zerocforum:`3.5.1 <announcements/6283-ice-3-5-1-released>`
    * - 3.6
      - from June 2015
      - to TBA
      - |Recommended|
      - |Recommended|
      - |Supported|
      - :zerocforum:`3.6.0 <announcements/6631-ice-3-6-0-and-ice-touch-3-6-0-released>`
        (:zerocforum:`3.6.1 <announcements/45941-ice-3-6-0-and-ice-touch-3-6-1-released>` |Broken|),
        :zerocforum:`3.6.2 <announcements/46347-ice-ice-e-and-ice-touch-3-6-2-released>`,
        :zerocforum:`3.6.3 <announcements/46475-ice-ice-e-and-ice-touch-3-6-3-released>`,
        :zerocforum:`3.6.4 <announcements/46550-ice-ice-e-and-ice-touch-3-6-4-released>`
    * - 3.7
      - from July 2017
      - to TBA
      - |Unsupported|
      - |Unsupported|
      - |Recommended|
      - :zerocforum:`3.7.0 <announcements/46530-ice-3-7-0-and-ice-touch-3-7-0-released>`

Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If no version is provided, a suitable repository is indicated.

.. list-table::
    :header-rows: 1

    * - Version
      - CentOS/RHEL
      - Ubuntu
      - Homebrew
      - FreeBSD Ports
    * - 3.5
      - 6, 7 (`zeroc <https://zeroc.com/distributions/ice/3.5/>`__)
      - 14.04, 16.04
      - N/A
      - N/A
    * - 3.6
      - 6, 7 (`zeroc <https://zeroc.com/distributions/ice/>`__)
      - 14.04, 16.04 (`zeroc <https://zeroc.com/distributions/ice/>`__)
      - Yes
      - Yes
    * - 3.7
      - 7 (`zeroc <https://zeroc.com/distributions/ice/>`__)
      - 16.04 (`zeroc <https://zeroc.com/distributions/ice/>`__)
      - Yes
      - Yes
    * - Details
      -
      - `Reference <http://packages.ubuntu.com/search?keywords=ice&searchon=names&suite=all&section=all>`__
      -
      -

Java
----

`General overview <http://www.oracle.com/technetwork/java/eol-135779.html>`__

OMERO support policies
^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Upstream support
      - OMERO 5.3
      - OMERO 5.4
      - OMERO 5.5
      - Details
    * - 7
      - from Jul 2011
      - to Apr 2015
      - |Deprecated|
      - |Deprecated|
      - |Dropped|
      - `Reference <http://www.oracle.com/technetwork/java/eol-135779.html>`__
    * - 8
      - from Mar 2014
      - to Mar 2017
      - |Recommended|
      - |Recommended|
      - |Supported|
      - `Reference <http://www.oracle.com/technetwork/java/eol-135779.html>`__
    * - 9
      - TBA
      - TBA
      - |Unsupported|
      - |Unsupported|
      - |Recommended|
      - 

Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1

    * - Version
      - CentOS/RHEL
      - Ubuntu
      - Homebrew
      - FreeBSD Ports
    * - 7
      - 6, 7
      - 14.04
      - N/A
      - Yes
    * - 8
      - 6, 7
      - 16.04
      - N/A
      - Yes
    * - 9
      - N/A
      - N/A
      - N/A
      - N/A
    * - Details
      - 
      - `Reference <http://packages.ubuntu.com/search?keywords=jdk&searchon=names&suite=all&section=all>`__
      - 
      - 

Note that all distributions provide OpenJDK 7 and/or 8 due to
distribution restrictions by Oracle. `Oracle Java <http://www.oracle.com/technetwork/java/javase/downloads/index-jsp-138363.html>`__ may be used if
downloaded separately.

nginx
-----

`General overview <http://nginx.org/en/download.html>`__ and `roadmap
<http://trac.nginx.org/nginx/roadmap>`__

OMERO support policies
^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Upstream support
      - OMERO 5.3
      - OMERO 5.4
      - OMERO 5.5
    * - 1.6
      - from Apr 2014
      - to Apr 2015
      - |Deprecated|
      - |Dropped|
      - |Dropped|
    * - 1.8
      - from Apr 2015
      - to Jan 2016
      - |Supported|
      - |Deprecated|
      - |Dropped|
    * - 1.10
      - from April 2016
      - TBA
      - |Recommended|
      - |Recommended|
      - |Supported|
    * - 1.12
      - from April 2016
      - TBA
      - |Supported|
      - |Supported|
      - |Recommended|

Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If no version is provided, a suitable repository is indicated.

.. list-table::
    :header-rows: 1

    * - Version
      - CentOS/RHEL
      - Ubuntu
      - Homebrew
      - FreeBSD Ports
    * - 1.6
      - N/A
      - N/A
      - N/A
      - N/A
    * - 1.8
      - N/A
      - N/A
      - N/A
      - N/A
    * - 1.10
      - 6 (`EPEL <https://dl.fedoraproject.org/pub/epel/6/x86_64/>`__), 7 (`EPEL <https://dl.fedoraproject.org/pub/epel/7/x86_64/>`__)
      - 14.04 (`nginx <https://launchpad.net/~nginx/+archive/ubuntu/stable>`__), 16.04
      - Yes
      - Yes
    * - 1.12
      - 6 (`EPEL <https://dl.fedoraproject.org/pub/epel/6/x86_64/>`__), 7 (`EPEL <https://dl.fedoraproject.org/pub/epel/7/x86_64/>`__)
      - 14.04 (`nginx <https://launchpad.net/~nginx/+archive/ubuntu/stable>`__), 16.04
      - Yes
      - Yes
    * - Details
      - 
      - 
      - `Reference <http://packages.ubuntu.com/search?keywords=nginx&searchon=names&suite=all&section=all>`__
      - 

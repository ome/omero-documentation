********************
Version requirements
********************

Summary of changes for OMERO 5.6 and provisional changes for 6.0
================================================================

We aim to support OMERO on the environments specified below, based
on the availability of support by upstream developers and operating
system distributions.
This applies over the lifetime of the |current_version| release and includes
security support.
Support is limited to those environments on which OMERO is
routinely tested.

This page details the minimum version requirements for the current
(|current_version|) release and also **possible** changes for the next release.

It is intended to provide a roadmap in order that sysadmins may
plan ahead and ensure that prerequisites are in place for future upgrades.

.. list-table::
    :header-rows: 1
    :align: left

    * - Level
      - Meaning
    * - |Upcoming|
      - unsupported/new
    * - |Supported|
      - supported/suboptimal
    * - |Recommended|
      - supported/optimal
    * - |Deprecated|
      - supported/deprecated
    * - |Dropped|
      - unsupported/old
    * - |Broken|
      - unsupported/broken
    * - |Unsupported|
      - unsupported/misc

Please check the full :ref:`support levels table <support-levels>` for more info on
each support level.

Bitness
-------

Rationale: OMERO is tested on 64-bit systems only.

.. list-table::
    :header-rows: 1

    * - Bitness
      - OMERO 5.4
      - OMERO 5.5
      - OMERO 5.6
      - OMERO 6.0
    * - 32-bit
      - |Deprecated| for Ice and native code [client]
      - |Dropped|
      - |Dropped|
      - |Dropped|
    * - 64-bit
      - |Recommended|
      - |Recommended|
      - |Recommended|
      - |Recommended|

NGINX
-----

.. list-table::
    :header-rows: 1
    :align: left

    * - nginx
      - OMERO 5.4
      - OMERO 5.5
      - OMERO 5.6
    * - 1.8
      - |Deprecated|
      - |Dropped|
      - |Dropped|
    * - 1.10
      - |Recommended|
      - |Supported|
      - |Deprecated|
    * - 1.12
      - |Supported|
      - |Recommended|
      - |Supported|
    * - 1.14
      - |Upcoming|
      - |Supported|
      - |Recommended|
    * - 1.16
      - |Upcoming|
      - |Upcoming|
      - |Recommended|

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
<https://access.redhat.com/articles/3078>`__ and `CentOS
<https://wiki.centos.org/About/Product>`__

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Supported until
      - OMERO 5.4
      - OMERO 5.5
      - OMERO 5.6
      - OMERO 6.0
      - Details
    * - 6
      - Nov 2010
      - Nov 2020
      - |Deprecated|
      - |Dropped|
      - |Dropped|
      - |Dropped|
      - `Reference <https://wiki.centos.org/About/Product>`__
    * - 7
      - June 2014
      - June 2024
      - |Recommended|
      - |Recommended|
      - |Recommended|
      - |Deprecated|
      - `Reference <https://wiki.centos.org/About/Product>`__
    * - 8
      - May 2019
      - May 2029
      - |Upcoming|
      - |Upcoming|
      - |Upcoming|
      - |Recommended|
      - `Reference <https://wiki.centos.org/About/Product>`__

RHEL/CentOS 7 is supported at present. Given the long life
of enterprise releases, we intend to support only the latest release
at any given time or else it ties us into very old dependencies.

Linux (Ubuntu)
--------------

`General overview <https://wiki.ubuntu.com/Releases>`__

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Supported until
      - OMERO 5.4
      - OMERO 5.5
      - OMERO 5.6
      - OMERO 6.0
    * - 14.04 LTS
      - Apr 2014
      - Apr 2019
      - |Supported|
      - |Dropped|
      - |Dropped|
      - |Dropped|
    * - 16.04 LTS
      - Apr 2016
      - Apr 2021
      - |Recommended|
      - |Recommended|
      - |Dropped|
      - |Dropped|
    * - 18.04 LTS
      - Apr 2018
      - Apr 2028
      - |Upcoming|
      - |Supported|
      - |Recommended|
      - |Supported|
    * - 20.04 LTS
      - Apr 2020
      - Apr 2030
      - |Upcoming|
      - |Upcoming|
      - |Upcoming|
      - |Recommended|

Only the LTS releases are supported due to resource limitations upon
CI and testing. Only the last two LTS releases are supported (being a
bit more frequent than CentOS/RHEL). There is currently no CI testing
for any version.

Microsoft Windows
-----------------

Client support only.
See `blog post explanation <https://blog.openmicroscopy.org/tech-issues/future-plans/deployment/2016/03/22/windows-support/>`_

MacOS X
-------

MacOS X is typically suited only to client use, not serious server
deployment, although the server can be expected to run on versions with
current security support for testing purposes.


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
    :align: left

    * - Operating system
      - Details
    * - CentOS 6 / RHEL 6
      - EOL
    * - CentOS 7 / RHEL 7
      - `Reference <http://mirror.centos.org/centos/7/os/x86_64/Packages/>`__
    * - Ubuntu
      - `Reference <https://packages.ubuntu.com/search?keywords=foo&searchon=names&suite=all&section=all>`__
    * - Homebrew
      - `Reference <https://github.com/Homebrew/homebrew-core/tree/master/Formula>`__
    * - FreeBSD Ports
      - `Reference <https://svnweb.freebsd.org/ports/head/>`__


PostgreSQL
----------

`General overview <https://www.postgresql.org/support/versioning/>`__

OMERO support policies
^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Supported until
      - OMERO 5.4
      - OMERO 5.5
      - OMERO 5.6
      - OMERO 6.0
    * - 9.3
      - Sep 2013
      - Sep 2018
      - |Deprecated|
      - |Dropped|
      - |Dropped|
      - |Dropped|
    * - 9.4
      - Dec 2014
      - Dec 2019
      - |Supported|
      - |Deprecated|
      - |Dropped|
      - |Dropped|
    * - 9.5
      - Jan 2016
      - Jan 2021
      - |Supported|
      - |Supported|
      - |Deprecated|
      - |Dropped|
    * - 9.6
      - Sep 2016
      - Sep 2021
      - |Recommended|
      - |Supported|
      - |Deprecated|
      - |Dropped|
    * - 10
      - Oct 2017
      - Nov 2022
      - |Upcoming|
      - |Recommended|
      - |Supported|
      - |Supported|
    * - 11
      - Oct 2018
      - Nov 2023
      - |Upcoming|
      - |Upcoming|
      - |Recommended|
      - |Recommended|
    * - 12
      - Oct 2019
      - Nov 2024
      - |Upcoming|
      - |Upcoming|
      - |Supported|
      - |Supported|

Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If no version is provided, a suitable repository is indicated.

.. list-table::
    :header-rows: 1
    :align: left

    * - Version
      - CentOS/RHEL
      - Ubuntu
      - Homebrew
      - FreeBSD Ports
    * - 10
      - 6 (`postgresql <https://yum.postgresql.org/10/redhat/rhel-6-x86_64/>`__),
	7 (`postgresql <https://yum.postgresql.org/10/redhat/rhel-7-x86_64/>`__),
	8 (`postgresql <https://yum.postgresql.org/10/redhat/rhel-8-x86_64/>`__)
      - 14.04, 16.04, 18.04 (`postgresql <https://apt.postgresql.org/pub/repos/apt/>`__)
      - Yes
      - Yes
    * - 11
      - 6 (`postgresql <https://yum.postgresql.org/11/redhat/rhel-6-x86_64/>`__), 7 (`postgresql <https://yum.postgresql.org/11/redhat/rhel-7-x86_64/>`__), 8 (`postgresql <https://yum.postgresql.org/11/redhat/rhel-8-x86_64/>`__)
      - 16.04, 18.04, 20.04 (`postgresql <https://apt.postgresql.org/pub/repos/apt/>`__)
      - Yes
      - Yes
    * - 12
      - 6 (`postgresql <https://yum.postgresql.org/12/redhat/rhel-6-x86_64/>`__), 7 (`postgresql <https://yum.postgresql.org/12/redhat/rhel-7-x86_64/>`__), 8 (`postgresql <https://yum.postgresql.org/12/redhat/rhel-8-x86_64/>`__)
      - 16.04, 18.04, 20.04 (`postgresql <https://apt.postgresql.org/pub/repos/apt/>`__)
      - Yes
      - Yes
    * - Details
      - 
      - `Reference <https://packages.ubuntu.com/search?keywords=postgresql&searchon=names&suite=all&section=all>`__
      - 
      - 

The PostgreSQL project provides `packages
<https://www.postgresql.org/download/>`__ for supported platforms
therefore distribution support is not necessary.

.. _python-requirements:

Python
------

OMERO support policies
^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Supported until
      - OMERO 5.4
      - OMERO 5.5
      - OMERO 5.6
      - OMERO 6.0
      - Details
    * - 2.6
      - Oct 2008
      - Oct 2013
      - |Dropped| [1]_ 
        |Supported| [2]_ 
      - |Dropped|
      - |Dropped|
      - |Dropped|
      - `PEP 361 <https://www.python.org/dev/peps/pep-0361/>`__
    * - 2.7
      - Jul 2010
      - Jan 2020
      - |Recommended|
      - |Recommended|
      - |Dropped|
      - |Dropped|
      - `PEP 373 <https://www.python.org/dev/peps/pep-0373/>`__
    * - 3.2
      - Feb 2011
      - Feb 2016
      - |Broken|
      - |Broken|
      - |Broken|
      - |Unsupported|
      - `PEP 392 <https://www.python.org/dev/peps/pep-0392/>`__
    * - 3.3
      - Sep 2012
      - Sep 2017
      - |Broken|
      - |Broken|
      - |Broken|
      - |Unsupported|
      - `PEP 398 <https://www.python.org/dev/peps/pep-0398/>`__
    * - 3.4
      - Mar 2014
      - Mar 2019
      - |Broken|
      - |Broken|
      - |Broken|
      - |Unsupported|
      - `PEP 429 <https://www.python.org/dev/peps/pep-0429/>`__
    * - 3.5
      - Sep 2015
      - Sep 2020
      - |Broken|
      - |Broken|
      - |Upcoming|
      - |Unsupported|
      - `PEP 478 <https://www.python.org/dev/peps/pep-0478/>`__
    * - 3.6
      - Dec 2016
      - Dec 2021
      - |Broken|
      - |Broken|
      - |Recommended|
      - |Supported|
      - `PEP 494 <https://www.python.org/dev/peps/pep-0494/>`__
    * - 3.7
      - Jun 2018
      - Jun 2023
      - |Broken|
      - |Broken|
      - |Supported|
      - |Recommended|
      - `PEP 537 <https://www.python.org/dev/peps/pep-0537/>`__

.. [1] For OMERO.web, Python 2.7 is the minimum supported version.
.. [2] For OMERO.py and OMERO.server 5.4, Python 2.6 is the minimum supported
       version.


Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1
    :align: left

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
      - 14.04, 16.04, 18.04
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
      - 7 (`EPEL <https://dl.fedoraproject.org/pub/epel/7/x86_64/>`__)
      - 14.04
      - N/A
      - Yes
    * - 3.5
      - N/A
      - 16.04
      - N/A
      - Yes
    * - 3.6
      - 7 (`EPEL <https://dl.fedoraproject.org/pub/epel/7/x86_64/>`__)
      - 18.04
      - Yes
      - Yes
    * - Details
      - 
      - `Python 2 <https://packages.ubuntu.com/search?keywords=python2&searchon=names&suite=all&section=all>`__
        `Python 3 <https://packages.ubuntu.com/search?keywords=python3&searchon=names&suite=all&section=all>`__
      - 
      - 

Python 2.7 support ends in 2020;

The Django version used by OMERO.web (1.11.26) is supported on Python 3.5, 3.6 and 3.7

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
      - Supported until
      - OMERO 5.4
      - OMERO 5.5
      - OMERO 5.6
      - OMERO 6.0
      - Details
    * - 3.5
      - Mar 2013
      - Oct 2013
      - |Deprecated|
      - |Dropped|
      - |Dropped|
      - |Dropped|
      - :zerocforum:`3.5.0 <6093/ice-3-5-0-released>`,
        :zerocforum:`3.5.1 <6283/ice-3-5-1-released>`
    * - 3.6
      - June 2015
      - TBA
      - |Recommended|
      - |Recommended|
      - |Recommended|
      - |Recommended|
      - :zerocforum:`3.6.0 <6631/ice-3-6-0-and-ice-touch-3-6-0-released>`
        (:zerocforum:`3.6.1 <45941/ice-3-6-0-and-ice-touch-3-6-1-released>` |Broken|),
        :zerocforum:`3.6.2 <46347/ice-ice-e-and-ice-touch-3-6-2-released>`,
        :zerocforum:`3.6.3 <46475/ice-ice-e-and-ice-touch-3-6-3-released>`,
        :zerocforum:`3.6.4 <46550/ice-ice-e-and-ice-touch-3-6-4-released>`,
        :zerocforum:`3.6.5 <46700/ice-3-6-5-released>`.
    * - 3.7
      - July 2017
      - TBA
      - |Unsupported|
      - |Unsupported|
      - |Unsupported|
      - |Unsupported|
      - :zerocforum:`3.7.0 <46530/ice-3-7-0-and-ice-touch-3-7-0-released>`,
        :zerocforum:`3.7.1 <46620/ice-3-7-1-released>`,
        :zerocforum:`3.7.2 <46670/ice-3-7-2-released>`,
        :zerocforum:`3.7.3 <46704/ice-3-7-3-released>`.


Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If no version is provided, a suitable repository is indicated.

.. list-table::
    :header-rows: 1
    :align: left

    * - Version
      - CentOS/RHEL
      - Ubuntu
      - Homebrew
      - FreeBSD Ports
    * - 3.5
      - 6, 7 (:zeroc:`zeroc <distributions/ice/3.5/>`)
      - 14.04, 16.04
      - N/A
      - N/A
    * - 3.6
      - 6, 7 (:zeroc:`zeroc <distributions/ice/3.6/>`)
      - 14.04, 16.04 (:zeroc:`zeroc <distributions/ice/3.6/>`)
      - Yes
      - Yes
    * - 3.7
      - 7 (:zeroc:`zeroc <distributions/ice/3.7/>`)
      - 16.04, 18.04 (:zeroc:`zeroc <distributions/ice/3.7/>`)
      - Yes
      - Yes
    * - Details
      -
      - `Reference <https://packages.ubuntu.com/search?keywords=ice&searchon=names&suite=all&section=all>`__
      -
      -

.. _version requirements java:

Java
----

`General overview <https://www.oracle.com/technetwork/java/eol-135779.html>`__

OMERO support policies
^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Supported until
      - OMERO 5.4
      - OMERO 5.5
      - OMERO 5.6
      - OMERO 6.0
      - Details
    * - 7
      - Jul 2011
      - Apr 2015
      - |Deprecated|
      - |Dropped|
      - |Dropped|
      - |Dropped|
      - `Reference <https://www.oracle.com/technetwork/java/eol-135779.html>`__
    * - 8
      - Mar 2014
      - Jun 2023
      - |Recommended|
      - |Recommended|
      - |Supported|
      - |Deprecated|
      - `Reference <https://access.redhat.com/articles/1299013>`__
    * - 11
      - Sep 2018
      - Oct 2024
      - |Unsupported|
      - |Supported|
      - |Recommended|
      - |Recommended|
      - `Reference <https://access.redhat.com/articles/1299013>`__
    * - 12
      - Sep 2018
      - Oct 2024
      - |Unsupported|
      - |Unsupported|
      - |Supported|
      - |Recommended|
      -
    * - 13
      - Sep 2018
      - Oct 2024
      - |Unsupported|
      - |Unsupported|
      - |Supported|
      - |Supported|
      -

Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1
    :align: left

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
      - 16.04, 18.04
      - N/A
      - N/A
    * - 11
      - 7
      - 18.04
      - N/A
      - Yes
    * - Details
      - 
      - `Reference <https://packages.ubuntu.com/search?keywords=jdk&searchon=names&suite=all&section=all>`__
      - 
      - 

Note that all distributions provide OpenJDK due to distribution restrictions
by Oracle. `Oracle Java
<https://www.oracle.com/technetwork/java/javase/downloads/index-jsp-138363.html>`__
may be used if downloaded separately.

NGINX
-----

`General overview <https://nginx.org/en/download.html>`__ and `roadmap
<https://trac.nginx.org/nginx/roadmap>`__

OMERO support policies
^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Supported until
      - OMERO 5.4
      - OMERO 5.5
      - OMERO 5.6
      - OMERO 6.0
    * - 1.6
      - Apr 2014
      - Apr 2015
      - |Deprecated|
      - |Dropped|
      - |Dropped|
      - |Dropped|
    * - 1.8
      - Apr 2015
      - Jan 2016
      - |Supported|
      - |Deprecated|
      - |Dropped|
      - |Dropped|
    * - 1.10
      - Apr 2016
      - Apr 2017
      - |Recommended|
      - |Supported|
      - |Deprecated|
      - |Dropped|
    * - 1.12
      - Apr 2017
      - Apr 2018
      - |Supported|
      - |Recommended|
      - |Supported|
      - |Deprecated|
    * - 1.14
      - Apr 2018
      - Apr 2019
      - |Upcoming|
      - |Supported|
      - |Recommended|
      - |Supported|
    * - 1.16
      - Apr 2019
      - TBA
      - |Upcoming|
      - |Upcoming|
      - |Recommended|
      - |Recommended|

Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If no version is provided, a suitable repository is indicated.

.. list-table::
    :header-rows: 1
    :align: left

    * - Version
      - CentOS/RHEL
      - Ubuntu
      - Homebrew
      - FreeBSD Ports
    * - 1.12
      - 7 (`EPEL <https://dl.fedoraproject.org/pub/epel/7/x86_64/>`__)
      - 14.04 (`nginx <https://launchpad.net/~nginx/+archive/ubuntu/stable>`__)
      - N/A
      - Yes
    * - 1.14
      - N/A
      - 16.04, 18.04 (`nginx <https://launchpad.net/~nginx/+archive/ubuntu/stable>`__)
      - Yes
      - Yes
    * - Details
      - 
      - 
      - `Reference <https://packages.ubuntu.com/search?keywords=nginx&searchon=names&suite=all&section=all>`__
      - 

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

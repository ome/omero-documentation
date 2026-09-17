********************
Version requirements
********************

Summary of changes for OMERO 5.6
================================

We aim to support OMERO on the environments specified below, based
on the availability of support by upstream developers and operating
system distributions.
This applies over the lifetime of the |current_version| release and includes
security support.
Support is limited to those environments on which OMERO is
routinely tested.

This page details the minimum version requirements for the current
(|current_version|) release.

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
      - OMERO 5.6
    * - 32-bit
      - |Dropped|
    * - 64-bit
      - |Recommended|


Operating system support
========================

The following subsections detail the versions of each operating system
which are supported by both its upstream developers (for security and
general updates) and by OME for OMERO building and server deployment.


Linux (CentOS and RHEL)
-----------------------

General overview for `RHEL
<https://access.redhat.com/articles/3078>`__ and `CentOS
<https://www.centos.org/>`__.

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Supported until
      - OMERO 5.6
    * - `RHEL 7 <https://endoflife.date/rhel>`__
      - June 2014
      - June 2024
      - |Dropped|
    * - `CentOS 7 <https://endoflife.date/centos>`__
      - June 2014
      - June 2024
      - |Dropped|
    * - `RHEL 8 <https://endoflife.date/rhel>`__
      - May 2019
      - Dec 2029
      - |Unsupported|
    * - `CentOS 8 <https://endoflife.date/centos>`__
      - May 2019
      - Dec 2021
      - |Unsupported|
    * - `RHEL 9 <https://endoflife.date/rhel>`__
      - May 2022
      - May 2032
      - |Recommended|
    * - `Rocky Linux 9 <https://endoflife.date/rocky-linux>`__
      - Jul 2022
      - May 2032
      - |Recommended|


RHEL 9/Rocky Linux 9 are supported at present. Given the long life
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
      - OMERO 5.6
    * - 18.04 LTS
      - Apr 2018
      - Apr 2028
      - |Dropped|
    * - 20.04 LTS
      - Apr 2020
      - Apr 2030
      - |Dropped|
    * - 22.04 LTS
      - Apr 2022
      - Apr 2032
      - |Supported|
    * - 24.04 LTS
      - Apr 2024
      - Apr 2034
      - |Recommended|


Only the LTS releases are supported due to resource limitations upon
CI and testing. Only the last LTS release is supported. There is currently no CI testing
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
    * - Rocky Linux 9
      - `Reference <https://download.rockylinux.org/pub/rocky/9/BaseOS/x86_64/os/Packages/>`__
    * - Ubuntu
      - `Reference <https://packages.ubuntu.com/search?keywords=foo&searchon=names&suite=all&section=all>`__


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
      - OMERO 5.6
    * - 12
      - Sep 2019
      - Nov 2024
      - |Dropped|
    * - 13
      - Sep 2020
      - Nov 2025
      - |Dropped|
    * - 14
      - Sep 2021
      - Nov 2026
      - |Supported|
    * - 15
      - Sep 2022
      - Nov 2027
      - |Recommended|
    * - 16
      - Sep 2023
      - Nov 2028
      - |Recommended|
    * - 17
      - Sep 2024
      - Nov 2029
      - |Upcoming|
    * - 18
      - Sep 2025
      - Nov 2030
      - |Upcoming|

Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If no version is provided, a suitable repository is indicated.

.. list-table::
    :header-rows: 1
    :align: left

    * - Version
      - CentOS/RHEL
      - Ubuntu
    * - 12
      - 9
      - 24.04 (`postgresql <https://apt.postgresql.org/pub/repos/apt/dists/noble-pgdg/>`__)
    * - 13
      - 9
      - 24.04 (`postgresql <https://apt.postgresql.org/pub/repos/apt/dists/noble-pgdg/>`__)
    * - 14
      - 9 (`postgresql <https://yum.postgresql.org/14/redhat/rhel-9-x86_64/>`__)
      - 24.04
    * - 15
      - 9 (`postgresql <https://yum.postgresql.org/15/redhat/rhel-9-x86_64/>`__)
      - 24.04 (`postgresql <https://apt.postgresql.org/pub/repos/apt/dists/noble-pgdg/>`__)
    * - 16
      - 9 (`postgresql <https://yum.postgresql.org/16/redhat/rhel-9-x86_64/>`__)
      - 24.04 (`postgresql <https://apt.postgresql.org/pub/repos/apt/dists/noble-pgdg/>`__)


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
      - OMERO 5.6
      - Details
    * - 3.6
      - Dec 2016
      - Dec 2021
      - |Dropped|
      - `PEP 494 <https://www.python.org/dev/peps/pep-0494/>`__
    * - 3.7
      - Jun 2018
      - Jun 2023
      - |Dropped|
      - `PEP 537 <https://www.python.org/dev/peps/pep-0537/>`__
    * - 3.8
      - Oct 2018
      - Oct 2024
      - |Dropped|
      - `PEP 569 <https://peps.python.org/pep-0569/>`__
    * - 3.9
      - Oct 2020
      - Oct 2025
      - |Dropped|
      - `PEP 596 <https://peps.python.org/pep-0596/>`__
    * - 3.10
      - Oct 2021
      - Oct 2026
      - |Supported|
      - `PEP 619 <https://peps.python.org/pep-0619/>`__
    * - 3.11
      - Oct 2022
      - Oct 2027
      - |Supported|
      - `PEP 664 <https://peps.python.org/pep-0664/>`__
    * - 3.12
      - Oct 2023
      - Oct 2028
      - |Recommended|
      - `PEP 693 <https://peps.python.org/pep-0693/>`__
    * - 3.13
      - Oct 2024
      - Oct 2029
      - |Upcoming|
      - `PEP 719 <https://peps.python.org/pep-0719/>`__
    * - 3.14
      - Oct 2025
      - Oct 2030
      - |Upcoming|
      - `PEP 745 <https://peps.python.org/pep-0745/>`__


Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1
    :align: left

    * - Version
      - CentOS/RHEL
      - Ubuntu
    * - 3.9
      - 9
      - 
    * - 3.12
      - 9.4+
      - 24.04

.. _ice-requirements:

Ice
---

:zeroc:`General overview <downloads/ice>`

OMERO support policies
^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1

    * - Version
      - Release date
      - Supported until
      - OMERO 5.6
      - Details
    * - 3.5
      - Mar 2013
      - Oct 2013
      - |Dropped|
      - `Release notes <https://archive.zeroc.com/rel/ice-releases/ice-3-5/ice-3-5-0-release-notes>`__
    * - 3.6
      - June 2015
      - TBA
      - |Recommended|
      -  `Release notes <https://archive.zeroc.com/rel/ice-releases/ice-3-6/ice-3-6-3-release-notes>`__
    * - 3.7
      - July 2017
      - TBA
      - |Unsupported|
      - `Release notes <https://archive.zeroc.com/ice/3.7/release-notes>`__


Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If no version is provided, a suitable repository is indicated.

.. list-table::
    :header-rows: 1
    :align: left

    * - Version
      - CentOS/RHEL
      - Ubuntu
    * - 3.6
      - 9 (`zeroc-ice-rhel9-x86_64 <https://github.com/glencoesoftware/zeroc-ice-rhel9-x86_64>`__)
      - 24.04 (`zeroc-ice-ubuntu2404-x86_64  <https://github.com/glencoesoftware/zeroc-ice-ubuntu2404-x86_64>`__)

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
      - OMERO 5.6
      - Details
    * - 7
      - Jul 2011
      - Apr 2015
      - |Dropped|
      - `Reference <https://www.oracle.com/technetwork/java/eol-135779.html>`__
    * - 8
      - Mar 2014
      - Nov 2026
      - |Deprecated|
      - `Reference <https://access.redhat.com/articles/1299013>`__
    * - 11
      - Aug 2021
      - Oct 2027
      - |Recommended|
      - `Reference <https://access.redhat.com/articles/1299013>`__
    * - 17
      - Sep 2018
      - Oct 2027
      - |Upcoming|
      - `Reference <https://access.redhat.com/articles/1299013>`__

Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1
    :align: left

    * - Version
      - CentOS/RHEL
      - Ubuntu
    * - 11
      - 9
      - 24.04
    * - Details
      - 
      - `Reference <https://packages.ubuntu.com/search?keywords=jdk&searchon=names&suite=all&section=all>`__

Note that all distributions provide OpenJDK due to distribution restrictions
by Oracle. `Oracle Java
<https://www.oracle.com/technetwork/java/javase/downloads/index-jsp-138363.html>`__
may be used if downloaded separately.

NGINX
-----

`General overview <https://nginx.org/en/download.html>`__ and `Code
<https://github.com/nginx/nginx>`__

OMERO support policies
^^^^^^^^^^^^^^^^^^^^^^

.. list-table::
    :header-rows: 1
    :align: left

    * - nginx
      - OMERO 5.6
    * - 1.27
      - |Dropped|
    * - 1.28
      - |Recommended|
    * - 1.29
      - |Upcoming|


Version provided by distribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If no version is provided, a suitable repository is indicated.

.. list-table::
    :header-rows: 1
    :align: left

    * - Version
      - RHEL/Rocky Linux
      - Ubuntu
    * - 1.23
      - 9 (`repo <http://nginx.org/packages/centos/9/x86_64/>`__)
      - N/A
    * - 1.24
      - 9 (`repo <http://nginx.org/packages/centos/9/x86_64/>`__)
      - 24.04

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

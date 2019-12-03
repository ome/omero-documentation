Migration from OMERO 5.5 (Python 2) to OMERO 5.6 (Python 3)
===========================================================

.. warning::

  This is still a pre-release of OMERO 5.6. The instructions below
  are intended to help plan a migration path from your current OMERO
  installation. We suggest you **not** perform the migration on your
  production systems until the 5.6.0 release is ready.

Basic steps
-----------

1. Choose a platform and a python. If your current installation platform
   does not match one of the :doc:`recommended platforms <version-requirements>`,
   you may want to choose a new platform as your migration target. See
   `Choosing a platform`_ below.
2. Instal OMERO.server and OMERO.web *separately*. All instructions like
   `OMERO.server`_ and `OMERO.web`_ below as well as the main installation
   :doc:`server <unix/server-installation>` and 
   :doc:`web <unix/install-web/web-deployment>` pages assume separate installations.
3. Once both have been installed, perform a
   :doc:`backup and restore <server-backup-and-restore>` procedure
   and test your installation against the copy of your data.

Choosing a platform
-------------------

We suggest Python 3.6. This is the default installation on the two recommended platforms,
CentOS 7 and Ubuntu 18.04.

Both 3.5 and 3.7 should work and are slated to have support added, but Python 3.6 has received
the most tested during the migration.

Similarly, other operating systems are slated for having support added, but help from the
community would be very welcome! Obvious next candidates are CentOS 8 and Ubuntu 20.04.

Debian is more of an issue. Debian 9 is still on Python 3.5 and Debian 10 has moved to Ice 3.7
so neither is particularly well supported at the moment.

Other prerequisites
-------------------

OMERO's other prerequisites have not changed substantially but if you would like to take this
opportunity to move to the :doc:`"recommended" version<version-requirements>` for all requirements,
the current choices are:

- Ice 3.6 (non-optional)
- Java 11
- Nginx 1.14
- PostgreSQL 11


Other options
-------------

Additional options that you may like to look into:

Ansible: if you would like to use ansible for deployment, the roles have been upgraded but are not yet fully released. Please get in touch or see the GitHub repositories for the latest info.
Conda: If you'd like to use conda, that should work fine on most platforms.


OMERO.server
------------

The steps for an OMERO.server installation have not changed substantially.

First, download the OMERO.server.zip as you would usually do, and unpack it under your
installation directory. We suggest: file:`/opt/omero/server/OMERO.server`

All instructions ...

Once you have your installation in place, you will need to follow the upgrade
documentation. Again, if any of the above is not clear, please see the very
extensive information on the documentation page. If in doubt, start [HERE]
(where?)


OMERO.web
---------

Installing OMERO.web no longer requires downloading a package from
https://downloads.openmicroscopy.org. The first choice to make is
whether you want to continue the previous method or move to a `pip install`-only
installation. If you don't need the Java libraries, `pip install` is likely more
convenient.

The primary change is that it is now required to set the :envvar:`OMERODIR` variable
to specify where the OMERO installation lives. This defines where configuration
files and log files will be stored.

Create an installation directory. We suggest: /opt/omero/web
Create a virtualenv: e.g. `python -mvenv venv3`
On some platforms, you may need to use python3 -mvenv venv3.
We're preferring to not use system-site-packages at the moment.
Choose between:
Downloading the OMERO.py zip as previously and unpack.
We suggest: /opt/omero/web/OMERO.web
Running: pip install --pre omero-web
mkdir -p OMERO.web/etc/ OMERO.web/var/
export OMERODIR=$PWD/OMERO.web/

Plugins
^^^^^^^

Core OMERO.web plugins have been updated for Python 3 and pre-released to
PyPI. This means that there versions end in ".devX" and will only be installed
by `pip install` if you add either a version specifier or the `--pre` flag.
For example both of the following can be used to install the updated version
of OMERO.iviewer:

::

    pip install 'omero-iviewer>=0.9.0.dev1'
    # or
    pip install --pre omero-iviewer


We will be releasing full versions of each of the plugins over the next month.

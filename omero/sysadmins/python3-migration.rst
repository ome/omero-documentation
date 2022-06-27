Migration to Python 3
=====================

Basic steps
-----------

#. Choose a platform and a Python version. If your current installation platform
   does not match one of the :doc:`recommended platforms <version-requirements>`,
   you may want to choose a new platform as your migration target. See
   `Choosing a platform`_ below.
#. Install OMERO.server and OMERO.web *separately*. Though not necessary, all
   instructions like `OMERO.server`_ and `OMERO.web`_ below as well as the main
   :doc:`server <unix/server-installation>` and 
   :doc:`web <unix/install-web/web-deployment>` installation pages now assume
   that the two are in separate installations.
#. Once both have been installed, perform a
   :doc:`backup and restore <server-backup-and-restore>` procedure
   and test your installation against the copy of your data.

Choosing a platform
-------------------

The two recommended platforms, CentOS 7 and Ubuntu 18.04, have Python 3.6 as
default installation and have therefore received the most testing which is why
Python 3.6 is the preferred version of Python.

Both Python 3.5 and 3.7 should work and are slated to have support added, but
Python 3.6 has been the focus of testing during the migration.

Similarly, other operating systems are slated for having support added, but help
from the community would be very welcome! Obvious next candidates are CentOS 8
and Ubuntu 20.04.

Debian 9 is still on Python 3.5 and Debian 10 has moved to Ice 3.7.
We have nonetheless an installation guide for Debian 9 with Python 3.5 and Ice 3.6
but an installation guide for Debian 10 with Python 3.7 and Ice 3.6.

Other prerequisites
-------------------

OMERO's other prerequisites have not changed substantially but if you would like to take this
opportunity to move to the :doc:`recommended version<version-requirements>` for all requirements,
the current choices are:

- Ice 3.6 (non-optional)
- Java 11
- Nginx 1.14 or higher
- PostgreSQL 11

Other options
-------------

The installation walkthroughs provided in the documentation try to stick to a minimum installation.
The only requirements are an understanding of the Unix shell, the standard package manager for your
platform, and the regular Python distribution mechanisms.

However, more advanced installation mechanisms are available if you are interested and have familiarity
with the given mechanism:

- `Ansible roles <https://galaxy.ansible.com/ome>`_ are available for most installation steps. The primary
  roles, `omero-server` and `omero-web` have not yet been released and will need to be installed from
  GitHub.

- A `conda channel <https://anaconda.org/ome>`_ provides pre-built packages needed by OMERO if you prefer
  to use Anaconda/Miniconda instead of the Python distribution provided by your platform.

- `Docker images <https://hub.docker.com/u/openmicroscopy>`_ are also available. Both the `omero-server`
  and `omero-web` images are considered production quality.

Please get in touch at :imagesc:`image.sc <c/data>` if you have any questions.

OMERO.server
------------

The steps for an OMERO.server installation have not changed substantially.

Download the OMERO.server.zip as you would usually do, and unpack it under your
installation directory. We suggest :file:`/opt/omero/server/` and symlink the unpacked
directory to `OMERO.server`

We highly recommend a virtualenv-based installation for all of the Python
dependencies. Follow the :doc:`standard installation instructions <unix/server-installation>` for your platform.
All instructions use a virtual environment.

Once you have your installation in place, you will need to follow the
:doc:`standard upgrade instructions <server-upgrade>`, working from
a *copy* of your data.

OMERO.web
---------

Although it is possible to also follow the previous installation steps
for OMERO.web, installation no longer requires downloading a package from
https://downloads.openmicroscopy.org. If you choose to follow this newly introduced route,
all requirements will be installed directly into the virtualenv for OMERO.web.
Instructions are available under :doc:`web-deployment <unix/install-web/web-deployment>`.

Note that setting of :envvar:`OMERODIR` variable is now required
to specify where the OMERO installation lives. This defines where configuration
files and log files will be stored.  We suggest :file:`/opt/omero/web` as the
root for your installation.

The :doc:`upgrade guide <omeroweb-upgrade>` can help you to transfer your
previous configuration. Moving forward, however, web upgrades should be much
simpler under Python 3. Only a `pip install -U` of the appropriate libraries
should be necessary.

Plugins
^^^^^^^

Core OMERO.web plugins have been updated for Python 3 and released to
PyPI_ e.g.

::

    pip install 'omero-iviewer>=0.9.0'

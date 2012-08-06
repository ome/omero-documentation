.. _developers/Omero/Server/Grid/Install:

OMERO Grid Install
==================

Before attempting to install |OmeroGrid|, the
requirements listed under :ref:`server/installation` must
be satisfied. In particular:

-  :ref:`server/installation#Prerequisites`: Java and Postgres
-  :ref:`server/installation#PreInstallation`: Creating users and directories
-  Configuration: Extraction and editing **local.properties** under
   :ref:`server/installation#Installation`

.. contents::

OMERO Grid requirements (platform specific)
--------------------------------------------

The main additional requirements for running the grid are the `Ice_
framework and `Python <http://python.org>`_, which are platform specific.

On all the supported platforms below, the appropriate Python version
comes pre-installed. Using versions of Python other than the OS default
will require additional build steps to have Ice work properly with
Python.

ZeroC_ provides Ice rpms for installation as well as Windows installers,
and both binary and source distributions. Several distros also provide
packages.

Once you have installed the requirements for your platform, continue
under :ref:`developers/Omero/Server/Grid/Install#Installation`.

Supported platforms
~~~~~~~~~~~~~~~~~~~

-  Ubuntu Gutsy. See :ref:`developers/Omero/Server/Grid/InstallGutsy`
-  CentOS 4 and 5. See :ref:`developers/Omero/Server/Grid/InstallCentOs`
-  Mac OS X 10.4 and 10.5. See :ref:`developers/Omero/Server/Grid/InstallMacOsx`
-  Windows XP. See :ref:`developers/Omero/Server/Grid/InstallWindowsXp`

Platforms requiring Ice compilation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following platforms require you to download Ice 3.2.1 as source and
build it for your platform. See
` http://www.zeroc.com/download\_3\_2\_1.html <http://www.zeroc.com/download_3_2_1.html>`_
and
` http://www.zeroc.com/download/Ice/3.2/ <http://www.zeroc.com/download/Ice/3.2/>`_
for more information.

-  Ubuntu Hardy Heron. Due to ` an Ubuntu
   bug <https://bugs.launchpad.net/ubuntu/+source/zeroc-ice-python/+bug/213508>`_,
   the package for IcePy currently does not work, and a manual
   installation is required.

Unsupported/untested platforms
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  openSuSE 10.3
-  Windows Vista

.. _developers/Omero/Server/Grid/Install#Installation:

Installation
------------

Once JBoss is running according to :ref:`server/installation#Installation`, a
few further steps are necessary to start |OmeroGrid|, which in turns starts
:ref:`server/blitz` and various other processes:

::

    bin/omero admin start
    bin/omero admin deploy

The deploy command can optionally take a path to an application
descriptor. For example,

::

    bin/omero admin deploy etc/grid/my-site.xml target1 target2

See |OmeroGrid| for more information.

Shortcuts
---------

If the ``bin/omero`` script is copied or symlinked to another name, then
the script will separate the name on hypens and execute ``bin/omero``
with the second and later parts **prepended** to the argument list.

For example,

::

      ln -s bin/omero bin/omero-admin
      bin/omero-admin start

works identically to:

::

      bin/omero admin start

Symbolic linking
----------------

Shortcuts allow the ``bin/omero`` script to function as a init.d script
when named "**omero-admin**\ ", and need only be copied to
``/etc/init.d/`` to function properly. It will resolve its installation
directory, and execute from there unless ``OMERO_HOME`` is set.

For example,

::

       ln -s $OMERO_HOME/bin/omero /etc/init.d/omero-admin
       /etc/init.d/omero-admin start

The same works for putting ``bin/omero`` on your path, either via:

::

       PATH=$OMERO_HOME/bin:$PATH

or

::

       # Assuming $HOME/bin is on your path
       ln -s $OMERO_HOME/bin/omero $HOME/bin/omero

This means that |OmeroGrid| can be unpacked
anywhere, and as long as the user invoking the commands has the proper
permissions on the ``$OMERO_HOME`` directory, it will function normally.

Running as root
---------------

One exception to this rule is that starting
|OmeroGrid| as root may actually delegate to
another user, if the "user" attribute is set on the ``<server/>``
elements in :source:`etc/grid/templates.xml`.
(This holds only for Unix-based platforms including MacOsX. See
:ref:`developers/Omero/Server/Grid/InstallWindowsXP` for
information on changing the server user under Windows.)

Starting on boot
----------------

Configuring |OmeroGrid| to start on boot is a
platform-specific configuration. Please see your platforms instructions.

.. seealso:: |OmeroGrid|

-  Ubuntu Gutsy. See :ref:`developers/Omero/Server/Grid/InstallGutsy`
-  CentOS 4 and 5. See :ref:`developers/Omero/Server/Grid/InstallCentOs`
-  Mac OS X 10.4 and 10.5. See :ref:`developers/Omero/Server/Grid/InstallMacOsx`
-  Windows XP. See :ref:`developers/Omero/Server/Grid/InstallWindowsXp`

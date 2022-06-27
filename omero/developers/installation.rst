.. _install_from_source:

Installing OMERO from source
============================

.. warning::
  
  Starting from OMERO 5.5, many components have been moved to their own
  repositories e.g. :omero_subs_github_repo_root:`OMERO.py <omero-py>`, to modernize
  the application and allow more flexibility.

  This page is currently under **review**.


Using the source code
---------------------

The source code of each release of OMERO is available for download from the
:downloads:`Source code <>` section of the OMERO download page.

.. note::
  At the moment, this source code bundle does not contain the version of
  Bio-Formats. To include this version information, you will need to manually
  copy the :file:`ant/gitversion.xml` file included in the source code bundle
  of Bio-Formats for the same release under :file:`components/bioformats/ant`.

Using the Git source repository
-------------------------------

To use the Git source repository, you will need to install Git on your system.
See the :devs_doc:`Using Git <using-git.html>` section of the Contributing
documentation for more information on how to install and configure Git.

The main repository for OMERO is available from
:omero_subs_github_repo_root:`openmicroscopy <openmicroscopy>`.
Most OME development is currently happening on GitHub, therefore it is highly
suggested that you become familiar with how it works, if not create an account
for yourself.

Start by cloning the official repository::

  git clone https://github.com/ome/openmicroscopy.git

Since the openmicroscopy repository now makes use of submodules, you first
need to initialize all the submodules::

  cd openmicroscopy
  git submodule update --init

Alternatively, with version 1.6.5 of git and later, you can pass the
``--recursive`` option to git clone and initialize all submodules::

  git clone --recursive https://github.com/ome/openmicroscopy.git

.. seealso::
  :devs_doc:`Using Git <using-git.html>`
    Section of the contributing documentation explaining how to use Git for
    contributing to the source code.

Building OMERO
--------------

To install the dependencies required to run the OMERO.server on Linux
or Mac OS X, take a look at the
:doc:`/sysadmins/unix/server-installation` page where you will also find links
to walk-throughs for specific platforms.

Some environment variables may need to be set up before building the server:

- If the system slice files cannot be found you must set :envvar:`SLICEPATH`
  to point to the :file:`slice` directory of the Ice installation.

Once all the dependencies and environment variables are set up, you can build
the server using::

    python build.py

or the clients using::

    python build.py release-clients

.. seealso::

    :doc:`build-system`
        Section of the developer documentation detailing the build system

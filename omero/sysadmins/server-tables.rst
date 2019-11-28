OMERO.tables
============

OMERO.tables provide a way to efficiently store large, tabular
results within OMERO. If you would like to find out more about
the use of the OMERO.tables API, see
:doc:`OMERO.analysis </developers/analysis>`

Requirements
------------

If you would like to help test the Tables API, you will need the following installed:

-  `HDF5 <https://www.hdfgroup.org/downloads/hdf5/>`_
-  `NumPy <http://numpy.sourceforge.net/numdoc/HTML/numdoc.htm>`_ points to downloads at
   http://sourceforge.net/projects/numpy/
-  `PyTables <http://pytables.github.com/downloads.html>`_ (Some packages include HDF5)


Unix
----

PyTables is likely available from the package repository of
your Unix-flavor. This includes Mac OS X (homebrew), Debian
and Ubuntu (apt-get), CentOS (yum), and SuSE (yast). Here
we've shown manual instructions using virtualenv.


Manually
~~~~~~~~

::

    $ virtualenv $HOME/virtualenv
    $ uname -o -p
    unknown GNU/Linux
    $ gcc --version
    gcc-4.8.real (Debian 4.8.1-9) 4.8.1
    Copyright (C) 2013 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    $ wget "https://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.11.tar.gz"
    $ tar xzf hdf5-1.8.11.tar.gz
    $ cd hdf5-1.8.11
    $ ./configure --prefix=$HOME/virtualenv
    $ make
    $ make install
    $ export LD_LIBRARY_PATH=$HOME/virtualenv/lib
    $ . $HOME/virtualenv/bin/activate
    $ easy_install tables


Checking that it works
~~~~~~~~~~~~~~~~~~~~~~

After that, the following should succeed:

::

    % python3
    Python 3.5.3 (default, Sep 27 2018, 17:25:39) 
    [GCC 6.3.0 20170516] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import tables
    >>> tables.test()
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    PyTables version:  3.4.4
    HDF5 version:      1.8.18
    NumPy version:     1.17.4
    Numexpr version:   2.7.0 (not using Intel's VML/MKL)
    Zlib version:      1.2.8 (in Python interpreter)
    LZO version:       2.09 (Feb 04 2015)
    BZIP2 version:     1.0.6 (6-Sept-2010)
    Blosc version:     1.14.3 (2018-04-06)
    Python version:    3.5.3 (default, Sep 27 2018, 17:25:39) 
    [GCC 6.3.0 20170516]
    Platform:          Linux-4.9.184-linuxkit-x86_64-with-debian-9.11
    Byte-ordering:     little
    Detected cores:    4
    …

.. note::

  If the above test fails with::

    ImportError: No module named mock

  then this is fixed by installing the corresponding Python module. Use
  your operating system's package installer if possible or if you must
  instead use PyPI_ directly::

    pip install mock

Once the required Python libraries are installed, starting OMERO will
automatically start up the OMERO.tables service; there should be no need
for further configuration or interaction.

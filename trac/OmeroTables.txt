OMERO.tables
============

Table of Contents
^^^^^^^^^^^^^^^^^

#. `Overview <#Overview>`_
#. `Getting Started <#GettingStarted>`_
#. `The Interface <#TheInterface>`_
#. `Examples <#Examples>`_
#. `The Implementation <#TheImplementation>`_
#. `Going forward <#Goingforward>`_
#. `Links <#Links>`_
#. `More install notes <#Moreinstallnotes>`_

   #. `Windows <#Windows>`_
   #. `Linux <#Linux>`_

Overview
--------

The new Tables API is an attempt to unify the storage of columnar data
from various sources, such as automated analysis results or script-based
processing, and make them available within OMERO. Often, users look to
store either external data (not in the OME schema) or schema-less data.
`StructuredAnnotations </ome/wiki/StructuredAnnotations>`_ are an option
for small quantities of data. Another option is to extend the OME model,
but this risks interoperability issues. (See
`ExtendingOmero </ome/wiki/ExtendingOmero>`_). With the Tables API,
tabular (i.e. spreadsheet-like) data can be stored via named columns,
and retrieved in bulk or via paging. A limited query language provides
basic filtering and selecting.

Getting Started
---------------

If you would like to help test the Tables API, you will need to do the
following:

-  Get a checkout of the latest code from trunk or a recent build (See:
   `OmeroContributing </ome/wiki/OmeroContributing>`_)
-  Install HDF5:
   ` http://www.hdfgroup.org/HDF5/release/obtain5.html <http://www.hdfgroup.org/HDF5/release/obtain5.html>`_
-  Install NumPy:
   ` http://numpy.sourceforge.net/numdoc/HTML/numdoc.htm <http://numpy.sourceforge.net/numdoc/HTML/numdoc.htm>`_
   points to downloads at
   ` http://sourceforge.net/projects/numpy/ <http://sourceforge.net/projects/numpy/>`_
-  Install PyTables:
   ` http://www.pytables.org/docs/manual/ch02.html <http://www.pytables.org/docs/manual/ch02.html>`_
   (Some packages include HDF5)

After that, the following should succeed:

::

    josh@mac:~$ python
    Python 2.5.4 (r254:67916, Jun 24 2009, 20:23:29) 
    [GCC 4.0.1 (Apple Computer, Inc. build 5370)] on darwin
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import tables
    >>> tables.test()
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    PyTables version:  2.1
    HDF5 version:      1.8.3
    NumPy version:     1.3.0
    Zlib version:      1.2.3
    BZIP2 version:     1.0.5 (10-Dec-2007)
    Python version:    2.5.4 (r254:67916, Jun 24 2009, 20:23:29) 
    [GCC 4.0.1 (Apple Computer, Inc. build 5370)]
    Platform:          darwin-i386
    Byte-ordering:     little
    ...

*Note: I installed Pytables vi MacPorts:*

::

    sudo port install py25-tables

Once the required Python libraries are installed, started OMERO will
automatically start up the OmeroTables service; there should be no need
for further configuration or interaction. *Eventually, support for
multiple OmeroTables services will be included, at which time the
service must be started on each machine.*

The Interface
-------------

The ` slice definition
file <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/blitz/resources/omero/Tables.ice>`_
for the `OmeroTables </ome/wiki/OmeroTables>`_ API primarily defines two
service interfaces and a type hierarchy:

-  ``omero.grid.Table`` is the central service for dealing with tabular
   data.
-  ``omero.grid.Tables`` is an internal service used for managing table
   services, and can be ignored for almost all purposes.
-  ``omero.grid.Column`` is the base class for a number of column types
   which permit returning arrays of columnar values
   (` Ice <http://zeroc.com>`_ doesn't provide an "Any" type, so it's
   necessary to group values of the same type.)

   -  ``omero.grid.WellColumn``, ``ImageColumn``, ``RoiColumn``, etc.
      are id-based columns which reference an object in the database.
   -  ``omero.grid.LongColumn``, ``DoubleColumn``, ``BoolColumn``, etc.
      are simply value columns for representing your data.

Further documentation on the API is available :jenkins:`here
<job/OMERO/javadoc/slice2html/omero/grid/Table.html#Table>`.  Several
examples are linked below, but these are only the beginning of what
can be done with `OmeroTables </ome/wiki/OmeroTables>`_. Future
methods and services can provide functionality for merging tables,
searching in parallel, and mathematical analysis, for example.

Examples
--------

-  Hello World:
   `ome.git/examples/OmeroTables/first.py </ome/browser/ome.git/examples/OmeroTables/first.py>`_
-  Creating a Measurement Table:
   `ome.git/examples/OmeroTables/creating.py </ome/browser/ome.git/examples/OmeroTables/creating.py>`_
   (see "Going forward" below)
-  Querying a Table:
   `ome.git/examples/OmeroTables/creating.py </ome/browser/ome.git/examples/OmeroTables/creating.py>`_
   (See "Going forward" below)
-  Also see the
   `OmeroTablesCodeExamples </ome/wiki/OmeroTablesCodeExamples>`_ page.

The Implementation
------------------

Currently, each table is backed by a single HDF table. Since PyTables?
(and HDF in the general case) don't support concurrent access,
`OmeroTables </ome/wiki/OmeroTables>`_ provides a global locking
mechanism which permits multiple views of the same data. Each
"OMERO.tables" file (registerd as an ``OriginalFile`` in the database),
is composed of a single HDF table with any number of certain limited
column types.

The query language mentioned above is *currently* the PyTables
` condition syntax <http://www.pytables.org/docs/manual/apb.html>`_.
Columns are referenced by name. The following operators are supported:

-  Logical operators: ``&, |, ~``
-  Comparison operators: ``<, <=, ==, !=, >=, >``
-  Unary arithmetic operators: ``-``
-  Binary arithmetic operators: ``+, -, *, /, **, %``

and the following functions:

-  ``where(bool, number1, number2)``: number — number1 if the bool
   condition is true, number2 otherwise.
-  ``{sin,cos,tan}(float|complex)``: float\|complex — trigonometric
   sine, cosine or tangent.
-  ``{arcsin,arccos,arctan}(float|complex)``: float\|complex —
   trigonometric inverse sine, cosine or tangent.
-  ``arctan2(float1, float2)``: float — trigonometric inverse tangent of
   float1/float2.
-  ``{sinh,cosh,tanh}(float|complex)``: float\|complex — hyperbolic
   sine, cosine or tangent.
-  ``{arcsinh,arccosh,arctanh}(float|complex)``: float\|complex —
   hyperbolic inverse sine, cosine or tangent.
-  ``{log,log10,log1p}(float|complex)``: float\|complex — natural,
   base-10 and log(1+x) logarithms.
-  ``{exp,expm1}(float|complex)``: float\|complex — exponential and
   exponential minus one.
-  ``sqrt(float|complex)``: float\|complex — square root.
-  ``{real,imag}(complex)``: float — real or imaginary part of complex.
-  ``complex(float, float)``: complex — complex from real and imaginary
   parts.

See
**` http://www.pytables.org/docs/manual/apb.html <http://www.pytables.org/docs/manual/apb.html>`_**
for more information.

Going forward
-------------

The Tables API itself provides little more than a remotely accessible
store, think of it as a server for Excel-like spreadsheets. We're
currently looking into the facilities that can be built on top of it,
and are **very** open to suggestions. For example, the IRoi interface
(:jenkins:`documentation
<job/OMERO/javadoc/slice2html/omero/api/IRoi.html#IRoi>`, :wiki:`wiki
<RegionsOfInterest>`) has been extended to filter ROIs by a given
measurement. This allows seeing only those results from a particular
analysis run. The following example shows how to setup such a
measurement and retrieve its results:

` iroi.py <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/examples/OmeroTables/iroi.py>`_

To see an example of production code that parses out such measurements,
see
` populate\_roi.py <http://trac.openmicroscopy.org.uk/ome/browser/ome.git/components/tools/OmeroPy/src/omero/util/populate_roi.py>`_.
**Note: the use of the FileAnnotation is provisional: a "Measurement"
data type will be added in future versions.**

The IRoi interface has been integrated into the Insight, allowing for
the visualization and export of `OmeroTables </ome/wiki/OmeroTables>`_:

`|Choice between multiple
measurements| </ome/attachment/wiki/OmeroTables/MeasurementListSep09.png>`_
`|Prototype of table results in
Insight| </ome/attachment/wiki/OmeroTables/MeasurementToolSep09.png>`_

Links
-----

-  ` http://pytables.org <http://pytables.org>`_
-  `source:ome.git/components/blitz/resources/omero/Tables.ice </ome/browser/ome.git/components/blitz/resources/omero/Tables.ice>`_
-  `source:ome.git/components/tools/OmeroPy/test/tablestest/servants.py </ome/browser/ome.git/components/tools/OmeroPy/test/tablestest/servants.py>`_

More install notes
------------------

Windows
~~~~~~~

-  PIL :
   ` http://effbot.org/downloads/PIL-1.1.6.win32-py2.5.exe <http://effbot.org/downloads/PIL-1.1.6.win32-py2.5.exe>`_
-  scipy:
   ` http://sourceforge.net/projects/scipy/files/scipy/0.7.1/scipy-0.7.1-win32-superpack-python2.5.exe/download <http://sourceforge.net/projects/scipy/files/scipy/0.7.1/scipy-0.7.1-win32-superpack-python2.5.exe/download>`_
-  numpy :
   ` http://sourceforge.net/projects/numpy/files/NumPy/1.3.0/numpy-1.3.0-win32-superpack-python2.5.exe/download <http://sourceforge.net/projects/numpy/files/NumPy/1.3.0/numpy-1.3.0-win32-superpack-python2.5.exe/download>`_
-  pytables :
   ` http://www.pytables.org/download/stable/tables-2.1.2.win32-py2.5.exe <http://www.pytables.org/download/stable/tables-2.1.2.win32-py2.5.exe>`_
-  szip lib :
   ` http://www.hdfgroup.org/ftp/lib-external/szip/2.1/bin/windows/szip21-vnet-enc.zip <http://www.hdfgroup.org/ftp/lib-external/szip/2.1/bin/windows/szip21-vnet-enc.zip>`_
-  zlib :
   ` http://www.hdfgroup.org/ftp/lib-external/zlib/1.2/bin/windows/zlib123-vnet.zip <http://www.hdfgroup.org/ftp/lib-external/zlib/1.2/bin/windows/zlib123-vnet.zip>`_
-  HDF :
   ` http://www.hdfgroup.org/ftp/HDF5/current/bin/windows/hdf5\_183\_xp32\_vs2008\_ivf101.zip <http://www.hdfgroup.org/ftp/HDF5/current/bin/windows/hdf5_183_xp32_vs2008_ivf101.zip>`_

Linux
~~~~~

::

    $ virtualenv $HOME/virtualenv
    $ uname -o -p
    i686 GNU/Linux
    $ gcc --version
    gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-44)
    Copyright (C) 2006 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    $ wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.3.tar.gz
    $ tar xzf hdf5-1.8.3.tar.gz
    $ cd hdf5-1.8.3
    $ ./configure --prefix=$HOME/virtualenv
    $ make
    $ make install
    $ export LD_LIBRARY_PATH=$HOME/virtualenv/lib
    $ . $HOME/virtualenv/bin/activate
    $ easy_install tables

Attachments
~~~~~~~~~~~

-  `MeasurementToolSep09.png </ome/attachment/wiki/OmeroTables/MeasurementToolSep09.png>`_
   `|Download| </ome/raw-attachment/wiki/OmeroTables/MeasurementToolSep09.png>`_
   (513.8 KB) - added by *jmoore* `3
   years </ome/timeline?from=2009-09-17T08%3A04%3A34%2B01%3A00&precision=second>`_
   ago. Prototype of table results in Insight
-  `MeasurementListSep09.png </ome/attachment/wiki/OmeroTables/MeasurementListSep09.png>`_
   `|image4| </ome/raw-attachment/wiki/OmeroTables/MeasurementListSep09.png>`_
   (455.0 KB) - added by *jmoore* `3
   years </ome/timeline?from=2009-09-17T08%3A39%3A43%2B01%3A00&precision=second>`_
   ago. Choice between multiple measurements

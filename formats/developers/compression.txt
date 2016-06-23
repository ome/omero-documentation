File compression
================

This section provides an analysis of several file formats (including 
:doc:`OME-XML </ome-xml/index>` and :doc:`OME-TIFF </ome-tiff/index>`) and 
compression techniques.

The figures regarding various storage formats were computed from the :ref:`tubhiswt_samples` before the current schema version. Thus, the byte counts between the downloadable ZIP files and the "zipped OME-TIFF" entry do not precisely match.  The table below also lists the space
requirements for each dataset with various formats and compression
types.


+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+
| Dataset                                                     | `tubhiswt-2D.zip`_    | `tubhiswt-3D.zip`_      | `tubhiswt-4D.zip`_       |
+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+
| Download Size                                               | 238,344 bytes         | 4,502,202 bytes         | 106,787,266 bytes        |
+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+
| **Size (raw pixels only)**                                  | 524,288 bytes         | 10,485,760 bytes        | 225,443,840 bytes        |
+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+
| **Size (OME-XML)**                                          | 314,346 bytes         | 5,964,603 bytes         | 142,498,355 bytes        |
+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+
| **Size (gzipped OME-XML)**                                  | 236,708 bytes         | 4,511,329 bytes         | 107,788,464 bytes        |
+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+
| **Size (zipped OME-XML)**                                   | 236,836 bytes         | 4,511,457 bytes         | 107,788,592 bytes        |
+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+
| **Size (7-zipped OME-XML)**                                 | 239,052 bytes         | 4,551,263 bytes         | 108,708,700 bytes        |
+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+
| **Size (OME-TIFF)**                                         | 531,384 bytes         | 10,499,384 bytes        | 225,874,680 bytes        |
+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+
| **Size (OME-TIFF with LZW)**                                | 273,190 bytes         | 4,998,148 bytes         | 118,517,497 bytes        |
+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+
| **Size (zipped OME-TIFF)**                                  | 235,764 bytes         | 4,446,727 bytes         | 105,389,599 bytes        |
+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+
| **Size (zipped OME-TIFF with LZW)**                         | 264,875 bytes         | 4,937,246 bytes         | 116,418,287 bytes        |
+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+
| **Size (7-zipped OME-TIFF)**                                | 209,593 bytes         | 3,891,846 bytes         | 93,939,055 bytes         |
+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+
| **Size (7-zipped OME-TIFF with LZW)**                       | 264,292 bytes         | 4,950,897 bytes         | 116,567,097 bytes        |
+-------------------------------------------------------------+-----------------------+-------------------------+--------------------------+

.. _tubhiswt-2D.zip: http://downloads.openmicroscopy.org/images/OME-TIFF/2016-06/tubhiswt-2D.zip
.. _tubhiswt-3D.zip: http://downloads.openmicroscopy.org/images/OME-TIFF/2016-06/tubhiswt-3D.zip
.. _tubhiswt-4D.zip: http://downloads.openmicroscopy.org/images/OME-TIFF/2016-06/tubhiswt-4D.zip


Efficiency of planar access
---------------------------

The following table compiles our results with average plane size
computed from the numbers above, and briefly summarizes each format's
ability to efficiently access individual image planes. We have not
performed benchmarks involving individual planar access for each
format—mostly because for many of these formats (especially zip, gzip
and 7-zip) it is quite impractical to attempt efficient access to
individual planes.

+---------------------------+----------------------------+-----------------------------------------------------------------------+
| **Format**                | **Average plane size**     | **Efficiency of access to individual planes**                         |
+---------------------------+----------------------------+-----------------------------------------------------------------------+
| Raw pixels only           | Worst – 262,144 bytes      | Best – Pixels can be ripped directly from disk.                       |
+---------------------------+----------------------------+-----------------------------------------------------------------------+
| OME-TIFF                  | Worst – 262,645 bytes      | Great – IFDs identify planar offsets.                                 |
+---------------------------+----------------------------+-----------------------------------------------------------------------+
| OME-TIFF+LZW              | Good – 137,238 bytes       | Good – The plane must be decoded from LZW, but IFDs identify planar   |
|                           |                            | offsets. With clever threading, each plane can be decoded while the   |
|                           |                            | next is being read from disk.                                         |
+---------------------------+----------------------------+-----------------------------------------------------------------------+
| OME-XML                   | Poor – 164,942 bytes       | Good – The plane must be decoded from base64, but the BinData Length  |
|                           |                            | attributes can be used to derive offsets without scanning the entire  |
|                           |                            | file. With clever threading, each plane can be decoded while the next |
|                           |                            | is being read from disk.                                              |
+---------------------------+----------------------------+-----------------------------------------------------------------------+
| OME-TIFF, 7-zipped        | Best – 108,692 bytes       | Poor – The appropriate OME-TIFF file must be uncompressed from the    |
|                           |                            | archive.                                                              |
+---------------------------+----------------------------+-----------------------------------------------------------------------+
| OME-TIFF, zipped          | Great – 122,031 bytes      | Poor – The appropriate OME-TIFF file must be uncompressed from the    |
|                           |                            | archive.                                                              |
+---------------------------+----------------------------+-----------------------------------------------------------------------+
| OME-TIFF+LZW, zipped      | Good – 134,834 bytes       | Poor – The appropriate OME-TIFF file must be uncompressed from the    |
|                           |                            | archive, and the plane must be decoded from LZW.                      |
+---------------------------+----------------------------+-----------------------------------------------------------------------+
| OME-TIFF+LZW, 7-zipped    | Good – 135,014 bytes       | Poor – The appropriate OME-TIFF file must be uncompressed from the    |
|                           |                            | archive, and the plane must be decoded from LZW.                      |
+---------------------------+----------------------------+-----------------------------------------------------------------------+
| OME-XML, gzipped          | Great – 124,763 bytes      | Worst – Entire dataset must be uncompressed, then the plane must be   |
|                           |                            | decoded from base64.                                                  |
+---------------------------+----------------------------+-----------------------------------------------------------------------+
| OME-XML, zipped           | Great – 124,764 bytes      | Worst – Entire dataset must be uncompressed, then the plane must be   |
|                           |                            | decoded from base64.                                                  |
+---------------------------+----------------------------+-----------------------------------------------------------------------+
| OME-XML, 7-zipped         | Great – 125,830 bytes      | Worst – Entire dataset must be uncompressed, then the plane must be   |
|                           |                            | decoded from base64.                                                  |
+---------------------------+----------------------------+-----------------------------------------------------------------------+

The performance penalty for accessing individual image planes from
externally compressed formats (zip, gzip, and 7-zip) is high, since the
data must be decompressed. There is little penalty for accessing them
from uncompressed OME-XML or OME-TIFF—with OME-XML, file readers can
build a list of offsets by skipping past the bulk of the BinData
characters according to the Length attribute values, and with OME-TIFF,
file readers can seek to the offsets indicated in the IFD entries.

Accessing them from an uncompressed OME-TIFF file, however, is
efficient. In addition, the TIFF format maintains compatibility with the
multitude of existing software that works with single- and multi-page
TIFF files.

Space required on disk
----------------------

As shown in the table above, and the chart :ref:`figure-tiff-chart`, our 
figures indicate that the most efficient format for space is OME-TIFF 
compressed with the `7-zip <http://www.7-zip.org/>`_ utility. Also good are 
gzipped OME-XML and zipped OME-TIFF.

.. _figure-tiff-chart:

.. figure:: /images/ome-tiff-chart.png
   :align: center
   :alt: OME-TIFF space used

   OME-TIFF space used

Uncompressed OME-TIFF format, while the least space-efficient, provides
its own advantages: it is highly compatible and provides efficient
access to individual image planes.

OME-TIFF with LZW often performs nearly as well as the externally
compressed formats (zip, gzip and 7-zip), without the performance
penalty of searching through a compressed archive. However, LZW is
noticeably less efficient to decode than uncompressed TIFF is, and LZW
is an additional requirement for client software—it may be that some
software supports uncompressed multi-page TIFF, but not LZW. Even more
unfortunate, the 7-zip algorithm appears to perform less well on
LZW-compressed OME-TIFFs than on uncompressed OME-TIFFs.

Recommendations
---------------

In conclusion, we highlight the following formats as most useful,
depending on your circumstances:

-  **Zipped OME-TIFF** – cuts down on file size while retaining the
   underlying compatibility of OME-TIFF. Use zipped OME-TIFF for wide
   distribution of data to colleagues. Zip is a ubiquitous compression
   format, decodable on all major operating systems. The downside is
   that it typically does not compress as well as 7-zip does.
-  **7-zipped OME-TIFF** – minimizes file size. As the most
   space-efficient format, use 7-zipped OME-TIFF for archival purposes,
   for transport from one OME database to another, and possibly for
   online distribution if space is a major concern and your target
   audience is computer-savvy enough to install 7-zip. The only
   downsides are that 7-zip is less ubiquitous than zip, and compressing
   a dataset with 7-zip takes longer than doing so with zip.
-  **OME-TIFF with LZW** – provides space advantages nearly as good as
   the externally compressed formats (zip, gzip, 7-zip) without
   sacrificing the accessibility of TIFF, for the most part. The
   downsides are that LZW takes somewhat longer to process than
   uncompressed TIFF, some software does not support LZW compression,
   and OME-TIFF with LZW does not shrink as much as uncompressed
   OME-TIFF does with external compression techniques.
-  **OME-TIFF** – maximizes compatibility. When actively working with
   data, storing it in uncompressed OME-TIFF format provides many
   options for efficient analysis and visualization. The downside is
   that the data takes up more space on disk.
-  **OME-XML** – provides metadata in a directly human-readable form. In
   addition, OME-XML maximizes compatibility with XML software. The
   downside is that very few image software packages support OME-XML.



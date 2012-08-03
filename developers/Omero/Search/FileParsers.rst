File Parsers
============

File parsers extract text from various file types and provide it as a
``Reader`` to the ``FullTextBridge`` for use during search indexing.
Plain text formats can use the default ``fileParser`` bean, but any
specialized format, such as PDF or RTF requires special libraries and
special registration.

Configuration
-------------

Currently, configuration takes places solely in
:source:` service-ome.api.Search.xml <components/server/resources/ome/services/service-ome.api.Search.xml>`.
Eventually, it should be able to replace file parsers at configuration
or even runtime.

Available parsers
-----------------

+-------------------+---------------------------------------------+
| **File type**     | **Parser**                                  |
+-------------------+---------------------------------------------+
| application/pdf   | ` http://pdfbox.org <http://pdfbox.org>`_   |
+-------------------+---------------------------------------------+
| text/xml          | (internal)                                  |
+-------------------+---------------------------------------------+
| text/plain        | (internal)                                  |
+-------------------+---------------------------------------------+
| text/csv          | (internal)                                  |
+-------------------+---------------------------------------------+

How to
------

For the necessary changes that need to be made, see r2260. The base
class for `FileParsers </ome/wiki/FileParsers>`_ are:
:source:` FileParser.java <components/server/src/ome/services/fulltext/FileParser.java>`

.. seealso:: :ref:`developers/Omero/Modules/Search`

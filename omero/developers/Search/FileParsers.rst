File parsers
============

File parsers extract text from various file types and provide it as a
``Reader`` to the ``FullTextBridge`` for use during search indexing.
Plain text formats can use the default ``fileParser`` bean, but any
specialized format, such as PDF or RTF requires special libraries and
special registration.

Configuration
-------------

Currently, configuration takes places solely in
:server_source:`service-ome.api.Search.xml <src/main/resources/ome/services/service-ome.api.Search.xml>`.
Eventually, it should be able to replace file parsers at configuration
or even runtime.

Available parsers
-----------------

+-------------------+---------------------------------------------+
| **File type**     | **Parser**                                  |
+-------------------+---------------------------------------------+
| application/pdf   | https://pdfbox.apache.org                   |
+-------------------+---------------------------------------------+
| text/xml          | (internal)                                  |
+-------------------+---------------------------------------------+
| text/plain        | (internal)                                  |
+-------------------+---------------------------------------------+
| text/csv          | (internal)                                  |
+-------------------+---------------------------------------------+


The base class for File parsers are
:server_source:`FileParser.java <src/main/java/ome/services/fulltext/FileParser.java>`

.. seealso:: :doc:`/developers/Modules/Search`

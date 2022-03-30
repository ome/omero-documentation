OMERO search
============

OMERO.server uses `Lucene <https://lucene.apache.org>`_ to index all string and
timestamp information in the database, as well as all ``OriginalFile`` which
can be parsed to simple text (see :doc:`/developers/Search/FileParsers` for
more information). The index is stored under :file:`/OMERO/FullText` or the
:file:`FullText` subdirectory of your :property:`omero.data.dir`, and can be
searched with Google-like queries.

Once an entity is indexed, it is possible to start writing querying
against the server via ``IQuery.findAllByFullText()``. Use
``new Parameters(new Filter().owner())`` and ``.group()`` to restrict
your search. Or alternatively use the ``ome.api.Search`` interface
(below).

.. seealso::
  :doc:`/sysadmins/search`
    Section of the sysadmin documentation describing the configuration of the
    search and indexing for the server.

Field names
-----------

Each row in the database becomes a single Lucene ``Document`` parsed
into the several ``Fields``. A field is referenced by prefixing a search
term with the field name followed by a colon. For example,
`name:myImage` searches for myImage anywhere in the name field.

.. csv-table::
    :widths: 20 80
    :header-rows: 1
    :file: searchfieldnames.tsv
    :delim: tab

Queries
-------

Search queries are very similar to Google searches. When search terms
are entered without a prefix ("name:"), then the default field will be
used which combines all available fields. Otherwise, a prefix can be
added to restrict the search. The search terms will be by default parsed as if there was "OR" operator
between them (see example in the "Indexing" paragraph). 
Further, tokenizing happens on all non-alphanumerical signs, such as underscore, 
hyphen etc. Again, when the term is tokenized, 
the default parsing of the tokens is with "OR" operator between the tokens. 
The search terms or the tokens created from them as above 
must precisely match the indexed entries. 
This means for example that a search term `tes` 
is **not** matching the indexed entry `test` and the search 
will accordingly give no result. 

Indexing
--------

Successful searching depends on understanding how the text is indexed.
The default analyzer used is :server_source:`the
FullTextAnalyzer <src/main/java/ome/services/fulltext/FullTextAnalyzer.java>`.

::

      1. Desktop/image_GFP-H2B_1.dv  --->  "desktop", "image", "gfp", "h2b", "1", "dv"
      2. Desktop/image_GFP-H2B_2.dv  --->  "desktop", "image", "gfp", "h2b", "2", "dv
      3. Desktop/image_GFP_01-H2B.dv --->  "desktop", "image", "gfp", "01", "h2b", "dv"
      4. Desktop/image_GFP-CSFV_a.dv --->  "desktop", "image", "gfp", "csfv", "a", "dv"

Assuming these entries above for Image.name:

-  searching for **GFP-H2B** returns 1, 2, 3 and 4, because of the tokenizing on the hyphen and joining of the tokens by an **OR**. This behavior is changed by adding wildcards or quotations, see below.
-  searching for **"GFP H2B"** only returns 1 and 2, since the quotes enforce the exact sequence of the terms.
-  searching for **GFP H2B** returns 1, 2, 3 and 4, since the two terms
   are joined by an **OR**.
-  searching for **"GFP-H2B"** returns 1 and 2.

With the same entries as above and adding a wildcard:

-  searching for **"GF\*"** returns no results.
-  searching for **GF\*** returns 1, 2, 3 and 4.
-  searching for **"GFP-\*"** returns 1, 2, 3 and 4.
-  searching for **GFP-\*** returns no results. 
-  searching for **\*FP-H2B** returns no results.
-  searching for **"\*FP-H2B"** returns no results.

Information for developers
--------------------------

ome.api.IQuery
^^^^^^^^^^^^^^

The current IQuery implementation restricts searches to a single class
at a time.

-  ``findAllByFullText(Image.class, "metaphase")`` -- Images which
   contain or are annotated with "metaphase"
-  ``findAllByFullText(Image.class, "annotation:metaphase")`` -- Images
   which are annotated with "metaphase"
-  ``findAllByFullText(Image.class, "tag:metaphase")`` -- Images which
   are tagged with "metaphase" (specialization of the previous)
-  ``findAllByFullText(Image.class, "file.contents:metaphase")`` --
   Images which have files attached containing "metaphase"
-  ``findAllByFullText(OriginalFile.class, "file.contents:metaphase")``
   -- File containing "metaphase"

ome.api.Search
^^^^^^^^^^^^^^

The Search API offers a number of different queries along with various
filters and settings which are all maintained on the server.

The matrix below show which combinations of parameters and queries are
supported (S), will throw an exception (X), and which will simply silently be
ignored (I).

.. list-table::
  :header-rows: 1

  - * Query Method -->
    * byGroupForTags/byTagsForGroup
    * byFullText/SomeMustNone
    * byAnnotatedWith

  - * **Parameters**
    *
    *
    *

  - * annotated between
    * S
    * S
    * S

  - * annotated by
    * S
    * S
    * S

  - * annotated by
    * S
    * I
    * I

  - * created between
    * S
    * I
    * I

  - * modified between
    * S
    * I (Immutable)
    * S

  - * owned by
    * S
    * S
    * S

  - * all types
    * X
    * I
    * X

  - * 1 type
    * S
    * I
    * S

  - * N types
    * X
    * I
    * X

  - * only ids
    * S
    * I
    * S

  - * **Ordering / Fetches**
    *
    *
    *

  - * orderBy
    * S
    * I
    * S

  - * fetchAnnotations
    * [1]_
    * I
    * [2]_

  - * **Other**
    *
    *
    *

  - * setProjections [3]_
    * X
    * X
    * X

  - * current\*Metdata [4]_
    * X
    * X
    * X


.. rubric:: Footnotes

.. [1] Any fetchAnnotation() argument to byFullText() or related queries,
   returns **all** annotations.
.. [2] byAnnotatedWith() does not accept a fetchAnnotation() argument of
   ``Annotation.class``.
.. [3] setProjects may need to be removed if Lucene cannot handle OMERO's
   security requirements.
.. [4] Not yet implemented.

Leading wildcard searches
^^^^^^^^^^^^^^^^^^^^^^^^^

Leading wildcard searches are disallowed by default. "?omething" or
"\*hatever", for example, would both throw exceptions. They can be run by
using:

::

      Search search = serviceFactory.createSearchService();
      search.setAllowLeadingWildcards(true);

There is a performance penalty, however. In addition,
wildcard searches get expanded on the server to boolean queries. For
example, assuming "ACELL", "BCELL", and "CCELL" are all terms in your
index, then the query:

::

      *CELL

gets expanded to:

::

      ACELL OR BCELL OR CCELL

If there are too many terms in the expansion then an exception will be
thrown. This requires the user to enter a more refined search, but not
because there are too many results, only because there is not enough
room in memory to search on all terms at once.

Extension points
^^^^^^^^^^^^^^^^

Two extension points are currently available for searching. The first
are the :doc:`/developers/Search/FileParsers` mentioned above. By
configuring the map of Formats (roughly mime-types) of files to parser
instances, extracting information from attached binary files can be made
quick and straightforward.

Similarly, :doc:`/developers/Modules/Search/Bridges` provide a mechanism
for parsing all metadata entering the system. One built in bridge (the
:server_source:`FullTextBridge <src/main/java/ome/services/fulltext/FullTextBridge.java>`)
parses out the fields mentioned above, but by creating your own bridge
it is possible to extract more information specific to your site.

.. seealso::
    :doc:`/developers/Model/StructuredAnnotations`,
    :doc:`/developers/Modules/Search/Bridges`,
    :doc:`/developers/Search/FileParsers`,
    `Query Parser Syntax <https://lucene.apache.org/core/3_6_0/queryparsersyntax.html>`_,

    `Luke <https://code.google.com/archive/p/luke/>`_
        a Java application which you can download and point at your ``/OMERO/FullText`` directory to get a better feeling for Lucene queries.

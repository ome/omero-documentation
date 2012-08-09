CamelCase
=========

New words created by smashing together capitalized words.

`CamelCase </ome/wiki/CamelCase>`_ is the original wiki convention for
creating hyperlinks, with the additional requirement that the capitals
are followed by a lower-case letter; hence “AlabamA” and “ABc” will not
be links.

Customizing the Wiki behavior
-----------------------------

Some people dislike linking by `CamelCase </ome/wiki/CamelCase>`_. While
Trac remains faithful to the original Wiki style, it provides a number
of ways to accomodate users with different preferences:

-  There's an option (``ignore_missing_pages`` in the
   `[wiki] </ome/wiki/TracIni#wiki-section>`_ section of
   `TracIni </ome/wiki/TracIni>`_) to simply ignore links to missing
   pages when the link is written using the
   `CamelCase </ome/wiki/CamelCase>`_ style, instead of that word being
   replaced by a gray link followed by a question mark.
    That can be useful when `CamelCase </ome/wiki/CamelCase>`_ style is
   used to name code artifacts like class names and there's no
   corresponding page for them.
-  There's an option (``split_page_names`` in the
   `[wiki] </ome/wiki/TracIni#wiki-section>`_ section of
   `TracIni </ome/wiki/TracIni>`_) to automatically insert space
   characters between the words of a `CamelCase </ome/wiki/CamelCase>`_
   link when rendering the link.
-  Creation of explicit Wiki links is also easy, see
   `WikiPageNames </ome/wiki/WikiPageNames>`_ for details.
-  In addition, Wiki formatting can be disabled completely in some
   places (e.g. when rendering commit log messages). See
   ``wiki_format_messages`` in the
   `[changeset] </ome/wiki/TracIni#changeset-section>`_ section of
   `TracIni </ome/wiki/TracIni>`_.

See `TracIni </ome/wiki/TracIni>`_ for more information on the available
options.

More information on CamelCase
-----------------------------

-  ` http://c2.com/cgi/wiki?WikiCase <http://c2.com/cgi/wiki?WikiCase>`_
-  ` http://en.wikipedia.org/wiki/CamelCase <http://en.wikipedia.org/wiki/CamelCase>`_

--------------

See also: `WikiPageNames </ome/wiki/WikiPageNames>`_,
`WikiNewPage </ome/wiki/WikiNewPage>`_,
`WikiFormatting </ome/wiki/WikiFormatting>`_,
`TracWiki </ome/wiki/TracWiki>`_

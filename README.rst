Documentation files to be linked under the ``docs/sphinx`` directory of
http://github.com/openmicroscopy/openmicroscopy.


***************************
Getting started with Sphinx
***************************

Sphinx depends on the ``sphinx-build`` Python script. As such, it can be
installed on any system with a working Python installation and PIP. On
Windows, make sure that the ``Scripts`` directory under the Python
installation directory (e.g. ``C:\Python26\Scripts``) is configured in your
PATH. On OS X/Linux, ``sphinx-build`` has to be accessible from the command
line.

The Sphinx documentation system can be obtained by issuing::
    
    pip install Sphinx
    
The structure of the documentation folder follows the Sphinx system
guidelines. A quick overview:
 
* source \*.txt files with reST markup live in the root of the folder and
  under subfolders,
* compiled output is placed in ``_build``,
* compiled visual themes are automatically placed in ``_static``,
* Sphinx configuration is held in ``conf.py``,
* goals for ``make`` and ``make.bat`` are held in ``Makefile``.
 
A reference of reStructuredText (reST) is available at
`http://thomas-cokelaer.info <http://thomas-cokelaer.info/tutorials/sphinx/rest_syntax.html>`_.
It is recommended to familiarise oneself with the syntax outlined there.

A tutorial covering Sphinx, which enhances working with reST documents, can be
found at `http://sphinx.pocoo.org <http://sphinx.pocoo.org/tutorial.html>`_.

Building the documentation
==========================

To clean the build directory of any previous builds, use::
    
    make clean
    
To build the documentation locally in the form of HTML pages, use::
    
    make html
    
To check the links (internal and external) of the documentation, use::
    
    make linkcheck
    
To list all targets of the sphinx builder, use::
    
    make
    
The output should look something like::
    
    Please use `make <target>' where <target> is one of
      html       to make standalone HTML files
      dirhtml    to make HTML files named index.html in directories
      singlehtml to make a single large HTML file
      pickle     to make pickle files
      json       to make JSON files
      htmlhelp   to make HTML files and a HTML help project
      qthelp     to make HTML files and a qthelp project
      devhelp    to make HTML files and a Devhelp project
      epub       to make an epub
      latex      to make LaTeX files, you can set PAPER=a4 or PAPER=letter
      latexpdf   to make LaTeX files and run them through pdflatex
      text       to make text files
      man        to make manual pages
      texinfo    to make Texinfo files
      info       to make Texinfo files and run them through makeinfo
      gettext    to make PO message catalogs
      changes    to make an overview of all changed/added/deprecated items
      linkcheck  to check all external links for integrity
      doctest    to run all doctests embedded in the documentation (if
                 enabled)
    
    
****************
Conventions used
****************

Part of the conventions used here is based on work by
`Benoît Bryon <https://github.com/benoitbryon/documentation-style-guide-sphinx>`_.

File names
==========

reST source file names should carry the ``txt`` suffix and use lowercase
alphanumeric characters and the ``-`` (minus) symbol.

Indentation
===========

Most reST directives don't need indentation, unless contents or options have
to be supplied. For consistency, please use 4 space indentation whenever
needed. Do not use indentation for the start of directives (start them at the
edge of the new line). Any content under a reST directive has to be indented
the same way as the options.

Example::
    
    .. toctree::
        :maxdepth: 2
        
        Some content here...
    
Line wrapping
=============

reST source files should use 78 lines for wrapping text. Please consult the
manual of your favourite text editor to see how to switch on text wrapping.

Blank lines
===========

Two new lines should be put before top-lined, top-level section names, i.e.
before H1 and H2. One new line in any other case.

Example::
    
    ###############
    Part title (H1)
    ###############
    
    Introduction text.
    (blank)
    (blank)
    ******************
    Chapter title (H2)
    ******************
    
Title headings
==============

Every reST source file should begin with an H2 (level two) title. H1 titles
are reserved for the index files (``index.txt``).

Titles should be capitalised (see `http://grammar.about.com <http://grammar.about.com/od/grammarfaq/f/capitalstitle.htm>`_
for a discussion about capitalisation styles).

The following symbols should be used to create headings:
 
* ``#`` with top line for parts
* ``*`` with top line for chapters
* ``=`` for sections
* ``-`` for subsections
* ``^`` for subsubsections
* ``"`` for paragraphs
 
Example::
    
    ###############
    Part title (H1)
    ###############
    
    H1 only in indexes.
    
    
    ******************
    Chapter title (H2)
    ******************
    
    Sample file content.
    
    
    ********************
    Another chapter (H2)
    ********************
    
    Section title (H3)
    ==================
    
    Subsection title (H4)
    ---------------------
    
    Subsubsection title (H5)
    ^^^^^^^^^^^^^^^^^^^^^^^^
    
    Paragraph title (H6)
    """"""""""""""""""""
    
    And some text.
    
Page labels and references
==========================

Every reST document should start with a label that matches the path and name
of the document::
    
    .. _path/name-of-the-page:
    
    *****************
    Title of the page
    *****************
    
This label allows the page to be uniquely referenced in the rest of the
documentation. To do so, use the following syntax
``:ref: `path/name-of-the-page``` or ``:ref: `link to my page <path/name-of-the-page>```.

References to labels above tables and images are also encouraged. The
``:ref:`` Sphinx role is advised over standard reST links, as it works across
files and reference names are automatically generated (e.g. from caption of an
image).

Images vs. Figures
==================

reST allows for two types of image embedding: using the ``image`` and
``figure`` directive. It is recommended to use the latter, as legends and
captions can be added easier.

All images referenced in a reST document shall be placed in an ``images``
folder in the top-level directory of the documentation.

Please do not use relative (``../../../images/foo.jpg``) paths to refer to
images. Sphinx does a good job at creating paths, so one can use
``images/foo.jpg``

Substitutions, aliases and hyperlinks
=====================================

reST allows for using substitutions in cases where a piece of markup is used
more than once, e.g.::
    
    Please visit Python.org_
    
    ...
    
    .. _Python.org: http://python.org
    
If a hyperlink appears only once, please use anonymous, "one-off" hyperlinks
(two underscores)::
    
    `RFC 2396 <http://www.rfc-editor.org/rfc/rfc2396.txt>`__ and `RFC
    2732 <http://www.rfc-editor.org/rfc/rfc2732.txt>`__ together
    define the syntax of URIs.
    
Finally, please avoid using ``here`` as the hyperlink name, as in::
    
    (...) go `here <http://www.google.com>`_.
    
Common markups
==============

* Notes should be formatted using the note directive: ``.. note::``
* Definition lists can be created and cross-referenced using the glossary
  directive: ``.. glossary::``
* References to external documentation can be formatted using:
  ``.. seealso::``
* Menu selections should be marked using the appropriate role:
  ``:menuselection: `Start --> Programs```

Global substitution
-------------------

Some substitutions have been implemented using ``rst_epilog`` in ``conf.py``.
They can be used in all pages of the documentation.
    
==================  ================================
Name                Path
==================  ================================
\|OmeroPy\|         developers/Omero/Python
\|OmeroCpp\|        developers/Omero/Cpp
\|OmeroJava\|       developers/Omero/Java
\|OmeroMatlab\|     developers/Omero/Matlab
\|OmeroCli\|        developers/Omero/CommandLine
\|OmeroApi\|        developers/Omero/Modules/Api
\|OmeroWeb\|        developers/Omero/Web
\|OmeroClients\|    developers/Omero/GettingStarted
\|OmeroInsight\|    developers/Omero/Insight
\|OmeroGrid\|       developers/Omero/Grid
\|OmeroSessions\|   developers/Omero/Server/Sessions
\|OmeroModel\|      developers/Omero/Model
\|ExtendingOmero\|  developers/Server/ExtendingOmero
\|BlitzGateway\|    developers/Omero/Python/Gateway
==================  ================================
    
For the most up-to-date list, please consult ``conf.py`` (section
``rst_epilog``).

Common URLs
-----------

Some URLs are widely used across the OME documentation. Using the Sphinx
``extlinks`` extension, a dictionary of aliases to base URLs has been defined
for the following:
 
* Trac tickets: ``:ticket: `3442```, displayed as ``<a>#3442</a>``
* Snapshots: ``:snapshot: `omero/myzip.zip```
* Plone pages: ``:plone: `Downloads <support/omero4/downloads>```
* DOIs: ``:doi: `Dantas, et al., JCB <10.1083/jcb.201012093>```
* Github source code, e.g. ``:source: `etc/omero.properties```
* OME Forums: ``:forum: `viewforum.php?f=3```

For the most up-to-date list, please consult ``conf.py`` (section
``extlinks``).

Inclusion of content
--------------------

When a specific type of content (e.g. code snippet) repeats itself among many
pages, it is advised to store it in a seperate file without the default
``.txt`` extension. This file can then be later included using the
``literalinclude`` directive.
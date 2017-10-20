Documentation files to be linked under the ``docs/sphinx`` directory of
http://github.com/openmicroscopy/openmicroscopy.

.. image:: https://travis-ci.org/openmicroscopy/ome-documentation.png
   :target: http://travis-ci.org/openmicroscopy/ome-documentation

***************************
Getting Started With Sphinx
***************************

Initial setup
=============

Sphinx
------

Sphinx depends on the ``sphinx-build`` Python script. As such, it can be
installed on any system with a working Python installation and PIP. On
Windows, make sure that the ``Scripts`` directory under the Python
installation directory (e.g. ``C:\Python26\Scripts``) is configured in your
PATH. On OS X/Linux, ``sphinx-build`` has to be accessible from the command
line.

The Sphinx documentation system can be obtained by issuing::

    pip install Sphinx

Most Linux distributions will also provide it in a python-sphinx package
(or similar).

Ant
---
You will also need ant for building the documentation. This can be installed
on Mac OSX by using homebrew::

    brew install ant


Structure and organization
==========================

The OME documentation is organized into multiple folders:

* the OMERO documentation is under the ``omero`` folder,
* the OME Contributing Developer documentation is under the ``contributing`` 
  folder,
* the shared configuration and themes are under the ``common`` folder.

The structure of each documentation folder follows the Sphinx system
guidelines. A quick overview:
 
* source \*.rst files with reST markup live in the root of the folder and
  under subfolders,
* images/screenshots are placed under ``images``,
* downloadable files are placed under ``downloads``,
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

The documentation may be built with ``make`` or ``ant``.  Note that ``ant``
requires ``ant-contrib`` to be on the classpath.

Basic build commands
--------------------

To build a set of documentation, first move to the documentation folder. To
build the OMERO documentation::

    cd omero/

or to build the Contributing Developer documentation::

   cd contributing/

To clean the build directory of any previous builds, use one of::
    
    make clean
    ant clean
    
To build the documentation locally in the form of HTML pages, use one of::
    
    make html
    ant html
    
To check the links (internal and external) of the documentation, use one of::
    
    make linkcheck
    ant linkcheck
    
By default, ``make`` will build the documentation locally in the form of HTML pages.


Top-level build command
-----------------------

The top-level directory Makefile also defines targets for building both the
OMERO and Contributing sets of documentation at once.

To clean the build directories of any previous builds, use one of::

    make clean
    ant clean

To build the sets of documentation locally in the form of HTML pages, use one of::

    make html
    ant html

By default, running ``make`` will build the documentation locally in the form of HTML pages.

Makefile options
----------------

Additional options for sphinx-build can be passed using the ``SPHINXOPTS``
variable. The ``-W`` option turns all warnings into errors::

    SPHINXOPTS=-W make clean html
    SPHINXOPTS=-W ant clean html

Release number
--------------

The release number of the OMERO documentation is `UNKNOWN` by default.
To modify this value set the environment variable ``OMERO_RELEASE`` e.g.::

    cd omero && OMERO_RELEASE=5.2.6 make clean html
    cd omero && OMERO_RELEASE=5.2.6 ant clean html

The Contributing Developer documentation has the release version removed as
the intention is to update these files as and when necessary, so that they
always reflect our current practices.

Zip bundles
-----------

To build the documentation as a zipped bundle, use::

    ant zip

By default, running ``ant`` will build as a zipped bundle.

From the top level directory::

    ant zip -Domero.release="5.3.0"

will generate the HTML documentation for OMERO and Contributing and bundle
just the OMERO documentation into an OMERO.doc-5.3.0.zip under omero/_build.

From omero directory::

    ant zip -Domero.release="5.3.0"

will generate the HTML documentation for OMERO and create an
OMERO.doc-5.3.0.zip under omero/_build.

From the contributing directory::

    ant zip -Domero.release="5.3.0"

will generate the HTML documentation for Contributing and create a
CONTRIBUTING.doc-5.3.0.zip under contributing/_build.

Auto-generated content
----------------------

Some parts of the OMERO documentation are auto-generated from the OMERO
deliverables (e.g. templates, command-line output...). This auto-generation is
usually done via Continuous Integration builds. To generate these components
manually, download the OMERO.server and run the auto-generation script as::

      WORSKSPACE=/path/to/OMERO/deliverables ./omero/autogen_docs

****************
Conventions Used
****************

Part of the conventions used here is based on work by
`Benoît Bryon <https://github.com/benoitbryon/documentation-style-guide-sphinx>`_.

File names
==========

reST source file names should carry the ``rst`` suffix and use lowercase
alphanumeric characters and the ``-`` (minus) symbol.

Indentation
===========

Most reST directives do not need indentation, unless contents or options have
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
are reserved for the index files (``index.rst``).

The following symbols should be used to create headings:
 
* ``#`` with top line for parts
* ``*`` with top line for chapters
* ``=`` for sections
* ``-`` for subsections
* ``^`` for subsubsections
* ``"`` for paragraphs
 
Example::
    
    ###############
    Part Title (H1)
    ###############
    
    H1 only in indexes.
    
    
    ******************
    Chapter Title (H2)
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

Every page can be uniquely referenced using the sphinx doc directive. Like
other directives, you can use the absolute file path, i.e. relative to the
top-level directory:
``:doc: `/path/name-of-the-page``` or ``:doc: `link to my page </path/name-of-the-page>```.

Only when a good reason exists, a document can also start with a label::
    
    .. _page-label:
    
    
    Title Of The Page
    =================

Use of labels to refer to whole files is discouraged. References to labels
above tables and images are encouraged. The ``:ref:`` Sphinx role is advised
over standard reST links, as it works across files and reference names are
automatically generated (e.g. from caption of an image).

Images vs. figures
==================

reST allows for two types of image embedding: using the ``image`` and
``figure`` directive. It is recommended to use the latter, as legends and
captions can be added easier.

All images referenced in a reST document shall be placed in an ``images``
folder in the top-level directory of the documentation.

Please do not use relative (``../../../images/foo.jpg``) paths to refer to
images. Sphinx does a good job at creating paths, so one can use
``/images/foo.jpg``

Tables
======

Please do not use tables for collections of links and figures, and leave them
solely for use as actual tables. While it can be used in HTML to shoehorn
content into boxes, it does not work too well for other output.

Big tables (typically wider than 50 characters) should be managed as external
files using the comma-separated values (CSV) format. These tables can then be
included in the documentation with the ``csv-table`` directive. If tables are
saved using the tab-separated values (TSV) format use the ``delim`` option to
set the table delimiter to `tab` e.g.::

    .. csv-table::
        :widths: 20 80
        :header-rows: 1
        :file: searchfieldnames.tsv
        :delim: tab


Substitutions, aliases and hyperlinks
=====================================

reST allows for using substitutions in cases where a piece of markup is used
more than once, e.g.::
    
    Please visit Python.org_
    
    ...
    
    .. _Python.org: http://www.python.org
    
If a hyperlink appears only once, please use anonymous, "one-off" hyperlinks
(two underscores)::
    
    `RFC 2396 <http://www.rfc-editor.org/rfc/rfc2396.txt>`__ and `RFC
    2732 <http://www.rfc-editor.org/rfc/rfc2732.txt>`__ together
    define the syntax of URIs.
    
Finally, please avoid using ``here`` as the hyperlink name, as in::
    
    (...) go `here <http://www.google.com>`_.
    
    
Common markups
==============

Please try to follow the rules outlined in
`Inline Markup <http://sphinx-doc.org/markup/inline.html>`_. This allows for
improving the semantics of the document elements.

* Notes should be formatted using the note directive: ``.. note::``
* Definition lists can be created and cross-referenced using the glossary
  directive: ``.. glossary::``. Each definition can be referenced anywhere in
  the documentation using the ``:term:`` role and an entry will be added for
  every term in the generated index.
* References to external documentation can be formatted using:
  ``.. seealso::``
* Menu selections should be marked using the appropriate role:
  ``:menuselection: `Start --> Programs```
* Environment variables should be formatted using the ``:envvar:`` role.
  This  role will add an entry for the variable in the generated index.
* CLI Commands can be formatted using the following role:
  ``:omerocmd: `admin start```
  This role will render as ``omero admin start`` and add an entry for
  the command in the generated index.
* Other commands should be formatted using the literal markup:
  ``:literal: `command``` or double back quoted markup
* Configuration properties for OMERO.server and OMERO.web are marked using
  the custom ``property`` directive and can be cross referenced e.g. using
  ``:property: `omero.data.dir```
* Other useful inline markups include: ``:option:`` and ``:guilabel:``
* Do not use inline highlighting or other markups in headings or subheadings

Global substitutions
====================

Some substitutions have been implemented using ``rst_epilog`` in ``conf.py``.
They can be used in all pages of the documentation.

Hyperlinks
----------

The table below lists targets for common hyperlinks.

=========================== ==============================================
Target name                 Link
=========================== ==============================================
Python                      http://www.python.org
Matplotlib                  http://matplotlib.org/
Pillow                      http://pillow.readthedocs.org
Hibernate                   http://www.hibernate.org
ZeroC                       https://zeroc.com
Ice                         https://zeroc.com
Jenkins                     http://jenkins-ci.org
roadmap                     https://trac.openmicroscopy.org/ome/roadmap
Open Microscopy Environment https://www.openmicroscopy.org
Glencoe Software, Inc.      https://www.glencoesoftware.com/
PyPI                        https://pypi.python.org
=========================== ==============================================

Abbreviations
-------------

The table below lists substitutions for common abbreviations. These
substitutions use the ``:abbr:`` Sphinx role meaning they are shown as
tool-tip in HTML.

======= ============= ======================
Name    Abbreviation  Explanation
======= ============= ======================
\|SSH\| SSH           Secure Shell
\|VM\|  VM            Virtual Machine
\|OS\|  OS            Operating System
\|SSL\| SSL           Secure Socket Layer
\|HDD\| HDD           Hard Disk Drive
\|CLI\| CLI           Command Line Interface
======= ============= ======================

OMERO page references
---------------------

The table below lists substitutions that can be used to create references to 
sections of the OMERO documentation.

==================  ===========================
Name                Path
==================  ===========================
\|OmeroPy\|         developers/Python
\|OmeroCpp\|        developers/Cpp
\|OmeroJava\|       developers/Java
\|OmeroMatlab\|     developers/Matlab
\|OmeroApi\|        developers/Modules/Api
\|OmeroWeb\|        developers/Web
\|OmeroClients\|    developers/GettingStarted
\|OmeroGrid\|       sysadmins/grid
\|OmeroSessions\|   developers/Server/Sessions
\|OmeroModel\|      developers/Model
\|ExtendingOmero\|  developers/ExtendingOmero
\|BlitzGateway\|    developers/Python
==================  ===========================

For the most up-to-date list, please consult ``conf.py`` (section
``rst_epilog``).

Common URLs
===========

Some URLs are widely used across the OME documentation. Using the Sphinx
``extlinks`` extension, a dictionary of aliases to base URLs has been defined
for the following:
 
* Trac tickets: ``:ticket: `3442```, displayed as ``<a>#3442</a>``
* Snapshots: ``:snapshot: `omero/myzip.zip```
* Website pages: ``:omero: `OMERO <>```
* OME Forums: ``:forum: `viewforum.php?f=3```
* Downloads: ``:downloads: `OMERO downloads <>```

For the most up-to-date list, please consult ``conf.py`` (section
``extlinks``). Note that there are separate ``conf.py`` files for each set of
documentation, as well as a shared one under ``common/``.

Source code links
=================

Links to the OMERO source code hosted on Github can be created using the
``source`` alias for single files, e.g. ``:source: `etc/grid/default.xml``` or
the ``sourcedir`` alias for directories, e.g. ``:sourcedir: `etc```.

By default, these links will point at the code under the ``develop`` branch or
https://github.com/openmicroscopy/openmicroscopy. To specify a specific fork
and/or  branch, set the SOURCE_USER and SOURCE_BRANCH environment variables,
e.g.::

    SOURCE_USER=sbesson SOURCE_BRANCH=my_branch make clean html
    SOURCE_USER=sbesson SOURCE_BRANCH=my_branch ant clean html

Jenkins links
=============

Links to the continuous integration server can be created using the 
``jenkins`` alias for the main server, e.g. ``:jenkins: `Jenkins server <>```,
the ``jenkinsjob`` alias for a given job, e.g. ``:jenkinsjob: `OMERO-4.4``` or
the ``jenkinsview`` alias for a given view, e.g. ``:jenkinsview: `4.4```.

Mailing-list links
==================

Links to the OME mailing lists can be created using the ``mailinglist`` alias,
e.g. ``:mailinglist:`ome-users/```. To point at specific discussion threads,
two aliases have been defined ``ome-users`` and ``ome-devel``, e.g.
``:ome-users:`ome-users thread <2009-June/001839.html>```.

Inclusion of content
====================

When a specific type of content (e.g. code snippet) repeats itself among many
pages, it is advised to store it in a separate file without the default
``.txt`` extension. This file can then be later included using the
``literalinclude`` directive.

*******************
Writing Conventions
*******************

* Do not use contractions (can't, isn't, I'll, etc.) or '&' in the
  documentation.
* All H1 and H2 level headings should have a capital letter at the start of
  each word.
* All sub-headings (H3 +) should begin with a capital letter for the first
  word and
  continue in lowercase, except where they refer to terms which are
  abbreviated in the text e.g. Virtual Machine.
* Use the full product name, e.g. OMERO.insight instead of Insight.
* Avoid using resp. in brackets to refer to alternative file names etc. Just
  use 'or'.
* Use full words rather than symbols in headings if possible.
* When giving instructions, address the user as 'you' and try to maintain a
  professional
  attitude - i.e. no random asides about making coffee or smilies!
* Bullet point lists should begin with a capital letter and end with a full
  stop if each point is a complete sentence, or more than one sentence. If
  not, no punctuation is necessary
  (see http://oxforddictionaries.com/words/bullet-points).
* Note that if you are giving an example link which is phrased like a
  hyperlink but not formatted as one because it does not actually exist, you
  need to prepend it with a '\\' to escape the
  link and stop the link-checker from reporting it as broken (e.g.
  ``\http://your_host/webclient/login/``), unless you use the literal mark-up.


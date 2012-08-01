Documentation files to be linked under
the docs/sphinx directory of

    http://github.com/openmicroscopy/openmicroscopy


# Getting started with Sphinx #

On OS X, the Sphinx documentation system can be obtained by:

	$ pip install Sphinx

That installs the sphinx-build command used during the documentation build process. The structure of the documentation folder follows the guidelines outlined by the Sphinx system documentation. A quick overview:

 * source reStructuredText (RST) markup lives in the root of the folder,
 * compiled output is placed in `_build`,
 * visual themes can be placed in `_static`,
 * Sphinx configuration is held in `conf.py`,
 * goals for `make` and `make.bat` are held in `Makefile`.

## Build ##

To build the documentation locally in the form of HTML pages, use:

	$ make html

To check the links (internal and external) of the documentation, use:

	$ make linkcheck
	
To list all targets of the sphinx builder, use:

	$ make
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
	  doctest    to run all doctests embedded in the documentation (if enabled)
	
# Conventions used #

A reference of reStructuredText is available at [http://thomas-cokelaer.info](http://thomas-cokelaer.info/tutorials/sphinx/rest_syntax.html). It is recommended to familiarise oneself with the syntax outlined there.

## Title headings ##

Every `.rst` file should begin with a title. The convention applied here follow Sphinx general rules:

 * `#` with overline, for parts
 * `*` with overline, for chapters
 * `=`, for sections
 * `-`, for subsections
 * `^`, for subsubsections
 * `"`, for paragraphs

Titles should be capitalized (see [here](http://grammar.about.com/od/grammarfaq/f/capitalstitle.htm) for a discussion about capitalization styles).

## Images vs. Captions ##

RST allows for two types of image embedding: using the `image` and `figure` directive. If no caption is needed for an image, use the former.

## Indentation ##

Most RST directives don't need indentation, unless arguments have to be supplied. For consistency, please use 4 space indentation whenever possible.


## Substitutions, aliases and hyperlinks ##

RST allows for using substitutions in cases where a piece of markup is used more than once, e.g.

	Please visit Python.org_
	
	...
	
	.. _Python.org: http://python.org
	
If a hyperlink appears only once, please use anonymous, "one-off" hyperlinks (two underscores):

	`RFC 2396 <http://www.rfc-editor.org/rfc/rfc2396.txt>`__ and `RFC
	2732 <http://www.rfc-editor.org/rfc/rfc2732.txt>`__ together
	define the syntax of URIs.

### Page labels and references ###

Every RST document should start with a label that matches the name of the document:

    .. _rst_name_of_the page:
    
    Title of the page
    =================

This label allows the page to be referenced in the rest of the documentation. To do so, use the following syntax ``:ref:`rst_name_of_the_page` `` or `` :ref:`link to my page <rst_name_of_the_page>` ``.

## Common markups ##


* Notes should be formatted using the note directive: `` .. note::``
* Definition lists can be created and cross-referenced using the glossary directive: `` .. glossary::``
* References to external documentation can be formatted using : `` .. seealso::``
* Menu selections should be marked using the menuselection role: `` :menuselection:`Start --> Programs` ``

### Common URLs ###

Some URLs are widely used across the OME documentation. Using the sphinx extlinks extension, a dictionary of aliases to base URLs has been defined for the following:

* Wiki sections: `` :wiki:`Section/Page` ``
* Trac tickets: `` :ticket:`3442` ``, displayed as <a>#3442</a>
* Snapshots: `` :snapshot:`omero/myzip.zip` ``
* Plone pages: `` :plone:`Downloads <support/omero4/downloads>` ``
* DOIs: `` :doi:`Dantas, et al., JCB <10.1083/jcb.201012093>` ``
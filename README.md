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

To build the documentation locally in the form of HTML pages, use:

	$ make html

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
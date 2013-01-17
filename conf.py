# -*- coding: utf-8 -*-
#
# ome documentation build configuration file, created by
# sphinx-quickstart on Wed Feb 22 20:24:38 2012.
#
# This file is execfile()d with the current directory set to its containing dir.
#
# Note that not all possible configuration values are present in this
# autogenerated file.
#
# All configuration values have a default; values that are commented out
# serve to show the default.

import datetime
import sys, os
import re

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#sys.path.insert(0, os.path.abspath('.'))

# -- General configuration -----------------------------------------------------

# If your documentation needs a minimal Sphinx version, state it here.
#needs_sphinx = '1.0'

# Add any Sphinx extension module names here, as strings. They can be extensions
# coming with Sphinx (named 'sphinx.ext.*') or your custom ones.)
extensions = ['sphinx.ext.extlinks']

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# The suffix of source filenames.
source_suffix = '.txt'

# The encoding of source files.
#source_encoding = 'utf-8-sig'

# The master toctree document.
master_doc = 'index'

# General information about the project.
project = u'OMERO'
title = project + u' Documentation'
author = u'The Open Microscopy Environment'
copyright = u'2000-%d, ' % datetime.datetime.now().year + author

# The version info for the project you're documenting, acts as replacement for
# |version| and |release|, also used in various other places throughout the
# built documents.
#

if "OMERO_RELEASE" in os.environ:
    release = os.environ.get('OMERO_RELEASE')
    split_release =  re.split("^([0-9]\.[0-9])(\.[0-9]+)(.*?)$",release)
    # The short X.Y version.
    version = split_release[1]
    previousversion = version[:-1] + str(int(version[-1])-1)
    if not release[-1] == "0":
        tags.add('point_release')
else:
    version = 'UNKNOWN'
    previousversion = 'UNKNOWN'
    release = 'UNKNOWN'

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
#language = None

# There are two options for replacing |today|: either, you set today to some
# non-false value, then it is used:
#today = ''
# Else, today_fmt is used as the format for a strftime call.
#today_fmt = '%B %d, %Y'

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
exclude_patterns = ['_build', 'formats' ]

# The reST default role (used for this markup: `text`) to use for all documents.
#default_role = None

# If true, '()' will be appended to :func: etc. cross-reference text.
#add_function_parentheses = True

# If true, the current module name will be prepended to all description
# unit titles (such as .. function::).
#add_module_names = True

# If true, sectionauthor and moduleauthor directives will be shown in the
# output. They are ignored by default.
#show_authors = False

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'sphinx'

# A list of ignored prefixes for module index sorting.
#modindex_common_prefix = []

# Variables used to define Github extlinks
if "SOURCE_BRANCH" in os.environ:
    branch = os.environ.get('SOURCE_BRANCH')
else:
    branch = 'develop'

if "SOURCE_USER" in os.environ:
    user = os.environ.get('SOURCE_USER')
else:
    user = 'openmicroscopy'

github_root = 'https://github.com/'
omero_github_root = github_root + user + '/openmicroscopy/'
doc_github_root = github_root + user + '/ome-documentation/'

# Variables used to define Jenkins extlinks
if "JENKINS_JOB" in os.environ:
    jenkins_job = os.environ.get('JENKINS_JOB')
else:
    jenkins_job = 'OMERO-trunk'

jenkins_root = 'http://hudson.openmicroscopy.org.uk'
jenkins_job_root = jenkins_root + '/job'
jenkins_view_root = jenkins_root + '/view'
omero_job_root = jenkins_job_root + '/' + jenkins_job

# Variables used to define other extlinks
cvs_root = 'http://cvs.openmicroscopy.org.uk'
trac_root = 'http://trac.openmicroscopy.org.uk/ome'
oo_root = 'http://www.openmicroscopy.org'
oo_site_root = oo_root + '/site'
lists_root = 'http://lists.openmicroscopy.org.uk'

extlinks = {
    # Trac links
    'ticket' : (trac_root + '/ticket/%s', '#'),
    'milestone' : (trac_root + '/milestone/%s', ''),
    'report' : (trac_root + '/report/%s', ''),
    # Github links
    'source' : (omero_github_root + 'blob/'+ branch + '/%s', ''),
    'sourcedir' : (omero_github_root + 'tree/'+ branch + '/%s', ''),
    'omedocs' : (doc_github_root + '%s', ''),
    # Jenkins links
    'jenkins' : (jenkins_root + '/%s', ''),
    'jenkinsjob' : (jenkins_job_root + '/%s', ''),
    'jenkinsview' : (jenkins_view_root + '/%s', ''),
    'omerojob' : (omero_job_root + '/%s', ''),
    'javadoc' : (omero_job_root + '/javadoc/%s', ''),
    # Mailing list/forum links
    'mailinglist' : (lists_root + '/mailman/listinfo/%s', ''),
    'ome-users' : (lists_root + '/pipermail/ome-users/%s' ,''),
    'ome-devel' : (lists_root + '/pipermail/ome-devel/%s' ,''),
    'forum' : (oo_root + '/community/%s', ''),
    # Plone links. Separating them out so that we can add prefixes and
    # suffixes during testing.
    'community_plone' : (oo_site_root + '/community/%s', ''),
    'feature_plone' : (oo_site_root + '/products/feature-list/%s', ''),
    'formats_plone' : (oo_site_root + '/support/file-formats/%s', ''),
    'legacy_plone' : (oo_site_root + '/support/legacy/%s', ''),
    'about_plone' : (oo_site_root + '/about/%s', ''),
    'team_plone' : (oo_site_root + '/team/%s', ''),
    'faq_plone' : (oo_site_root + '/support/faq/%s', ''),
    'training_plone' : (oo_site_root + '/support/training/%s', ''),
    'omero_plone' : (oo_site_root + '/products/omero/%s/', ''),
    'bf_plone' : (oo_site_root + 'site/products/bio-formats/%s/', ''),
    'bf_doc' : (oo_site_root + '/support/bio-formats/%s', ''),
    # Miscellaneous links
    'snapshot' : (cvs_root + '/snapshots/%s', ''),
    'zeroc' : ('http://zeroc.com/%s', ''),
    'doi' : ('http://dx.doi.org/%s', ''),
    }

rst_epilog = """
.. _Hibernate: http://www.hibernate.org
.. _ZeroC: http://www.zeroc.com
.. _Ice: http://www.zeroc.com
.. _Jenkins: http://jenkins-ci.org
.. _roadmap: https://trac.openmicroscopy.org.uk/ome/roadmap
.. _Open Microscopy Environment: http://www.openmicroscopy.org/site
.. _Glencoe Software, Inc.: http://www.glencoesoftware.com/
.. _Python Imaging Library: http://www.pythonware.com/products/pil/
.. _Matplotlib: http://matplotlib.org/
.. _Python: http://python.org
.. _Libjpeg: http://libjpeg.sourceforge.net/

.. |SSH| replace:: :abbr:`SSH (Secure Shell)`
.. |VM| replace:: :abbr:`VM (Virtual Machine)`
.. |OS| replace:: :abbr:`OS (Operating System)`
.. |SSL| replace:: :abbr:`SSL (Secure Socket Layer)`
.. |HDD| replace:: :abbr:`HDD (Hard Disk Drive)`
.. |CLI| replace:: :abbr:`CLI (Command Line Interface)`

.. |OME| replace:: `Open Microscopy Environment`_
.. |Glencoe| replace:: `Glencoe Software, Inc.`_
.. |OmeroPy| replace:: :doc:`/developers/Python`
.. |OmeroCpp| replace:: :doc:`/developers/Cpp`
.. |OmeroJava| replace:: :doc:`/developers/Java`
.. |OmeroMatlab| replace:: :doc:`/developers/Matlab`
.. |OmeroApi| replace:: :doc:`/developers/Modules/Api`
.. |OmeroWeb| replace:: :doc:`/developers/Web`
.. |OmeroClients| replace:: :doc:`/developers/GettingStarted`
.. |OmeroGrid| replace:: :doc:`/sysadmins/grid`
.. |OmeroSessions| replace:: :doc:`/developers/Server/Sessions`
.. |OmeroModel| replace:: :doc:`/developers/Model`
.. |ExtendingOmero| replace:: :doc:`/developers/Server/ExtendingOmero`
.. |BlitzGateway| replace:: :doc:`/developers/Python`
.. |DevelopingOmeroClients| replace:: :doc:`/developers/GettingStarted/AdvancedClientDevelopment`
"""
rst_epilog += """.. |previousversion| replace:: %s""" % previousversion

# -- Options for HTML output ---------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
html_theme = 'sphinxdoc'

# Theme options are theme-specific and customize the look and feel of a theme
# further.  For a list of options available for each theme, see the
# documentation.
#html_theme_options = {}

# Add any paths that contain custom themes here, relative to this directory.
html_theme_path = ['themes']

# The name for this set of Sphinx documents.  If None, it defaults to
# "<project> v<release> documentation".
#html_title = None

# A shorter title for the navigation bar.  Default is the same as html_title.
#html_short_title = None

# The name of an image file (relative to this directory) to place at the top
# of the sidebar.
#html_logo = None

# The name of an image file (within the static path) to use as favicon of the
# docs.  This file should be a Windows icon file (.ico) being 16x16 or 32x32
# pixels large.
#html_favicon = None

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

# If not '', a 'Last updated on:' timestamp is inserted at every page bottom,
# using the given strftime format.
html_last_updated_fmt = '%b %d, %Y'

# If true, SmartyPants will be used to convert quotes and dashes to
# typographically correct entities.
#html_use_smartypants = True

# Custom sidebar templates, maps document names to template names.
html_sidebars = { '**' : ['globalomerotoc.html', 'pagetoc.html',
'relations.html', 'searchbox.html', 'sourcelink.html'] }

# Additional templates that should be rendered to pages, maps page names to
# template names.
#html_additional_pages = {}

# If false, no module index is generated.
#html_domain_indices = True

# If false, no index is generated.
#html_use_index = True

# If true, the index is split into individual pages for each letter.
#html_split_index = False

# If true, links to the reST sources are added to the pages.
#html_show_sourcelink = True

# If true, "Created using Sphinx" is shown in the HTML footer. Default is True.
#html_show_sphinx = True

# If true, "(C) Copyright ..." is shown in the HTML footer. Default is True.
#html_show_copyright = True

# If true, an OpenSearch description file will be output, and all pages will
# contain a <link> tag referring to it.  The value of this option must be the
# base URL from which the finished HTML is served.
#html_use_opensearch = ''

# This is the file name suffix for HTML files (e.g. ".xhtml").
#html_file_suffix = None

# Output file base name for HTML help builder.
htmlhelp_basename = 'projstandardsdoc'


# -- Options for LaTeX output --------------------------------------------------

latex_elements = {
'classoptions': ',oneside',
'babel': '\\usepackage[english]{babel}',
'printindex': '\\phantomsection \
\\addcontentsline{toc}{part}{\indexname} \
\\printindex'
# The paper size ('letterpaper' or 'a4paper').
#'papersize': 'letterpaper',

# The font size ('10pt', '11pt' or '12pt').
#'pointsize': '10pt',

# Additional stuff for the LaTeX preamble.
#'preamble': '',
}

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title, author, documentclass [howto/manual]).
target = project + '-' + release + '.tex'
latex_documents = [
  (master_doc, target, title, author, 'manual'),
]

# The name of an image file (relative to this directory) to place at the top of
# the title page.
latex_logo = 'images/omero-logo.pdf'

# For "manual" documents, if this is true, then toplevel headings are parts,
# not chapters.
latex_use_parts = True

# If true, show page references after internal links.
#latex_show_pagerefs = False

# If true, show URL addresses after external links.
latex_show_urls = 'footnote'

# Documents to append as an appendix to all manuals.
#latex_appendices = []

# If false, no module index is generated.
#latex_domain_indices = True


# -- Options for manual page output --------------------------------------------

# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
man_pages = [
    (master_doc, 'OMERO', title, author, 1)
]

# If true, show URL addresses after external links.
#man_show_urls = False


# -- Options for Texinfo output ------------------------------------------------

# Grouping the document tree into Texinfo files. List of tuples
# (source start file, target name, title, author,
#  dir menu entry, description, category)
texinfo_documents = [
  (master_doc, project, title, author, 'omedocs', 'One line description of project.',
   'Miscellaneous'),
]

# Documents to append as an appendix to all manuals.
#texinfo_appendices = []

# If false, no module index is generated.
#texinfo_domain_indices = True

# How to display URL addresses: 'footnote', 'no', or 'inline'.
#texinfo_show_urls = 'footnote'

# -- Options for the linkcheck builder ----------------------------------------

# Timeout value, in seconds, for the linkcheck builder
if not (sys.version_info[0] == 2 and sys.version_info[1] <= 5):
    linkcheck_timeout = 30

# Regular expressions that match URIs that should not be checked when doing a linkcheck build
linkcheck_ignore = [r'http://localhost:\d+/?', 'http://localhost/', 'http://www.hibernate.org',
        r'^https?://www\.openmicroscopy\.org/site/team/.*', r'.*[.]?example\.com/.*',
        r'^https?://www\.openmicroscopy\.org/site/support/faq.*']

# -- Custom roles for the OMERO documentation -----------------------------------------------

from docutils import nodes
from sphinx import addnodes

def omero_command_role(typ, rawtext, etext, lineno, inliner,
                     options={}, content=[]):
    """Role for CLI commands that generates an index entry."""

    env = inliner.document.settings.env
    targetid = 'cmd-%s' % env.new_serialno('index')

    # Create index and target nodes
    indexnode = addnodes.index()
    targetnode = nodes.target('', '', ids=[targetid])
    inliner.document.note_explicit_target(targetnode)
    indexnode['entries'] = [('single', "; ".join(etext.split(" ")), targetid, '')]

    # Mark the text in bold face
    sn = nodes.strong(etext, etext)
    return [indexnode, targetnode, sn], []

def setup(app):
    app.add_role('omerocmd', omero_command_role)

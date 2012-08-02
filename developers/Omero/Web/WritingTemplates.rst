`|The base\_header.html template extended in webtest with dummy
content| </ome/attachment/wiki/OmeroWeb/WritingTemplates/webtest-base_header.png>`_

Writing Page Templates in OMERO.web
===================================

This page documents the various base templates that are used by the
webclient and describes how to extend these to create your own pages
with the OMERO.web look and feel.

Django templates
----------------

We use Django templates for the OMERO.web pages. See docs here:
` http://docs.djangoproject.com/en/dev/ref/templates/ <http://docs.djangoproject.com/en/dev/ref/templates/>`_.
We have designed a number of OMERO.web base templates that you can
extend. These live in the 'common' app under
omeroweb/common/templates/common/base. Here's a list of the templates
with more details below:

-  **base\_html.html**. This provides the base <html> template with
   blocks for 'link'(for css) 'title' 'script' and 'body'. It is
   extended by every other template. Usage:
   `` {% extends "common/base/base_html.html" %} ``
-  **base\_frame.html**. This adds jQuery and jQuery-ui libraries to a
   blank page. Used for popup windows etc. Usage:
   `` {% extends "common/base/base_frame.html" %} ``
-  **base\_header.html**. This also extends base\_html.html adding all
   the header and footer components that are used by the webclient. See
   screen-shot above. More details below.
-  **container2.html, container3.html**. These templates extend the
   base\_header.html template, adding a 2 or 3 column layout in the main
   body of the page. They are used by the webclient for many pages. See
   screen-shot below.

`|base/container3.html extended in webtest with dummy
content| </ome/attachment/wiki/OmeroWeb/WritingTemplates/webtest-container3.png>`_

Extending templates
-------------------

You should aim to create a small number of your own base templates,
extending the OMERO.web common or webclient templates as required. If
you extend all of your own pages from a small number of your own base
templates, then you will find it easier to change things in future. For
example, any changes in our 'common' templates will only require you to
edit your own base templates.

Extending base\_header.html & container3.html
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These templates are going to be your main points of extension if you
want pages to resemble the existing OMERO.web pages (webclient,
webadmin). If you want the 2 and 3 column layouts you can use the
container2.html and container3.html templates. These extend
base\_header.html and therefore also contain the various base\_header
blocks described here:

webtest examples
~~~~~~~~~~~~~~~~

You can find examples of how to extend the base templates in the webtest
application. Look under omeroweb/webtest/templates/webtest/common. If
you have access to a 4.4 OMERO.web, the webtest examples can be viewed
using the following link, updating the host and port as necessary:
` http://localhost:8000/webtest/common/base\_header/ <http://localhost:8000/webtest/common/base_header/>`_
(screen-shot above). This is a basic extension of base\_header.html and
contains links to all the other webtest examples. These pages indicate
the names of the various template "blocks" that have been used to add
content to different parts of the page (also see below for block names).

Content Blocks
--------------

These blocks can be used to add content to specific points in the page.
NB: It is important to consider using `` {{ block.super }} `` if you
want to include the content from the parent template. This is critical
for the "link" and "script" blocks, which are used to add <link> and
<script> elements to the head of the page. If you forget to use
`` {{ block.super }} `` then you will remove all the css and javascript
links required by the parent template.

base\_header.html
~~~~~~~~~~~~~~~~~

See omeroweb/common/templates/common/base/base\_header.html for full
template details

-  link: Used to add css with <link> blocks to the page head. E.g:

   ::

       {% block link %}
           {{ block.super }}
           <link rel="stylesheet" href="{% static "common/css/header.css" %}" type="text/css" />
       {% endblock %}

-  script: Used to add javascript with <script> blocks to the page head
-  title: Add text here for the page <title>. E.g:

   ::

       {% block title %}
           Page Title Here
       {% endblock %}

-  head: Another block for any extra head elements
-  logo: This block contains <div> and <img> elements to display "ome"
   logo. You don't need to use this unless you want to hide or change
   the logo.
-  util\_links: Text added to this block will appear in the far
   top-right of the page. E.g:

   ::

       {% block util_links %}
           <a href="help">Help</a>
       {% endblock %}

-  middle\_header\_right: Adds content to the right of the dark (middle)
   toolbar
-  middle\_header\_left: Adds content to the left of the dark (middle)
   toolbar
-  thin\_header\_right: Adds content to the right of the thin (lower)
   toolbar
-  thin\_header\_left: Adds content to the left of the thin (lower)
   toolbar
-  content: Main page content.
-  footer\_content: Add text to the footer
-  copywrite: Adds second line to footer. Use for OME copywrite.

container2.html, container3.html
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These templates have all the same blocks as base\_header.html since they
extent it (see above). In addition, they also add the following blocks:
(see omeroweb/common/templates/common/base/container3.html for full
template details)

-  left: The left column (NOT in container2.html)
-  center: The middle column
-  right: The right column

Section Blocks
--------------

All of the main sections of base\_header.html are contained within
corresponding blocks, allowing you to remove or replace whole sections.
E.g. to remove the footer in a page that extends base\_header.html,
simply add

::

    {% block footer %} {% endblock %}

NB: In some cases, removing sections may require you to tweak the
position or layout of other sections (see css below)

-  body: Corresponds to the page <body>
-  top\_header: Contains OME logo etc.
-  middle\_header: Darker colored toolbar.
-  thin\_header: Thinner, light tool bar.
-  footer: Page footer.

Webclient components
--------------------

The 'common' base templates do not contain any elements that require an
OMERO connection or any webclient functionality. If you want your
templates to display such features, you can either extend the webclient
base templates, E.g. base\_container.html or you can 'include' various
components, such as menus, group & user-choosers etc. These templates
and includes are in omeroweb/webclient/templates/base/.

-  webclient menu: To include links to the main webclient pages. E.g.
   add to the left of the middle header :

   ::

       {% block middle_header_left %}
           {% include "webclient/base/menu.html" %}
       {% endblock %}

-  webclient search: Adds a text field and "Go" button that takes you to
   the webclient seach page to display results. E.g. add to the right of
   the thin header:

   ::

       {% block thin_header_right %}
           {% include "webclient/base/search_field.html" %}
       {% endblock %}

-  Logout: Logs user out and redirects to webclient login (login will
   take you to the webclient home page). E.g.

   ::

       {% block util_links %}
           {% include "webclient/base/logout.html" %}
       {% endblock %}

-  etc...? scripts? change\_user/group? Need to test in webtest - these
   need context data.

Configuring tabs
----------------

Tweeking css
------------

Attachments
~~~~~~~~~~~

-  `webtest-base\_header.png </ome/attachment/wiki/OmeroWeb/WritingTemplates/webtest-base_header.png>`_
   `|Download| </ome/raw-attachment/wiki/OmeroWeb/WritingTemplates/webtest-base_header.png>`_
   (121.4 KB) - added by *wmoore* `7
   ago. The base\_header.html template extended in webtest with dummy
   content
-  `webtest-container3.png </ome/attachment/wiki/OmeroWeb/WritingTemplates/webtest-container3.png>`_
   `|image4| </ome/raw-attachment/wiki/OmeroWeb/WritingTemplates/webtest-container3.png>`_
   (125.5 KB) - added by *wmoore* `7
   ago. base/container3.html extended in webtest with dummy content
-  `webtest-header\_links.png </ome/attachment/wiki/OmeroWeb/WritingTemplates/webtest-header_links.png>`_
   `|image5| </ome/raw-attachment/wiki/OmeroWeb/WritingTemplates/webtest-header_links.png>`_
   (165.2 KB) - added by *wmoore* `7
   ago. Extending base\_header.html in webtest, removing a toolbar.

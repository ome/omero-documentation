.. _developers/Omero/Web:

OMERO.web Framework
===================

`|OmeroWeb infrastructure
components| </ome/attachment/wiki/OmeroWeb/OmeroWeb.png>`_

` MOVIE introduction to
OmeroWeb <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-3/mov/OmeroWebIntro-4.3.mov>`_

OMERO.web is a framework for building web applications for OMERO. It
uses ` Django <http://www.djangoproject.com/>`_ to generate html pages
from data retrieved from the OMERO server. OmeroWeb acts as a Python
client of the OMERO server using the OMERO API, as well as being a web
server itself (see 'infrastructure' info below). It uses Django 'apps'
to provide modular web tools, such as the webclient (working with image
data) and webadmin (administrator management). This modular framework
makes it possible to extend OmeroWeb with your own apps.

One of the apps, `webgateway </ome/wiki/OmeroWeb/WebGateway>`_, provides
utility methods for accessing data and rendering images, as well as
handling the connection to OMERO server.

OMERO.web infrastructure
------------------------

OMERO Python API
~~~~~~~~~~~~~~~~

The OMERO.web framework is all based on the OMERO Python API, using the
Blitz Gateway (see |OmeroPy|). The web framework
provides functionality for creating and retrieving connections to OMERO
(see example below &
`OmeroWeb/WritingViews </ome/wiki/OmeroWeb/WritingViews>`_ for more
details).

Web Gateway
~~~~~~~~~~~

The webgateway is a Django app that provides utility functionality for
the other web components. This includes a full image viewer, as well as
methods for rendering images etc. You can browse the ` webgateway
urls <http://hudson.openmicroscopy.org.uk/job/OMERO/javadoc/epydoc/omeroweb.webgateway.urls-module.html>`_,
or see the `OmeroWeb/WebGateway </ome/wiki/OmeroWeb/WebGateway>`_ wiki
page for more info.

Web Apps
~~~~~~~~

The OMERO.web framework consists of several Django apps denoted by
folders named 'web....'. These include webgateway & webtest, as
discussed above, as well as released tools (webadmin, webclient) and
other apps in development:

-  webclient: Main web client for viewing images, annotating etc. ` more
   info <https://www.openmicroscopy.org.uk/site/support/omero4/clients/web>`_
-  webadmin: For administration of user and group settings.
-  webgateway: A web services interface, providing rendered images and
   data. See `OmeroWeb/WebGateway </ome/wiki/OmeroWeb/WebGateway>`_
-  webtest: A sample app for testing, that can also be used as a basis
   for creating your own app.

Getting Started
---------------

All your development should be in a new 'app'. Django apps provide a
nice way for you to keep all your code in one place and make it much
easier to port your app to new OMERO releases or share it with other
users. To get started, see
`OmeroWeb/CreateApp </ome/wiki/OmeroWeb/CreateApp>`_. But if you want to
have a quick look at some example code, see below...

Quick Example - webtest
~~~~~~~~~~~~~~~~~~~~~~~

`|Screen-shot of the webtest/dataset/
example| </ome/attachment/wiki/OmeroWeb/webtest-dataset.png>`_

This tiny example gives you a feel for how the OMERO.web framework gets
data from OMERO and displays it on a web page. You can find this and
other examples in the 'webtest' app. Also see the ` OmeroWeb demo
movie <http://cvs.openmicroscopy.org.uk/snapshots/movies/omero-4-3/mov/OmeroWebIntro-4.3.mov>`_
**BUT note:** some details of this code have changed in the OMERO 4.4
release - see below).

There are 3 parts to each page: url, view and template. For example,
this code below is for generating an html page of a Dataset (see
screen-shot). If you have OMERO web running, you can view the page under
` http://serverName/webtest/dataset/ <http://serverName/webtest/dataset/>`_\ <datasetId>.

-  **Url**, goes in omeroweb/webtest/urls.py

This maps the url 'webtest/dataset/<datasetId>/' to the View function
'dataset', passing it the datasetId.

::

    url( r'^dataset/(?P<datasetId>[0-9]+)/$', views.dataset ),

-  **View** function, in omeroweb/webtest/views.py. NB: @login\_required
   decorator retrieves connection to OMERO as 'conn' passed in args to
   method. See
   `OmeroWeb/WritingViews </ome/wiki/OmeroWeb/WritingViews>`_ for more
   details.

   ::

       from omeroweb.webclient.decorators import login_required

       @login_required()    # wrapper handles login (or redirects to webclient login). Was @isUserConnected before OMERO 4.4
       def dataset(request, datasetId, conn=None, **kwargs):
           ds = conn.getObject("Dataset", datasetId)     # before OMERO 4.3 this was conn.getDataset(datasetId)
           return render_to_response('webtest/dataset.html', {'dataset': ds})    # generate html from template

-  **Template:** The template web page, in
   omeroweb/webtest/templates/webtest/dataset.html

   ::

       <html><body>

       <h1>{{ dataset.getName }}</h1>

       {% for i in dataset.listChildren %}
           <div style="float:left; padding:10px">
               <img src="{% url webgateway.views.render_thumbnail i.id %}" />
               <br />
               {{ i.getName }}
           </div>
       {% endfor %}

       </body></html>

-  Next: Get started by `Creating your own
   App </ome/wiki/OmeroWeb/CreateApp>`_....

Attachments
~~~~~~~~~~~

-  `OmeroWeb.png </ome/attachment/wiki/OmeroWeb/OmeroWeb.png>`_
   `|Download| </ome/raw-attachment/wiki/OmeroWeb/OmeroWeb.png>`_ (179.7
   KB) - added by *wmoore* `21
   months </ome/timeline?from=2010-11-18T12%3A45%3A03Z&precision=second>`_
   ago. `OmeroWeb </ome/wiki/OmeroWeb>`_ infrastructure components
-  `webtest-dataset.png </ome/attachment/wiki/OmeroWeb/webtest-dataset.png>`_
   `|image4| </ome/raw-attachment/wiki/OmeroWeb/webtest-dataset.png>`_
   (73.9 KB) - added by *wmoore* `14
   months </ome/timeline?from=2011-06-09T10%3A32%3A55%2B01%3A00&precision=second>`_
   ago. Screen-shot of the webtest/dataset/ example

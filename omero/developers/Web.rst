OMERO.web framework
===================

.. figure:: /images/OmeroWeb.png
  :align: center
  :alt: OmeroWeb infrastructure components


OMERO.web is a framework for building web applications for OMERO. It
uses `Django <https://www.djangoproject.com/>`_ to generate HTML and JSON
from data retrieved from the OMERO server. OMERO.web acts as a Python
client of the OMERO server using the OMERO API, as well as being a web
server itself (see 'infrastructure' info below). It uses Django 'apps'
to provide modular web tools, such as the webclient, webgateway and
the JSON api app. This modular framework
makes it possible to extend OMERO.web with your own apps.

Since version ``5.14.0``, ``OMERO.web`` requires an update of Django to ``3.2.x``.  Plugin developers should read the `Guide <https://github.com/ome/omero-web/blob/master/MIGRATION_TO_DJANGO_32_GUIDE.md>`_ detailing how to migrate their plugin(s) to Django 3.2.x.

OMERO.web infrastructure
------------------------

OMERO Python API
^^^^^^^^^^^^^^^^

The OMERO.web framework is all based on the OMERO Python API. Code-generated
omero.model objects communicate remotely with their counterparts on the
OMERO.server using `Ice from ZeroC <https://zeroc.com/products/ice>`_.

BlitzGateway
^^^^^^^^^^^^

The Blitz Gateway wraps omero.model objects to facilitate many loading
and update operations (see :doc:`/developers/PythonBlitzGateway`).

OMERO.web
^^^^^^^^^

The OMERO.web framework consists of several Django apps that are
included in the OMERO.server release, as well as others that can be installed
independently (see below).
It also includes utilities for creating and retrieving connections to OMERO
(see example below and :doc:`/developers/Web/WritingViews` for more details).

**Included apps**

-  **webclient:** Main web client for browsing, viewing and annotating images.
   More information available under :ref:`OMERO.web <omero-web>`.

-  **webgateway:** Provides rendered images and JSON data for other OMERO.web apps or
   for external applications hosted elsewhere.
   See :doc:`/developers/Web/WebGateway`.

-  **webadmin:** Tool for OMERO.server Administrators to manage users and groups.

-  **api:** New in 5.3.0, this provides a JSON API for OMERO. See :doc:`/developers/json-api`.

**Additional apps**

-  **omero-figure:** The `OMERO.figure <https://github.com/ome/omero-figure/>`_ app
   allows you to create scientific figures.

-  **omero-webtest:** `webtest <https://github.com/ome/omero-webtest/>`_
   is an example app that contains several code samples mentioned in
   the following pages.

-  **omero-iviewer:** The `OMERO.iviewer <https://github.com/ome/omero-iviewer>`_
   is a new (currently unreleased) image viewer that supports ROI creation and editing.

-  **webtagging:** The `webtagging <https://github.com/MicronOxford/webtagging>`_ app
   was developed externally by Douglas Russell. It supports 'auto' tagging based on
   image name and Tag-based filtering of data.

-  **omero-mapr:** The `OMERO.mapr <https://github.com/ome/omero-mapr/>`_ app
   is a new tool that allows browsing data through Map Annotations
   linked to images.

-  **omero-gallery:** `OMERO.gallery <https://github.com/ome/omero-gallery/>`_
   provides a simple interface for browsing Projects, Datasets and Images.

.. warning::
    Although it is possible to access functionality from any installed app,
    **ONLY webgateway** and **api** should be considered as a stable public API. URLs and methods
    within other web apps are purely designed to provide internal functionality for
    the app itself and may change in minor releases without warning.


Getting started
---------------

The preferred workflow for extending OMERO.web is to create a new Django app.
Django apps provide a nice way for you to keep all your code in one place and
make it much easier to port your app to new OMERO releases or share it with
other users. To get started, see :doc:`/developers/Web/CreateApp`. Further
documentation on editing the core OMERO.web code is at
:doc:`/developers/Web/EditingOmeroWeb`.
If you want to have a quick look at some example code, see below.

Quick example - OMERO.webtest
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. figure:: /images/webtest-dataset.png
  :align: center
  :alt: Screen-shot of the omero-webtest/dataset/example

This tiny example gives you a feel for how the OMERO.web framework gets data
from OMERO and displays it on a web page. You can find this and other examples
in the `OMERO.webtest <https://github.com/ome/omero-webtest/>`_
repository.

There are 3 parts to each page: url, view and template. For example, this code
below is for generating an HTML page of a Dataset (see screen-shot). If you
have OMERO.web running and webtest installed, you can view the page under
`http://`\ `<servername>/webtest/dataset/`\ `<datasetId>`.

-  **url** goes in omeroweb/omero_webtest/urls.py This maps the URL
   'webtest/dataset/<datasetId>/' to the View function
   'dataset', passing it the datasetId.

   ::

       url( r'^dataset/(?P<dataset_id>[0-9]+)/$', views.dataset, name="webtest_dataset" ),

-  **view** function, in omeroweb/omero_webtest/views.py. N.B.: @login\_required
   decorator retrieves connection to OMERO as 'conn' passed in args to
   method. See :doc:`/developers/Web/WritingViews` for more
   details.

   ::

       from omeroweb.webclient.decorators import login_required
       # handles login (or redirects)
       @login_required()
       def dataset(request, dataset_id, conn=None, **kwargs):
           ds = conn.getObject("Dataset", dataset_id)
           # generate html from template
           return render(request, 'webtest/dataset.html', {'dataset': ds})

-  **template:** The template web page, in
   omero-webtest/omero_webtest/templates/webtest/dataset.html

   ::

       <html><body>

       <h1>{{ dataset.getName }}</h1>

       {% for i in dataset.listChildren %}
           <div style="float:left; padding:10px">
               <img src="{% url 'webgateway.views.render_thumbnail' i.id %}" />
               <br />
               {{ i.getName }}
           </div>
       {% endfor %}

       </body></html>

-  Next: Get started by :doc:`/developers/Web/Deployment`....

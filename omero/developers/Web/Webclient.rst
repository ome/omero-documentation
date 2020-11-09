The OMERO.web client application
================================

The webclient Django app provides the main OMERO.web client UI.

Data is retrieved from OMERO using the :doc:`/developers/Python` and
is rendered to HTML using :djangodoc:`Django templates <topics/templates/>` before being
sent to the browser. Additional javascript (jQuery-based) functionality in the browser
is used to update the UI in response to user interactions such as 
browsing or modifying the data.
This will often involve AJAX calls to load more data as HTML or JSON objects.

.. note::
    The webclient should **NOT** be considered as a stable public API. URLs and methods
    within the app are purely designed to provide internal functionality for
    the webclient itself and may change in minor releases without warning.

Top level pages
---------------

There are a small number of top level HTML pages that the user will start at.
These are all handled by the load_template view:

- / (homepage delegates to /userdata)
- /userdata
- /usertags
- /public
- /history
- /search

These pages contain many different jQuery scripts that run when the page loads,
to setup event listeners and to load additional data.

Additional top-level pages are used in popup windows for running scripts and
downloading data.

JsTree
------

A jsTree is used by the userdata, usertags and public pages to browse hierarchical
data. Each time a node is expanded, it uses appropriate AJAX calls to load children as
json data.
Further POST or DELETE AJAX calls are made to modify the data hierachy by
creating or deleting links between objects.

Selection changes in the jsTree and centre panel thumbnails cause events to be
triggered by jQuery on the ``$("body")`` element of the page, allowing other scripts
to listen for these events.
These are used to load selected data into the centre and right panels.
The HTML for these panels contains additional scripts that also run when they load
to setup their own event listeners.

There is also a global ``update_thumbnails_panel`` function that can be called
by any script that needs to refresh the centre panel. For example, when the jsTree
is used to add or remove Images from a selected Dataset.

Switching Groups and Users
--------------------------

The current group and user are stored in
the :djangodoc:`HTTP session <topics/http/sessions/>`
as ``request.session['active_group']`` and ``request.session['user_id']``.
These are used to define the data that is loaded in the
main ``userdata`` and ``usertags`` pages.

The group and user are switched by the Groups and Users menu, which updates the
session and reloads the page.

Show queries
------------

Data in OMERO can be linked from the webclient with URLs of the form
``/webclient/?show=image-23|image-34``

In the load_template view, the first object is queried from OMERO and its parent
containers are also loaded. The owner and group of the top container is
used to set the ``active_group`` and ``user_id`` so that the main page loads
the appropriate data hierarchy.

The jsTree does its own lookup from the query string, retrieving json
data and using this to expand the appropriate nodes to show the
specified objects.


Javascript code
---------------

The majority of javascript code is jQuery-based code that is embedded within the
HTML templates and is run when the page loads.

Additional code is in static scripts, with functions generally name-spaced
under an ``OME`` module.


Reusing OMERO sessions
----------------------

In some situations you may wish to automatically log in to OMERO.web using
an existing session key that can be passed as a query parameters.
For example a direct link to image will look as follows::

    https://your_host/webgateway/img_detail/IMAGE_ID/?server=SERVER_ID&bsession=OMERO_SESSION_KEY

.. note::

    The `SERVER_ID` should match the index from the list set using
    :property:`omero.web.server_list` from the server session
    you created. If your list contains only one server, the index will be 1.

For more details about how to create an OMERO session see
:doc:`server-side session </developers/Server/Sessions>` or
use the :doc:`command line interface </users/cli/sessions>` to create one.

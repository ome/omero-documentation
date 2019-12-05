
Linking from Webclient
======================

If you want users to be able to access your app or other resources from the webclient
there are a number of ways you can add links to the webclient UI.

OMERO.web top links
-------------------

You can configure :property:`omero.web.ui.top_links` to add links to the list
of links at the top of the webclient main pages.

-  **Name your URL in urls.py** (optional). Preferably we use URL names to
   refer to URLs.
   For example, the homepage of your app might be named like this in organization-appname/urls.py.

   ::

       url(r'^$', views.index, name='figure_index'),


   You can then refer to the link defined above using this ``name``, or you can simply use a full URL for external links.


-  **Update configuration** Use the OMERO command line interface to append the link to the ``top_links`` list.

   Links use the format ``["Label", "URL_name"]`` or you can follow this example:

   ::

       $ omero config append omero.web.ui.top_links '["Figure", "figure_index"]'

   From OMERO 5.1, you can add additional attributes to links using the format ``['Link Text', 'link', attrs]``.
   This can be used to add tool-tips and to open the link in a new "target" tab. For example:

   ::

       $ omero config append omero.web.ui.top_links '["Homepage", "http://myhome.com", {"title": "Homepage", "target": "_blank"}]'


Custom image viewer
-------------------

If you have created your own image viewer and would like to have it replace the existing image viewer in the
webclient, this can be configured using :property:`omero.web.viewer.view`.

You will need your :file:`views.py` method to take an Image ID with a parameter named ``iid``. For example, see
``channel_overlay_viewer`` from `omero-webtest <https://github.com/openmicroscopy/omero-webtest/>`_ app:

::

    @login_required()
    def channel_overlay_viewer(request, iid, conn=None, **kwargs):

You can then configure the webclient to use this viewer by providing the full path name to this view method.
For example, if you have webtest installed you can use the ``channel_overlay_viewer``:

::

    $ omero config set omero.web.viewer.view webtest.views.channel_overlay_viewer

This will now direct the image viewer url at ``webclient/img_detail/<iid>/`` to this viewer.
However, the existing viewer will still be available under webgateway at ``webgateway/img_detail/<iid>/``.

If you want to use a different viewer for different images, you can conditionally redirect to
the webgateway viewer or elsewhere.
For example:

::

    if image.getSizeC() == 1:
        return HttpResponseRedirect(reverse("webgateway.views.full_viewer", args=(iid,)))


Open with
---------

The 'Open with' configuration allows users to 'open' data from OMERO in another web page
using :property:`omero.web.open_with`.

For example:

- Open images in a custom viewer
- Open images in a new figure with OMERO.figure
- Link to external resources, e.g. open Dataset named '000397' with url https://www.ncbi.nlm.nih.gov/protein/000397

Currently, 'Open With' options are shown in the context menu of the left-panel tree
and are therefore only available for objects shown in the tree.

Label, name and supported objects
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In the simplest case the minimum needed to add an ``Open with`` option is a
unique identifier for your extension, a
url name, and a list of the types of objects that are supported by your app.
For example:

::

    $ omero config append omero.web.open_with '["xyz_viewer", "url_name", {"supported_objects": ["image"]}]'

This will create a menu option named ``xyz_viewer`` that is only enabled when a
single "image" is selected.

The unique ID string,``xyz_viewer`` can be used to identify your plugin
if you add extra scripts, as shown below. If you want your ``Open with`` option
to appear under a different menu label, see "UI Label" section below.

We use ``reverse(url_name)`` to resolve a url from the url_name. If the url_name
is not recognised (for external urls) the ``url_name`` will be used directly.

When the ``xyz_viewer`` option is clicked, a new window will be opened with the
selected object(s) added to the url as a query string

::

    url?image=:imageId

Supported objects can be configured to support multiple images or other data types.
Data types are ``project, dataset, image, screen, plate, acquisition``
or use plurals to indicate that multiple objects are supported.
For example, ```images``` will enable the 'Open with' option when 1 or more images are selected.
In the following example, we support a single ``dataset`` or multiple ``images``.

::

    "supported_objects": ["dataset", "images"]

Further parameters can be specified in the options object, as described below.

Open in new tab
^^^^^^^^^^^^^^^

If you wish to open in a new browser tab instead of a popup window, you can add a ``target``
attribute to the options:

::

    $ omero config append omero.web.open_with '["xyz_viewer", "url_name", {"supported_objects": ["image"], "target": "_blank"}]'

UI Label
^^^^^^^^

If a "label" is specified in the options object, this will be used as the display label in the webclient context menu
instead of using the ID.

::

    $ omero config append omero.web.open_with '["xyz_viewer", "url_name"], {"supported_objects": ["image"], "label": "X-Y-Z viewer"}]'

JavaScript handlers
^^^^^^^^^^^^^^^^^^^

For more control over the enabled status of your plugin or to configure how urls
are created from selected objects, you can write JavaScript functions
that handle these steps.
These functions use the label specified above as an ID for your ``Open with``
option. In this example it is ``xyz_viewer``.
Add one or both of these function calls to a script, for example ``openwith.js``

::

    // Here we set an 'enabled' handler that is passed a list of selected
    // objects and should return ``true`` if the 'Open with' option should
    // be enabled.
    // The ``supported_objects`` parameter will not be needed.
    // First argument is the label that we used above to identify the option
    OME.setOpenWithEnabledHandler("xyz_viewer", function(selected){
        // selected is a list of objects containing id, name, type

        // Only support single objects
        if (selected.length !== 1) return false;

        // Only support image with name ending in .svs
        var obj = selected[0];
        return (obj.type === 'image' && obj.name.endsWith('.svs'))
    });

    // Here we configure a url provider. This function will be passed the selected
    // objects and the base url that was specified in the 'Open with' configuration above.
    OME.setOpenWithUrlProvider("xyz_viewer", function(selected, url) {

        // Build a url using id from selected objects
        url += selected[0].id + "/";
        return url;
    });

Save the script to a static location, either within an OMERO.web app's static directory
or make it available at another url.
Then specify this location using the ``script_url`` option.

.. note::

    Once you have added a script and updated the config, you will need to restart OMERO.web as normal.
    This will ``syncmedia`` to copy the script to the static files location.

::

    # Script is saved at myviewer/static/myviewer/openwith.js
    $ omero config append omero.web.open_with '["xyz_viewer", "url_name"], {"script_url": "myviewer/openwith.js"}]'

    # 'Open with' option loads a script from the specified url.
    # The script will open any object with url https://www.ncbi.nlm.nih.gov/protein/:name
    # and is enabled when the :name of the object is a number (all digits)
    $ omero config append omero.web.open_with '["GenBank Protein", "https://www.ncbi.nlm.nih.gov/protein/", {"script_url": "https://will-moore.github.io/presentations/2016/OpenWith-Filtering-June-2016/openwith.js"}]'


OMERO.web plugins
-----------------

If you want to display content from your app within the webclient UI, please see :doc:`/developers/Web/WebclientPlugin`.
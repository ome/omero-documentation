Webclient Plugins
=================

The webclient UI can be configured to include content from other web apps.
This allows you to extend the webclient UI with your own functionality.
This is used by the `webtagging app <https://github.com/MicronOxford/webtagging>`_
and there are also some examples in the  :omero_subs_github_repo_root:`omero-webtest <omero-webtest/>` repository.


Currently you can add content in the following locations:

-  **Center Panel** Adding a panel to the center of the webclient will display
   a drop-down menu to the top right of the center panel, allowing users to
   choose your plugin.

-  **Right Panel** You can add additional tabs to the right panel. These will
   be available in the main webclient page as well as history and search
   result pages.


Overview
--------

To begin with, you need to prepare your plugin pages in your own app, with
their own URLs, views and templates.
Then you can display these pages within the webclient UI, using the plugin
framework.

.. note::

    When you embed your pages in the webclient, there is potential for
    conflicts between JavaScript and CSS in the host page and your own code.
    Care must be taken not to overwrite global JavaScript functions (such as
    jQuery or the 'OME' namespace) or to add CSS codes that may affect
    host elements.

The webclient plugins work by adding some custom JavaScript snippets into the
main pages of the webclient and adding HTML elements to specified locations in
the webclient. These snippets of JavaScript can be used to load content into
these HTML elements. Usually you will want to do this dynamically, to display
data based on the currently selected objects (although this is optional).
Helpers can be used to respond to changes in the selected objects and the
selected tab, so you can load or refresh your plugin only when necessary.

App URLs
--------

To display content based on currently selected data, such as Projects,
Datasets and Images, your app pages will need to have these defined in their
URLs. For example:

::

    # Webtagging: Tag images within the selected dataset
    url(r'^auto_tag/dataset/(?P<datasetId>[0-9]+)/$', views.auto_tag),

    # Webtest: Show a panel of ROI thumbnails for an image
    url(r'^image_rois/(?P<imageId>[0-9]+)/', views.image_rois, name='webtest_image_rois'),

These URLs should simply display the content that you want to show in the
webclient. When these pages load in the webclient, they will have all the webclient
CSS and JavaScript (such as jQuery) available so you do not need to include
these in your page.


Configuring the plugin
----------------------

Choose an element ID
^^^^^^^^^^^^^^^^^^^^

You will need to specify an ID for the `<div>` element that is added to the
webclient, so that you can refer to this element in the JavaScript. For
example, ``image_roi_tab`` or ``auto_tag_panel``.

Create a JavaScript file
^^^^^^^^^^^^^^^^^^^^^^^^

This will contain the JavaScript snippet that is injected into the main
webclient page `<head>` when the page is generated. This is added using
Django's templates, so it should be placed within your app's
`/templates/<organization_appname>/` directory and named `.html`, e.g.
`/templates/<organization_appname>/webclient_plugins/right_plugin_rois.html`.
All the JavaScript should be within `<script>` and `</script>` tags.
Your plugin initialization should happen after the page has loaded, so you use
the jQuery on-ready function.

You use custom jQuery functions, called ``omeroweb_right_plugin`` or
``omeroweb_center_plugin``, to initialize the webclient plugin. These will
handle all the selection change events.
You simply need to specify how the panel is loaded, based on the selected
object(s) and what objects are supported. The plugin will be disabled when
non-supported objects are selected.

Below is a simple example of their usage. More detailed documentation
available in the :ref:`plugin options section <plugin-options-label>` below.


**Center Panel Plugin**

::

    <script>
    $(function() {

        // Initialise the center panel plugin, on our specified element
        $("#auto_tag_panel").omeroweb_center_plugin({

            // To support single item selection, we can specify the types like this.
            // Tab will only be enabled when a single dataset is selected
            supported_obj_types: ['dataset'],

            load_plugin_content: function(selected, dtype, oid){

                // since we currently limit our dtype to 'dataset', oid will be dataset ID
                // Use the 'index' of your app as base for your URL
                var auto_tag_url = '{% url 'webtagging_index' %}auto_tag/dataset/'+oid+'/';
                $(this).load(auto_tag_url);
            }
        });
    });
    </script>


**Right Tab Plugin**

::

    <script>
    $(function() {

       // Initialise the right tab plugin, on our specified tab element
       $("#image_roi_tab").omeroweb_right_plugin({

           // Tab will only be enabled when a single image is selected
           supported_obj_types: ['image'],

           // This will get called when tab is displayed or selected objects change
           load_plugin_content: function(selected, obj_dtype, obj_id) {

               // since we only support single images, the obj_id will be an image ID
               // Generate url based on a template-generated url
               var url = '{% url 'webtest_index' %}image_rois/' + obj_id + '/';

               // Simply load the tab
               $(this).load(url);
           },

       });

    });
    </script>

.. _plugin-installation-label:

Plugin installation
-------------------

Now you need to add your plugin to the appropriate plugin list, stating the
displayed name of the plugin, the ``path/to/js_snippet.html`` and the ``ID`` of the
plugin element. Plugin lists are:

- :property:`omero.web.ui.center_plugins`

- :property:`omero.web.ui.right_plugins`

Use the OMERO command line interface to add the plugin to the appropriate
list.

::

    $ omero config append omero.web.ui.center_plugins
        '["Auto Tag", "webtagging/auto_tag_init.js.html", "auto_tag_panel"]'

The right_plugins list includes the `Acquisition` tab and `Preview` tab by
default. If you want to append the OMERO.webtest ROI plugin or your own plugin
to the list, you can simply do:

::

    $ omero config append omero.web.ui.right_plugins
        '["ROIs", "omero_webtest/webclient_plugins/right_plugin.rois.js.html", "image_roi_tab"]'

If you want to replace existing plugins and display only your own single
plugin, you can simply do:

::

    $ omero config set omero.web.ui.right_plugins
        '[["ROIs", "omero_webtest/webclient_plugins/right_plugin.rois.js.html", "image_roi_tab"]]'


Restart Web
^^^^^^^^^^^

Stop and restart your web server, then refresh the webclient UI. You should
see your plugin appear in the webclient UI in the specified location. You
should only be able to select the plugin from the drop-down menu or tab **if**
the supported data type is selected, e.g. 'image'. When you select your
plugin, the load content method you specified above will be called and you
should see your plugin loaded.

Refreshing content
^^^^^^^^^^^^^^^^^^

If you now edit the :file:`views.py` or HTML template for your plugin and want
to refresh the plugin within the webclient, all you need to do is to select a
different object (e.g. dataset, image etc.). If you select an object that
is not supported by your plugin, then nothing will be displayed, and for the
right-tab plugin, the tab selection will change to the first tab.

.. _plugin-options-label:

Plugin options
--------------

-  **supported_obj_types**: If your plugin displays data from single objects,
   such as a single Image or Dataset, you can specify that here, using a list
   of types:

   ::

      supported_obj_types: ['dataset', 'image'],

   This will ensure that the plugin is only enabled when a single Dataset or
   Image is selected.
   To support multiple objects, see 'tab_enabled'.

-  **plugin_enabled**: This function allows you to specify whether a plugin is
   enabled or not when specified objects are selected. It is only used if you
   have NOT defined 'supported_obj_types'.
   The function is passed a single argument:

   -  selected: This is a list of the selected objects
      e.g. `[{'id':'image-123'}, {'id':'image-456'}]`

   The function should return true if the plugin should be enabled.
   For example, if you want the center plugin to support multiple images, or a
   single dataset:

   ::

      plugin_enabled: function(selected){
          if (selected.length == 0) return false;
          var dtype = selected[0]['id'].split('-')[0];
           if (selected.length > 1) {
              return (dtype == "image");
          } else {
              return ($.inArray(dtype, ["image", "dataset"]) > -1);
          }
      }

-  **load_plugin_content / load_tab_content**: This function will be called
   when the plugin/tab content needs to be refreshed, either because the
   plugin is displayed for the first time, or because the selected object
   changes. The function will be passed 3 arguments:

   -  selected: This is a list of the selected objects
      e.g. `[{'id':'image-123'}, {'id':'image-456'}]`

   -  obj_dtype: This is the data-type of the first selected object, e.g.
      'image'

   -  obj_id: This is the ID of the first selected object, e.g. 123

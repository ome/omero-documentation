WebGateway
==========

WebGateway is a Django app within the |OmeroWeb|. It provides a web API for
rendering images and accessing data on the OMERO server via URLs.

.. note::

    The OMERO.web client also supports URLs linking to specified data in
    OMERO. See the :help:`OMERO.web user guides <>` for more details.

Web services
------------

This list of URLs below may be incomplete or out of date. For a complete
list of URLs, see the :pythondoc:`latest
API <omeroweb/omeroweb.webgateway.html#module-omeroweb.webgateway.urls>`
and try the URLs out for yourself!

The HTTP request will need to include login details for creating or using a
current server connection. This will be true for any request made after
logging in to the server, e.g. login using the webclient login page
then go to ``webgateway/…`` or if you have logged in to a server at
``http://ome.example.com/webclient`` then go to, for example,
``http://ome.example.com/webgateway/render_image/<imageid>/<z>/<t>/``

.. figure:: /images/webgateway-thumbnail.jpg
  :align: center
  :alt: Rendered thumbnail

  Rendered thumbnail


.. _urls_from_within_OMERO_web:

URLs from within OMERO.web
^^^^^^^^^^^^^^^^^^^^^^^^^^

Images rendered within OMERO.web templates should use Django's ``{% url %}``
tag to generate URLs for webgateway, passing in the ID of the image. This is
shown for each of the URLs below:


Image viewer
""""""""""""

-   Provides a full image viewer, with controls for scrolling Z and T, editing
    rendering settings etc.

    ::
    
        URL: https://your_host/webgateway/img_detail/<imageid>/

        Template tag: {% url 'webgateway.views.full_viewer' image_id %}



Images
""""""

-  Returns a jpeg of the specified plane with current rendering settings

   ::

       URL: https://your_host/webgateway/render_image/<imageid>/<z>/<t>/

       Template tag: {% url 'webgateway.views.render_image' image_id theZ theT %}
       
   Omitting Z and T will use the default values:


   ::

       URL: https://your_host/webgateway/render_image/<imageid>/

       Template tag: {% url 'webgateway.views.render_image' image_id %}

-  Makes a jpeg laying out each active channel in a separate panel

   ::

       URL: https://your_host/webgateway/render_split_channel/<imageId>/<z>/<t>/

       Template tag: {% url 'webgateway.views.render_split_channel' image_id theZ theT %}

-  Plots the intensity of a row of pixels in an image. w is line width

   ::

       URL: https://your_host/webgateway/render_row_plot/<imageId>/<z>/<t>/<y>/<w>

       Template tag: {% url 'webgateway.views.render_row_plot' image_id theZ theT yPos width %}

-  Plots the intensity of a column of pixels in an image.

   ::

       URL: https://your_host/webgateway/render_col_plot/<imageId>/<z>/<t>/<x>/<w>/

       Template tag: {% url 'webgateway.views.render_col_plot' image_id theZ theT xPos width %}

-  Returns a jpeg of a thumbnail for an image. w and h are optional
   (default is 64). Specify just one to retain aspect ratio.
   It is also possible to specify Z and T indices in the query string.

   ::

       URL: https://your_host/webgateway/render_thumbnail/<imageId>/?z=10

       Template tag: {% url 'webgateway.views.render_thumbnail' image_id %}?z=10    # default size, z=10

       URL: https://your_host/webgateway/render_thumbnail/<imageId>/<w>/<h>

       Template tag: {% url 'webgateway.views.render_thumbnail' image_id 100 %}     # size 100


Rendering settings
""""""""""""""""""

If no rendering settings are specified (as above), then the current rendering
settings will be used. To apply different settings to images returned by the
``render_image`` and ``render_split_channels`` URLs, parameters can be
specified in the request. N.B. These settings are only applied to the rendered
image and will not be saved unless specified.

Individual parameters are:

-  **Channels on/off** e.g. for an image with 4 channels, to turn on all channels
   except 2:

   ::

       ?c=1,-2,3,4
       
       # You can simply specify the active channels.
       ?c=3         # only Channel 3 is active
       ?c=3,4       # Channels 3 and 4 are active

-  **Channel color** e.g. to set the colors for channels 1 to red and 2
   to green and 3 to blue:

   ::

       ?c=1|$FF0000,2|$00FF00,3|$0000FF

-  **Rendering levels** e.g. to set the cut-in and cut-out values for an image with 3 Channels.

   ::

       ?c=1|400:505,2|463:2409,3|620:3879
       ?c=-1|400:505,2|463:2409,3|620:3879      # First channel inactive "-1"
       ?c=2|463:2409,3|620:3879     # Inactive channels can be omitted

-  **Z-projection**: Maximum intensity, Mean intensity or None (normal). By
   default we use all z-sections, but a range can be specified.

   ::

       ?p=intmax
       ?p=intmax|0:10       # Use z-sections 0-10 inclusive
       ?p=intmean
       ?p=normal

-  **Rendering 'Mode'**: greyscale or color.

   ::

       ?m=g    # greyscale (only the first active channel will be shown in grey)
       ?m=c    # color

-  **Codomain maps**: OMERO's rendering engine supports mapping from input -> output
   pixel intensity via application of "codomain maps". Currently only the 'reverse'
   intensity map is supported, but the use of JSON encoding for the ``maps`` query
   parameter is designed to support more maps in future.
   In the case of the 'reverse' map, we only need to specify whether it is enabled
   for each channel. For an image with 2 channels, to enable ``reverse`` map for the
   first channel, we can use this query string:

   ::

       ?maps=[{"reverse":{"enabled":true}},{"reverse":{"enabled":false}}]

-  Parameters can be combined, e.g.

   ::

       https://your_host/webgateway/render_image/2602/10/0/?c=1|100:505$0000FF,2|463:2409$00FF00,3|620:3879$FF0000,-4|447:4136$FF0000&p=normal

JSON methods
""""""""""""

-  List of projects:
   ``webgateway/proj/list/``

   ::

       [{"description": "", "id": 269, "name": "Aurora"},
       {"description": "", "id": 269, "name": "Drugs"} ]

-  Project info: ``webgateway/proj/<projectId>/detail/``

   ::

       {"description": "", "type": "Project", "id": 269, "name": "CenpA"}

-  List of Datasets in a Project: ``webgateway/proj/<projectId>/children/``

   ::

       [{"child\_count": 9, "description": "", "type": "Dataset", "id": 270,
            "name": "Control"}, ]

-  Dataset, same as for Project: ``webgateway/dataset/<datasetId>/detail/``

-  Details of Images in the dataset:
   ``webgateway/dataset/<datasetId>/children/``

-  Lots of metadata for the image. See
   below: ``webgateway/imgData/<imageId>/``

-  **Histogram** of pixel intensity data for an image plane. Channel index is zero-based.
   By default the Z and T index are 0 and the number of histogram bins is 256, but these
   can be specified in the query string.
   The range of the histogram will be the pixel intensity range for that channel of the
   image (see "window": "min" and "max" in imgData below)

   ::

       URL: webgateway/histogram_json/<imageId>/channel/<index>/?theT=0&theZ=0&bins=20

   ::

       {"data": [ 24354, 93878, 87555, 45323, 27365, 14690, 9346, 2053, 60, 7, 19, 14, 15, 9, 5, 5, 3, 0, 2, 1]}


Saving etc.
"""""""""""

-  ``webgateway/saveImgRDef/<imageId>/``
-  ``webgateway/compatImgRDef/<imageId>/``
-  ``webgateway/copyImgRDef/``

ImgData
"""""""

The following is sample JSON data generated by
``/webgateway/imgData/<imageId>/``

::

    {
    "split_channel": {
        "c": {"width": 1448, "gridy": 2, "border": 2, "gridx": 3, "height": 966},
        "g": {"width": 966, "gridy": 2, "border": 2, "gridx": 2, "height": 966}
        },
    "rdefs": {"defaultT": 0, "model": "color",
                "projection": "normal", "defaultZ": 15},
    "pixel_range": [-32768, 32767],
    "channels": [
        {"color": "0000FF", "active": true,
            "window": {"max": 449.0, "end": 314, "start": 70, "min": 51.0},
            "emissionWave": "DAPI",
            "label": "DAPI"},
        {"color": "00FF00", "active": true,
            "window": {"max": 7226.0, "end": 1564, "start": 396, "min": 37.0},
            "emissionWave": "FITC",
            "label": "FITC"}
        ], 
    "meta": {
        "projectDescription": "",
        "datasetName": "survivin",
        "projectId": 2,
        "imageDescription": "",
        "imageTimestamp": 1277977808.0,
        "imageId": 12,
        "imageAuthor": "Will Moore",
        "imageName": "CSFV-siRNAi02_R3D_D3D.dv",
        "datasetDescription": "",
        "projectName": "siRNAi",
        "datasetId": 3
    }, 
    "id": 12,
    "pixel_size": {"y": 0.0663, "x": 0.0663, "z": 0.2},
    "size": {
        "width": 480,
        "c": 4,
        "z": 31,
        "t": 1,
        "height": 480
    },
    "tiles": false
    }


For large tiled images, the following data is also included:

::

    {
    "tiles": true,
    "tile_size": {
        width: 256,
        height: 256
    },
    "levels": 5,
    "zoomLevelScaling": {
        0: 1,
        1: 0.25,
        2: 0.0625,
        3: 0.0312,
        4: 0.0150
    },
    }

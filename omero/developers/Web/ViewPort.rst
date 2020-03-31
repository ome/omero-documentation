Embedding an OMERO.web viewport in a web page
=============================================

.. note:: These example are intended to be used with images that have been
    added to the PUBLIC group with a Public member in OMERO, making them
    publicly available. To see how to configure public URL filters, see the
    :doc:`/sysadmins/public` section.

OMERO.web viewer in iframe
--------------------------

Insert the following:

::

    <div id="omeroviewport"><iframe width="850" height="600" src="http://localhost:8000/webclient/img_detail/IMAGE_ID/" id="omeroviewport" name="omeroviewport"></iframe></div>


.. _launching_web_viewer:

Launching OMERO.web viewer
--------------------------

Use the following code to reference the scripts.

::

    <script type="text/javascript">

        function openPopup(url) {
            owindow = window.open(url, 'anew', config='height=600,width=850,left=50,top=50,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,directories=no,status=no');
            if(!owindow.closed) owindow.focus();
            return false;
        }

    </script>

Then in ``<BODY>`` insert the following:

::

        <a href="#" onclick="return openPopup('http://localhost:8000/webclient/img_detail/IMAGE_ID/')">Open viewer</a>

.. only:: html

   Example
   ^^^^^^^

   .. raw:: html

    <p style="width:160px; margin-right:10px; padding:5px; background-color: #f8f8f8; border: 1px solid #ccc;">
        <a onclick="window.open(this.href, '', 'resizable=no,status=no,location=no,width=800,top=100,left=100,height=600,toolbar=no,menubar=no,fullscreen=no,scrollbars=no,dependent=no'); return false;" href="https://nightshade.openmicroscopy.org/webgateway/img_detail/3933597/">
             <img src="https://nightshade.openmicroscopy.org/webgateway/render_thumbnail/3933597/150/150/" style="margin:5px;"/>
        </a>
        <i>Click on the thumbnail to view and manipulate the image in OMERO.</i>
    </p>


.. _embedding_web_viewport:

Customizing the content of the embedded OMERO.web viewport
----------------------------------------------------------

This section demonstrates how to embed an OMERO.web image viewer
in any HTML page, allowing use of resources directly from an OMERO server.

::

    $ omero config set omero.web.public.url_filter '^/webgateway'

Provided the image corresponding to ``IMAGE_ID`` is in the PUBLIC group, it
can be accessed via the link:
`\http://your_host/webgateway/img_detail/IMAGE_ID/`. Please remember that
public images must be in a public group where a public user can access
them. The :doc:`/sysadmins/public` documentation section can help you to
set this up.

Use the following code to load stylesheets and scripts.

::

    <link rel="stylesheet" type="text/css" href="http://your_host/static/omeroweb.viewer.min.css">
    <script type="text/javascript" src="http://your_host/static/omeroweb.viewer.min.js"></script>

Then create the small JavaScript with associated stylesheet which allows you
to view particular image defined by **IMAGE\_ID**.

::

    <style type="text/css">
        .viewport {
            height: 500px;
            width: 800px;
            padding: 10px;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {

            /* Prepare the viewport */
            viewport = $.WeblitzViewport($("#viewport"), "http://your_host/webgateway/", {
                'mediaroot': "http://your_host/static/"
            });

            /* Load the selected image into the viewport */
            viewport.load(IMAGE_ID);

        });
    </script>

Then in ``<BODY>`` insert the following:

::

    <div id="viewport" class="viewport"></div>


The viewport can be made more interactive by adding buttons or links to allow
display of scalebars, ROIs, zooming and selection of channels. Full examples
of how to embed microscopy or Whole Slide Image are available in the
`OMERO.webtest GitHub repository <https://github.com/ome/omero-webtest/tree/master/omero_webtest/templates/webtest/examples>`_.


Embedding OMERO.web viewport to your website
--------------------------------------------

Insert the following: **WARNING**: Please note that you are giving plane
password and everyone can read from your html source code!

::

        <div id="omeroviewport"><iframe width="850" height="600" src="http://localhost:8000/webclient/login/?username=TEST_USER&password=SECRET&server=1&url=http://localhost:8000/webclient/img_detail/IMAGE_ID/" id="omeroviewport" name="omeroviewport"></iframe></div>

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

Then in **<BODY>** insert the following:

::

        <a href="#" onclick="return openPopup('http://localhost:8000/webclient/img_detail/IMAGE_ID/')">Open viewer</a>

Embedding OMERO.web viewport to the template in OMERO.web
---------------------------------------------------------

This website will show you how to easily embed the viewport to the new
template with the use of the jQuery JavaScript? library.

Use the following code to reference the stylesheets and scripts.

::

        <link rel="stylesheet" href="/appmedia/webgateway/css/jquery-plugin-gs_slider.css" type="text/css" media="screen"/>
        <link rel="stylesheet" href="/appmedia/webgateway/css/weblitz-viewport.css" type="text/css" media="screen"/>

        <script type="text/javascript" src="/appmedia/omeroweb/javascript/jquery_1.3.2.js"></script>

        <script type="text/javascript" src="/appmedia/webgateway/js/weblitz-viewport.js"></script>
        <script type="text/javascript" src="/appmedia/webgateway/js/jquery-plugin-viewportImage.js"></script>
        <script type="text/javascript" src="/appmedia/webgateway/js/jquery-plugin-gs_slider.js"></script>
        <script type="text/javascript" src="/appmedia/webgateway/js/gs_utils.js"></script>

Then create the small java script which allows you to view particular
image defined by **image\_id**. Please note that if you also need to
modify the name of your application **/my\_app**\ you are running in.

::

        <script type="text/javascript">
            $(document).ready(function() 
                {
                    var viewport = $.WeblitzViewport($("#viewport"), "/MYAPP" );
                    viewport.load(image_id);

            });
        </script>

Then in **<BODY>** insert the following:

::

        <div class="miniview" id="viewport"></div>

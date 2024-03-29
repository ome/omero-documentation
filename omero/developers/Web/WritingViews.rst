Writing OMERO.web views
=======================

This page contains info on how to write your own views.py code, including
documentation on the :file:`webclient/views.py` and
:file:`webgateway/views.py` code. Although we aim to provide some useful notes
and examples here, you will find the best source of examples is
`the code itself <https://github.com/ome/omero-web/blob/master/omeroweb/webclient/views.py>`_.

@Decorators
-----------

Decorators in Python are functions that 'wrap' other functions to provide
additional functionality. They are added above a method using the @ notation.
We use them in the OMERO.web framework to handle common tasks such as login
(getting connection to OMERO server) etc.

@login\_required()
^^^^^^^^^^^^^^^^^^

The login\_required decorator uses parameters in the 'request' object to
retrieve an existing connection to OMERO. In the case where the user is not
logged in, they are redirected to a login page. Upon login, they will be
redirected back to the page that they originally tried to view. The method
that is wrapped by this decorator will be passed a 'conn' Blitz Gateway
connection to OMERO.

.. note::

    login\_required is a class-based decorator with several methods
    that can be overwritten to customize its functionality (see below).
    This means that the decorator **MUST** be instantiated when used with
    the @ notation, i.e.

    ::

        @login_required()     NOT  @login_required    # this will give you strange error messages

A simple example of @login\_required() usage (in `omero_webtest/views.py <https://github.com/ome/omero-webtest/blob/master/omero_webtest/views.py>`_). Note
the Blitz Gateway connection "conn" retrieved by @login\_required() is
passed to the function via the optional parameter ``conn=None``.

::

    from omeroweb.decorators import login_required

    @login_required()
    def dataset(request, datasetId, conn=None, **kwargs):
        ds = conn.getObject("Dataset", datasetId)
        return render(request, 'webtest/dataset.html', {'dataset': ds})

or

::

    from omeroweb.decorators import login_required, render_response

    @login_required()
    @render_response()
    def dataset(request, datasetId, conn=None, **kwargs):
        ds = conn.getObject("Dataset", datasetId)
        context['template'] = 'webtest/dataset.html'
        context['dataset'] = ds
        return context

.. figure:: /images/web-get-blitz-connection-flow.png
  :align: center
  :alt: Blitz Connection Flow

  Logic flow for retrieving Blitz Gateway connection from HTTP request.

login\_required logic
^^^^^^^^^^^^^^^^^^^^^

The login\_required decorator has some complex connection handling code,
to retrieve or create connections to OMERO. Although it is not necessary
to study the code itself, you may find it useful to understand the logic
that is used (see Flow Diagram). As mentioned above, we start with a
HTTP request (top left) and either a connection is returned (bottom
left) OR we are redirected to login page (right).

.. note:: 
    Options to configure a "public user" are described in the
    :doc:`/sysadmins/public` documentation.

Extending login\_required
^^^^^^^^^^^^^^^^^^^^^^^^^

The base login\_required class can be found in :file:`omeroweb/decorators.py`.
It has a number of methods that can be overwritten to customize or
extend its functionality. Again, it is best to look at an example of
this. See :file:`webclient/decorators.py` to see how the base
omeroweb.decorators.login\_required has been extended to configure the
conn connection upon login, handle login failure differently etc.

.. _render-response:

render\_response
^^^^^^^^^^^^^^^^

This decorator handles the rendering of view methods to HttpResponse. It
expects that wrapped view methods return a dict. This allows:

-  the template to be specified in the method arguments OR within the view
   method itself
-  the dict to be returned as json if required
-  the request is passed to the template context, as required by some tags
   etc
-  a hook is provided for adding additional data to the context, from the
   :doc:`/developers/PythonBlitzGateway` or from the request.

.. note::
    Using ``@render\_response`` guarantees using special
    :djangodoc:`RequestContext class <ref/templates/api/#subclassing-context-requestcontext>`
    which always uses ``django.template.context_processors.csrf`` (no matter
    what template context processors are configured in the TEMPLATES setting).
    For more details see :doc:`CSRF <CSRF>`.

Extending render\_response
^^^^^^^^^^^^^^^^^^^^^^^^^^

The base render\_response class can be found in
:file:`omeroweb/decorators.py`. It has a number of methods that can be
overwritten to customize or extend its functionality. Again, it is best to
look at an example of this. See :file:`webclient/decorators.py` to see how
the base omeroweb.decorators.render\_response has been extended to configure
HttpResponse and its subclasses.

Style guides
------------

Tips on good practice in :file:`views.py` methods and their corresponding
URLs.

-  Include any required arguments in the function parameter list.
   Although many :file:`views.py` methods use the **kwargs parameter to accept
   additional arguments, it is best not to use this for arguments that
   are absolutely required by the method.**
-  Specify default parameters where possible. This makes it easier to
   reuse the method in other ways.
-  Use keyword arguments in URL regular expressions. This makes them
   less brittle to changes in parameter ordering in the views.
-  Similarly, use keyword arguments for URLs in templates

   ::

       {% url 'url_name' object_id=obj.id %}

   and reverse function:

   ::

       >>> from django.urls import reverse
       >>> reverse('url_name', kwargs={'object_id': 1})

.. _omeroweb_error_handling:

OMERO.web error handling
------------------------

Django comes with some nice error handling functionality. We have
customized this and also provided some client-side error handling in
JavaScript to deal with errors in AJAX requests. This JavaScript can be
included in all pages that require this functionality. Errors are handled as
follows:

-  **404** - simply displays a 404 message to the user
-  **403** - this is 'permission denied' which probably means the user needs
   to login to the server (e.g. session may have timed out). The page is
   refreshed which will redirect the user to login page.
-  **500** - server error. We display a feedback form for the user to submit
   details of the error to our QA system - POSTs to
   "qa.openmicroscopy.org.uk:80". This URL is configurable in
   :file:`settings.py`.

In general, you should not have to write your own error handling code in
:file:`views.py` or client side. The default behavior is as follows:

With Debug: True (during development)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Django will return an HTML page describing the error, with various
parameters, stack trace etc. If the request was AJAX, and you have our
JavaScript code on your page then the error will be handled as described
(see above). NB: with Debug True, 500 errors will be returned as HTML
pages by Django but these will not be rendered as HTML in our feedback
form. You can use developer tools on your browser (e.g. Firebug on
Firefox) to see various errors and open the request in a new tab to
display the full debug info as HTML.

With Debug: False (in production)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Django will use its internal error handling to produce standard 404,
500 error pages. We have customized this behavior to display our own
error pages. The 500 error page allows you to submit the error as
feedback to our QA system. If the request is AJAX, we return the stack
trace is displayed in a dialog which also allows the error to be
submitted to QA.

Custom error handling
^^^^^^^^^^^^^^^^^^^^^

If you want to handle certain exceptions in particular ways you should
use appropriate try/except statements.

This is only advised for trivial errors, where you can give the user a
simple message, e.g. "No Objects selected, please try again", or if the
error is well understood and you can recover from the error in a
reasonable way.

For 'unexpected' server errors, it is best to allow the exception to be
handled by Django since this will provide a lot more info to the user
(request details etc.) and format HTML (both with Debug True or
False).

If you still want to handle the exception yourself, you can provide
stack trace alongside a message for the user. If the request is AJAX,
do not return HTML, since the response text will be displayed in a dialog
box for the user (not rendered as HTML).

::

    try:
        # something bad happens
    except:
        # log the stack trace
        logger.error(traceback.format_exc())
        # message AND stack trace
        err_msg = "Something bad happened! \n \n%s" % traceback.format_exc()
        if request.is_ajax():
            return HttpResponseServerError(err_msg)
        else:
            ...   # render err_msg with a custom template
            return HttpResponseServerError(content)

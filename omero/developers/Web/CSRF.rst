Cross Site Request Forgery protection
=====================================


CSRF is an attack which forces an end user to execute unwanted actions on a web
application in which they are currently authenticated. For more details see
`Cross-Site Request Forgery <https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)>`_.

OMERO.web provides easy-to-use protection against Cross Site Request
Forgeries, for more information see
:djangodoc:`Django documentation <ref/csrf/>`.

The first defense against CSRF attacks is to ensure that GET requests
(and other ‘safe’ methods, as defined by 9.1.1 Safe Methods, HTTP 1.1,
`RFC 2616 <https://tools.ietf.org/html/rfc2616.html#section-9.1.1>`_) are only
reading data from the server.

Requests that write data to the server should only use methods such as
POST, PUT and DELETE. These requests can then be protected as follows:

- By default OMERO.web has the middleware ``django.middleware.csrf.CsrfViewMiddleware``
  added to the list of middleware classes.

- In any template that uses a POST form, use the ``csrf_token`` tag inside
  the ``<form>`` element if the form is for an internal URL, e.g.:

  ::

    <form action="." method="post">{% csrf_token %}

  .. note::

    This should not be done for POST forms that target external URLs, since
    that would cause the CSRF token to be leaked, leading to a vulnerability.

- On each XMLHttpRequest set a custom X-CSRFToken header to the value of the
  CSRF token and pass the CSRF token in data with every AJAX POST request. If
  your custom template already benefits from
  :ref:`loading built-in jQuery <jquery_and_jquery_ui>` template you do not need to do
  anything as it already loads ``webgateway/js/ome.csrf.js``. Otherwise simply
  import the script as follows:

  ::

    <script type="text/javascript" src="{% static "webgateway/js/ome.csrf.js" %}"></script>

  For more details see
  :djangodoc:`CSRF for ajax <ref/csrf/#ajax>`.


The Django framework also offers decorator methods that can help you protect your
view methods and restrict access to views based on the request method.
For more details see :djangodoc:`Django decorators <topics/http/decorators/>`.


By default OMERO.web provides a built-in view that handles all unsafe incoming
requests failing with **403 Forbidden** response if the CSRF token has not been
included with a POST form.

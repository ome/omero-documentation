OMERO.server Websockets
=======================

OMERO 5.5.0 includes experimental support for websocket connections.
This allows clients to connect to OMERO.server over HTTP/S using the Ice
protocol (note: this is not the same as the
:doc:`OMERO.web or JSON APIs <../developers/json-api>`).


Configuration
-------------

The :property:`omero.client.icetransports` OMERO.server configuration property
must be changed. See the linked documentation for details.

You can override the default ``ws`` and ``wss`` ports with the properties
``omero.ports.ws`` ``omero.ports.wss``.

If you want to proxy OMERO.server websockets via a webserver such as Nginx you
must also add a cipher supported by Nginx to
:property:`omero.glacier2.IceSSL.Ciphers` since the anonymous ciphers that
OMERO uses are not supported.

For a full configuration example see
https://github.com/ome/docker-example-omero-websockets


Client connection
-----------------

You can connect to an OMERO websocket by setting the appropriate ``Ice.Config``
properties in the :doc:`client
<../developers/GettingStarted/AdvancedClientDevelopment>`, for example::

    Ice.Default.Router="OMERO.Glacier2/router:wss -p 8443 -h example.org -r omero/websocket"

Some clients also support specifying the Ice transport in the host, e.g.
``wss://example.org:8443/omero/websocket``.

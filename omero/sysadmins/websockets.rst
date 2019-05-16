OMERO.server Websockets
=======================

OMERO 5.5.0 includes experimental support for websocket connections.
This allows clients to connect to OMERO.server over HTTP/S using the Ice
protocol (note this is not the same as the
:doc:`OMERO.web or JSON APIs <../developers/json-api>`).


Configuration
-------------

The :property:`omero.client.icetransports` OMERO.server configuration property
must be changed, see the documentation for details.

You can override the default ``ws`` and ``wss`` ports with the properties
``omero.ports.ws`` ``omero.ports.wss``.

If you want to proxy OMERO.server websockets via a webserver such as Nginx you
must also add a cipher supported by Nginx to
:property:`omero.glacier2.IceSSL.Ciphers` since the anonymous ciphers that
OMERO uses are not supported.

For a full configuration example see
https://github.com/ome/docker-example-omero-websockets

Deprecated Services
-------------------

As we work towards a cleaner more concise API (see
`Omero/GatewayApi </ome/wiki/Omero/GatewayApi>`_), some API services
will become deprecated, starting in the OMERO Beta 4.3 release. This
page documents the various services that are to be deprecated and
provide other ways of accessing the same functionality.

'Gateway' session.createGateway()
---------------------------------

This service will be deprecated in the 4.3 release. Below are
alternative ways of reproducing gateway functionality.

image = gateway.getImage()
~~~~~~~~~~~~~~~~~~~~~~~~~~

This method loads the omero.model.ImageI object along with it's Pixels
object and Channels. You can achieve almost the same thing using the
container service, although channels are not loaded.

::

    containerService = session.getContainerService()
    image = containerService.getImages("Image", [iId], None, None)[0]  

NB: If no images are found by the query, getImages() will return an
empty list.

saveObject() saveAndReturnObject() deleteObject()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All of these methods are also provided by the update service:

::

    updateService = session.getUpdateService()
    updateService.saveObject(myObject)
    savedObject = updateService.saveAndReturnObject(myObject)
    updateService.deleteObject(savedObject)

getPixels(pixelsId)
~~~~~~~~~~~~~~~~~~~

You can use the query service to get Pixels, although this will not load
the associated Channels.

::

    queryService = session.getQueryService
    pixels = queryService.get("Pixels", pixelsId)

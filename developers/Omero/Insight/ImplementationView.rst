.. _developers/Omero/Insight/ImplementationView:

Organisation
============

The source code is organised as follows. All classes share a common base
namespace:

::

    org.openmicroscopy.shoola

Two main packages sit under the shoola directory:

-  ``agents``: All the classes related to concrete agents.
-  ``env``: All the classes that make up the runtime environment, that
   is the container.

The ``agents`` package is further broken down into:

-  ``events``
-  ``dataBrowser``
-  ``editor``
-  ``imviewer``
-  ``measurement``
-  ``metadata``
-  ``treeviewer``
-  ``util``

These packages contain the code for the Data Browser, Data Manager,
Editor, Viewer, and Measurement agents. The events package contains the
events that are used by all these agents.

The ``env`` package is also broken down into further sub-packages:

-  ``config``: Registry-related classes.
-  ``data``: Defines the client's side interface and implementation of
   the Remote Facade that we use to access the OMERO server.
-  ``event``: The event bus classes.
-  ``init``: Classes to perform initialisation tasks at start-up.
-  ``log``: Adapter classes to wrap
   ` log4j <http://logging.apache.org/log4j/>`_.
-  ``cache``: Adapter classes to wrap
   ` ehcache <http://ehcache.sourceforge.net/>`_.
-  ``rnd``: The image data provider.
-  ``ui``: The top frame window and the user notification widgets.

.. note::

	Two extra packages are part of the project for convenience reason only:

    - ``svc``: Provides general services e.g. transport service using *HTTP*.
    - ``util``: Collection of classes that be used outside the OMERO structure

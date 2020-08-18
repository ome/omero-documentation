#########################################
OMERO Overview and CLI User Documentation
#########################################

************
Introduction
************

OME Remote Objects (OMERO) is a modern client-server software platform
for visualizing, managing, and annotating scientific image data. OMERO
lets you import and archive your images, annotate and tag them, record
your experimental protocols, and export images in a number of formats. It also
allows you to collaborate with colleagues anywhere in the world by creating
user groups with different permission levels. OMERO consists of a Java server,
several Java client applications, as well as Python and C++ bindings
and a Django-based web application.

The OMERO clients are cross-platform. To run on your computer they require
Java |javaversion| or higher to be installed. This can easily be installed
from `<https://java.com/>`_ if it is not already included in your OS. The
OMERO.insight client gets all of its information from a remote OMERO.server —
the location of which is specified at login. Since this connection utilises a
standard network connection, the client can be run anytime the user is
connected to the internet.

.. figure:: /images/omero-overview.png
    :width: 85%
    :align: center
    :alt: The OMERO Platform

This documentation is for the OMERO 5 Platform. This version is designed
to improve our handling of complex multidimensional datasets. It allows you to
upload your files in their original format, preserving file names and any
nested directory structure in the server repository. For more technical
information, please refer to the :doc:`/developers/index`. You can read about
the development of OMERO in the :doc:`history` and the latest user-facing
changes in :doc:`whatsnew`.

*************
OMERO clients
*************

.. toctree::
    :maxdepth: 1
    :titlesonly:

    clients-overview
    cli/index

********************
Additional resources
********************

-   :omero:`OMERO for scientists <scientists>` introduces OMERO for new users,
    while the :omero:`feature pages <new>` provide an overview of the platform
    features by type, including community developed apps and integrations
    which could help OMERO meet your research needs more fully.

-   You can try out OMERO without committing to installing your own server by
    applying for an account on our `demo server <https://www.openmicroscopy.org/explore/>`_.

-   Workflow-based user assistance guides are provided on our
    :help:`help website <>`.

-   The `OME YouTube channel <https://www.youtube.com/channel/UCyySB9ZzNi8aBGYqcxSrauQ>`_ features
    tutorials and presentations.

-   As OMERO is an open source project with developers and users in many
    countries, :doc:`connecting to the community <community-resources>` can
    provide you with a wealth of experience to draw on for help and advice.

-   Additional `OMERO apps <https://www.openmicroscopy.org/omero/apps/>`_ add functionality
    to the OMERO.web or Command-Line clients.

.. toctree::
    :maxdepth: 1
    :hidden:

    community-resources
    whatsnew
    history

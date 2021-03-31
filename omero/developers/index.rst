#######################
Developer Documentation
#######################

The following documentation is for developers wishing to write OMERO client
code or extend the OMERO server. Instructions on :downloads:`downloading <>`,
installation and administering OMERO can be found under the
:doc:`/sysadmins/index` of the main site.

.. figure:: /images/developer-api-figure.png
   :align: center
   :width: 80%
   :alt:

**OMERO** is an open source client/server system written in Java for
visualizing, managing, and annotating microscope images and metadata.
The |OmeroApi| allows clients to be
written in :doc:`Java </developers/Java>`, :doc:`Python </developers/Python>`,
:doc:`C++ </developers/Cpp>` or :doc:`MATLAB </developers/Matlab>`. OMERO
releases include a Java client OMERO.insight, a Python-based web client
OMERO.web and the :doc:`/developers/cli/index`, which also uses
Python. There is also an ImageJ plugin. OMERO can be extended by modifying
these clients or by writing your own in any of the supported languages (see
figure). OMERO also supports a :doc:`Scripting Service <scripts/index>` which
allows Python scripts to be run on the server and called from any of the other
clients.

OMERO is designed, developed and released by the |OME|, with contributions
from |Glencoe| OMERO is released under the `GNU General Public License (GPL)`_
with commercial licenses and customization available from |Glencoe|. You can
read about how OMERO has developed since the project started in the
:doc:`/users/history`.

.. _GNU General Public License (GPL): https://www.gnu.org/copyleft/gpl.html

For help with any aspect of OMERO, see details of our
:community:`forums and mailing lists <>`.

*********************
Introduction to OMERO
*********************

.. toctree::
    :maxdepth: 1
    :titlesonly:

    whatsnew
    python3-migration
    installation
    build-system
    GettingStarted
    testing


*******************
Using the OMERO API
*******************

.. toctree::
    :maxdepth: 1
    :titlesonly:

    Python
    PythonBlitzGateway
    cli/index
    Java
    Matlab
    Cpp
    json-api


********
Analysis
********

.. toctree::
    :maxdepth: 2
    :titlesonly:

    analysis
    Tables


***************************
Scripts - plugins for OMERO
***************************

.. toctree::
    :maxdepth: 1
    :titlesonly:

    scripts/index
    scripts/user-guide
    scripts/style-guide
    scripts/matlab-scripts
    scripts/advanced


.. _web_index:

***
Web
***


.. toctree::
    :maxdepth: 1
    :titlesonly:

    Web
    Web/Deployment
    Web/CreateApp
    Web/ReleaseApp
    Web/LinkingFromWebclient
    Web/WebclientPlugin
    Web/EditingOmeroWeb
    Web/WebGateway
    Web/ViewPort
    Web/WritingViews
    Web/WritingTemplates
    Web/CSRF
    Web/Webclient


*******
Insight
*******

.. note:: With the release of OMERO 5.3.0, the OMERO.insight desktop client
    has entered **maintenance mode**, meaning it will only be updated if a
    major bug is discovered. Instead, the OME team will be focusing on
    developing the web clients. As a result, coding against this client is no
    longer recommended. Technical documentation can be found at `<https://omero-insight.readthedocs.io/en/latest/>`_.


*****************
More on API Usage
*****************

OMERO can be extended by modifying these clients or by writing your own in any
of the supported languages.

.. toctree::
    :maxdepth: 1
    :titlesonly:

    GettingStarted/AdvancedClientDevelopment
    Modules/Api
    Modules/Api/AdminInterface
    Modules/Delete
    Clients/ImportLibrary
    Modules/TempFileManager
    Modules/ExceptionHandling
    logging
    Server/GraphRequests
    Server/GraphsMigration


******************
The OME Data Model
******************

.. toctree::
    :maxdepth: 1
    :titlesonly:

    Model
    Model/StructuredAnnotations
    Model/EveryObject
    Model/Units
    Model/KeyValuePairs
    Model/XsltTransformations
    Model/Containers


*********
Searching
*********

.. toctree::
    :maxdepth: 1
    :titlesonly:

    Modules/Search
    Search/FileParsers
    Modules/Search/Bridges


***************************
Authentication and Security
***************************

.. toctree::
    :maxdepth: 1
    :titlesonly:

    Server/PasswordProvider
    Server/LoginAttemptListener
    Server/Ldap
    Server/SecurityRoles
    Server/SecuritySystem
    Server/Permissions


*********************
OMERO.server in depth
*********************

.. toctree::
    :maxdepth: 1
    :titlesonly:

    Server
    Server/ExtendingOmero
    server-blitz
    Server/FS
    ImportFS
    server-processor
    server-rendering
    Server/Clustering
    Server/CollectionCounts
    Server/HowToCreateAService
    Server/Sessions
    Server/Aop
    Server/Context
    Server/Events
    Server/Properties
    Server/Queries
    Server/Throttling
    Server/RenderingEngine
    Server/ScalingOmero
    Server/SqlAction
    Server/LightAdmins
    Server/ObjectGraphs
    Server/GraphsImpl

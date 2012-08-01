Deprecated Page

Table of Contents
^^^^^^^^^^^^^^^^^

#. `Description <#Description>`_
#. `Usage <#Usage>`_
#. `Breakdown <#Breakdown>`_

Publishing data
===============

Description
-----------

As the consequence of the sharing data, OMERO needs to allow people to
make their data public (accessible in Internet).

Usage
-----

User should be able to generate a link to the public data, for example:

-  http://host/user\_name/public/image/1/
-  http://host/user\_name/public/dataset/2/

Breakdown
---------

OMERO.server:

#. Decide on implementation (0.5+0.5+0.5 days)

OMERO.web `#1733 </ome/ticket/1733>`_:

#. Preparing layout for public data. Building templates. (5 days)
#. Implementing new methods in gateway. (2 days)
#. Writing the Controller. (3 days)

Blitz Gateway API
=================

The API for the Python Blitz Gateway is being reworked extensively in
the OMERO 4.3 release. This page will document which methods from the
` 4.2
API <http://hudson.openmicroscopy.org.uk/view/Beta4.2/job/OMERO-Beta4.2/javadoc/epydoc/omero.gateway-module.html>`_
are deprecated and provide examples on how to access the same
functionality from other methods.

Changes to the BlitzGateway (connection wrapper) ` 4.2 methods <http://hudson.openmicroscopy.org.uk/view/Beta4.2/job/OMERO-Beta4.2/javadoc/epydoc/omero.gateway._BlitzGateway-class.html>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Deprecated methods are listed below as bullet points. Commits for
   these changes are on ticket `#4681 </ome/ticket/4681>`_".

   ::

       Examples of how to use new methods to replace the functionality of deprecated methods 
       are shown in these code samples

Getting objects
---------------

Most of the get, find and list methods have been replaced by a single
method.

::

    def getObjects (self, obj_type, ids=None, params=None, attributes=None):

-  getProject(self, oid)

   ::

       getObject("Project", oid)

-  getDataset(self, oid)

   ::

       getObject("Dataset", oid)

-  getImage(self, oid)

   ::

       getObject("Image", oid)

-  getScreen(self, oid)

   ::

       getObject("Screen", oid)

-  getPlate(self, oid)

   ::

       getObject("Plate", oid)

-  getFileAnnotation(self, oid)

NB: All annotations
``FileAnnotation, CommentAnnotation, TagAnnotation etc)`` are all in the
same database table, so annotation ID is unique among all annotations.

::

    getObject("Annotation", oid)

-  getCommentAnnotation(self, oid)

   ::

       getObject("Annotation", oid)

-  getTagAnnotation(self, oid)

   ::

       getObject("Annotation", oid)

-  getGroup(self, gid)

   ::

       getObject("ExperimenterGroup", gid)

-  findProject(self, name)

   ::

       getObject("Project", attributes={'name':name})

-  lookupTagAnnotation(self, name)

   ::

       getObject("TagAnnotation", attributes={"textValue":name})

4.3.2
~~~~~

-  findGroup(self, name) removed in 4.3.2

   ::

       getObject("ExperimenterGroup", attributes={'name':name})

-  getExperimenter(self, eid)

   ::

       getObject("Experimenter", eid)

-  listExperimenters(self)

   ::

       getObjects("Experimenter")

-  findExperimenter(self, username)

   ::

       getObject("Experimenter", attributes={'omeName': username}

Annotation Links
----------------

Most queries for annotated objects or annotations on an object can be
handled by this method

::

    def getAnnotationLinks (self, parent_type, parent_ids=None, ann_ids=None, ns=None, params=None)

-  listImages(self, ns, params=None)

   ::

       def listImages(ns=None):
           imageAnnLinks = self.gateway.getAnnotationLinks("Image", ns=ns, params=params)
           return [omero.gateway.ImageWrapper(self.gateway, link.parent) for link in imageAnnLinks]

Search Objects
--------------

All searching can now be done through a single method

::

    def searchObjects(self, obj_types, text, created=None)

-  searchImages(self, text=None, created=None)

   ::

       searchObjects(["Image"], text, created)

-  searchDatasets(self, text=None, created=None)

   ::

       searchObjects(["Dataset"], text, created)

-  searchProjects(self, text=None, created=None)

   ::

       searchObjects(["Project"], text, created)

-  searchScreens(self, text=None, created=None)

   ::

       searchObjects(["Screen"], text, created)

-  searchPlates(self, text=None, created=None)

   ::

       searchObjects(["Plate"], text, created)

-  simpleSearch(self, text, types=None)

   ::

       searchObjects(["Project", "Dataset", "Image"], text)

Delete Objects
--------------

To delete via the delete queue (removing all un-needed data from DB) use

::

    def deleteObjects(self, obj_type, obj_ids, deleteAnns=False, deleteChildren=False)

To 'manually' delete a single object from the database use

::

    def deleteObject(self, obj)

-  deleteImage(self, oid, anns=None)

   ::

       deleteObjects("Image", [oid])

-  deleteImages(self, ids, anns=None)

   ::

       deleteObjects("Image", ids)

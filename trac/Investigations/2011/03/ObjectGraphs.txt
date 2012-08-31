Object Graphs
=============

Data is obtained from the OMERO server as objects that correspond to
database tables. However, it is often required that several linked
objects are returned from a single call, to minimise the number of calls
needed.

One challenge in returning 'graphs' of data is how to specify the graph
of linked objects. This is currently possible (Beta 4.2) either with the
Container service OR using iQuery to specify the precise set of objects
required.

It is proposed that in a future API / gateway (see
`Omero/GatewayApi </ome/wiki/Omero/GatewayApi>`_) we either provide a
small number of specific object graphs and/or a way to specify the
extend of a limited selection of graphs.

Josh's Proposal etc
-------------------

There will need to be a very fine balance between complexity and
flexibility (i.e. power) of this interface. If we go too far in what we
provide, then we will essentially be rewriting HQL, and any changes to
the model will break clients. Specifically, dot notation
"annotationLink.child" etc. could be a barrier to upgrading the model.
Perhaps then it would be good to start by listing **in order of
priority** the responsibilities of this API:

-  Josh's first attempt at an ordering:

   -  minimize need of developers to rewrite after upgrade
   -  power of expression
   -  simple to use
   -  extensible by user (these may require rewriting)

Building on the graph infrastructure from delete (4.2.1) perhaps we
could define something of the form:

::

     Fields                   Example1                            Example 2                Explanation
     ------------------------ ----------------------------------- ------------------------ -----------------------
     Graph: A                 "/Project"                          "/Project_by_Image"

       Root                   Project                             Project
       Primary Lookup         Project                             Project/Dataset/Image    As value like {"id":[1,2,3]} gets passed which must match against this object.
                                                                                           Where "root" and "primary lookup" aren't the same, all the roots which are
                                                                                           reachable from the "primary lookup" will be returned.
                                                                                           
       Secondary Lookups      {"ann_ns":Project/AnnotationLink/Annotation}                 Ignored if not present.
                              {"ns_like": "openmicroscopy.org/%"}                          Notice the use of operators: _like, _ilike, _gt, _lt,


       Non-optional           Project/Dataset                                              This defines the base graph that most people will use.
                              Project/Dataset/Image

       Configurable-Sets      {"Plate":Project/Dataset/Image/Plate}                        
       (may be on by          {"ProjectAnnotation":                                        Some kind of logic like "last choice wins" would be necessary.
        default)                 Project/AnnotationLink
                                 Project/AnnotationLink/Annotations}
                              {"AllAnnotations":
                                 Project/AnnotationLink...
                                 Project/Dataset/Image/AnnotationLink...}
                              {"Details":                                                  This could be on by default for loading, but would need to be
                                 Project/details/owner}                                    off by default for deleting via graphs.

       Filters                                                                             Filters would not prevent loading, but would remove values before
         Filter name          Mine_only                                                    performing the given action.
         Filter target        */details/owner
         Filter type          Bool
         Filter example       True
         Filter range         True,False
         Filter applies       Project
                              Project/Dataset
                              Project/Dataset/Image

         Filter name          Only_belongs_to
         Filter target        */details/owner
         Filter type          Long
         Filter example       1
         Filter range         >=0
         Filter applies       */Annotation


    Example execution:
    ------------------
    graph = Graph()
    graph.name              = "/Project"
    graph.lookup            = {"id": [1,2]}
    graph.secondary_lookups = {"ns_like": "openmicroscopy.org/%"}
    graph.filters           = {"Mine_Only": True}

    projects = gateway.load(graph)

In both the documentation and via the API it would be possible to
discover the configurable elements, and none of them should require
parsing dot notation or maps of maps, etc:

::

    gateway.get_graph_lookups("/Project")
    gateway.get_configurable_sets("/Project")
    gateway.get_filters("/Project)
    ...

There are a couple of ways we could start moving toward a system like
this. One would be to create all the graphs needed to cover the
requirements above, and then slowly start combining them by adding
filters, etc. Most important would be that whatever graphs we release
remain supported through upgrades. When adding objects to a graph, care
would need to be taken to handle the difference between loads and
deletes. For example, adding a new subgraph to be loaded is probably
completely backwards compatible; deleting a new subgraph may not be.

More examples
~~~~~~~~~~~~~

Trying to use the above proposal to define the various queries in
original proposal below:

::

    gateway.get_graph_lookups("/Image")      # E.g. ["Image", "Dataset", "ImageAnnotationLink" ..etc]
    gateway.get_configurable_sets("/Image")  # E.g. ["Image/Dataset", "Image/ImageAnnotationLinks", "Image/ImageAnnotationLink/Annotation"..etc]
    gateway.get_filters("/Image)             # E.g. ["Mine_Only", "Owner", "CreationDateAfter", ..etc]
    gateway.get_filter("Owner")   #  {"name": "Owner", "target": "*/details/owner", "type":Long, "applies":['Project', 'Image', 'Annotation', etc] }

    graph = Graph()
    graph.name              = "/Image"        # maybe this should be graph.root
    graph.filters           = {"Owner": 2}
    images = gateway.load(graph)           # equivalent to listObjects("Image", param={"details.owner":2}) 

    graph = Graph()
    graph.name              = "/Image"
    graph.lookup            = "id": [iId]
    graph.configurable_set  = "Image/ImageAnnotationLink/Annotation"
    images = gateway.load(graph)           # equivalent to getObjects("Image", [iId], alsoLoad=["AnnotationLink", "Child"])

Original Proposal (Will)
------------------------

Probably a good idea to always load details for every root object (maybe
every linked object too??), since they will be needed very frequently
for display of owner, creation date etc.

Parameters
~~~~~~~~~~

Ways of filtering returned objects.

-  Owner ID E.g. listObjects("Image", param={"details.owner":2})
-  Attribute of object. E.g. listObjects("ImageAnnotationLink?",
   param={"child":[123, 567]})

Problem: how to filter by attributes of other objects in graph? Maybe
don't need to, if you can always 'root' the query on the object you want
to filter by.

Query abstract types (Annotation, AnnotationLink?)?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If I want all the objects that an annotation is linked to, I could root
the query on the annotation:

::

    getObjects("FileAnnotation", [annId], alsoLoad=["AnnotationLink","Parent"])[0]

If I want to get linked Images and filter by link owner, I need to root
the query on the link:

::

    listObjects("ImageAnnotationLink", alsoLoad=["Parent"], param={"child":annId, details.owner":8})

But if I want ALL linked objects filtered by link owner, I would like to
be able to do root the query on 'AnnotationLink?'

::

    anns = listObjects("AnnotationLink", alsoLoad=["Parent"], param={"child":annId, details.owner":8})
    # return a list of Annotations of different types:
    for a in anns:
        if isinstance(a, TagAnnotationI):
            print "Tag:", a.getTextValue().getValue()
        if isinstance(a, FileAnnotationI):
            print "File:", a.getFile().getValue()

Annotations
~~~~~~~~~~~

Many current queries retrieve annotations in various graphs, selected by
various criteria. Annotation Links in DB: annotation, project, dataset,
image, screen, plate, well, channel, experimenter, experimenter-group,
namespace, node, original-file, pixels, planeinfo, plate-acquisition,
reagent, roi, session, well-sample)

To cover the majority of needs we would want to retrieve:

-  AnnotationLink? + Details
-  Parent
-  Child + Details

Select by: child.id(s), link.owner.id, parent.id(s), ns (only for Annot
alone).

-  Examples:

   ::

       # query rooted at Image. Would need to root on link to select by link.owner AND parent.id (see below)
       image = getObjects("Image", [iId], alsoLoad=["AnnotationLink", "Child"])[0]
       print image.getDetails().getOwner().getOmeName().getValue()  # details always loaded
       for annLink in image.copyAnnotationLinks():
           print "Linked by", annLink.getDetails().getOwner().getOmeName().getValue()  # link details loaded ???
           ann = annLink.getChild()
           if isinstance(ann, TagAnnotationI):
               print "Tag:", ann.getTextValue().getValue()
               print "Owned by", ann.getDetails().getOwner().getOmeName().getValue()  # link details loaded ???

       ann = getObjects("Annotation", [annId], alsoLoad=["AnnotationLink", "Parent"])[0]  #NB: This would select ALL Annotation types. 
       print ann.getDetails().getOwner().getOmeName().getValue()  # always have details for root object
       if isinstance(ann, TagAnnotationI):
           print "Tag:", ann.getTextValue().getValue()
           print ann.getDetails().getOwner().getOmeName().getValue()  # load link details? always??
       for annLink in ann.copyAnnotationLinks():
           parent = annLink.getParent()
           if isinstance(parent, ProjectI)
               print "Project:", project.getName().getValue()
               print project.getDetails().getOwner().getOmeName().getValue()  # load parent details? always??

       links = listObjects("ProjectAnnotationLink", alsoLoad=["Parent", "Child"], param={"details.owner":12, "parent": 3456})
       print "MY annotations on a single Project ID 3456:"
       for l in links:
           ann = l.getChild()
           print "Annotation owner:", ann.getDetails().getOwner().getOmeName().getValue()  # load details of child??
           print "Linked by:", l.getDetails().getOwner().getOmeName().getValue()  # always have details of root object
           if isinstance(ann, CommentAnnotation):
               print "Comment:", ann.getTextValue().getValue()

       listObjects("Annotation", param={"ns":"myNameSpace"})        #NB: This would select ALL Annotation types. 
       listObjects("TagAnnotation", param={"ns":"myNameSpace"})     #NB:Limit to a single Annotation type. 

Well
~~~~

-  Well + Details
-  Plate
-  Well-Sample
-  ws.plateAcq
-  ws.Image
-  img.Pixels
-  Pixels-type

select by plate.id, plateAcq.id, image.id

-  Examples (to select by image - see below)

   ::

       plate = getObjects("Plate", [pIds], alsoLoad=["Well", "WellSample", "PlateAcquisition", "Image", "Pixels"])[0]
       # can't also select by PlateAcquisition.id
       print p.name.val
       for w in p.copyWells():
           for ws in w.copyWellSamples():
               pa = ws.getPlateAcquisition
               print pa.name.val
               image = ws.getImage()
               pix = image.getPrimaryPixels()
               print pix.getSizeX().val

Image
~~~~~

Probably should always get Pixels-type when we get pixels.

-  Image + Details (owner, group, creationEvent)
-  Pixels + Pixels-type

select by image.id or image owner (with creation or acquisition dates)

::

    image = getObjects("Image", [iId], alsoLoad=[Pixels])[0]
    print image.getDetails().getOwner().getOmeName().getValue()  # details always loaded
    pixels = image.getPrimaryPixels()
    print pixels.getPixelsType().getValue().getValue()
    print pixels.getSizeZ()

Image Hierarchy
~~~~~~~~~~~~~~~

-  Image + Details (owner, group, creationEvent)
-  Dataset
-  Project

select by image.id

::

    image = getObjects("Image", [iId], alsoLoad=["Dataset", "Project"])[0]
    print image.getDetails().getOwner().getOmeName().getValue()  # details always loaded
    for dsLink in image.copyDatasetLinks():
        dataset = dsLink.getParent()
        print dataset.name.val
        for pLink in dataset.copyProjectLinks():
            project = pLink.getParent()
            print project.name.val

-  Image
-  Pixels + Pixels-Type
-  Well-Sample
-  Plate

Container Hierarchy
~~~~~~~~~~~~~~~~~~~

-  Project
-  Dataset

select by project.id

-  Dataset
-  Images + Details

select by dataset.id

::

    dataset = getObjects("Dataset", [dsId], alsoLoad=['Image'])[0]
    print "Dataset:", dataset.name.val
    for iLink in dataset.copyImageLinks():
        image = iLink.getChild()
        print "Image:", image.getName().getValue()
        print image.getDetails().getOwner().getOmeName().getValue()  # details loaded ?? How to specify?

-  Orphan Project/Dataset/Image/Plate? + Details

Not sure if we want to support this (maybe use iQuery)

::

    orphanImages = listObjects("Image", param={"Orphan": True})

Groups
~~~~~~

-  Experimenter
-  Groups

select by experimenter.id

-  Group
-  Experimenters

select by group.id

Original File
~~~~~~~~~~~~~

-  Original File + Details
-  Pixels-Original File Map
-  Child (pixels)

select by pixels.id

::

    map = listObjects("PixelsOriginalFileMap", alsoLoad=["Parent","Child"], param={"Child":5678})[0]
    print "File:", getParent().getName().getValue()
    print "Pixels:", getChild().getSizeX().getValue()

Current iQuery queries
----------------------

Below are the current set of queries that our current clients use with
iQuery. These can be used to determine what object graphs are currently
required.

Insight OMEROgateway.java
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Groups (by names) "getSystemGroups"
-  AnnotationLinks + Child + Parent (select by [child.id, link.ownerId])
   "loadLinks"
-  AnnotationLinks + Child (select by link.ownerId) "findAllAnnotations"
-  AnnotationLinks (select by parent.id and link.ownerId [child.id])
   "findAnnotationLink"
-  AnnotationLinks + link.Owner + Child + Parent (select by [parentId,
   childIds]) "findAnnotationLinks"
-  AnnotationLink (select by parent.id and child.id) "findLink"
-  AnnotationLinks (select by parent.id [c.ids] "findLinks"
-  AnnotationLinks (select by c.ids [link.ownerId]) "findLinks"
-  AnnotationLinks + Child + Child-owner + Link-owner (select by cIds
   [p.id, link.ownerId]) "findAnnotationLinks"
-  Ann-Ann-link (where child is Tag and link.ownerId)
   "removeTagDescription"
-  Image + img-ann.link.count + Ann-links + Pixels + Pixels-type (select
   by link.childIds [img.ownerIds]) "getAnnotatedObjects"
-  Image/Dataset/Project? + annLinks + link.Child (select by child.id)
   "getDataObjectsTaggedCount"

-  Well + Plate + Well-Sample + ws.Image + img.Pixels + Pixels-type (by
   image.id) "getImportedPlate"
-  Well + Plate + Well-Sample + ws.plateAcq + ws.Image + img.Pixels +
   Pixels-type (by plate.id [plateAcq.id]) "loadPlateWells"

-  'Object' (select by name, owner.id) "findIObjectByName"
-  Group + geMap + map.parent + map.child + map.child.map..etc! (select
   by groups that user.id is in) "getAvailableGroups" *need method
   server side!*
-  Original-File + pixelsFileMap + Child (select by child.id)
   "getArchivedFiles"
-  Original-File (select by id) "getOriginalFile"
-  Original-File + pixelsFileMap + Child (select by child.id)
   "getOriginalFiles"
-  Original-Files + owner (select by owner.id) "getUsedSpace"
-  Image + Pixels + Pixels-type + img.owner (select by ownerIds [acqDate
   > start, acqDate < end]) "searchByTime"
-  Image + Pixels + Pixels-type + img.owner (select by ownerIds
   [creatDate > start, creatDate < end])
-  Plate-Info (by pixels.id [z, t, c]) "loadPlaneInfo"
-  GroupExpMap? + Parent (by parent.id) "countExperimenters"
-  Group + grExMap + map.Child (by child.id) "getGroups"
-  Group + grExMap + map.Child + child.map + child.map.parent! (by
   group.id)

gateway.init.py
~~~~~~~~~~~~~~~

-  Object-Annotation link + Parent + Child (by child.id, [parent.ids])
-  Annotations (select by Ids)
-  Annotations (select by type, ns, owner)
-  Annotation (by ID)
-  TagAnnotation? (select by text, owner, ns=null)
-  Annotation links + Annotation (select by parent.id)
-  Annotation (not linked to parent.id)
-  'Objects' + AnnLinks? + Ann (select by annId) P/D/I/S/P/W

-  Parent-Child link (select by p.id and c.id)
-  Child link + Child + Annotation link + Annotation (select by
   parent.id, ann.ns, ann.val)
-  Child link + Parent + Child (select by child.id, p.id in pIds)
-  Child link + Parent + Child (select by parent.id, c.id in cIds)
-  Group (select by id in IDs)
-  Experimenters (select by id in IDs)
-  Experimenters (select by id NOT in IDs)
-  Experimenter (select by name like 'start')
-  Experimenter (where e.id : g.id exists in map of g.id) "listStaffs"
-  Groups (select g.id in gIds)
-  Screen + Details (owner & group) select by s.id
-  Plate + Details (owner & group) + Screen links + Parent (select by
   plate.id)
-  'Objects' + Details (owner & group) select by oId. P/D/I/S/P/W
-  DatasetImageLink? + child (select by parent.id)
-  Experimenter (by id)
-  Dataset + Dataset-Image links + Image (select by i.id)
-  Project + P-D links + Dataset + Dataset-Image links + Image (select
   by i.id)

webclient\_gateway.py
~~~~~~~~~~~~~~~~~~~~~

-  Well (& Details) + Plate + Well-Sample + Image (select by Plate ID)
-  Well (& Details) + Well-Sample + Image (& Details) (select by well
   ID)
-  Well + Plate + Well-Sample + Image (select by plate name, well
   column, well row

-  Images + Details (creationEvent, owner, group) (select by IDs)
-  Image & Details + Dataset (select by dsId)
-  Project + Details
-  Orphan Image / Dataset / Plate + Details
-  Screen + Details
-  Tag (by text, description & ns=null)
-  Experimenter (by omeName)
-  Experimenter (by email)
-  Experimenters (by IDs)
-  Group (by name)
-  Groups (name not user/system/guest)

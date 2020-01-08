Working with OMERO
==================

This page describes various tools and resources useful for working with
the OMERO API, as well as some tips on setting up your working environment. It
should be useful to client developers working in any of the supported
languages. For language specific info, see the following links: |OmeroJava|,
|OmeroPy|, |OmeroCpp|, |OmeroMatlab|.

OMERO.clients
-------------

The OMERO model is implemented as a relational PostgreSQL database on
the OMERO.server and mapped to code-generated model objects used by the
clients in the various supported languages (linked above). The OMERO API
consists of a number of services for working with these objects and
associated binary data. Typically, clients will use various stateless
services to query the OMERO model and then use the stateful services for
exchange of binary data or image rendering.

A typical client interaction might have an outline such as:

-  Log in to OMERO, obtaining connection and 'service factory'.
-  Use the stateless 'Query Service' or 'Container Service' to traverse
   Projects, Datasets and Images.
-  Use the stateful 'Rendering Engine' or 'Thumbnail Service' to view
   images.
-  Use the stateful 'Raw Pixels Service' or 'Raw File Store' to retrieve
   pixel or file data for analysis.
-  Create new Annotations or other objects and save them with the
   stateless 'Update Service'.
-  Close stateful services to free resources and close the connection.

OMERO.clients use a common 'gateway' to communicate with an OMERO.server
installation and allow the user to import, display, edit, and manage
server data. The OMERO team has developed a suite of clients
(see :doc:`/users/clients-overview`), but the open source nature of the OMERO
project also allows developers to create their own, customized clients. If you
are interested in doing this, further information is available on
|DevelopingOmeroClients|.

OMERO server
------------

Although most interactions with OMERO can be achieved remotely, you will
generally find it easier to have the server installed on your
development machine, particularly if you are going to be doing a lot of
OMERO development. This gives you local access to the database, binary
repository, logs etc. and means you can work 'off-line'.

Even if the server you are connecting to is remote, you will still want
to have the server package available locally, so as to give you the
command line tools, Python libraries, etc. It is important that all
OMERO server and client libraries you use are the same OMERO version.

You may wish to work with the most recent OMERO release, or alternatively you
can use the latest development code. Instructions on how to download or check
out the code can be found on the main :downloads:`downloads page <>`.

Regular builds of the server are performed by Jenkins_ including generated
Javadocs. See the
:devs_doc:`contributing developer continuous integration <ci-omero.html>`
documentation for more information.

Environment variables
---------------------

In addition to the install instructions, you might find it useful to set
the following variables:

-  For Python developers, create a virtual environment and install omero-py.

-  Add to your PATH the /bin/ directory of the virtual environment e.g. ``OMERO_VENV=/opt/omero/server/venv3`` where omero-py is installed - allows you to call the 'omero'
   command from anywhere

   ::

       export PATH=$PATH:$OMERO_VENV/bin/



Now checkout the |CLI|.

::

    $ omero -h

Network hopping for laptops
---------------------------

By default OMERO will bind to all available interfaces. On a laptop this
has the undesirable effect of requiring an OMERO restart when changing
network connections, e.g. from a home to a work network connection. To
avoid this, it is possible to bind only on the localhost interface which
will never change IP address.

::

    $ omero config set Ice.Default.Host 127.0.0.1
    # Restart to activate the new setting
    $ omero admin restart

.. note::

    Be warned, if doing this, it will no longer be possible to connect
    to the OMERO server instance from anywhere except the local machine.

Database access
---------------

It is useful to be able to directly query or browse the OMERO PostgreSQL
database, which can be achieved with a number of tools. E.g.

-  psql - this command line tool should already be installed.
   Depending on your permissions, you may need to connect as the
   'postgres' user:

   ::

       $ sudo -u postgres psql omero
       Password:       # sudo password
       omero=# \d;     # give a complete list of tables and views
       omero=# \d annotation;         # list all the columns in a particular table
       omero=# select id, discriminator, ns, textValue, file from annotation order by id desc;   # query

-  `pgAdmin <https://www.pgadmin.org/>`_ is a free, cross platform GUI
   tool for working with PostgreSQL

OMERO model
-----------

.. figure:: /images/developer-model-pdi2.png
   :align: center
   :alt:

You can browse the OMERO model in a number of ways, one of which is by
looking at the database itself (see above). Another is via the
:slicedoc_blitz:`OMERO model API <omero/model.html>` documentation.

However, due to the complexity of the OMERO model, it is helpful to have
some starting points (follow links below to the docs themselves).

.. note::

    These figures show highly simplified outlines of various model objects.

Projects, datasets and images
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:slicedoc_blitz:`Projects <omero/model/Project.html>`
and
:slicedoc_blitz:`Datasets <omero/model/Dataset.html>`
are many-to-many containers for
:slicedoc_blitz:`Images <omero/model/Image.html>`
(linked by
:slicedoc_blitz:`ProjectDatasetLinks <omero/model/ProjectDatasetLink.html>`
and
:slicedoc_blitz:`DatasetImageLinks <omero/model/DatasetImageLink.html>`
respectively).

Projects, Datasets, Images and a number of other entities can be linked
to Annotations :slicedoc_blitz:`(abstract superclass) <omero/model/Annotation.html>`
via specific links
(:slicedoc_blitz:`ProjectAnnotationLink <omero/model/ProjectAnnotationLink.html>`,
:slicedoc_blitz:`DatasetAnnotationLink <omero/model/DatasetAnnotationLink.html>`
etc). Annotation subclasses such as
:slicedoc_blitz:`CommentAnnotation <omero/model/CommentAnnotation.html>`,
:slicedoc_blitz:`FileAnnotation <omero/model/FileAnnotation.html>`
etc. are stored in a single database table in OMERO (all Annotations have
unique ID).

Images
^^^^^^

.. figure:: /images/developer-model-img.png
   :align: center
   :alt:

Images in OMERO are made up of many entities. These include core image
components such as :slicedoc_blitz:`Pixels <omero/model/Pixels.html>` and
:slicedoc_blitz:`Channels <omero/model/Channel.html>`, as well as a large
number of additional metadata objects such as Instrument (microscope),
Objective, Filters, Light Sources, and Detectors.

Working with the OMERO model objects
------------------------------------

For detailed information see |OmeroModel| and |DevelopingOmeroClients| pages.

Objects that you wish to work with on the client must be loaded from
OMERO, with the query defining the extent of any data graph that is
"fetched".

The |OmeroApi| supports two principle ways of querying OMERO and retrieving
the objects. You can write SQL-like queries using the query service (uses
"HQL") or you can use one of the other services that already has suitable
queries. Using the query service is very flexible but it requires detailed
knowledge of the OMERO model (see above) and is susceptible to any change in
the model.

For example, to load a specific Project and its linked Datasets you could
write a query like this:

::

    queryService = session.getQueryService()
    params = omero.sys.Parameters()
    params.map = {"pid": rlong(projectId)}
    query = "select p from Project p left outer join fetch p.datasetLinks as links left
                outer join fetch links.child as dataset where p.id=:pid"
    project = queryService.findByQuery(query, params)
    for dataset in project.linkedDatasetList:
        print(dataset.getName().getValue())

Or use the Container Service like this:

::

    containerService = session.getContainerService()
    project = containerService.loadContainerHierarchy("Project", [projectId], True)
    for dataset in project.linkedDatasetList:
        print(dataset.getName().getValue())

For a list of the available services, see the |OmeroApi| page.

Examples
--------

HQL examples
^^^^^^^^^^^^

HQL is used for Query Service queries (see above). Some examples,
coupled with the references for the :doc:`OMERO model
<Model/EveryObject>` and `HQL syntax
<https://docs.jboss.org/hibernate/orm/3.6/reference/en-US/html/queryhql.html>`_
should get you going, along with notes about object loading on the
|OmeroModel| page.

.. note::
    If possible, it is advisable to use an existing API method from one
    of the other services (as for the container service above).

Although it is possible to place query parameters directly into the string, it
is preferable (particularly for type-checking) to use the omero.sys.Parameters
object:

::

    queryService.findByQuery("from PixelsType as p where p.value='%s'" % pType, None)

    # better to do
    params = omero.sys.Parameters()
    params.map = {"pType": rstring(pType)}
    queryService.findByQuery("from PixelsType as p where p.value=:pType", params)

psql queries
^^^^^^^^^^^^

Below are a number of example psql database queries:

::

    # list any images that do not have pixels:
    omero=#select id, name from Image i where i.id not in (select image from Pixels where image is not null) order by i.id desc;

    omero=# select id, name, ome_perms(permissions) from experimentergroup;
     id  |                        name                        | ome_perms
    -----+----------------------------------------------------+-----------
       0 | system                                             | -rw----
       1 | user                                               | -rwr-r-
       2 | guest                                              | -rw----
       3 | JRS-private                                        | -rw----
       4 | JRS-read-only                                      | -rwr---

    omero=# select id, name, path, owner_id, group_id, ome_perms(permissions) from originalfile order by id desc limit 100;
     id |       name                        |          path                                         | owner_id | group_id | ome_perms
    ----+-----------------------------------+-------------------------------------------------------+----------+----------+-----------
     56 | GFP-FRAP.cpe.xml                  | /Users/will/omero/editor/GFP-FRAP.cpe.xml             |        4 |        5 | -rwr---

    omero=# \x
    Expanded display is on.
    omero=# select id, discriminator, ns, textValue, file from annotation where id=369;
    -[ RECORD 1 ]-+----------------------------------------------
    id            | 369
    discriminator | /type/OriginalFile/
    ns            | openmicroscopy.org/omero/import/companionFile
    textvalue     |
    file          | 570

    omero=# \x
    Expanded display is off.
    omero=# select * from joboriginalfilelink where parent = 7;
     id | permissions | version | child | creation_id | external_id | group_id | owner_id | update_id | parent
    ----+-------------+---------+-------+-------------+-------------+----------+----------+-----------+--------
     14 |        -103 |         |   110 |         891 |             |      208 |      207 |       891 |      7
     17 |        -103 |         |   113 |         926 |             |      208 |      207 |       926 |      7
    (2 rows)

    omero=# select id, name, path, owner_id, group_id, ome_perms(permissions) from originalfile where id in (110,113) order by id desc limit 100;
     id  |       name        |                             path                             | owner_id | group_id | ome_perms
    -----+-------------------+--------------------------------------------------------------+----------+----------+-----------
     113 | stdout            | /Users/will/omero/tmp/omero_will/75270/processuLq8fd.dir/out |      207 |      208 | -rw----
     110 | imagesFromRois.py | ScriptName061ea79c-f98c-447b-b720-d17003d6a72f               |        0 |        0 | -rw----
    (2 rows)

    # find all annotations on Image ID=2
    omero=# select * from annotation where id in (select child from imageannotationlink where parent = 2) ;

    # trouble-shooting postgres
    omero=# select * from pg_stat_activity ;

omero hql
^^^^^^^^^

You can use the :program:`omero hql` command to query a remote OMERO
database, entering your login details when requested.

.. note::

    Because you will be querying the database under a particular login, the
    entries returned will be subject to the permissions of that login.

::

    omero hql -q --limit=10 "select name from OriginalFile where id=4106"
    omero hql -q --limit=10 "select id, textValue, file from Annotation a order by a.id desc"
    omero hql -q --limit=10 "select id, textValue from TagAnnotation a order by a.id desc"
    omero hql -q --limit=100 "select id, owner.id, started, userAgent from Session where closed is null"

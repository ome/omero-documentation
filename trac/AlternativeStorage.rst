Investigation of Alternative Storage Mechanisms
===============================================

    We have looked at different mechanisms for storing and querying ROI,
    these can be grouped into several categories:

-  Document Based Databases

   -  MongoDB ` MongoDB <http://www.mongodb.org/display/DOCS/Home>`_
   -  CouchDB
      ` http://couchdb.apache.org/ <http://couchdb.apache.org/>`_

-  Graph Databases

   -  Neo4J ` http://neo4j.org/ <http://neo4j.org/>`_
   -  InfoGrid ` http://infogrid.org/ <http://infogrid.org/>`_

-  BigTable implementations

   -  Cassandra
      ` http://incubator.apache.org/cassandra/ <http://incubator.apache.org/cassandra/>`_
   -  HyperTables
      ` http://www.hypertable.org/ <http://www.hypertable.org/>`_
   -  HBase
      ` http://hadoop.apache.org/hbase/ <http://hadoop.apache.org/hbase/>`_

-  Key value DB

   -  Berkeley Database
      ` http://www.oracle.com/technology/products/berkeley-db/index.html <http://www.oracle.com/technology/products/berkeley-db/index.html>`_
   -  Tokyo Cabinet
      ` http://1978th.net/tokyocabinet/ <http://1978th.net/tokyocabinet/>`_
   -  Project Voldermort
      ` http://project-voldemort.com/ <http://project-voldemort.com/>`_

-  Other

   -  Pytables
      ` http://www.pytables.org/moin/PyTables <http://www.pytables.org/moin/PyTables>`_

Other groups are also evaluating the same mechanisms
` http://blog.boxedice.com/2009/07/25/choosing-a-non-relational-database-why-we-migrated-from-mysql-to-mongodb/ <http://blog.boxedice.com/2009/07/25/choosing-a-non-relational-database-why-we-migrated-from-mysql-to-mongodb/>`_

    The current investigation is still in progress, it has mainly
    focused on MongoDB, Cassandra and more recently Neo4J.

Document Databases
------------------

    A document database is part of the NOSQL movement, data is stored as
    a document in the database, there is no concept of schema and any
    type of information my be stored. The database contains a series of
    collections into which any document may be inserted. In contrast to
    RBD's there are no tables, joins nor are they're transactions. Each
    operation on an document is atomic, this is to fit into the
    Map-Reduce
    ` http://en.wikipedia.org/wiki/MapReduce <http://en.wikipedia.org/wiki/MapReduce>`_
    paradigm of many of the distributed database systems.

Each document can contain sub-components which can be accessed
individually, one could think of a single document being a row in a
non-normalised RDB.

MongoDB
~~~~~~~

    **PROS**

-  It has bindings to numerous languages(C++, C#, Java, Python, ...).
-  Allows storage, indexing, linking of any user data.
-  Annotations are now very easy, efficient.
-  Has mechanisms for *schema* upgrade.
-  Dynamic Queries.
-  Replication.
-  Sharding.
-  Map-Reduce framework.
-  Fast.
-  GridFS is a distributed file storage mechanism within Mongo.

    **CONS**

-  Schemaless, data integrity will need to be worked on.
-  Graph structures not inherently supported.

    **DEPLOYMENTS**

-  SourceForge ` http://sourceforge.net/ <http://sourceforge.net/>`_
-  BusinessInsider
   ` http://www.businessinsider.com/ <http://www.businessinsider.com/>`_
-  New York Times ` http://www.nytimes.com/ <http://www.nytimes.com/>`_
-  Disqus ` http://www.disqus.com/ <http://www.disqus.com/>`_

SourceForge has released a python wrapper to pyMongo, called
` Ming <http://merciless.sourceforge.net/tour.html>`_ it supports data
integrity, datastructure upgrade paths and simpler access to querying.

MongoDB uses JSON to insert documents into its database. It allows all
elements of the datastructure to be queried.

    **Using pyMongo to insert ROI with two Ellipse**

::

    connection = Connection();
    db = connection['databaseName'];
    collection = db.['collectionName'];
     
    collection.insert({"tags" : [ ], "label" : null, "shapes" : [{
            "tags" : [{"tag" : "foo", "namespace" : "bob"}],
            "rx" : 17,
            "ry" : 17,
            "label" : null,
            "cy" : 75,
            "cx" : 3,
            "t" : 0,
            "z" : 0,
            "type" : "Ellipse",
            "id" : 3
        },
        {
            "tags" : [{"tag" : "foo", "namespace" : "bob"}],
            "rx" : 10,
            "ry" : 16,
            "label" : null,
            "cy" : 82,
            "cx" : 45,
            "t" : 0,
            "z" : 0,
            "type" : "Ellipse",
            "id" : 5
        }], "type" : "Roi", "id" : 565 })

MongoDB allows you to query on any part of the datastructure and to
retrieve only those portions of the data that is interesting, so in the
above example shapes may be queried but only attributes of the ROI may
be requested.

**Example Query - Find ROI with id 2 and shapes with id 3**

::

    connection = Connection();
    db = connection['databaseName'];
    collection = db.['collectionName'];
    collection.find({"id":2,"shapes.id":3})

MongoDB allows you to seach using regular expressions.

**Example Query - Find all Shapes with tag containing mitosis**

::

    connection = Connection();
    db = connection['databaseName'];
    collection = db.['collectionName'];
    collection.find({"shapes.tags.tag":'/.*mitosis.*/i'})

CouchDB
~~~~~~~

    **PROS**

-  Allows storage, indexing, linking of any user data.
-  Annotations are now very easy, efficient.
-  Has mechanisms for *schema* upgrade.
-  is ACID

    **CONS**

-  Schemaless, data integrity will need to be worked on.
-  Graph structures not inherently supported.
-  Does not support sharding
-  No replication
-  No Dynamic Queries

    **DEPLOYMENTS**

-  BBC
   ` http://www.erlang-factory.com/conference/London2009/speakers/endafarrell <http://www.erlang-factory.com/conference/London2009/speakers/endafarrell>`_
-  Assay Depot
   ` http://www.assaydepot.com/ <http://www.assaydepot.com/>`_

Other viewpoints
~~~~~~~~~~~~~~~~

    ` http://nosql.mypopescu.com/post/298557551/couchdb-vs-mongodb <http://nosql.mypopescu.com/post/298557551/couchdb-vs-mongodb>`_

Graph Databases
---------------

The graph databases are another solution to the storage of structured
data in a non-relational database. Commonly these databases use nodes to
represent objects and user defined relationships to link the nodes.
Currently we have looked at two of these databases,
` Neo4J <http://neo4j.org/>`_ and ` InfoGrid <http://infogrid.org/>`_.

Neo4J
~~~~~

Neo4J is a graph database, it's written in java with a native inference
engine underneath. A good tutorial on Neo4J is
` http://www.slideshare.net/nguyenandan/basic-neo4j-code-examples-2008-05-08-2714356 <http://www.slideshare.net/nguyenandan/basic-neo4j-code-examples-2008-05-08-2714356>`_.

**PROS**

-  Handles graph structures nicely
-  Transactional
-  Supported by Gremlin
   ` Gremlin <http://wiki.github.com/tinkerpop/gremlin/>`_
-  Native RDF
   ` http://components.neo4j.org/neo-rdf-sail/ <http://components.neo4j.org/neo-rdf-sail/>`_

**CONS**

-  No C++ language binding.
-  Not distributed.
-  Tables are not so easily modelled.

**DEPLOYMENTS**

-  The Swedish Defence forces ` http://www.mil.se <http://www.mil.se>`_
-  Windh Technologies ` http://www.windh.com <http://www.windh.com>`_
-  Flextoll ` http://www.flextoll.se <http://www.flextoll.se>`_

    **Define a set of relationships**

    ::

        public enum OMERORelations implements RelationshipType
        {
            ASSOCIATE
            DERIVE
            AGGREGATE
            COMPOSE
        }

    **Creating an image image link in Neo4J**

    ::

        Node image = neo.createNode();
        image.setProperty("IObject",imageI);
        image.setProperty("id",imageI.getId().getValue());
        image.setProperty("name",imageI.getName().getValue());

        Node derivedImage = neo.createNode();
        derivedImage.setProperty("IObject",derivedImageI);
        derivedImage.setProperty("id",derivedImageI.getId().getValue());
        derivedImage.setProperty("name",derivedImageI.getName().getValue());

        Relationship relationship = image.createRelationshipTo( derivedImage, OMERORelations.DERIVE );
        relationship.setProperty("type","Deconvolution");

    **Creating an roi image link in Neo4J**

::

    Node image = neo.createNode();
    image.setProperty("IObject",imageI);
    image.setProperty("id",imageI.getId().getValue());
    image.setProperty("name",imageI.getName().getValue());

    Node derivedImage = neo.createNode();
    derivedImage.setProperty("IObject",derivedImageI);
    derivedImage.setProperty("id",derivedImageI.getId().getValue());
    derivedImage.setProperty("name",derivedImageI.getName().getValue());

    Relationship relationship = image.createRelationshipTo( derivedImage, OMERORelations.DERIVE );
    relationship.setProperty("type","ROI");
    relationship.setProperty("operation","crop");
    relationship.setProperty("roi",cropRoiI);

**Example of Graph Traversal**

::

    Traverser derivedTraverser = imageNode.traverse( 
    Traverser.Order.BREADTH_FIRST, 
    StopEvaluator.END_OF_NETWORK, 
    ReturnableEvaluator.ALL_BUT_START_NODE, 
    RelTypes.DERIVE, 
    Direction.OUTGOING ); 

    System.out.println( "Derived Images:" ); 
    for ( Node derived : derivedTraverser ) 
    { 
       String type = derived.getProperty("type");
       if(type=="Decovolution")
          System.out.print(derived.getProperty( "name" ) + " was deconvolved from " + imageNode.getProperty("name"));
       if(type=="roi")
          System.out.print(derived.getProperty( "name" ) + " was "+ derivedTraverser.lastRelationshipTraversed().getProperty("operation") +" from " + imageNode.getProperty("name"));
     
    }

BigTable Implementations
------------------------

` BigTable <http://en.wikipedia.org/wiki/BigTable>`_ is a storage method
popularised by Google, described as "a sparse, distributed
multi-dimensional sorted map", it can be though of as a variant of a
` ColumnDB <http://en.wikipedia.org/wiki/Column-oriented_DBMS>`_. The
storage solution allows the insertion of data where the columns can vary
between rows.

Currently we have only investigated HBase, Cassandra and Hypertables,
and for this investigation focused on
` Cassandra <http://incubator.apache.org/cassandra/>`_ which is a
project, submitted to apache from facebook.

As the table solutions of BigTables are effectively complex key/value
store, this needs a sophisticated toolset to get the most out of this
solutions, for instance google has created
` sawzall <http://labs.google.com/papers/sawzall-sciprog.pdf>`_ to query
this system. Digg have created a language to work with Cassandra
` LazyBoy <http://github.com/digg/lazyboy>`_.

BigTable implementations like the document orientated databases do not
allow joins, GQL, googles variant of SQL for BigTables does not support
joins.
